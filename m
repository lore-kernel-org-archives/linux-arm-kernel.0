From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 20 Jan 2014 10:44:18 -0800
Subject: [PATCH v4 1/1] ARM: davinci: aemif: get rid of davinci-nand
 driver dependency on aemif
In-Reply-To: <1389346564-24243-1-git-send-email-nsekhar@ti.com>
References: <1389346564-24243-1-git-send-email-nsekhar@ti.com>
Message-ID: <20140120184418.GI8919@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Sorry, I do have one complaint about this patch.

On Fri, Jan 10, 2014 at 03:06:04PM +0530, Sekhar Nori wrote:
> --- a/arch/arm/mach-davinci/aemif.c
> +++ b/arch/arm/mach-davinci/aemif.c
> @@ -130,4 +136,82 @@ int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(davinci_aemif_setup_timing);
> +
> +/**
> + * davinci_aemif_setup - setup AEMIF interface by davinci_nand_pdata
> + * @pdev - link to platform device to setup settings for
> + *
> + * This function does not use any locking while programming the AEMIF
> + * because it is expected that there is only one user of a given
> + * chip-select.
> + *
> + * Returns 0 on success, else negative errno.
> + */
> +int davinci_aemif_setup(struct platform_device *pdev)
> +{
> +	struct davinci_nand_pdata *pdata = dev_get_platdata(&pdev->dev);
> +	uint32_t val;
> +	unsigned long clkrate;
> +	struct resource	*res;
> +	void __iomem *base;
> +	struct clk *clk;
> +	int ret = 0;
> +
> +	clk = clk_get(&pdev->dev, "aemif");
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		dev_dbg(&pdev->dev, "unable to get AEMIF clock, err %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret < 0) {
> +		dev_dbg(&pdev->dev, "unable to enable AEMIF clock, err %d\n",
> +			ret);
> +		return ret;

coccinelle gives a warning for this:

  arch/arm/mach-davinci/aemif.c:171:2-8: ERROR: missing clk_put; clk_get on line 160 and execution via conditional on line 168 [coccinelle]

You need a clk_put() on the error path for clk_prepare_enable. For
instance, you can add a label below and replace this 'return ret' with
'goto err_put'.

> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "cannot get IORESOURCE_MEM\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	base = ioremap(res->start, resource_size(res));
> +	if (!base) {
> +		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res);
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	/*
> +	 * Setup Async configuration register in case we did not boot
> +	 * from NAND and so bootloader did not bother to set it up.
> +	 */
> +	val = davinci_aemif_readl(base, A1CR_OFFSET + pdev->id * 4);
> +	/*
> +	 * Extended Wait is not valid and Select Strobe mode is not
> +	 * used
> +	 */
> +	val &= ~(ACR_ASIZE_MASK | ACR_EW_MASK | ACR_SS_MASK);
> +	if (pdata->options & NAND_BUSWIDTH_16)
> +		val |= 0x1;
> +
> +	davinci_aemif_writel(base, A1CR_OFFSET + pdev->id * 4, val);
> +
> +	clkrate = clk_get_rate(clk);
> +
> +	if (pdata->timing)
> +		ret = davinci_aemif_setup_timing(pdata->timing, base, pdev->id,
> +						 clkrate);
> +
> +	if (ret < 0)
> +		dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
> +
> +	iounmap(base);
> +err:
> +	clk_disable_unprepare(clk);

Then the label could be here:

err_put:

> +	clk_put(clk);
> +	return ret;
> +}

Brian
