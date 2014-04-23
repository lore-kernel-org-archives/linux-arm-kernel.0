From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:16:16 +0200
Subject: [PATCH v2 04/38] clk: mvebu: add Orion5x clock driver
In-Reply-To: <1398202002-28530-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A100.1050406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit adds a core clock driver for the Orion5x SoC, with support
> for the tclk, the CPU frequency and the DDR frequency. All the details
> about the Sample-At-Reset register were extracted from the U-Boot
> sources for Orion5x.
>
> Note that Orion5x does not have gatable clocks, so this core clock
> driver is sufficient to support clocking on Orion5x platforms.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Mike Turquette <mturquette@linaro.org>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   .../devicetree/bindings/clock/mvebu-core-clock.txt |   8 +
>   drivers/clk/mvebu/Kconfig                          |   4 +
>   drivers/clk/mvebu/Makefile                         |   1 +
>   drivers/clk/mvebu/orion.c                          | 210 +++++++++++++++++++++
>   4 files changed, 223 insertions(+)
>   create mode 100644 drivers/clk/mvebu/orion.c
>
> diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
> index 307a503..dc5ea5b 100644
> --- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
> @@ -29,6 +29,11 @@ The following is a list of provided IDs and clock names on Kirkwood and Dove:
>    2 = l2clk  (L2 Cache clock derived from CPU0 clock)
>    3 = ddrclk (DDR controller clock derived from CPU0 clock)
>
> +The following is a list of provided IDs and clock names on Orion5x:
> + 0 = tclk   (Internal Bus clock)
> + 1 = cpuclk (CPU0 clock)
> + 2 = ddrclk (DDR controller clock derived from CPU0 clock)
> +
>   Required properties:
>   - compatible : shall be one of the following:
>   	"marvell,armada-370-core-clock" - For Armada 370 SoC core clocks
> @@ -38,6 +43,9 @@ Required properties:
>   	"marvell,dove-core-clock" - for Dove SoC core clocks
>   	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
>   	"marvell,mv88f6180-core-clock" - for Kirkwood MV88f6180 SoC
> +	"marvell,mv88f5182-core-clock" - for Orion MV88F5182 SoC
> +	"marvell,mv88f5281-core-clock" - for Orion MV88F5281 SoC
> +	"marvell,mv88f6183-core-clock" - for Orion MV88F6183 SoC
>   - reg : shall be the register address of the Sample-At-Reset (SAR) register
>   - #clock-cells : from common clock binding; shall be set to 1
>
> diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
> index 693f7be..3b34dba 100644
> --- a/drivers/clk/mvebu/Kconfig
> +++ b/drivers/clk/mvebu/Kconfig
> @@ -34,3 +34,7 @@ config DOVE_CLK
>   config KIRKWOOD_CLK
>   	bool
>   	select MVEBU_CLK_COMMON
> +
> +config ORION_CLK
> +	bool
> +	select MVEBU_CLK_COMMON
> diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
> index 4c66162..a9a56fc 100644
> --- a/drivers/clk/mvebu/Makefile
> +++ b/drivers/clk/mvebu/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_ARMADA_38X_CLK)	+= armada-38x.o
>   obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
>   obj-$(CONFIG_DOVE_CLK)		+= dove.o
>   obj-$(CONFIG_KIRKWOOD_CLK)	+= kirkwood.o
> +obj-$(CONFIG_ORION_CLK)		+= orion.o
> diff --git a/drivers/clk/mvebu/orion.c b/drivers/clk/mvebu/orion.c
> new file mode 100644
> index 0000000..fd12956
> --- /dev/null
> +++ b/drivers/clk/mvebu/orion.c
> @@ -0,0 +1,210 @@
> +/*
> + * Marvell Orion SoC clocks
> + *
> + * Copyright (C) 2014 Thomas Petazzoni
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include "common.h"
> +
> +static const struct coreclk_ratio orion_coreclk_ratios[] __initconst = {
> +	{ .id = 0, .name = "ddrclk", }
> +};
> +
> +/*
> + * Orion 5182
> + */
> +
> +#define SAR_MV88F5182_TCLK_FREQ      8
> +#define SAR_MV88F5182_TCLK_FREQ_MASK 0x3
> +
> +static u32 __init mv88f5182_get_tclk_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5182_TCLK_FREQ) &
> +		SAR_MV88F5182_TCLK_FREQ_MASK;
> +	if (opt == 1)
> +		return 150000000;
> +	else if (opt == 2)
> +		return 166666667;
> +	else
> +		return 0;
> +}
> +
> +#define SAR_MV88F5182_CPU_FREQ       4
> +#define SAR_MV88F5182_CPU_FREQ_MASK  0xf
> +
> +static u32 __init mv88f5182_get_cpu_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5182_CPU_FREQ) &
> +		SAR_MV88F5182_CPU_FREQ_MASK;
> +	if (opt == 0)
> +		return 333333333;
> +	else if (opt == 1 || opt == 2)
> +		return 400000000;
> +	else if (opt == 3)
> +		return 500000000;
> +	else
> +		return 0;
> +}
> +
> +static void __init mv88f5182_get_clk_ratio(void __iomem *sar, int id,
> +					   int *mult, int *div)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5182_CPU_FREQ) &
> +		SAR_MV88F5182_CPU_FREQ_MASK;
> +	if (opt == 0 || opt == 1) {
> +		*mult = 1;
> +		*div  = 2;
> +	} else if (opt == 2 || opt == 3) {
> +		*mult = 1;
> +		*div  = 3;
> +	} else {
> +		*mult = 0;
> +		*div  = 1;
> +	}
> +}
> +
> +static const struct coreclk_soc_desc mv88f5182_coreclks = {
> +	.get_tclk_freq = mv88f5182_get_tclk_freq,
> +	.get_cpu_freq = mv88f5182_get_cpu_freq,
> +	.get_clk_ratio = mv88f5182_get_clk_ratio,
> +	.ratios = orion_coreclk_ratios,
> +	.num_ratios = ARRAY_SIZE(orion_coreclk_ratios),
> +};
> +
> +static void __init mv88f5182_clk_init(struct device_node *np)
> +{
> +	return mvebu_coreclk_setup(np, &mv88f5182_coreclks);
> +}
> +
> +CLK_OF_DECLARE(mv88f5182_clk, "marvell,mv88f5182-core-clock", mv88f5182_clk_init);
> +
> +/*
> + * Orion 5281
> + */
> +
> +static u32 __init mv88f5281_get_tclk_freq(void __iomem *sar)
> +{
> +	/* On 5281, tclk is always 166 Mhz */
> +	return 166666667;
> +}
> +
> +#define SAR_MV88F5281_CPU_FREQ       4
> +#define SAR_MV88F5281_CPU_FREQ_MASK  0xf
> +
> +static u32 __init mv88f5281_get_cpu_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5281_CPU_FREQ) &
> +		SAR_MV88F5281_CPU_FREQ_MASK;
> +	if (opt == 1 || opt == 2)
> +		return 400000000;
> +	else if (opt == 3)
> +		return 500000000;
> +	else
> +		return 0;
> +}
> +
> +static void __init mv88f5281_get_clk_ratio(void __iomem *sar, int id,
> +					   int *mult, int *div)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5281_CPU_FREQ) &
> +		SAR_MV88F5281_CPU_FREQ_MASK;
> +	if (opt == 1) {
> +		*mult = 1;
> +		*div = 2;
> +	} else if (opt == 2 || opt == 3) {
> +		*mult = 1;
> +		*div = 3;
> +	} else {
> +		*mult = 0;
> +		*div = 1;
> +	}
> +}
> +
> +static const struct coreclk_soc_desc mv88f5281_coreclks = {
> +	.get_tclk_freq = mv88f5281_get_tclk_freq,
> +	.get_cpu_freq = mv88f5281_get_cpu_freq,
> +	.get_clk_ratio = mv88f5281_get_clk_ratio,
> +	.ratios = orion_coreclk_ratios,
> +	.num_ratios = ARRAY_SIZE(orion_coreclk_ratios),
> +};
> +
> +static void __init mv88f5281_clk_init(struct device_node *np)
> +{
> +	return mvebu_coreclk_setup(np, &mv88f5281_coreclks);
> +}
> +
> +CLK_OF_DECLARE(mv88f5281_clk, "marvell,mv88f5281-core-clock", mv88f5281_clk_init);
> +
> +/*
> + * Orion 6183
> + */
> +
> +#define SAR_MV88F6183_TCLK_FREQ      9
> +#define SAR_MV88F6183_TCLK_FREQ_MASK 0x1
> +
> +static u32 __init mv88f6183_get_tclk_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F6183_TCLK_FREQ) &
> +		SAR_MV88F6183_TCLK_FREQ_MASK;
> +	if (opt == 0)
> +		return 133333333;
> +	else if (opt == 1)
> +		return 166666667;
> +	else
> +		return 0;
> +}
> +
> +#define SAR_MV88F6183_CPU_FREQ       1
> +#define SAR_MV88F6183_CPU_FREQ_MASK  0x3f
> +
> +static u32 __init mv88f6183_get_cpu_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F6183_CPU_FREQ) &
> +		SAR_MV88F6183_CPU_FREQ_MASK;
> +	if (opt == 9)
> +		return 333333333;
> +	else if (opt == 17)
> +		return 400000000;
> +	else
> +		return 0;
> +}
> +
> +static void __init mv88f6183_get_clk_ratio(void __iomem *sar, int id,
> +					   int *mult, int *div)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F6183_CPU_FREQ) &
> +		SAR_MV88F6183_CPU_FREQ_MASK;
> +	if (opt == 9 || opt == 17) {
> +		*mult = 1;
> +		*div  = 2;
> +	} else {
> +		*mult = 0;
> +		*div  = 1;
> +	}
> +}
> +
> +static const struct coreclk_soc_desc mv88f6183_coreclks = {
> +	.get_tclk_freq = mv88f6183_get_tclk_freq,
> +	.get_cpu_freq = mv88f6183_get_cpu_freq,
> +	.get_clk_ratio = mv88f6183_get_clk_ratio,
> +	.ratios = orion_coreclk_ratios,
> +	.num_ratios = ARRAY_SIZE(orion_coreclk_ratios),
> +};
> +
> +
> +static void __init mv88f6183_clk_init(struct device_node *np)
> +{
> +	return mvebu_coreclk_setup(np, &mv88f6183_coreclks);
> +}
> +
> +CLK_OF_DECLARE(mv88f6183_clk, "marvell,mv88f6183-core-clock", mv88f6183_clk_init);
>
