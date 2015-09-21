From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 21 Sep 2015 15:27:13 +0800
Subject: [PATCH 2/5] pinctrl: berlin: add the berlin4ct pinctrl driver
In-Reply-To: <55FF09D5.6090707@gmail.com>
References: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
 <1442656956-5740-3-git-send-email-jszhang@marvell.com>
 <55FF09D5.6090707@gmail.com>
Message-ID: <20150921152713.523b7ab5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Sun, 20 Sep 2015 21:32:37 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 19.09.2015 12:02, Jisheng Zhang wrote:
> > Add the pin-controller driver for Marvell Berlin BG4CT SoC, with definition
> > of its groups and functions. This uses the core Berlin pinctrl driver.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> [...]
> > diff --git a/drivers/pinctrl/berlin/berlin4ct.c b/drivers/pinctrl/berlin/berlin4ct.c
> > new file mode 100644
> > index 0000000..2960e16
> > --- /dev/null
> > +++ b/drivers/pinctrl/berlin/berlin4ct.c
> > @@ -0,0 +1,503 @@
> > +/*
> > + * Marvell berlin4ct pinctrl driver
> [...]
> > +static const struct berlin_desc_group berlin4ct_soc_pinctrl_groups[] = {
> > +	BERLIN_PINCTRL_GROUP("EMMC_RSTn", 0x0, 0x3, 0x00,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "emmc_rstn"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "gpio47")),
> 
> Jisheng,
> 
> I am fine with naming the groups after the 0x0 function but
> the functions themselves should be named after a generic
> name, e.g. "emmc" instead of "emmc_rstn".

This seems better. Will change in newer version.

> 
> That will allow to add pinmux nodes like
> 
> uart_pmx {
> 	groups = "SM_UART0_TXD", "SM_UART0_RXD";
> 	function = "uart0";
> };
> 
> instead of two separate nodes like in patch 5/5.
> 
> You should however keep the actual pin function e.g. in a comment
> after the function define above:
> 
> BERLIN_PINCTRL_GROUP("EMMC_RSTn", 0x0, 0x3, 0x00,
> 	BERLIN_PINCTRL_FUNCTION(0x0, "emmc"),	/* RESETn */
> 	BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),	/* GPIO47 */
> 
> > +	BERLIN_PINCTRL_GROUP("NAND_IO0", 0x0, 0x3, 0x03,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_rxd0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_clk"),
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "gpio0")),
> [...]
> > +	BERLIN_PINCTRL_GROUP("SD0_CLK", 0x4, 0x3, 0x12,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio29"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_clk"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "sts4_clk"),
> 
> Please find a better name for "sts" whatever it is for.

sts is one kind of HW component, and that's what we called it.

> 
> > +			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg8"),
> 
> ditto for "v4g"

v4g is another kind of HW component which is called as "v4g"

> 
> > +			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg8")),
> [...]
> > +	BERLIN_PINCTRL_GROUP("SCRD0_RST", 0xc, 0x3, 0x06,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio15"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_rst"),
> 
> ditto for "scrd0"

scrd stands for smartcard. But it's what HW/ASIC call them

> 
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_clk")),
> > +	BERLIN_PINCTRL_GROUP("SCRD0_DCLK", 0xc, 0x3, 0x09,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio16"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_dclk"),
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_cmd")),
> 
> What is the "a" for in "sd1a" ? There is a "sd1b" below so I
> guess that there is two pinmux groups that mux sd1?

Yes, correct.

> 
> > +	BERLIN_PINCTRL_GROUP("SCRD0_GPIO0", 0xc, 0x3, 0x0c,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio17"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_gpio0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "sif_dio"),
> 
> What kind of interface is "sif" ?

serial interface, ASIC called it as SIF

> 
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_dat0")),
> [...]
> > +static const struct berlin_desc_group berlin4ct_soc_aviopinctrl_groups[] = {
> > +	BERLIN_PINCTRL_GROUP("TX_EDDC_SCL", 0x0, 0x3, 0x00,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "tx_eddc_scl"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "tw1_scl")),
> > +	BERLIN_PINCTRL_GROUP("TX_EDDC_SDA", 0x0, 0x3, 0x03,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio1"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "tx_eddc_sda"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "tw1_sda")),
> > +	BERLIN_PINCTRL_GROUP("I2S1_LRCKO", 0x0, 0x3, 0x06,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio2"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1_lrcko"),
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "sts6_clk"),
> > +			BERLIN_PINCTRL_FUNCTION(0x4, "adac_dbg0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_clk"),
> > +			BERLIN_PINCTRL_FUNCTION(0x7, "avio_dbg0")),
> [...]
> > +static const struct berlin_desc_group berlin4ct_sysmgr_pinctrl_groups[] = {
> > +	BERLIN_PINCTRL_GROUP("SM_TW2_SCL", 0x0, 0x3, 0x00,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio19"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw2_scl")),
> 
> I'd say, remove the "sm_" prefix for all of the SM functions if
> there is no collusion with any of the other functions.

Could I keep "sm_" prefix for SM GPIOs?

> 
> > +	BERLIN_PINCTRL_GROUP("SM_TW2_SDA", 0x0, 0x3, 0x03,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio20"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw2_sda")),
> > +	BERLIN_PINCTRL_GROUP("SM_TW3_SCL", 0x0, 0x3, 0x06,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio21"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw3_scl")),
> > +	BERLIN_PINCTRL_GROUP("SM_TW3_SDA", 0x0, 0x3, 0x09,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio22"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw3_sda")),
> > +	BERLIN_PINCTRL_GROUP("SM_TMS", 0x0, 0x3, 0x0c,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_tms"),
> 
> Please use function "jtag" instead.

OK. So I also need to name "jtag" in below sm_tdi, sm_sdo, right?

> 
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "pwm0")),
> > +	BERLIN_PINCTRL_GROUP("SM_TDI", 0x0, 0x3, 0x0f,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_tdi"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio1"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "pwm1")),
> > +	BERLIN_PINCTRL_GROUP("SM_TDO", 0x0, 0x3, 0x12,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_tdo"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio2")),
> > +	BERLIN_PINCTRL_GROUP("SM_URT0_TXD", 0x0, 0x3, 0x15,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_urt0_txd"),
> 
> Please avoid abbreviating acronyms even more, we can afford the
> few extra bytes.
> 
> [...]
> > +	BERLIN_PINCTRL_GROUP("SM_URT1_TXD", 0x0, 0x3, 0x1b,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio5"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_urt1_txd"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "eth1_rxclk"),
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "pwm2"),
> > +			BERLIN_PINCTRL_FUNCTION(0x4, "sm_timer0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x5, "clk_25m")),
> 
> "clko" ?

This is for 25m clk output. but ASIC calls this clk_25m, there's no "o".

> 
> Sebastian
> 
> [...]
> > +static int berlin4ct_pinctrl_probe(struct platform_device *pdev)
> > +{
> > +	const struct of_device_id *match =
> > +		of_match_device(berlin4ct_pinctrl_match, &pdev->dev);
> > +	struct regmap_config *rmconfig;
> > +	struct regmap *regmap;
> > +	struct resource *res;
> > +	void __iomem *base;
> > +
> > +	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
> > +	if (!rmconfig)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	rmconfig->reg_bits = 32,
> > +	rmconfig->val_bits = 32,
> > +	rmconfig->reg_stride = 4,
> > +	rmconfig->max_register = resource_size(res);
> > +
> > +	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
> > +	if (IS_ERR(regmap))
> > +		return PTR_ERR(regmap);
> > +
> > +	return berlin_pinctrl_probe(pdev, regmap, match->data);
> > +}
> > +
> > +static struct platform_driver berlin4ct_pinctrl_driver = {
> > +	.probe	= berlin4ct_pinctrl_probe,
> > +	.driver	= {
> > +		.name = "berlin4ct-pinctrl",
> > +		.of_match_table = berlin4ct_pinctrl_match,
> > +	},
> > +};
> > +module_platform_driver(berlin4ct_pinctrl_driver);
> > +
> > +MODULE_AUTHOR("Jisheng Zhang <jszhang@marvell.com>");
> > +MODULE_DESCRIPTION("Marvell berlin4ct pinctrl driver");
> > +MODULE_LICENSE("GPL");
> >
> 
