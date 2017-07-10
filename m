From: oliver@schinagl.nl (Olliver Schinagl)
Date: Mon, 10 Jul 2017 11:45:32 +0200
Subject: [linux-sunxi] [PATCH v5 2/6] clk: sunxi-ng: Add sun4i/sun7i CCU
 driver
In-Reply-To: <65066c74b8dedfeb8de27d90b5fecfea3a700178.1499197129.git-series.plaes@plaes.org>
References: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
 <65066c74b8dedfeb8de27d90b5fecfea3a700178.1499197129.git-series.plaes@plaes.org>
Message-ID: <5099cd90-e019-8a65-38e5-02b3c939a7a8@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pleas,

again, but this time with content :)

On 04-07-17 22:04, Priit Laes wrote:
> Introduce a clock controller driver for sun4i A10 and sun7i A20
> series SoCs.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/Kconfig              |   14 +-
>  drivers/clk/sunxi-ng/Makefile             |    1 +-
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.c      | 1448 ++++++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.h      |   61 +-
>  include/dt-bindings/clock/sun4i-a10-ccu.h |  200 +++-
>  include/dt-bindings/clock/sun7i-a20-ccu.h |   53 +-
>  include/dt-bindings/reset/sun4i-a10-ccu.h |   67 +-
>  7 files changed, 1844 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.h
>  create mode 100644 include/dt-bindings/clock/sun4i-a10-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun7i-a20-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun4i-a10-ccu.h
>
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 7342928..381cc32 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -11,6 +11,19 @@ config SUN50I_A64_CCU
>  	default ARM64 && ARCH_SUNXI
>  	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>
> +config SUNXI_A10_CCU
I understand why you say sunXi here (it's support for both sun4i and 
sun7i) but then why A10, as it also supports the A20.

I guess the CCU is identical on the A20 and the A10, right? Thus would 
it not be sensible to just call it sun4i_ccu (like we do for sun5i_ccu 
below?

> +	bool "Support for the Allwinner A10/A20 CCU"
> +	select SUNXI_CCU_DIV
> +	select SUNXI_CCU_MULT
> +	select SUNXI_CCU_NK
> +	select SUNXI_CCU_NKM
> +	select SUNXI_CCU_NM
> +	select SUNXI_CCU_MP
> +	select SUNXI_CCU_PHASE
> +	default MACH_SUN4I
> +	default MACH_SUN7I
> +	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
> +
>  config SUN5I_CCU
>  	bool "Support for the Allwinner sun5i family CCM"
>  	default MACH_SUN5I
> @@ -57,4 +70,5 @@ config SUN8I_R_CCU
>  	bool "Support for Allwinner SoCs' PRCM CCUs"
>  	default MACH_SUN8I || (ARCH_SUNXI && ARM64)
>
> +
oops?

>  endif
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 0c45fa5..01e958c 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -21,6 +21,7 @@ lib-$(CONFIG_SUNXI_CCU)		+= ccu_mp.o
>  obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
>  obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
>  obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
> +obj-$(CONFIG_SUNXI_A10_CCU)	+= ccu-sun4i-a10.o
>  obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
>  obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
>  obj-$(CONFIG_SUN8I_A83T_CCU)	+= ccu-sun8i-a83t.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> new file mode 100644
> index 0000000..49052b7
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c

<snip>

> +static const char *const apb1_parents[] = { "hosc", "pll-periph", "osc32k" };
> +static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", apb1_parents, 0x058,
> +			     0, 5,	/* M */
> +			     16, 2,	/* P */
> +			     24, 2,	/* mux */
> +			     0);
> +
> +/* Not present on A20 */
> +static SUNXI_CCU_GATE(axi_dram_clk,	"axi-dram",	"ahb",
> +		      0x05c, BIT(31), 0);

Same here I guess, two defines make this a bit more readable.
> +
> +static SUNXI_CCU_GATE(ahb_otg_clk,	"ahb-otg",	"ahb",
> +		      0x060, BIT(0), 0);
> +static SUNXI_CCU_GATE(ahb_ehci0_clk,	"ahb-ehci0",	"ahb",
> +		      0x060, BIT(1), 0);
> +static SUNXI_CCU_GATE(ahb_ohci0_clk,	"ahb-ohci0",	"ahb",
> +		      0x060, BIT(2), 0);
> +static SUNXI_CCU_GATE(ahb_ehci1_clk,	"ahb-ehci1",	"ahb",
> +		      0x060, BIT(3), 0);
> +static SUNXI_CCU_GATE(ahb_ohci1_clk,	"ahb-ohci1",	"ahb",
> +		      0x060, BIT(4), 0);
> +static SUNXI_CCU_GATE(ahb_ss_clk,	"ahb-ss",	"ahb",
> +		      0x060, BIT(5), 0);
> +static SUNXI_CCU_GATE(ahb_dma_clk,	"ahb-dma",	"ahb",
> +		      0x060, BIT(6), 0);
> +static SUNXI_CCU_GATE(ahb_bist_clk,	"ahb-bist",	"ahb",
> +		      0x060, BIT(7), 0);
> +static SUNXI_CCU_GATE(ahb_mmc0_clk,	"ahb-mmc0",	"ahb",
> +		      0x060, BIT(8), 0);
> +static SUNXI_CCU_GATE(ahb_mmc1_clk,	"ahb-mmc1",	"ahb",
> +		      0x060, BIT(9), 0);
> +static SUNXI_CCU_GATE(ahb_mmc2_clk,	"ahb-mmc2",	"ahb",
> +		      0x060, BIT(10), 0);
> +static SUNXI_CCU_GATE(ahb_mmc3_clk,	"ahb-mmc3",	"ahb",
> +		      0x060, BIT(11), 0);
> +static SUNXI_CCU_GATE(ahb_ms_clk,	"ahb-ms",	"ahb",
> +		      0x060, BIT(12), 0);
> +static SUNXI_CCU_GATE(ahb_nand_clk,	"ahb-nand",	"ahb",
> +		      0x060, BIT(13), 0);
> +static SUNXI_CCU_GATE(ahb_sdram_clk,	"ahb-sdram",	"ahb",
> +		      0x060, BIT(14), CLK_IS_CRITICAL);

<snip>

> +static struct ccu_reset_map sun7i_a20_ccu_resets[] = {
> +	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
> +	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
> +	[RST_USB_PHY2]		= { 0x0cc, BIT(2) },
> +	[RST_GPS]		= { 0x0d0, BIT(0) },
> +	[RST_DE_BE0]		= { 0x104, BIT(30) },
> +	[RST_DE_BE1]		= { 0x108, BIT(30) },
> +	[RST_DE_FE0]		= { 0x10c, BIT(30) },
> +	[RST_DE_FE1]		= { 0x110, BIT(30) },
> +	[RST_DE_MP]		= { 0x114, BIT(30) },
> +	[RST_TCON0]		= { 0x118, BIT(30) },
> +	[RST_TCON1]		= { 0x11c, BIT(30) },
You are missing the TV encoder reset:
+      [RST_TVE0]              = { 0x118, BIT(29) },
+      [RST_TVE1]              = { 0x11c, BIT(29) },

(to match your table i did not use defines :p)

> +	[RST_CSI0]		= { 0x134, BIT(30) },
> +	[RST_CSI1]		= { 0x138, BIT(30) },
> +	[RST_VE]		= { 0x13c, BIT(0) },
> +	[RST_ACE]		= { 0x148, BIT(16) },
> +	[RST_LVDS]		= { 0x14c, BIT(0) },
> +	[RST_GPU]		= { 0x154, BIT(30) },
> +	[RST_HDMI_H]		= { 0x170, BIT(0) },
> +	[RST_HDMI_SYS]		= { 0x170, BIT(1) },
> +	[RST_HDMI_AUDIO_DMA]	= { 0x170, BIT(2) },
> +};

<snip>

> +#ifndef _DT_BINDINGS_RST_SUN4I_A10_H
> +#define _DT_BINDINGS_RST_SUN4I_A10_H
> +
> +#define	RST_USB_PHY0		1
> +#define	RST_USB_PHY1		2
> +#define	RST_USB_PHY2		3
> +#define	RST_GPS			4
> +#define	RST_DE_BE0		5
> +#define	RST_DE_BE1		6
> +#define	RST_DE_FE0		7
> +#define	RST_DE_FE1		8
> +#define	RST_DE_MP		9
> +#define	RST_TCON0		10
> +#define	RST_TCON1		11

Also here the TV encoder.

+#define RST_TVE0              21
+#define RST_TVE1              22

> +#define	RST_CSI0		12
> +#define	RST_CSI1		13
> +#define	RST_VE			14
> +#define	RST_ACE			15
> +#define	RST_LVDS		16
> +#define	RST_GPU			17
> +#define	RST_HDMI_H		18
> +#define	RST_HDMI_SYS		19
> +#define	RST_HDMI_AUDIO_DMA	20
> +
> +#endif /* DT_BINDINGS_RST_SUN4I_A10_H */
>
