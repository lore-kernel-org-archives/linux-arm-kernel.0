From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 2 Apr 2016 12:45:41 +0200
Subject: [PATCH 1/2] clk: Add Oxford Semiconductor OXNAS Standard Clocks
In-Reply-To: <20160402005045.GX18567@codeaurora.org>
References: <1459520791-13269-1-git-send-email-narmstrong@baylibre.com>
 <1459520791-13269-2-git-send-email-narmstrong@baylibre.com>
 <20160402005045.GX18567@codeaurora.org>
Message-ID: <56FFA2D5.4060603@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2016 02:50 AM, Stephen Boyd wrote:
>> +
>> +/* Bit - Name association */
>> +static const struct clk_init_data *clk_oxnas_init[] = {
>> +	[0] = &clk_leon_init,
>> +	[1] = &clk_dma_sgdma_init,
>> +	[2] = &clk_cipher_init,
>> +	[3] = NULL,		/* Do not touch to DDR clock */
> 
> Why do we have this here then? The dt binding has different
> numbers, so having this array with a hole in it seems fragile
> when we're using the order of this array to map to the clk
> indices.

Hi Stephen,

I skipped the DDR clock since it must be touched in any case, I could have introduced a read-only clock....

I already posted an arm-soc dts pull request with the DTSI using the bindings indices.
Here the array indice is the register bit index, maybe I can order by bindings indice and add the hardware bit in an intermediate structure ?

>> +	clk_oxnas = devm_kzalloc(&pdev->dev,
>> +				 sizeof(*clk_oxnas)*ARRAY_SIZE(clk_oxnas_init),
>> +				 GFP_KERNEL);
> 
> devm_kcalloc()?
> 
>> +	if (!clk_oxnas)
>> +		return -ENOMEM;
>> +
>> +	clks = devm_kzalloc(&pdev->dev,
>> +			    sizeof(*clks)*ARRAY_SIZE(clk_oxnas_init),
>> +			    GFP_KERNEL);
> 
> devm_kcalloc()? This can be one smaller because DDR is never
> touched?

Sure
> 
>> +	if (!clks)
>> +		return -ENOMEM;
>> +
>> +	onecell_data = devm_kzalloc(&pdev->dev, sizeof(*onecell_data),
>> +				     GFP_KERNEL);
> 
> Maybe we should have one structure that we allocate all at once?
> 
>> +	if (!onecell_data)
>> +		return -ENOMEM;
>> +
>> +	regmap = syscon_node_to_regmap(of_get_parent(np));
> 
> Can we use dev_get_regmap(&pdev->dev.parent) here instead? I'd
> prefer device APIs over DT APIs here. 

Ok

>> +	if (!regmap) {
>> +		dev_err(&pdev->dev, "failed to have parent regmap\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(clk_oxnas_init); i++) {
>> +		struct clk_oxnas *_clk;
>> +
>> +		if (!clk_oxnas_init[i])
>> +			continue;
>> +
>> +		_clk = &clk_oxnas[i];
>> +		_clk->bit = i;
> 
> Ah I see now, the order is used to encode bit offset. The comment
> above the init data array could be expanded a bit then please.
Sure it need clarifications !

> 
>> +		_clk->hw.init = clk_oxnas_init[i];
>> +		_clk->regmap = regmap;
>> +
>> +		clks[clks_count] = devm_clk_register(&pdev->dev, &_clk->hw);
>> +		if (WARN_ON(IS_ERR(clks[clks_count])))
>> +			return PTR_ERR(clks[clks_count]);
>> +
>> +		++clks_count;
>> +	}
>> +
>> +	onecell_data->clks = clks;
>> +	onecell_data->clk_num = clks_count;
>> +
>> +	return of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
>> +}
>> +
>> +static const struct of_device_id oxnas_stdclk_dt_ids[] = {
>> +	{ .compatible = "oxsemi,ox810se-stdclk" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, oxnas_stdclk_dt_ids);
>> +
>> +static struct platform_driver oxnas_stdclk_driver = {
>> +	.probe = oxnas_stdclk_probe,
>> +	.remove = oxnas_stdclk_remove,
>> +	.driver	= {
>> +		.name = "oxnas-stdclk",
>> +		.of_match_table = of_match_ptr(oxnas_stdclk_dt_ids),
> 
> You can drop of_match_ptr() here, it will just lead to unused
> variable warnings.

OK, thanks for the review, I hope the next post will go throught 4.7 !

Regards,
Neil
