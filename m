From: plaes@plaes.org (Priit Laes)
Date: Thu, 13 Jul 2017 19:23:58 +0000
Subject: [linux-sunxi] [PATCH v5 2/6] clk: sunxi-ng: Add sun4i/sun7i CCU
 driver
In-Reply-To: <5099cd90-e019-8a65-38e5-02b3c939a7a8@schinagl.nl>
References: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
 <65066c74b8dedfeb8de27d90b5fecfea3a700178.1499197129.git-series.plaes@plaes.org>
 <5099cd90-e019-8a65-38e5-02b3c939a7a8@schinagl.nl>
Message-ID: <20170713192358.GB22375@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 11:45:32AM +0200, Olliver Schinagl wrote:
> Hi Pleas,
> 
> again, but this time with content :)
> 
> On 04-07-17 22:04, Priit Laes wrote:
> >Introduce a clock controller driver for sun4i A10 and sun7i A20
> >series SoCs.

[ ... ]

> >+++ b/drivers/clk/sunxi-ng/Kconfig
> >@@ -11,6 +11,19 @@ config SUN50I_A64_CCU
> > 	default ARM64 && ARCH_SUNXI
> > 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> >
> >+config SUNXI_A10_CCU
> I understand why you say sunXi here (it's support for both sun4i and sun7i)
> but then why A10, as it also supports the A20.
> 
> I guess the CCU is identical on the A20 and the A10, right? Thus would it
> not be sensible to just call it sun4i_ccu (like we do for sun5i_ccu below?

No, it's not identical.

> >+	bool "Support for the Allwinner A10/A20 CCU"
> >+	select SUNXI_CCU_DIV
> >+	select SUNXI_CCU_MULT
> >+	select SUNXI_CCU_NK
> >+	select SUNXI_CCU_NKM
> >+	select SUNXI_CCU_NM
> >+	select SUNXI_CCU_MP
> >+	select SUNXI_CCU_PHASE
> >+	default MACH_SUN4I
> >+	default MACH_SUN7I
> >+	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
> >+
> > config SUN5I_CCU
> > 	bool "Support for the Allwinner sun5i family CCM"
> > 	default MACH_SUN5I
> >@@ -57,4 +70,5 @@ config SUN8I_R_CCU
> > 	bool "Support for Allwinner SoCs' PRCM CCUs"
> > 	default MACH_SUN8I || (ARCH_SUNXI && ARM64)
> >
> >+
> oops?

OK

> 
> >new file mode 100644
> >index 0000000..49052b7
> >--- /dev/null
> >+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> 
> <snip>
> 
> >+static const char *const apb1_parents[] = { "hosc", "pll-periph", "osc32k" };
> >+static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", apb1_parents, 0x058,
> >+			     0, 5,	/* M */
> >+			     16, 2,	/* P */
> >+			     24, 2,	/* mux */
> >+			     0);
> >+
> >+/* Not present on A20 */
> >+static SUNXI_CCU_GATE(axi_dram_clk,	"axi-dram",	"ahb",
> >+		      0x05c, BIT(31), 0);
> 
> Same here I guess, two defines make this a bit more readable.

You mean SUN4I_CCU_GATE? and SUN7I_CCU_GATE defines?
I don't think it makes things more readable...

> >+
> >+static SUNXI_CCU_GATE(ahb_otg_clk,	"ahb-otg",	"ahb",
...
> >+		      0x060, BIT(14), CLK_IS_CRITICAL);
> 
> <snip>
> 
> >+static struct ccu_reset_map sun7i_a20_ccu_resets[] = {
> >+	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
> >+	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
> >+	[RST_USB_PHY2]		= { 0x0cc, BIT(2) },
> >+	[RST_GPS]		= { 0x0d0, BIT(0) },
> >+	[RST_DE_BE0]		= { 0x104, BIT(30) },
> >+	[RST_DE_BE1]		= { 0x108, BIT(30) },
> >+	[RST_DE_FE0]		= { 0x10c, BIT(30) },
> >+	[RST_DE_FE1]		= { 0x110, BIT(30) },
> >+	[RST_DE_MP]		= { 0x114, BIT(30) },
> >+	[RST_TCON0]		= { 0x118, BIT(30) },
> >+	[RST_TCON1]		= { 0x11c, BIT(30) },
> You are missing the TV encoder reset:
> +      [RST_TVE0]              = { 0x118, BIT(29) },
> +      [RST_TVE1]              = { 0x11c, BIT(29) },
> 
> (to match your table i did not use defines :p)

Where did you get this information?
This is not present in any datasheets I have:
  * A10 - 1.50
  * A20 - 1.4

[...]

P?ikest,
Priit Laes
