From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 14:10:14 +0000
Subject: [PATCH v3 4/5] ASoC: dwc: Add devicetree support for Designware
 I2S
In-Reply-To: <9699e11a566938b8d1821f9be3df3276d57cd979.1418826016.git.Andrew.Jackson@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <9699e11a566938b8d1821f9be3df3276d57cd979.1418826016.git.Andrew.Jackson@arm.com>
Message-ID: <20141222141014.GS17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 04:18:08PM +0000, Andrew Jackson wrote:

> +union snd_dma_data {
> +	struct i2s_dma_data pd;
> +	struct snd_dmaengine_dai_dma_data dt;
> +};
> +

This is a driver local union with a very generic name, it seems likely
that this will collide in future causing build breaks

> -	ret = dev->i2s_clk_cfg(config);
> -	if (ret < 0) {
> -		dev_err(dev->dev, "runtime audio clk config fail\n");
> -		return ret;
> +		/* TODO: Validate sample rate against permissible set */
> +		bitclk = config->sample_rate * config->data_width * 2;
> +		clk_set_rate(dev->clk, bitclk);
>  	}

This is ignoring errors in clk_set_rate().

> +/* Maximum resolution of a channel - not uniformly spaced */
> +static const u32 fifo_width[] = {
> +	12, 16, 20, 24, 32, 0, 0, 0
> +};
> +
> +/* Width of (DMA) bus */
> +static const u32 bus_widths[] = {
> +	DMA_SLAVE_BUSWIDTH_1_BYTE,
> +	DMA_SLAVE_BUSWIDTH_2_BYTES,
> +	DMA_SLAVE_BUSWIDTH_4_BYTES,
> +	DMA_SLAVE_BUSWIDTH_UNDEFINED
> +};

> +	u32 bus_width = bus_widths[COMP1_APB_DATA_WIDTH(comp1)];
> +	u32 fifo_depth = 1 << (1 + COMP1_FIFO_DEPTH_GLOBAL(comp1));
> +	u32 max_size;

I'd feel a lot more comfortable if there were bounds checking on these
array indexes, especially since the arrays aren't explicitly sized and
instead just have the number of elements that is (hopefully) safe with
no comments or anything.  As things stand this is all using really
fraigle idioms, this could easily be broken if someone is updating the
driver for new IP features or even just cleaning up the code.

> -	dev->i2s_clk_cfg = pdata->i2s_clk_cfg;
> -	dev->clk = clk_get(&pdev->dev, NULL);
> +		dev->clk = clk_get(&pdev->dev, NULL);
> +	} else {
> +		dw_configure_dai_by_dt(dev, dw_i2s_dai, res);
> +
> +		dev->clk = devm_clk_get(&pdev->dev, "i2sclk");
> +	}

This changes from clk_get() to devm_clk_get() but I'm not seeing
anything that removes clk_put() calls.

> +#ifdef CONFIG_OF
> +		.of_match_table = dw_i2s_of_match,
> +#endif

of_match_ptr().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/4c4373be/attachment.sig>
