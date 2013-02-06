From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Feb 2013 12:38:36 +0000
Subject: [PATCH v5 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <1360094115-14999-2-git-send-email-andrew@lunn.ch>
References: <1360094115-14999-1-git-send-email-andrew@lunn.ch>
 <1360094115-14999-2-git-send-email-andrew@lunn.ch>
Message-ID: <20130206123836.GI26842@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have just a small problem with this.

On Tue, Feb 05, 2013 at 07:55:13PM +0000, Andrew Lunn wrote:
> The Marvell Kirkwood SoCs have simple cpufreq support in hardware. The
> CPU can either use the a high speed cpu clock, or the slower DDR
> clock. Add a driver to swap between these two clock sources.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  Documentation/devicetree/bindings/arm/kirkwood.txt |   27 ++
>  drivers/clk/mvebu/clk-gating-ctrl.c                |    1 +
>  drivers/cpufreq/Kconfig.arm                        |    6 +
>  drivers/cpufreq/Makefile                           |    1 +
>  drivers/cpufreq/kirkwood-cpufreq.c                 |  259 ++++++++++++++++++++
>  5 files changed, 294 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/kirkwood.txt
>  create mode 100644 drivers/cpufreq/kirkwood-cpufreq.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/kirkwood.txt b/Documentation/devicetree/bindings/arm/kirkwood.txt
> new file mode 100644
> index 0000000..98cce9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/kirkwood.txt
> @@ -0,0 +1,27 @@
> +Marvell Kirkwood Platforms Device Tree Bindings
> +-----------------------------------------------
> +
> +Boards with a SoC of the Marvell Kirkwood
> +shall have the following property:
> +
> +Required root node property:
> +
> +compatible: must contain "marvell,kirkwood";
> +
> +In order to support the kirkwood cpufreq driver, there must be a node
> +cpus/cpu at 0 with three clocks, "cpu_clk", "ddrclk" and "powersave",

Devicetree unit-addresses are meant to correspond to the node's reg property.

As the cpu does not have an MPIDR, and thus the node has no reg (by the general
arm cpu binding), this should just be /cpus/cpu.

> +where the "powersave" clock is a gating clock used to switch the CPU
> +between the "cpu_clk" and the "ddrclk".
> +
> +Example:
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                     device_type = "cpu";
> +                     compatible = "marvell,sheeva-88SV131";
> +                     clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
> +                     clock-names = "cpu_clk", "ddrclk", "powersave";
> +               };
> diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
> index 8fa5408..ebf141d 100644
> --- a/drivers/clk/mvebu/clk-gating-ctrl.c
> +++ b/drivers/clk/mvebu/clk-gating-ctrl.c
> @@ -193,6 +193,7 @@ static const struct mvebu_soc_descr __initconst kirkwood_gating_descr[] = {
>         { "runit", NULL, 7 },
>         { "xor0", NULL, 8 },
>         { "audio", NULL, 9 },
> +       { "powersave", "cpuclk", 11 },
>         { "sata0", NULL, 14 },
>         { "sata1", NULL, 15 },
>         { "xor1", NULL, 16 },
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a0b3661..80c8229 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -77,6 +77,12 @@ config ARM_EXYNOS5250_CPUFREQ
>           This adds the CPUFreq driver for Samsung EXYNOS5250
>           SoC.
> 
> +config ARM_KIRKWOOD_CPUFREQ
> +       def_bool ARCH_KIRKWOOD && OF
> +       help
> +         This adds the CPUFreq driver for Marvell Kirkwood
> +         SoCs.
> +
>  config ARM_SPEAR_CPUFREQ
>         bool "SPEAr CPUFreq support"
>         depends on PLAT_SPEAR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index fadc4d4..39a0ffe 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)      += exynos-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
> +obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)     += kirkwood-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)                += spear-cpufreq.o
> 
> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> new file mode 100644
> index 0000000..0e83e3c
> --- /dev/null
> +++ b/drivers/cpufreq/kirkwood-cpufreq.c
> @@ -0,0 +1,259 @@
> +/*
> + *     kirkwood_freq.c: cpufreq driver for the Marvell kirkwood
> + *
> + *     Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> + *
> + *     This program is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     as published by the Free Software Foundation; either version
> + *     2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/cpufreq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <asm/proc-fns.h>
> +
> +#define CPU_SW_INT_BLK BIT(28)
> +
> +static struct priv
> +{
> +       struct clk *cpu_clk;
> +       struct clk *ddr_clk;
> +       struct clk *powersave_clk;
> +       struct device *dev;
> +       void __iomem *base;
> +} priv;
> +
> +#define STATE_CPU_FREQ 0x01
> +#define STATE_DDR_FREQ 0x02
> +
> +/*
> + * Kirkwood can swap the clock to the CPU between two clocks:
> + *
> + * - cpu clk
> + * - ddr clk
> + *
> + * The frequencies are set at runtime before registering this *
> + * table.
> + */
> +static struct cpufreq_frequency_table kirkwood_freq_table[] = {
> +       {STATE_CPU_FREQ,        0}, /* CPU uses cpuclk */
> +       {STATE_DDR_FREQ,        0}, /* CPU uses ddrclk */
> +       {0,                     CPUFREQ_TABLE_END},
> +};
> +
> +static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
> +{
> +       if (__clk_is_enabled(priv.powersave_clk))
> +               return kirkwood_freq_table[1].frequency;
> +       return kirkwood_freq_table[0].frequency;
> +}
> +
> +static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
> +{
> +       struct cpufreq_freqs freqs;
> +       unsigned int state = kirkwood_freq_table[index].index;
> +       unsigned long reg;
> +
> +       freqs.old = kirkwood_cpufreq_get_cpu_frequency(0);
> +       freqs.new = kirkwood_freq_table[index].frequency;
> +       freqs.cpu = 0; /* Kirkwood is UP */
> +
> +       cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +       dev_dbg(priv.dev, "Attempting to set frequency to %i KHz\n",
> +               kirkwood_freq_table[index].frequency);
> +       dev_dbg(priv.dev, "old frequency was %i KHz\n",
> +               kirkwood_cpufreq_get_cpu_frequency(0));
> +
> +       if (freqs.old != freqs.new) {
> +               local_irq_disable();
> +
> +               /* Disable interrupts to the CPU */
> +               reg = readl_relaxed(priv.base);
> +               reg |= CPU_SW_INT_BLK;
> +               writel_relaxed(reg, priv.base);
> +
> +               switch (state) {
> +               case STATE_CPU_FREQ:
> +                       clk_disable(priv.powersave_clk);
> +                       break;
> +               case STATE_DDR_FREQ:
> +                       clk_enable(priv.powersave_clk);
> +                       break;
> +               }
> +
> +               /* Wait-for-Interrupt, while the hardware changes frequency */
> +               cpu_do_idle();
> +
> +               /* Enable interrupts to the CPU */
> +               reg = readl_relaxed(priv.base);
> +               reg &= ~CPU_SW_INT_BLK;
> +               writel_relaxed(reg, priv.base);
> +
> +               local_irq_enable();
> +       }
> +       cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +};
> +
> +static int kirkwood_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +       return cpufreq_frequency_table_verify(policy, kirkwood_freq_table);
> +}
> +
> +static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
> +                           unsigned int target_freq,
> +                           unsigned int relation)
> +{
> +       unsigned int index = 0;
> +
> +       if (cpufreq_frequency_table_target(policy, kirkwood_freq_table,
> +                               target_freq, relation, &index))
> +               return -EINVAL;
> +
> +       kirkwood_cpufreq_set_cpu_state(index);
> +
> +       return 0;
> +}
> +
> +/* Module init and exit code */
> +static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       int result;
> +
> +       /* cpuinfo and default policy values */
> +       policy->cpuinfo.transition_latency = 5000; /* 5uS */
> +       policy->cur = kirkwood_cpufreq_get_cpu_frequency(0);
> +
> +       result = cpufreq_frequency_table_cpuinfo(policy, kirkwood_freq_table);
> +       if (result)
> +               return result;
> +
> +       cpufreq_frequency_table_get_attr(kirkwood_freq_table, policy->cpu);
> +
> +       return 0;
> +}
> +
> +static int kirkwood_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       cpufreq_frequency_table_put_attr(policy->cpu);
> +       return 0;
> +}
> +
> +static struct freq_attr *kirkwood_cpufreq_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       NULL,
> +};
> +
> +static struct cpufreq_driver kirkwood_cpufreq_driver = {
> +       .get    = kirkwood_cpufreq_get_cpu_frequency,
> +       .verify = kirkwood_cpufreq_verify,
> +       .target = kirkwood_cpufreq_target,
> +       .init   = kirkwood_cpufreq_cpu_init,
> +       .exit   = kirkwood_cpufreq_cpu_exit,
> +       .name   = "kirkwood-cpufreq",
> +       .owner  = THIS_MODULE,
> +       .attr   = kirkwood_cpufreq_attr,
> +};
> +
> +static int kirkwood_cpufreq_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np;
> +       struct resource *res;
> +       int err;
> +
> +       priv.dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "Cannot get memory resource\n");
> +               return -ENODEV;
> +       }
> +       priv.base = devm_request_and_ioremap(&pdev->dev, res);
> +       if (!priv.base) {
> +               dev_err(&pdev->dev, "Cannot ioremap\n");
> +               return -EADDRNOTAVAIL;
> +       }
> +
> +       np = of_find_node_by_path("/cpus/cpu at 0");
> +       if (!np)
> +               return -ENODEV;

Thus this should grab "/cpus/cpu".

[...]

Thanks,
Mark.
