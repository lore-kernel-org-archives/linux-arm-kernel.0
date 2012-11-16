From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Nov 2012 13:52:44 +0100
Subject: [PATCH 1/7] clk: mvebu: add mvebu core clocks.
In-Reply-To: <1353014906-31566-2-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
 <1353014906-31566-2-git-send-email-andrew@lunn.ch>
Message-ID: <50A6371C.9060204@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 11/15/2012 10:28 PM, Andrew Lunn wrote:
> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> This driver allows to provide DT clocks for core clocks found on
> Marvell Kirkwood, Dove & 370/XP SoCs. The core clock frequencies and
> ratios are determined by decoding the Sample-At-Reset registers.
> 
> Although technically correct, using a divider of 0 will lead to
> div_by_zero panic. Let's use a ratio of 0/1 instead to fail later
> with a zero clock.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   47 ++
>  drivers/clk/Kconfig                                |    2 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/mvebu/Kconfig                          |    3 +
>  drivers/clk/mvebu/Makefile                         |    1 +
>  drivers/clk/mvebu/clk-core.c                       |  675 ++++++++++++++++++++
>  drivers/clk/mvebu/clk-core.h                       |   18 +
>  drivers/clk/mvebu/clk.c                            |   23 +
>  include/linux/clk/mvebu.h                          |   22 +
>  9 files changed, 792 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
>  create mode 100644 drivers/clk/mvebu/Kconfig
>  create mode 100644 drivers/clk/mvebu/Makefile
>  create mode 100644 drivers/clk/mvebu/clk-core.c
>  create mode 100644 drivers/clk/mvebu/clk-core.h
>  create mode 100644 drivers/clk/mvebu/clk.c
>  create mode 100644 include/linux/clk/mvebu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
> new file mode 100644
> index 0000000..84cfae7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
> @@ -0,0 +1,47 @@
> +* Core Clock bindings for Marvell MVEBU SoCs
> +
> +Marvell MVEBU SoCs usually allow to determine core clock frequencies by
> +reading the Sample-At-Reset (SAR) register. The core clock consumer should
> +specify the desired clock by having the clock ID in its "clocks" phandle cell.
> +
> +The following is a list of provided IDs and clock names on Kirkwood and Dove:
> + 0 = tclk   (Internal Bus clock)
> + 1 = cpuclk (CPU0 clock)
> + 2 = l2clk  (L2 Cache clock derived from CPU0 clock)
> + 3 = ddrclk (DDR controller clock derived from CPU0 clock)
> +
> +The following is a list of provided IDs and clock names on 370/XP:

You should call them Aramda 370 and Aramda XP. You do this modification
in the 2nd patch but it should be squashed in this patch.

> + 0 = tclk    (Internal Bus clock)
> + 1 = cpuclk  (CPU clock)
> + 2 = nbclk   (L2 Cache clock)
> + 3 = hclk    (DRAM control clock)
> + 4 = dramclk (DDR clock)
> +
> +Required properties:
> +- compatible : shall be one of the following:
> +	"marvell,dove-core-clocks" - for Dove SoC core clocks
> +	"marvell,kirkwood-core-clocks" - for Kirkwood SoC (except mv88f6180)
> +	"marvell,mv88f6180-core-clocks" - for Kirkwood MV88f6180 SoC
> +	"marvell,370-core-clocks" - For 370 SoC core clocks
> +	"marvell,xp-core-clocks" - For XP SoC core clocks

Same here.

> +- reg : shall be the register address of the Sample-At-Reset (SAR) register
> +- #clock-cells : from common clock binding; shall be set to 1
> +
> +Optional properties:
> +- clock-output-names : from common clock binding; allows overwrite default clock
> +	output names ("tclk", "cpuclk", "l2clk", "ddrclk")
> +
> +Example:
> +
> +core_clk: core-clocks at d0214 {
> +	compatible = "marvell,dove-core-clocks";
> +	reg = <0xd0214 0x4>;
> +	#clock-cells = <1>;
> +};
> +
> +spi0: spi at 10600 {
> +	compatible = "marvell,orion-spi";
> +	/* ... */
> +	/* get tclk from core clock provider */
> +	clocks = <&core_clk 0>;
> +};
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index bace9e9..60427c0 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -54,3 +54,5 @@ config COMMON_CLK_MAX77686
>  	  This driver supports Maxim 77686 crystal oscillator clock. 
>  
>  endmenu
> +
> +source "drivers/clk/mvebu/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 71a25b9..d0a14ae 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PLAT_SPEAR)	+= spear/
>  obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
>  obj-$(CONFIG_COMMON_CLK_VERSATILE) += versatile/
>  obj-$(CONFIG_ARCH_PRIMA2)	+= clk-prima2.o
> +obj-$(CONFIG_PLAT_ORION)	+= mvebu/
>  ifeq ($(CONFIG_COMMON_CLK), y)
>  obj-$(CONFIG_ARCH_MMP)		+= mmp/
>  endif
> diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
> new file mode 100644
> index 0000000..fd7bf97
> --- /dev/null
> +++ b/drivers/clk/mvebu/Kconfig
> @@ -0,0 +1,3 @@
> +config MVEBU_CLK_CORE
> +       bool
> +
> diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
> new file mode 100644
> index 0000000..de1d961
> --- /dev/null
> +++ b/drivers/clk/mvebu/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_MVEBU_CLK_CORE) 	+= clk.o clk-core.o
> diff --git a/drivers/clk/mvebu/clk-core.c b/drivers/clk/mvebu/clk-core.c
> new file mode 100644
> index 0000000..26ba835
> --- /dev/null
> +++ b/drivers/clk/mvebu/clk-core.c
> @@ -0,0 +1,675 @@
> +/*
> + * Marvell EBU clock core handling defined at reset
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include "clk-core.h"
> +
> +struct core_ratio {
> +	int id;
> +	const char *name;
> +};
> +
> +struct core_clocks {
> +	u32 (*get_tclk_freq)(void __iomem *sar);
> +	u32 (*get_cpu_freq)(void __iomem *sar);
> +	void (*get_clk_ratio)(void __iomem *sar, int id, int *mult, int *div);
> +	const struct core_ratio *ratios;
> +	int num_ratios;
> +};
> +
> +static struct clk_onecell_data clk_data;
> +
> +static void __init mvebu_clk_core_setup(struct device_node *np,
> +				 struct core_clocks *coreclk)
> +{
> +	const char *tclk_name = "tclk";
> +	const char *cpuclk_name = "cpuclk";
> +	void __iomem *base;
> +	unsigned long rate;
> +	int n;
> +
> +	base = of_iomap(np, 0);
> +	if (WARN_ON(!base))
> +		return;
> +
> +	/*
> +	 * Allocate struct for TCLK, cpu clk, and core ratio clocks
> +	 */
> +	clk_data.clk_num = 2 + coreclk->num_ratios;
> +	clk_data.clks = kzalloc(clk_data.clk_num * sizeof(struct clk *),
> +				GFP_KERNEL);
> +	if (WARN_ON(!clk_data.clks))
> +		return;
> +
> +	/*
> +	 * Register TCLK
> +	 */
> +	of_property_read_string_index(np, "clock-output-names", 0,
> +				      &tclk_name);
> +	rate = coreclk->get_tclk_freq(base);
> +	clk_data.clks[0] = clk_register_fixed_rate(NULL, tclk_name, NULL,
> +						   CLK_IS_ROOT, rate);
> +	WARN_ON(IS_ERR(clk_data.clks[0]));
> +
> +	/*
> +	 * Register CPU clock
> +	 */
> +	of_property_read_string_index(np, "clock-output-names", 1,
> +				      &cpuclk_name);
> +	rate = coreclk->get_cpu_freq(base);
> +	clk_data.clks[1] = clk_register_fixed_rate(NULL, cpuclk_name, NULL,
> +						   CLK_IS_ROOT, rate);
> +	WARN_ON(IS_ERR(clk_data.clks[1]));
> +
> +	/*
> +	 * Register fixed-factor clocks derived from CPU clock
> +	 */
> +	for (n = 0; n < coreclk->num_ratios; n++) {
> +		const char *rclk_name = coreclk->ratios[n].name;
> +		int mult, div;
> +
> +		of_property_read_string_index(np, "clock-output-names",
> +					      2+n, &rclk_name);
> +		coreclk->get_clk_ratio(base, coreclk->ratios[n].id,
> +				       &mult, &div);
> +		clk_data.clks[2+n] = clk_register_fixed_factor(NULL, rclk_name,
> +				       cpuclk_name, 0, mult, div);
> +		WARN_ON(IS_ERR(clk_data.clks[2+n]));
> +	};
> +
> +	/*
> +	 * SAR register isn't needed anymore
> +	 */
> +	iounmap(base);
> +
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +}
> +
> +#ifdef CONFIG_MACH_ARMADA_370_XP
> +/*
> + * 370/XP Sample At Reset is a 64 bit bitfiled split in two register

Add "Armada" in front of 370/XP please.

> + * of 32 bits
> + */
> +
> +#define SARL				    0	/* Low part [0:31] */
> +#define	    SARL_AXP_PCLK_FREQ_OPT	    21
> +#define	    SARL_AXP_PCLK_FREQ_OPT_MASK	    0x7
> +#define	    SARL_A370_PCLK_FREQ_OPT	    11
> +#define	    SARL_A370_PCLK_FREQ_OPT_MASK    0xF
> +#define	    SARL_AXP_FAB_FREQ_OPT	    24
> +#define	    SARL_AXP_FAB_FREQ_OPT_MASK	    0xF
> +#define	    SARL_A370_FAB_FREQ_OPT	    15
> +#define	    SARL_A370_FAB_FREQ_OPT_MASK	    0x1F
> +#define	    SARL_A370_TCLK_FREQ_OPT	    20
> +#define	    SARL_A370_TCLK_FREQ_OPT_MASK    0x1
> +#define SARH				    4	/* High part [32:63] */
> +#define	    SARH_AXP_PCLK_FREQ_OPT	    (52-32)
> +#define	    SARH_AXP_PCLK_FREQ_OPT_MASK	    0x1
> +#define	    SARH_AXP_PCLK_FREQ_OPT_SHIFT    3
> +#define	    SARH_AXP_FAB_FREQ_OPT	    (51-32)
> +#define	    SARH_AXP_FAB_FREQ_OPT_MASK	    0x1
> +#define	    SARH_AXP_FAB_FREQ_OPT_SHIFT	    4
> +
> +static const u32 __initconst a370_tclk_frequencies[] = {

In all other part in the kernel the relatives functions to
Armada 370 or Armada XP are suffixed by armada_370 or armada_xp.
Could we do the same here for being consistent?
It will help when one wants to grep code relative to the armada
370 or the armada XP.


> +	16600000,
> +	20000000,
> +};
> +
> +static u32 __init a370_get_tclk_freq(void __iomem *sar)
Same here.

> +{
> +	u8 tclk_freq_select = 0;
> +
> +	tclk_freq_select = ((readl(sar) >> SARL_A370_TCLK_FREQ_OPT) &
> +			    SARL_A370_TCLK_FREQ_OPT_MASK);
> +	return a370_tclk_frequencies[tclk_freq_select];
> +}
> +
> +static const u32 __initconst a370_cpu_frequencies[] = {
> +	400000000,
> +	533000000,
> +	667000000,
> +	800000000,
> +	1000000000,
> +	1067000000,
> +	1200000000,
> +};
> +
> +static u32 __init a370_get_cpu_freq(void __iomem *sar)
> +{
> +	u32 cpu_freq;
> +	u8 cpu_freq_select = 0;
> +
> +	cpu_freq_select = ((readl(sar) >> SARL_A370_PCLK_FREQ_OPT) &
> +			   SARL_A370_PCLK_FREQ_OPT_MASK);
> +	if (cpu_freq_select > ARRAY_SIZE(a370_cpu_frequencies)) {
> +		pr_err("CPU freq select unsuported %d\n", cpu_freq_select);
> +		cpu_freq = 0;
> +	} else
> +		cpu_freq = a370_cpu_frequencies[cpu_freq_select];
> +
> +	return cpu_freq;
> +}
> +
> +enum { A370_XP_NBCLK, A370_XP_HCLK, A370_XP_DRAMCLK };
> +
> +static const struct core_ratio __initconst a370_xp_core_ratios[] = {
> +	{ .id = A370_XP_NBCLK,	 .name = "nbclk" },
> +	{ .id = A370_XP_HCLK,	 .name = "hclk" },
> +	{ .id = A370_XP_DRAMCLK, .name = "dramclk" },
> +};
> +
> +static const int __initconst a370_xp_nbclk_ratios[32][2] = {
> +	{0, 1}, {1, 2}, {2, 2}, {2, 2},
> +	{1, 2}, {1, 2}, {1, 1}, {2, 3},
> +	{0, 1}, {1, 2}, {2, 4}, {0, 1},
> +	{1, 2}, {0, 1}, {0, 1}, {2, 2},
> +	{0, 1}, {0, 1}, {0, 1}, {1, 1},
> +	{2, 3}, {0, 1}, {0, 1}, {0, 1},
> +	{0, 1}, {0, 1}, {0, 1}, {1, 1},
> +	{0, 1}, {0, 1}, {0, 1}, {0, 1},
> +};
> +
> +static const int __initconst a370_xp_hclk_ratios[32][2] = {
> +	{0, 1}, {1, 2}, {2, 6}, {2, 3},
> +	{1, 3}, {1, 4}, {1, 2}, {2, 6},
> +	{0, 1}, {1, 6}, {2, 10}, {0, 1},
> +	{1, 4}, {0, 1}, {0, 1}, {2, 5},
> +	{0, 1}, {0, 1}, {0, 1}, {1, 2},
> +	{2, 6}, {0, 1}, {0, 1}, {0, 1},
> +	{0, 1}, {0, 1}, {0, 1}, {1, 1},
> +	{0, 1}, {0, 1}, {0, 1}, {0, 1},
> +};
> +
> +static const int __initconst a370_xp_dramclk_ratios[32][2] = {
> +	{0, 1}, {1, 2}, {2, 3}, {2, 3},
> +	{1, 3}, {1, 2}, {1, 2}, {2, 6},
> +	{0, 1}, {1, 3}, {2, 5}, {0, 1},
> +	{1, 4}, {0, 1}, {0, 1}, {2, 5},
> +	{0, 1}, {0, 1}, {0, 1}, {1, 1},
> +	{2, 3}, {0, 1}, {0, 1}, {0, 1},
> +	{0, 1}, {0, 1}, {0, 1}, {1, 1},
> +	{0, 1}, {0, 1}, {0, 1}, {0, 1},
> +};
> +
> +static void __init a370_xp_get_clk_ratio(u32 opt,
> +	void __iomem *sar, int id, int *mult, int *div)
> +{
> +	switch (id) {
> +	case A370_XP_NBCLK:
> +		*mult = a370_xp_nbclk_ratios[opt][0];
> +		*div = a370_xp_nbclk_ratios[opt][1];
> +		break;
> +	case A370_XP_HCLK:
> +		*mult = a370_xp_hclk_ratios[opt][0];
> +		*div = a370_xp_hclk_ratios[opt][1];
> +		break;
> +	case A370_XP_DRAMCLK:
> +		*mult = a370_xp_dramclk_ratios[opt][0];
> +		*div = a370_xp_dramclk_ratios[opt][1];
> +		break;
> +	}
> +}
> +
> +static void __init a370_get_clk_ratio(
> +	void __iomem *sar, int id, int *mult, int *div)
> +{
> +	u32 opt = ((readl(sar) >> SARL_A370_FAB_FREQ_OPT) &
> +		SARL_A370_FAB_FREQ_OPT_MASK);
> +
> +	a370_xp_get_clk_ratio(opt, sar, id, mult, div);
> +}
> +
> +
> +static const struct core_clocks a370_core_clocks = {
> +	.get_tclk_freq = a370_get_tclk_freq,
> +	.get_cpu_freq = a370_get_cpu_freq,
> +	.get_clk_ratio = a370_get_clk_ratio,
> +	.ratios = a370_xp_core_ratios,
> +	.num_ratios = ARRAY_SIZE(a370_xp_core_ratios),
> +};
> +
> +static const u32 __initconst xp_cpu_frequencies[] = {

And for Armada XP even the 'a' disappeared!

Gregory
