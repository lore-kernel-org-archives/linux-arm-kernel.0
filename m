From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 25 Sep 2017 13:10:11 +0930
Subject: [PATCH v2 1/5] clk: Add clock driver for ASPEED BMC SoCs
In-Reply-To: <20170921042641.7326-2-joel@jms.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-2-joel@jms.id.au>
Message-ID: <1506310811.30138.15.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-21 at 13:56 +0930, Joel Stanley wrote:
> This adds the stub of a driver for the ASPEED SoCs. The clocks are
> defined and the static registration is set up.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> ?drivers/clk/Kconfig??????????????????????|??12 +++
> ?drivers/clk/Makefile?????????????????????|???1 +
> ?drivers/clk/clk-aspeed.c?????????????????| 162 +++++++++++++++++++++++++++++++
> ?include/dt-bindings/clock/aspeed-clock.h |??43 ++++++++
> ?4 files changed, 218 insertions(+)
> ?create mode 100644 drivers/clk/clk-aspeed.c
> ?create mode 100644 include/dt-bindings/clock/aspeed-clock.h
>?
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 1c4e1aa6767e..9abe063ef8d2 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -142,6 +142,18 @@ config COMMON_CLK_GEMINI
> ?	??This driver supports the SoC clocks on the Cortina Systems Gemini
> ?	??platform, also known as SL3516 or CS3516.
> ?
> +config COMMON_CLK_ASPEED
> +	bool "Clock driver for Aspeed BMC SoCs"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	default ARCH_ASPEED
> +	select MFD_SYSCON
> +	select RESET_CONTROLLER
> +	---help---
> +	??This driver supports the SoC clocks on the Aspeed BMC platforms.
>
> +	??The G4 and G5 series, including the ast2400 and ast2500, are supported
> +	??by this driver.
> +
> ?config COMMON_CLK_S2MPS11
> ?	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
> ?	depends on MFD_SEC_CORE || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index c99f363826f0..575c68919d9b 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
> ?obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
> ?obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
> ?obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
> +obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
> ?obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
> ?obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
> ?obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> new file mode 100644
> index 000000000000..824c54767009
> --- /dev/null
> +++ b/drivers/clk/clk-aspeed.c
> @@ -0,0 +1,162 @@
> +/*
> + * Copyright 2017 IBM Corporation
> + *
> + * Joel Stanley <joel@jms.id.au>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) "clk-aspeed: " fmt
> +
> +#include <linux/slab.h>
> +#include <linux/of_address.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <dt-bindings/clock/aspeed-clock.h>
> +
> +#define ASPEED_RESET_CTRL	0x04
> +#define ASPEED_CLK_SELECTION	0x08
> +#define ASPEED_CLK_STOP_CTRL	0x0c
> +#define ASPEED_MPLL_PARAM	0x20
> +#define ASPEED_HPLL_PARAM	0x24
> +#define ASPEED_MISC_CTRL	0x2c
> +#define ASPEED_STRAP		0x70
> +
> +/* Keeps track of all clocks */
> +static struct clk_hw_onecell_data *aspeed_clk_data;
> +
> +static void __iomem *scu_base;
> +
> +/**
> + * struct aspeed_gate_data - Aspeed gated clocks
> + * @clock_idx: bit used to gate this clock in the clock register
> + * @reset_idx: bit used to reset this IP in the reset register. -1 if no
> + *?????????????reset is required when enabling the clock
> + * @name: the clock name
> + * @parent_name: the name of the parent clock
> + * @flags: standard clock framework flags
> + */
> +struct aspeed_gate_data {
> +	u8		clock_idx;
> +	s8		reset_idx;
> +	const char	*name;
> +	const char	*parent_name;
> +	unsigned long	flags;
> +};
> +
> +/**
> + * struct aspeed_clk_gate - Aspeed specific clk_gate structure
> + * @hw:		handle between common and hardware-specific interfaces
> + * @reg:	register controlling gate
> + * @clock_idx:	bit used to gate this clock in the clock register
> + * @reset_idx:	bit used to reset this IP in the reset register. -1 if no
> + *		reset is required when enabling the clock
> + * @flags:	hardware-specific flags
> + * @lock:	register lock
> + *
> + * Some of the clocks in the Aspeed SoC must be put in reset before enabling.
> + * This modified version of clk_gate allows an optional reset bit to be
> + * specified.
> + */
> +struct aspeed_clk_gate {
> +	struct clk_hw	hw;
> +	struct regmap	*map;
> +	u8		clock_idx;
> +	s8		reset_idx;
> +	u8		flags;
> +	spinlock_t	*lock;
> +};

It feels like the two structures could be unified, but the result turns into a
bit of a mess with a union of structs to limit the space impact, so perhaps we
shouldn't go there?

> +
> +#define to_aspeed_clk_gate(_hw) container_of(_hw, struct aspeed_clk_gate, hw)
> +
> +/* TODO: ask Aspeed about the actual parent data */
> +static const struct aspeed_gate_data aspeed_gates[] __initconst = {
> +/*	?clk rst???name			parent		flags	*/
> +	{??0, -1, "eclk-gate",		"eclk",		0 }, /* Video Engine */
> +	{??1,??7, "gclk-gate",		NULL,		0 }, /* 2D engine */
> +	{??2, -1, "mclk-gate",		"mpll",		CLK_IS_CRITICAL }, /* SDRAM */
> +	{??3,??6, "vclk-gate",		NULL,		0 }, /* Video Capture */
> +	{??4, 10, "bclk-gate",		"bclk",		0 }, /* PCIe/PCI */
> +	{??5, -1, "dclk-gate",		NULL,		0 }, /* DAC */
> +	{??6, -1, "refclk-gate",	"clkin",	CLK_IS_CRITICAL },
> +	{??7,??3, "usb-port2-gate",	NULL,		0 }, /* USB2.0 Host port 2 */
> +	{??8,??5, "lclk-gate",		NULL,		0 }, /* LPC */
> +	{??9, 15, "usb-uhci-gate",	NULL,		0 }, /* USB1.1 (requires port 2 enabled) */
> +	{ 10, 13, "d1clk-gate",		NULL,		0 }, /* GFX CRT */

Is there a typo in the AST2400 datasheet? It claims bit 10 is "D2CLK".

> +	/* 11: reserved */
> +	/* 12: reserved */
> +	{ 13, 4,??"yclk-gate",		NULL,		0 }, /* HAC */
> +	{ 14, 14, "usb-port1-gate",	NULL,		0 }, /* USB2 hub/USB2 host port 1/USB1.1 dev */
> +	{ 15, -1, "uart1clk-gate",	"uart",		0 }, /* UART1 */
> +	{ 16, -1, "uart2clk-gate",	"uart",		0 }, /* UART2 */
> +	{ 17, -1, "uart5clk-gate",	"uart",		0 }, /* UART5 */
> +	/* 18: reserved */
> +	{ 19, -1, "espiclk-gate",	NULL,		0 }, /* eSPI */

19 is reserved on the AST2400, and must be kept at '1'.

> +	{ 20, 11, "mac1clk-gate",	"clkin",	0 }, /* MAC1 */
> +	{ 21, 12, "mac2clk-gate",	"clkin",	0 }, /* MAC2 */
> +	/* 22: reserved */
> +	/* 23: reserved */
> +	{ 24, -1, "rsaclk-gate",	NULL,		0 }, /* RSA */
> +	{ 25, -1, "uart3clk-gate",	"uart",		0 }, /* UART3 */
> +	{ 26, -1, "uart4clk-gate",	"uart",		0 }, /* UART4 */
> +	{ 27, 16, "sdclk-gate",		NULL,		0 }, /* SDIO/SD */
> +	{ 28, -1, "lhclk-gate",		"lhclk",	0 }, /* LPC master/LPC+ */
> +	/* 29: reserved */
> +	/* 30: reserved */
> +	/* 31: reserved */

Interestingly bits 29-30 are reserved in both the AST2400 and AST2500
datasheets, but are reserved-clear in the AST2400 datasheet and reserved-set in
the AST2500 datasheet. This may affect how we write register.

Separately, at one point I mistook the clk column for the index the entry
should appear at, which isn't the case. Do you think designated intializers
might help?

> +};
> +
> +static void __init aspeed_cc_init(struct device_node *np)
> +{
> +	struct regmap *map;
> +	u32 val;
> +	int ret;
> +	int i;
>
> +	scu_base = of_iomap(np, 0);
> +	if (IS_ERR(scu_base))
> +		return;
> +
> +	aspeed_clk_data = kzalloc(sizeof(*aspeed_clk_data) +
> +			sizeof(*aspeed_clk_data->hws) * ASPEED_NUM_CLKS,
> +			GFP_KERNEL);
> +	if (!aspeed_clk_data)
> +		return;
> +
> +	/*
> +	?* This way all clock fetched before the platform device probes,

Typo: "clocks"

> +	?* except those we assign here for early use, will be deferred.
> +	?*/
> +	for (i = 0; i < ASPEED_NUM_CLKS; i++)
> +		aspeed_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +	map = syscon_node_to_regmap(np);
> +	if (IS_ERR(map)) {
> +		pr_err("no syscon regmap\n");
> +		return;
> +	}
> +	/*
> +	?* We check that the regmap works on this very first access,
> +	?* but as this is an MMIO-backed regmap, subsequent regmap
> +	?* access is not going to fail and we skip error checks from
> +	?* this point.
> +	?*/
> +	ret = regmap_read(map, ASPEED_STRAP, &val);
> +	if (ret) {
> +		pr_err("failed to read strapping register\n");
> +		return;
> +	}
> +
> +	aspeed_clk_data->num = ASPEED_NUM_CLKS;
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, aspeed_clk_data);
> +	if (ret)
> +		pr_err("failed to add DT provider: %d\n", ret);
> +};
> +CLK_OF_DECLARE_DRIVER(aspeed_cc_g5, "aspeed,ast2500-scu", aspeed_cc_init);
> +CLK_OF_DECLARE_DRIVER(aspeed_cc_g4, "aspeed,ast2400-scu", aspeed_cc_init);
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> new file mode 100644
> index 000000000000..afe06b77562d
> --- /dev/null
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -0,0 +1,43 @@
> +#ifndef DT_BINDINGS_ASPEED_CLOCK_H
> +#define DT_BINDINGS_ASPEED_CLOCK_H
> +
> +#define ASPEED_NUM_CLKS	34

This is a bit of a nit pick: Do the constants below represent all the
clocks in the SoC(s)? Maybe if not it's better to define
ASPEED_NUM_CLKS in terms of (n + ASPEED_CLK_GATES) at the bottom - that
way when a clock or gate is added ASPEED_NUM_CLKS has better locality and
better visual progression in context.

As a note, and as a clk noob but as someone with access to the Aspeed
datasheet, I was wondering whether the clocks and gates need to be represented
in the same number space. However it seems to be so by how it's used with
respect to struct clk_hw_onecell_data.

> +
> +#define ASPEED_CLK_HPLL			0
> +#define ASPEED_CLK_AHB			1
> +#define ASPEED_CLK_APB			2
> +#define ASPEED_CLK_UART			3
> +#define ASPEED_CLK_SDIO			4
> +#define ASPEED_CLK_ECLK			5
> +#define ASPEED_CLK_ECLK_MUX		6
> +#define ASPEED_CLK_LHCLK		7
> +#define ASPEED_CLK_MAC			8
> +#define ASPEED_CLK_BCLK			9
> +#define ASPEED_CLK_MPLL			10
> +#define ASPEED_CLK_GATES		11
> +#define ASPEED_CLK_GATE_ECLK		(0 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_GCLK		(1 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_MCLK		(2 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_VCLK		(3 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_BCLK		(4 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_DCLK		(5 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_REFCLK		(6 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_USBPORT2CLK	(7 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_LCLK		(8 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_USBUHCICLK	(9 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_D1CLK		(10 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_YCLK		(11 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_USBPORT1CLK	(12 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_UART1CLK	(13 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_UART2CLK	(14 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_UART5CLK	(15 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_ESPICLK		(16 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_MAC1CLK		(17 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_MAC2CLK		(18 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_RSACLK		(19 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_UART3CLK	(20 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_UART4CLK	(21 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_SDCLKCLK	(22 + ASPEED_CLK_GATES)
> +#define ASPEED_CLK_GATE_LHCCLK		(23 + ASPEED_CLK_GATES)

Looks like there's an off-by-one error here: ASPEED_NUM_CLKS should be (23 +
ASPEED_CLK_GATES + 1) = 35.

Cheers,

Andrew

> +
> +#endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/92e3efd1/attachment.sig>
