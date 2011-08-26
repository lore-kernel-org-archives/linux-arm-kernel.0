From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 26 Aug 2011 17:12:54 +0200
Subject: [PATCH v10 1/3] MTD : add the common code for GPMI-NAND
	controller driver
In-Reply-To: <1314171204-25458-2-git-send-email-b32955@freescale.com>
References: <1314171204-25458-1-git-send-email-b32955@freescale.com>
	<1314171204-25458-2-git-send-email-b32955@freescale.com>
Message-ID: <201108261712.55028.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 24, 2011 09:33:22 AM Huang Shijie wrote:
> These files contain the common code for the GPMI-NAND driver.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

[...]

Hi Huang, please don't forget to CC me next time, but there will be next time 
for this patch I guess ;-)

> +int start_dma_without_bch_irq(struct gpmi_nand_data *this,
> +				struct dma_async_tx_descriptor *desc)
> +{
> +	struct completion *dma_c = &this->dma_done;
> +	int err;
> +
> +	init_completion(dma_c);
> +
> +	desc->callback		= dma_irq_callback;
> +	desc->callback_param	= this;
> +	dmaengine_submit(desc);
> +
> +	/* Wait for the interrupt from the DMA block. */
> +	err = wait_for_completion_timeout(dma_c, msecs_to_jiffies(1000));
> +	err = (!err) ? -ETIMEDOUT : 0;

This might need a tiny correction.

> +	if (err) {
> +		pr_err("DMA timeout, last DMA :%d\n", this->last_dma_type);
> +		if (gpmi_debug & GPMI_DEBUG_VERBOSE)
> +			gpmi_dump_info(this);
> +	}
> +	return err;
> +}

But that's a minor thing. Even like this:

Acked-by: Marek Vasut <marek.vasut@gmail.com>
