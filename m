From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 10:49:17 -0700
Subject: [PATCH v12 1/4] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1471854565-19810-2-git-send-email-erin.lo@mediatek.com>
References: <1471854565-19810-1-git-send-email-erin.lo@mediatek.com>
 <1471854565-19810-2-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160824174917.GB19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22, Erin Lo wrote:
> +
> +static void __init mtk_infrasys_init_early(struct device_node *node)
> +{
> +	int r, i;
> +
> +	if (!infra_clk_data) {
> +		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
> +
> +		for (i = 0; i < CLK_INFRA_NR; i++)
> +			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
> +						infra_clk_data);
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
> +	if (r)
> +		pr_err("%s(): could not register clock provider: %d\n",
> +			__func__, r);
> +}
> +CLK_OF_DECLARE(mtk_infra, "mediatek,mt2701-infracfg", mtk_infrasys_init_early);

This should use CLK_OF_DECLARE_DRIVER? Has this been tested on
latest clk-next? Some recent patches make it so that
CLK_OF_DECLARE() prevents platform devices from being created for
the associated DT nodes that match during of_clk_init().

> +
> +static int mtk_infrasys_init(struct device_node *node)
> +{
> +	int r, i;
> +
> +	if (!infra_clk_data) {
> +		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
> +	} else {
> +		for (i = 0; i < CLK_INFRA_NR; i++) {
> +			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
> +				infra_clk_data->clks[i] = ERR_PTR(-ENOENT);
> +		}
> +	}
> +
> +	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> +						infra_clk_data);
> +	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
> +						infra_clk_data);
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
> +	if (r)
> +		pr_err("%s(): could not register clock provider: %d\n",
> +			__func__, r);
> +
> +	return r;
> +}
> +
> +static const struct mtk_gate_regs peri0_cg_regs = {
> +	.set_ofs = 0x0008,
> +	.clr_ofs = 0x0010,
> +	.sta_ofs = 0x0018,
> +};
> +
> +static const struct mtk_gate_regs peri1_cg_regs = {
> +	.set_ofs = 0x000c,
> +	.clr_ofs = 0x0014,
> +	.sta_ofs = 0x001c,
> +};
> +
> +#define GATE_PERI0(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &peri0_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +	}
> +
> +#define GATE_PERI1(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &peri1_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +	}
> +
> +static const struct mtk_gate peri_clks[] = {
> +	GATE_PERI1(CLK_PERI_USB0_MCU, "usb0_mcu_ck", "axi_sel", 31),
> +	GATE_PERI1(CLK_PERI_ETH, "eth_ck", "clk26m", 30),
> +	GATE_PERI1(CLK_PERI_SPI0, "spi0_ck", "spi0_sel", 29),
> +	GATE_PERI1(CLK_PERI_AUXADC, "auxadc_ck", "clk26m", 28),
> +	GATE_PERI0(CLK_PERI_I2C3, "i2c3_ck", "clk26m", 27),
> +	GATE_PERI0(CLK_PERI_I2C2, "i2c2_ck", "axi_sel", 26),
> +	GATE_PERI0(CLK_PERI_I2C1, "i2c1_ck", "axi_sel", 25),
> +	GATE_PERI0(CLK_PERI_I2C0, "i2c0_ck", "axi_sel", 24),
> +	GATE_PERI0(CLK_PERI_BTIF, "bitif_ck", "axi_sel", 23),
> +	GATE_PERI0(CLK_PERI_UART3, "uart3_ck", "axi_sel", 22),
> +	GATE_PERI0(CLK_PERI_UART2, "uart2_ck", "axi_sel", 21),
> +	GATE_PERI0(CLK_PERI_UART1, "uart1_ck", "axi_sel", 20),
> +	GATE_PERI0(CLK_PERI_UART0, "uart0_ck", "axi_sel", 19),
> +	GATE_PERI0(CLK_PERI_NLI, "nli_ck", "axi_sel", 18),
> +	GATE_PERI0(CLK_PERI_MSDC50_3, "msdc50_3_ck", "emmc_hclk_sel", 17),
> +	GATE_PERI0(CLK_PERI_MSDC30_3, "msdc30_3_ck", "msdc30_3_sel", 16),
> +	GATE_PERI0(CLK_PERI_MSDC30_2, "msdc30_2_ck", "msdc30_2_sel", 15),
> +	GATE_PERI0(CLK_PERI_MSDC30_1, "msdc30_1_ck", "msdc30_1_sel", 14),
> +	GATE_PERI0(CLK_PERI_MSDC30_0, "msdc30_0_ck", "msdc30_0_sel", 13),
> +	GATE_PERI0(CLK_PERI_AP_DMA, "ap_dma_ck", "axi_sel", 12),
> +	GATE_PERI0(CLK_PERI_USB1, "usb1_ck", "usb20_sel", 11),
> +	GATE_PERI0(CLK_PERI_USB0, "usb0_ck", "usb20_sel", 10),
> +	GATE_PERI0(CLK_PERI_PWM, "pwm_ck", "axi_sel", 9),
> +	GATE_PERI0(CLK_PERI_PWM7, "pwm7_ck", "axi_sel", 8),
> +	GATE_PERI0(CLK_PERI_PWM6, "pwm6_ck", "axi_sel", 7),
> +	GATE_PERI0(CLK_PERI_PWM5, "pwm5_ck", "axi_sel", 6),
> +	GATE_PERI0(CLK_PERI_PWM4, "pwm4_ck", "axi_sel", 5),
> +	GATE_PERI0(CLK_PERI_PWM3, "pwm3_ck", "axi_sel", 4),
> +	GATE_PERI0(CLK_PERI_PWM2, "pwm2_ck", "axi_sel", 3),
> +	GATE_PERI0(CLK_PERI_PWM1, "pwm1_ck", "axi_sel", 2),
> +	GATE_PERI0(CLK_PERI_THERM, "therm_ck", "axi_sel", 1),
> +	GATE_PERI0(CLK_PERI_NFI, "nfi_ck", "nfi2x_sel", 0),
> +
> +	GATE_PERI1(CLK_PERI_FCI, "fci_ck", "ms_card_sel", 11),
> +	GATE_PERI1(CLK_PERI_SPI2, "spi2_ck", "spi2_sel", 10),
> +	GATE_PERI1(CLK_PERI_SPI1, "spi1_ck", "spi1_sel", 9),
> +	GATE_PERI1(CLK_PERI_HOST89_DVD, "host89_dvd_ck", "aud2dvd_sel", 8),
> +	GATE_PERI1(CLK_PERI_HOST89_SPI, "host89_spi_ck", "spi0_sel", 7),
> +	GATE_PERI1(CLK_PERI_HOST89_INT, "host89_int_ck", "axi_sel", 6),
> +	GATE_PERI1(CLK_PERI_FLASH, "flash_ck", "nfi2x_sel", 5),
> +	GATE_PERI1(CLK_PERI_NFI_PAD, "nfi_pad_ck", "nfi1x_pad", 4),
> +	GATE_PERI1(CLK_PERI_NFI_ECC, "nfi_ecc_ck", "nfi1x_pad", 3),
> +	GATE_PERI1(CLK_PERI_GCPU, "gcpu_ck", "axi_sel", 2),
> +	GATE_PERI1(CLK_PERI_USB_SLV, "usbslv_ck", "axi_sel", 1),
> +	GATE_PERI1(CLK_PERI_USB1_MCU, "usb1_mcu_ck", "axi_sel", 0),
> +};
> +
> +static const char * const uart_ck_sel_parents[] = {
> +	"clk26m",
> +	"uart_sel",
> +};
> +
> +static const struct mtk_composite peri_muxs[] = {
> +	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents,
> +		0x40c, 0, 1),
> +	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents,
> +		0x40c, 1, 1),
> +	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents,
> +		0x40c, 2, 1),
> +	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents,
> +		0x40c, 3, 1),
> +};
> +
> +static int mtk_pericfg_init(struct device_node *node)
> +{
> +	struct clk_onecell_data *clk_data;
> +	void __iomem *base;
> +	int r;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s(): ioremap failed\n", __func__);

Please pass the device structure to these callbacks so that we
can use standard devm_ioremap() type APIs like normal platform
drivers.

> +		return -ENOMEM;
> +	}
> +
> +	clk_data = mtk_alloc_clk_data(CLK_PERI_NR);
> +
> +	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
> +						clk_data);
> +
> +	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
> +			&lock, clk_data);
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (r)
> +		pr_err("%s(): could not register clock provider: %d\n",
> +			__func__, r);
> +
> +	return r;
> +}
> +
> +#define MT8590_PLL_FMAX		(2000 * MHZ)
> +#define CON0_MT8590_RST_BAR	BIT(27)
> +
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, \
> +			_pd_shift, _tuner_reg, _pcw_reg, _pcw_shift) {	\
> +		.id = _id,						\
> +		.name = _name,						\
> +		.reg = _reg,						\
> +		.pwr_reg = _pwr_reg,					\
> +		.en_mask = _en_mask,					\
> +		.flags = _flags,					\
> +		.rst_bar_mask = CON0_MT8590_RST_BAR,			\
> +		.fmax = MT8590_PLL_FMAX,				\
> +		.pcwbits = _pcwbits,					\
> +		.pd_reg = _pd_reg,					\
> +		.pd_shift = _pd_shift,					\
> +		.tuner_reg = _tuner_reg,				\
> +		.pcw_reg = _pcw_reg,					\
> +		.pcw_shift = _pcw_shift,				\
> +	}
> +
> +static const struct mtk_pll_data apmixed_plls[] = {
> +	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x200, 0x20c, 0x80000001,
> +			PLL_AO, 21, 0x204, 24, 0x0, 0x204, 0),
> +	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x210, 0x21c, 0xf0000001,
> +		  HAVE_RST_BAR, 21, 0x210, 4, 0x0, 0x214, 0),
> +	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x220, 0x22c, 0xf3000001,
> +		  HAVE_RST_BAR, 7, 0x220, 4, 0x0, 0x224, 14),
> +	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x230, 0x23c, 0x00000001, 0,
> +				21, 0x230, 4, 0x0, 0x234, 0),
> +	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x240, 0x24c, 0x00000001, 0,
> +				21, 0x240, 4, 0x0, 0x244, 0),
> +	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x250, 0x25c, 0x00000001, 0,
> +				21, 0x250, 4, 0x0, 0x254, 0),
> +	PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x270, 0x27c, 0x00000001, 0,
> +				31, 0x270, 4, 0x0, 0x274, 0),
> +	PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x280, 0x28c, 0x00000001, 0,
> +				31, 0x280, 4, 0x0, 0x284, 0),
> +	PLL(CLK_APMIXED_ETHPLL, "ethpll", 0x290, 0x29c, 0x00000001, 0,
> +				31, 0x290, 4, 0x0, 0x294, 0),
> +	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x2a0, 0x2ac, 0x00000001, 0,
> +				31, 0x2a0, 4, 0x0, 0x2a4, 0),
> +	PLL(CLK_APMIXED_HADDS2PLL, "hadds2pll", 0x2b0, 0x2bc, 0x00000001, 0,
> +				31, 0x2b0, 4, 0x0, 0x2b4, 0),
> +	PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x2c0, 0x2cc, 0x00000001, 0,
> +				31, 0x2c0, 4, 0x0, 0x2c4, 0),
> +	PLL(CLK_APMIXED_TVD2PLL, "tvd2pll", 0x2d0, 0x2dc, 0x00000001, 0,
> +				21, 0x2d0, 4, 0x0, 0x2d4, 0),
> +};
> +
> +static int mtk_apmixedsys_init(struct device_node *node)
> +{
> +	struct clk_onecell_data *clk_data;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	mtk_clk_register_plls(node, apmixed_plls, ARRAY_SIZE(apmixed_plls),
> +								clk_data);
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (r)
> +		pr_err("%s(): could not register clock provider: %d\n",
> +			__func__, r);

These three lines could be moved to the caller so taht we don't
duplicate the same logic over and over.

> +
> +	return r;
> +}
> +
> +static const struct of_device_id of_match_clk_mt2701[] = {
> +	{
> +		.compatible = "mediatek,mt2701-topckgen",
> +		.data = mtk_topckgen_init,
> +	}, {
> +		.compatible = "mediatek,mt2701-infracfg",
> +		.data = mtk_infrasys_init,
> +	}, {
> +		.compatible = "mediatek,mt2701-pericfg",
> +		.data = mtk_pericfg_init,
> +	}, {
> +		.compatible = "mediatek,mt2701-apmixedsys",
> +		.data = mtk_apmixedsys_init,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static int clk_mt2701_probe(struct platform_device *pdev)
> +{
> +	int (*clk_init)(struct device_node *);
> +	const struct of_device_id *of_id;
> +
> +	pr_warn("%s():%d: %s\n", __func__, __LINE__, pdev->name);
> +
> +	of_id = of_match_node(of_match_clk_mt2701, pdev->dev.of_node);
> +	if (!of_id || !of_id->data)
> +		return -EINVAL;

This can be

	clk_init = of_device_get_match_data(of_match_clk_mt2701, &pdev->dev);
	if (!clk_init)
		return -EINVAL;

> +
> +	clk_init = of_id->data;
> +	return clk_init(pdev->dev.of_node);
> +}
> +
> +static struct platform_driver clk_mt2701_drv = {
> +	.probe = clk_mt2701_probe,
> +	.driver = {
> +		.name = "clk-mt2701",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_clk_mt2701,
> +	},
> +};
> +
> +static int __init clk_mt2701_init(void)
> +{
> +	return platform_driver_register(&clk_mt2701_drv);
> +}
> +
> +arch_initcall(clk_mt2701_init);
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index bb30f70..6a015a8 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -58,6 +58,9 @@ void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_fixed_clk *rc = &clks[i];
>  
> +		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id]))
> +			continue;
> +
>  		clk = clk_register_fixed_rate(NULL, rc->name, rc->parent, 0,
>  					      rc->rate);
>  
> @@ -81,6 +84,9 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_fixed_factor *ff = &clks[i];
>  
> +		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id]))
> +			continue;
> +
>  		clk = clk_register_fixed_factor(NULL, ff->name, ff->parent_name,
>  				CLK_SET_RATE_PARENT, ff->mult, ff->div);
>  
> @@ -116,6 +122,9 @@ int mtk_clk_register_gates(struct device_node *node,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_gate *gate = &clks[i];
>  
> +		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id]))
> +			continue;
> +
>  		clk = mtk_clk_register_gate(gate->name, gate->parent_name,
>  				regmap,
>  				gate->regs->set_ofs,
> @@ -232,6 +241,9 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_composite *mc = &mcs[i];
>  
> +		if (!IS_ERR_OR_NULL(clk_data->clks[mc->id]))
> +			continue;
> +
>  		clk = mtk_clk_register_composite(mc, base, lock);
>  
>  		if (IS_ERR(clk)) {
> @@ -244,3 +256,31 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  			clk_data->clks[mc->id] = clk;
>  	}
>  }
> +
> +void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> +			int num, void __iomem *base, spinlock_t *lock,
> +				struct clk_onecell_data *clk_data)
> +{
> +	struct clk *clk;
> +	int i;
> +
> +	for (i = 0; i <  num; i++) {
> +		const struct mtk_clk_divider *mcd = &mcds[i];
> +
> +		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id]))

This dereferences clk_data...

> +			continue;
> +
> +		clk = clk_register_divider(NULL, mcd->name, mcd->parent_name,
> +			mcd->flags, base +  mcd->div_reg, mcd->div_shift,
> +			mcd->div_width, mcd->clk_divider_flags, lock);
> +
> +		if (IS_ERR(clk)) {
> +			pr_err("Failed to register clk %s: %ld\n",
> +				mcd->name, PTR_ERR(clk));
> +			continue;
> +		}
> +
> +		if (clk_data)

And then we check it for NULL here? That doesn't make any sense.

> +			clk_data->clks[mcd->id] = clk;
> +	}
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
