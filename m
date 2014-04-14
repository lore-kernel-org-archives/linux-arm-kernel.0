From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 11:27:17 +0200
Subject: [PATCH 03/29] clk: mvebu: add Orion5x clock driver
In-Reply-To: <1397400006-4315-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BA9F5.7080908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> This commit adds a core clock driver for the Orion5x SoC, with support
> for the tclk, the CPU frequency and the DDR frequency. All the details
> about the Sample-At-Reset register were extracted from the U-Boot
> sources for Orion5x.
>
> Note that Orion5x does not have gatable clocks, so this core clock
> driver is sufficient to support clocking on Orion5x platforms.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   .../devicetree/bindings/clock/mvebu-core-clock.txt |   8 +
>   drivers/clk/mvebu/Kconfig                          |   4 +
>   drivers/clk/mvebu/Makefile                         |   1 +
>   drivers/clk/mvebu/orion.c                          | 212 +++++++++++++++++++++
>   4 files changed, 225 insertions(+)
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

Maybe it is time to introduce a dt-binding include to remember
us to provide the same for the other SoCs, too?

>   Required properties:
>   - compatible : shall be one of the following:
>   	"marvell,armada-370-core-clock" - For Armada 370 SoC core clocks
> @@ -38,6 +43,9 @@ Required properties:
>   	"marvell,dove-core-clock" - for Dove SoC core clocks
>   	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
>   	"marvell,mv88f6180-core-clock" - for Kirkwood MV88f6180 SoC
> +	"marvell,mv88f5182-core-clock" - for Orion MV88F5182 SoC

Do you know how different 5182 and 5182L are? In the pinctrl driver
there was an additional L at the end, here it is missing.

The 5182 datasheet I am looking at, is titled "88F5182L Datasheet" but
uses 88F5182 all over. Maybe we can drop the L entirely.

> +	"marvell,mv88f5281-core-clock" - for Orion MV88F5281 SoC
> +	"marvell,mv88f6183-core-clock" - for Orion MV88F6183 SoC
>   - reg : shall be the register address of the Sample-At-Reset (SAR) register
>   - #clock-cells : from common clock binding; shall be set to 1
[...]
> diff --git a/drivers/clk/mvebu/orion.c b/drivers/clk/mvebu/orion.c
> new file mode 100644
> index 0000000..005aa2f
> --- /dev/null
> +++ b/drivers/clk/mvebu/orion.c
> @@ -0,0 +1,212 @@
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
> +#define SAR_MV88F5182_TCLK_FREQ      0x8

nit: as this is a shift, I'd use decimal values.

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
> +#define SAR_MV88F5182_CPU_FREQ       0x4

ditto.

> +#define SAR_MV88F5182_CPU_FREQ_MASK  0xf
> +
> +static u32 __init mv88f5182_get_cpu_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5182_CPU_FREQ) &
> +		SAR_MV88F5182_CPU_FREQ_MASK;
> +	if (opt == 0)
> +		return 333333333;
> +	else if (opt == 1)
> +		return 400000000;
> +	else if (opt == 2)
> +		return 400000000;

join the two above...

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

.. like you did here.

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
> +#define SAR_MV88F5281_CPU_FREQ       0x4

same nit for the hex/decimal value.

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
> +#define SAR_MV88F6183_TCLK_FREQ      0x9

ditto.

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
> +#define SAR_MV88F6183_CPU_FREQ       0x1

ditto.

Besides the dt-include and nits,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

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
