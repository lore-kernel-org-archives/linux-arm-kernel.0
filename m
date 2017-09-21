From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 21 Sep 2017 14:25:58 +0300
Subject: [PATCH v4 2/4] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <1504785168-26572-3-git-send-email-pierre-yves.mordret@st.com>
References: <1504785168-26572-1-git-send-email-pierre-yves.mordret@st.com>
 <1504785168-26572-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <a88a83ba-9477-36ae-87ba-a35f477a5ca1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-09-07 14:52, Pierre-Yves MORDRET wrote:
> This patch implements the STM32 DMAMUX driver.
> 
> The DMAMUX request multiplexer allows routing a DMA request line between
> the peripherals and the DMA controllers of the product. The routing
> function is ensured by a programmable multi-channel DMA request line
> multiplexer. Each channel selects a unique DMA request line,
> unconditionally or synchronously with events from its DMAMUX
> synchronization inputs. The DMAMUX may also be used as a DMA request
> generator from programmable events on its input trigger signals
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v4:
>         * Get rid of st,dmamux property and custom API between STM32
>           DMAMUX and DMA.
>           DMAMUX will read DMA masters from Device Tree from now on.
>           Merely one DMAMUX node is needed now.
>         * Only STM32 DMA are allowed to be connected onto DMAMUX
>         * channelID is computed locally within the driver and crafted in
>           dma_psec to be passed toward DMA master.
>           DMAMUX router sorts out which DMA master will serve the
>           request automatically.
>         * This version forbids the use of DMA in standalone and DMAMUX at
>           the same time : all clients need to be connected either on DMA
>           or DMAMUX ; no mix up

Great that you got it working w/o a custom API!
I have one comment, which actually valid for the ti-dma-crossbar driver
as well...

> +static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +	struct stm32_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct stm32_dmamux *mux;
> +	u32 i, min, max, ret;
> +	unsigned long flags;
> +
> +	if (dma_spec->args_count != 3) {
> +		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (dma_spec->args[0] > dmamux->dmamux_requests) {
> +		dev_err(&pdev->dev, "invalid mux request number: %d\n",
> +			dma_spec->args[0]);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
> +					   dmamux->dma_requests);

you pick the first available chan_id here under the lock.

> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +	if (mux->chan_id == dmamux->dma_requests) {
> +		dev_err(&pdev->dev, "Run out of free DMA requests\n");
> +		kfree(mux);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Look for DMA Master */
> +	for (i = 1, min = 0, max = dmamux->dma_reqs[i];
> +	     i <= dmamux->dma_reqs[0];
> +	     min += dmamux->dma_reqs[i], max += dmamux->dma_reqs[++i])
> +		if (mux->chan_id < max)
> +			break;
> +	mux->master = i - 1;
> +
> +	/* The of_node_put() will be done in of_dma_router_xlate function */
> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
> +	if (!dma_spec->np) {
> +		dev_err(&pdev->dev, "can't get dma master\n");
> +		kfree(mux);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* Set dma request */
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +	if (!IS_ERR(dmamux->clk)) {
> +		ret = clk_enable(dmamux->clk);
> +		if (ret < 0) {
> +			spin_unlock_irqrestore(&dmamux->lock, flags);
> +			kfree(mux);
> +			dev_err(&pdev->dev, "clk_prep_enable issue: %d\n", ret);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	set_bit(mux->chan_id, dmamux->dma_inuse);

But nothing stops other parallel threads to pick the same chan_id since
you have released the lock (released, got the lock to protect the set
dma request and released it again). imho the find_first_zero_bit() and
the set_bit() should be done within the same lock to avoid race conditions.

- P?ter
