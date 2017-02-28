From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Feb 2017 09:21:08 +0100
Subject: [PATCH 2/4] clk: sunxi-ng: Add sun7i-a20 CCU driver
In-Reply-To: <20170227210914.18954-3-plaes@plaes.org>
References: <20170227210914.18954-1-plaes@plaes.org>
 <20170227210914.18954-3-plaes@plaes.org>
Message-ID: <20170228082108.cthaanfuffbwbkaf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 27, 2017 at 11:09:12PM +0200, Priit Laes wrote:
> Introduce a clock controller driver for sun7i A20 SoC.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/Kconfig         |   11 +
>  drivers/clk/sunxi-ng/Makefile        |    1 +
>  drivers/clk/sunxi-ng/ccu-sun7i-a20.c | 1068 ++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun7i-a20.h |  121 ++++
>  4 files changed, 1201 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun7i-a20.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun7i-a20.h
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 695bbf9..4f436ab 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -85,6 +85,17 @@ config SUN6I_A31_CCU
>  	select SUNXI_CCU_PHASE
>  	default MACH_SUN6I
>  
> +config SUN7I_A20_CCU
> +	bool "Support for the Allwinner A20 CCU"
> +	select SUNXI_CCU_DIV
> +	select SUNXI_CCU_MULT
> +	select SUNXI_CCU_NK
> +	select SUNXI_CCU_NKM
> +	select SUNXI_CCU_NM
> +	select SUNXI_CCU_MP
> +	select SUNXI_CCU_PHASE
> +	default MACH_SUN7I
> +
>  config SUN8I_A23_CCU
>  	bool "Support for the Allwinner A23 CCU"
>  	select SUNXI_CCU_DIV
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 6feaac0..bedda5b 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
>  obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
>  obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
>  obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
> +obj-$(CONFIG_SUN7I_A20_CCU)	+= ccu-sun7i-a20.o
>  obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
>  obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
>  obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun7i-a20.c b/drivers/clk/sunxi-ng/ccu-sun7i-a20.c
> new file mode 100644
> index 0000000..90d2f13
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun7i-a20.c
> @@ -0,0 +1,1068 @@
> +/*
> + * Copyright (c) 2017 Priit Laes. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_mult.h"
> +#include "ccu_nk.h"
> +#include "ccu_nkm.h"
> +#include "ccu_nkmp.h"
> +#include "ccu_nm.h"
> +#include "ccu_phase.h"
> +
> +#include "ccu-sun7i-a20.h"
> +
> +/*
> + * PLL1 - Core clock
> + *
> + * TODO: sigma-delta pattern bits 2 & 3
> + * TODO: PLL1 tuning register

I don't think we need those TODO's at all, and these comments too. If
the clock name is good enough (and it is), it's redundant.

> + */
> +static struct ccu_nkmp pll_core_clk = {
> +	.enable		= BIT(31),
> +	.n		= _SUNXI_CCU_MULT_OFFSET(8, 5, 0),
> +	.k		= _SUNXI_CCU_MULT(4, 2),
> +	.m		= _SUNXI_CCU_DIV(0, 2),
> +	.p		= _SUNXI_CCU_DIV(16, 2),
> +	.common		= {
> +		.reg		= 0x000,
> +		.hw.init	= CLK_HW_INIT("pll-core",
> +					      "hosc",
> +					      &ccu_nkmp_ops,
> +					      0),
> +	},
> +};
> +
> +/* PLL2 - Audio clock */
> +static struct ccu_nm pll_audio_base_clk = {
> +	.enable		= BIT(31),
> +	.n		= _SUNXI_CCU_MULT_OFFSET(8, 7, 0),
> +	.m		= _SUNXI_CCU_DIV_OFFSET(0, 5, 0),
> +	.common		= {
> +		.reg		= 0x008,
> +		.hw.init	= CLK_HW_INIT("pll-audio-base",
> +					      "hosc",
> +					      &ccu_nm_ops,
> +					      0),
> +	},
> +
> +};

You're forgetting the post-divider here

> +/* TODO: pll8 gpu 0x040 */

Please add all the clocks.

> +/* BIT(21 .. 31) - reserved */

I'm not sure we need those comments either.

> +/*
> + * TODO: SATA clock also supports external clock as parent.
> + * Currently we default to using PLL6 SATA gate.
> + */

Which external clock? It should be modelled anyway. If we have a
dependency on some other clock, it should be in our DT binding, and
listed in the mux there.

Otherwise, the clock framework will not be able to deal with that mux
being already set by the bootloader, and if we need to support that
clock in the future, our binding will be ready for it.

> +static CLK_FIXED_FACTOR(pll_periph_2x_clk, "pll-periph-2x",
> +			"pll-periph", 1, 2, CLK_SET_RATE_PARENT);
> +/* We hardcode the divider to 4 for now */
> +static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
> +			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
> +static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
> +			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
> +static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
> +			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
> +static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
> +			"pll-audio-base", 1, 2, CLK_SET_RATE_PARENT);
> +static CLK_FIXED_FACTOR(pll_video0_2x_clk, "pll-video0-2x",
> +			"pll-video0", 1, 2, CLK_SET_RATE_PARENT);
> +static CLK_FIXED_FACTOR(pll_video1_2x_clk, "pll-video1-2x",
> +			"pll-video1", 1, 2, CLK_SET_RATE_PARENT);

It feels more natural to just have the clocks defined in the same
order than their parents. So periph shouldn't be first

> +static struct ccu_reset_map sun7i_a20_ccu_resets[] = {
> +
> +	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
> +	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
> +	[RST_USB_PHY2]		= { 0x0cc, BIT(2) },
> +	[RST_DE_BE0]		= { 0x104, BIT(30) },
> +	[RST_DE_BE1]		= { 0x108, BIT(30) },
> +	[RST_DE_FE0]		= { 0x10c, BIT(30) },
> +	[RST_DE_FE1]		= { 0x110, BIT(30) },
> +	[RST_DE_MP]		= { 0x114, BIT(30) },
> +	[RST_TCON0]		= { 0x118, BIT(30) },
> +	[RST_TCON1]		= { 0x11c, BIT(30) },
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
> +
> +static const struct sunxi_ccu_desc sun7i_a20_ccu_desc = {
> +	.ccu_clks	= sun7i_a20_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun7i_a20_ccu_clks),
> +
> +	.hw_clks	= &sun7i_a20_hw_clks,
> +
> +	.resets		= sun7i_a20_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun7i_a20_ccu_resets),
> +};
> +
> +static void __init sun7i_a20_ccu_setup(struct device_node *node)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n",
> +		       of_node_full_name(node));
> +		return;
> +	}
> +
> +	#define SUN7I_PLL_AUDIO_REG	0x008

This should be defined above

> +
> +	/* Force the PLL-Audio-1x divider to 4 */
> +	val = readl(reg + SUN7I_PLL_AUDIO_REG);
> +	val &= ~GENMASK(19, 16);
> +	writel(val | (3 << 16), reg + SUN7I_PLL_AUDIO_REG);
> +
> +	/*
> +	 * Use PLL6 as parent for AHB
> +	 * CPU/AXI clock changes rate when cpufreq is enabled

I'm not sure why that last sentence is needed too. A lot of clock
listed there change rate when <some-feature> is enabled.

> +/* Some AHB gates are exported */
> +#define CLK_AHB_BIST		31
> +#define CLK_AHB_MS		36
> +#define CLK_AHB_SDRAM		38
> +#define CLK_AHB_ACE		39
> +#define CLK_AHB_TS		41
> +#define CLK_AHB_VE		48
> +#define CLK_AHB_TVD		49
> +#define CLK_AHB_TVE1		51
> +#define CLK_AHB_LCD1		53
> +#define CLK_AHB_CSI0		54
> +#define CLK_AHB_CSI1		55
> +#define CLK_AHB_HDMI0		56
> +#define CLK_AHB_DE_BE1		59
> +#define CLK_AHB_DE_FE0		60
> +#define CLK_AHB_DE_FE1		61
> +#define CLK_AHB_MP		63
> +#define CLK_AHB_GPU		64
> +
> +/* Some APB0 gates are exported */
> +#define CLK_APB0_AC97		67
> +#define CLK_APB0_KEYPAD		74
> +
> +/* Some APB1 gates are exported */
> +#define CLK_APB1_CAN		79
> +#define CLK_APB1_SCR		80
> +
> +/* Some IP module clocks are exported */
> +#define CLK_MS			93
> +#define CLK_TS			106
> +#define CLK_PATA		111
> +#define CLK_AC97		115
> +#define CLK_KEYPAD		117
> +#define CLK_SATA		118
> +
> +/* Some DRAM gates are exported */
> +#define CLK_DRAM_VE		125
> +#define CLK_DRAM_CSI0		126
> +#define CLK_DRAM_CSI1		127
> +#define CLK_DRAM_TS		128
> +#define CLK_DRAM_TVD		129
> +#define CLK_DRAM_TVE1		131
> +#define CLK_DRAM_OUT		132
> +#define CLK_DRAM_DE_FE1		133
> +#define CLK_DRAM_DE_FE0		134
> +#define CLK_DRAM_DE_BE1		136
> +#define CLK_DRAM_MP		137
> +#define CLK_DRAM_ACE		138
> +
> +#define CLK_DE_BE1		140
> +#define CLK_DE_FE0		141
> +#define CLK_DE_FE1		142
> +#define CLK_DE_MP		143
> +#define CLK_TCON1_CH0		145
> +#define CLK_CSI_SPECIAL		146
> +#define CLK_TVD			147
> +#define CLK_TCON0_CH1_SCLK2	148
> +#define CLK_TCON1_CH1_SCLK2	150
> +#define CLK_TCON1_CH1		151
> +#define CLK_CSI0		152
> +#define CLK_CSI1		153
> +#define CLK_VE			154
> +#define CLK_AVS			156
> +#define CLK_ACE			157
> +#define CLK_HDMI		158
> +#define CLK_GPU			159
> +#define CLK_MBUS		160
> +#define CLK_HDMI1_SLOW		161
> +#define CLK_HDMI1_REPEAT	162
> +#define CLK_OUT_A		163
> +#define CLK_OUT_B		164

Is there a reason not to expose these clocks?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170228/f51e2583/attachment.sig>
