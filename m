From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Apr 2016 17:50:45 -0700
Subject: [PATCH 1/2] clk: Add Oxford Semiconductor OXNAS Standard Clocks
In-Reply-To: <1459520791-13269-2-git-send-email-narmstrong@baylibre.com>
References: <1459520791-13269-1-git-send-email-narmstrong@baylibre.com>
 <1459520791-13269-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160402005045.GX18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01, Neil Armstrong wrote:
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 16f7d33..2efdbab 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -197,6 +197,12 @@ config COMMON_CLK_PXA
>  	---help---
>  	  Support for the Marvell PXA SoC.
>  
> +config COMMON_CLK_OXNAS
> +	bool

Please add some text in quotes here so that this is user visible.

> +	select MFD_SYSCON
> +	---help---
> +	  Support for the OXNAS SoC Family clocks.
> +
> diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
> new file mode 100644
> index 0000000..5f02cfa
> --- /dev/null
> +++ b/drivers/clk/clk-oxnas.c
> @@ -0,0 +1,202 @@
> +
> +/* Clk init data declaration */
> +DECLARE_STD_CLK(leon);
> +DECLARE_STD_CLK(dma_sgdma);
> +DECLARE_STD_CLK(cipher);
> +DECLARE_STD_CLK(sata);
> +DECLARE_STD_CLK(audio);
> +DECLARE_STD_CLK(usbmph);
> +DECLARE_STD_CLKP(etha, eth_parents);
> +DECLARE_STD_CLK(pciea);
> +DECLARE_STD_CLK(nand);
> +
> +/* Bit - Name association */
> +static const struct clk_init_data *clk_oxnas_init[] = {
> +	[0] = &clk_leon_init,
> +	[1] = &clk_dma_sgdma_init,
> +	[2] = &clk_cipher_init,
> +	[3] = NULL,		/* Do not touch to DDR clock */

Why do we have this here then? The dt binding has different
numbers, so having this array with a hole in it seems fragile
when we're using the order of this array to map to the clk
indices.

> +	[4] = &clk_sata_init,
> +	[5] = &clk_audio_init,
> +	[6] = &clk_usbmph_init,
> +	[7] = &clk_etha_init,
> +	[8] = &clk_pciea_init,
> +	[9] = &clk_nand_init,
> +};
> +
> +static int oxnas_stdclk_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct regmap *regmap;
> +	struct clk_oxnas *clk_oxnas;
> +	struct clk_onecell_data *onecell_data;
> +	struct clk **clks;
> +	unsigned int clks_count = 0;
> +	int i;
> +
> +	clk_oxnas = devm_kzalloc(&pdev->dev,
> +				 sizeof(*clk_oxnas)*ARRAY_SIZE(clk_oxnas_init),
> +				 GFP_KERNEL);

devm_kcalloc()?

> +	if (!clk_oxnas)
> +		return -ENOMEM;
> +
> +	clks = devm_kzalloc(&pdev->dev,
> +			    sizeof(*clks)*ARRAY_SIZE(clk_oxnas_init),
> +			    GFP_KERNEL);

devm_kcalloc()? This can be one smaller because DDR is never
touched?

> +	if (!clks)
> +		return -ENOMEM;
> +
> +	onecell_data = devm_kzalloc(&pdev->dev, sizeof(*onecell_data),
> +				     GFP_KERNEL);

Maybe we should have one structure that we allocate all at once?

> +	if (!onecell_data)
> +		return -ENOMEM;
> +
> +	regmap = syscon_node_to_regmap(of_get_parent(np));

Can we use dev_get_regmap(&pdev->dev.parent) here instead? I'd
prefer device APIs over DT APIs here. 

> +	if (!regmap) {
> +		dev_err(&pdev->dev, "failed to have parent regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(clk_oxnas_init); i++) {
> +		struct clk_oxnas *_clk;
> +
> +		if (!clk_oxnas_init[i])
> +			continue;
> +
> +		_clk = &clk_oxnas[i];
> +		_clk->bit = i;

Ah I see now, the order is used to encode bit offset. The comment
above the init data array could be expanded a bit then please.

> +		_clk->hw.init = clk_oxnas_init[i];
> +		_clk->regmap = regmap;
> +
> +		clks[clks_count] = devm_clk_register(&pdev->dev, &_clk->hw);
> +		if (WARN_ON(IS_ERR(clks[clks_count])))
> +			return PTR_ERR(clks[clks_count]);
> +
> +		++clks_count;
> +	}
> +
> +	onecell_data->clks = clks;
> +	onecell_data->clk_num = clks_count;
> +
> +	return of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
> +}
> +
> +static const struct of_device_id oxnas_stdclk_dt_ids[] = {
> +	{ .compatible = "oxsemi,ox810se-stdclk" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, oxnas_stdclk_dt_ids);
> +
> +static struct platform_driver oxnas_stdclk_driver = {
> +	.probe = oxnas_stdclk_probe,
> +	.remove = oxnas_stdclk_remove,
> +	.driver	= {
> +		.name = "oxnas-stdclk",
> +		.of_match_table = of_match_ptr(oxnas_stdclk_dt_ids),

You can drop of_match_ptr() here, it will just lead to unused
variable warnings.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
