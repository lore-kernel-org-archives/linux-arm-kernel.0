From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 20 Jan 2013 09:35:14 +0100
Subject: [PATCH 1/3] cpufreq: kirkwood: Add a cpufreq driver for Marvell
 Kirkwood SoCs
In-Reply-To: <CAOh2x=kF2RfM3UrFGC7aX6Tn=etkPce_ix5934Q+wu2XjOCJfw@mail.gmail.com>
References: <1358518846-16251-1-git-send-email-andrew@lunn.ch>
 <1358518846-16251-2-git-send-email-andrew@lunn.ch>
 <CAOh2x=kF2RfM3UrFGC7aX6Tn=etkPce_ix5934Q+wu2XjOCJfw@mail.gmail.com>
Message-ID: <20130120083514.GB20719@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 20, 2013 at 09:41:34AM +0530, Viresh Kumar wrote:
> On Fri, Jan 18, 2013 at 7:50 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > The Marvell Kirkwood SoCs have simple cpufreq support in hardware. The
> > CPU can either use the a high speed cpu clock, or the slower DDR
> > clock. Add a driver to swap between these two clock sources.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/clk/mvebu/clk-gating-ctrl.c |    1 +
> >  drivers/cpufreq/Kconfig.arm         |    6 +
> >  drivers/cpufreq/Makefile            |    1 +
> >  drivers/cpufreq/kirkwood-cpufreq.c  |  273 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 281 insertions(+)
> >  create mode 100644 drivers/cpufreq/kirkwood-cpufreq.c
> >
> > diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
> > index 8fa5408..ebf141d 100644
> > --- a/drivers/clk/mvebu/clk-gating-ctrl.c
> > +++ b/drivers/clk/mvebu/clk-gating-ctrl.c
> > @@ -193,6 +193,7 @@ static const struct mvebu_soc_descr __initconst kirkwood_gating_descr[] = {
> >         { "runit", NULL, 7 },
> >         { "xor0", NULL, 8 },
> >         { "audio", NULL, 9 },
> > +       { "powersave", "cpuclk", 11 },
> >         { "sata0", NULL, 14 },
> >         { "sata1", NULL, 15 },
> >         { "xor1", NULL, 16 },
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index a0b3661..08ca366 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -77,6 +77,12 @@ config ARM_EXYNOS5250_CPUFREQ
> >           This adds the CPUFreq driver for Samsung EXYNOS5250
> >           SoC.
> >
> > +config ARM_KIRKWOOD_CPUFREQ
> > +        def_bool ARCH_KIRKWOOD && OF
> > +       help
> > +         This adds the CPUFreq driver for Marvell Kirkwood
> > +         SoCs.
> > +
> >  config ARM_SPEAR_CPUFREQ
> >         bool "SPEAr CPUFreq support"
> >         depends on PLAT_SPEAR
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index fadc4d4..39a0ffe 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)      += exynos-cpufreq.o
> >  obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
> >  obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
> >  obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
> > +obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)     += kirkwood-cpufreq.o
> >  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
> >  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)                += spear-cpufreq.o
> >
> > diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> > new file mode 100644
> > index 0000000..4f0a435
> > --- /dev/null
> > +++ b/drivers/cpufreq/kirkwood-cpufreq.c
> > @@ -0,0 +1,273 @@
> > +/*
> > + *     kirkwood_freq.c: cpufreq driver for the Marvell kirkwood
> > + *
> > + *     Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> > + *
> > + *     This program is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License
> > + *     as published by the Free Software Foundation; either version
> > + *     2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk-provider.h>
> 
> why do you need this one?

I need __clk_is_enabled() in order to know the current state of the
clock. What i found is that if the state does not change, the CPU
never wakes up from the WFI. So i want to read back from the hardware
what state the clock is in.

> 
> > +#include <linux/of.h>
> > +#include <linux/delay.h>
> > +#include <linux/clk.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/timex.h>
> > +#include <linux/io.h>
> > +#include <asm/proc-fns.h>
> 
> would be better to keep them in alphabetical order to guarantee that we don't
> include anything twice.

O.K.
 
> > +#define CPU_SW_INT_BLK BIT(28)
> > +
> > +
> > +#include <linux/clk-private.h>
> > +
> > +static struct priv
> > +{
> > +       struct clk *cpu_clk;
> > +       struct clk *ddr_clk;
> > +       struct clk *powersave_clk;
> > +       struct device *dev;
> > +       void __iomem *base;
> > +} priv;
> > +
> > +#define STATE_CPU_FREQ 0x01
> > +#define STATE_DDR_FREQ 0x02
> > +
> > +/* Kirkwood can swap the clock to the CPU between two clocks:
> > + *
> > + * - cpu clk
> > + * - ddr clk
> > + *
> > + * The frequencies are set at runtime before registering this *
> > + * table. */
> 
> wrong multiline comment style.
> 
> /*
>  * ....
>  * ....
>  */
> 
> > +static struct cpufreq_frequency_table kirkwood_freq_table[] = {
> > +       {STATE_CPU_FREQ,        0}, /* CPU uses cpuclk */
> > +       {STATE_DDR_FREQ,        0}, /* CPU uses ddrclk */
> > +       {0,                     CPUFREQ_TABLE_END},
> > +};
> 
> I don't know if anything is broken now, but i would like to keep index
> in freq_table.index
> field as the actual index in the table.
> 
> i.e, currently you have order as 1,2,0 .. but should have been 0, 1, 2

Documentation/cpu-freq/cpu-drivers.txt says:

2. Frequency Table Helpers
==========================

As most cpufreq processors only allow for being set to a few specific
frequencies, a "frequency table" with some functions might assist in
some work of the processor driver. Such a "frequency table" consists
of an array of struct cpufreq_freq_table entries, with any value in
"index" you want to use, and the corresponding frequency in
"frequency". At the end of the table, you need to add a
cpufreq_freq_table entry with frequency set to CPUFREQ_TABLE_END. And
if you want to skip one entry in the table, set the frequency to 
CPUFREQ_ENTRY_INVALID. The entries don't need to be in ascending
order.

 
> > +static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
> > +{
> > +       if (__clk_is_enabled(priv.powersave_clk))
> > +               return kirkwood_freq_table[1].frequency;
> > +       return kirkwood_freq_table[0].frequency;
> > +}
> > +
> > +static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
> > +{
> > +
> > +       struct cpufreq_freqs freqs;
> > +       unsigned int state = kirkwood_freq_table[index].index;
> > +       unsigned long reg;
> > +
> > +       freqs.old = kirkwood_cpufreq_get_cpu_frequency(0);
> > +       freqs.new = kirkwood_freq_table[index].frequency;
> > +       freqs.cpu = 0; /* Kirkwood is UP */
> > +
> > +       cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +
> > +       dev_dbg(priv.dev, "Attempting to set frequency to %i KHz\n",
> > +               kirkwood_freq_table[index].frequency);
> > +       dev_dbg(priv.dev, "old frequency was %i KHz\n",
> > +               kirkwood_cpufreq_get_cpu_frequency(0));
> > +
> > +       if (freqs.old != freqs.new) {
> > +               local_irq_disable();
> > +
> > +               /* Disable interrupts to the CPU */
> > +               reg = readl_relaxed(priv.base);
> > +               reg |= CPU_SW_INT_BLK;
> > +               writel(reg, priv.base);
> > +
> > +               switch (state) {
> > +               case STATE_CPU_FREQ:
> > +                       clk_disable(priv.powersave_clk);
> > +                       break;
> > +               case STATE_DDR_FREQ:
> > +                       clk_enable(priv.powersave_clk);
> > +                       break;
> > +               default:
> > +                       dev_err(priv.dev, "Unexpected cpufreq state");
> > +               }
> > +
> > +               /* Wait-for-Interrupt, which the hardware changes frequency */
> > +               cpu_do_idle();
> > +
> > +               /* Enable interrupts to the CPU */
> > +               reg = readl_relaxed(priv.base);
> > +               reg &= ~CPU_SW_INT_BLK;
> > +               writel(reg, priv.base);
> > +
> > +               local_irq_enable();
> > +       }
> > +       cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > +};
> > +
> > +static int kirkwood_cpufreq_verify(struct cpufreq_policy *policy)
> > +{
> > +       return cpufreq_frequency_table_verify(policy, &kirkwood_freq_table[0]);
> > +}
> > +
> > +static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
> > +                           unsigned int target_freq,
> > +                           unsigned int relation)
> > +{
> > +       unsigned int index = 0;
> > +
> > +       if (cpufreq_frequency_table_target(policy, kirkwood_freq_table,
> > +                               target_freq, relation, &index))
> > +               return -EINVAL;
> > +
> > +       kirkwood_cpufreq_set_cpu_state(index);
> 
> You can get this function inlined here.. as it is only called from
> this location.

Yes, i could. gcc will inline it anyway. But look at other
drivers. elan, gx-suspmod, longhaul, maple, p4, powernow-k6,
powernow-k7, powernow-k8, etc, all have a helper function to do the
actual change, which is called from the target function. So i'm just
following the normal convention.

 
> > +       return 0;
> > +}
> > +
> > +/*
> > + *     Module init and exit code
> > + */
> > +static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       int result;
> > +
> > +       /* cpuinfo and default policy values */
> > +       policy->cpuinfo.transition_latency = 5000; /* 5uS */
> > +       policy->cur = kirkwood_cpufreq_get_cpu_frequency(0);
> > +
> > +       result = cpufreq_frequency_table_cpuinfo(policy, kirkwood_freq_table);
> > +       if (result)
> > +               return result;
> > +
> > +       cpufreq_frequency_table_get_attr(kirkwood_freq_table, policy->cpu);
> > +
> > +       return 0;
> > +}
> > +
> > +static int kirkwood_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +       cpufreq_frequency_table_put_attr(policy->cpu);
> > +       return 0;
> > +}
> > +
> > +static struct freq_attr *kirkwood_cpufreq_attr[] = {
> > +       &cpufreq_freq_attr_scaling_available_freqs,
> > +       NULL,
> > +};
> > +
> > +
> > +static struct cpufreq_driver kirkwood_cpufreq_driver = {
> > +       .get    = kirkwood_cpufreq_get_cpu_frequency,
> > +       .verify = kirkwood_cpufreq_verify,
> > +       .target = kirkwood_cpufreq_target,
> > +       .init   = kirkwood_cpufreq_cpu_init,
> > +       .exit   = kirkwood_cpufreq_cpu_exit,
> > +       .name   = "kirkwood_freq",
> > +       .owner  = THIS_MODULE,
> > +       .attr   = kirkwood_cpufreq_attr,
> > +};
> > +
> > +static int kirkwood_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np = of_find_compatible_node(
> > +               NULL, NULL, "marvell,kirkwood-core-clock");
> 
> Is cpu0 a better location for adding this entry?

I'm not adding an entry here. I'm using an existing entry.

 
> > +       struct of_phandle_args clkspec;
> > +       struct resource *res;
> > +       int err;
> > +
> > +       priv.dev = &pdev->dev;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               dev_err(&pdev->dev, "Cannot get memory resource\n");
> > +               return -ENODEV;
> > +       }
> > +       priv.base = devm_request_and_ioremap(&pdev->dev, res);
> > +       if (!priv.base) {
> > +               dev_err(&pdev->dev, "Cannot ioremap\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       clkspec.np = np;
> > +       clkspec.args_count = 1;
> > +       clkspec.args[0] = 1;
> > +
> > +       priv.cpu_clk = of_clk_get_from_provider(&clkspec);
> > +       if (IS_ERR(priv.cpu_clk)) {
> > +               dev_err(priv.dev, "Unable to get cpuclk");
> > +               return PTR_ERR(priv.cpu_clk);
> > +       }
> > +
> > +       clk_prepare_enable(priv.cpu_clk);
> > +       kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> > +
> > +       clkspec.args[0] = 3;
> > +       priv.ddr_clk = of_clk_get_from_provider(&clkspec);
> > +       if (IS_ERR(priv.ddr_clk)) {
> > +               dev_err(priv.dev, "Unable to get ddrclk");
> > +               err = PTR_ERR(priv.ddr_clk);
> > +               goto out_cpu;
> > +       }
> > +
> > +       clk_prepare_enable(priv.ddr_clk);
> > +       kirkwood_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
> > +
> > +       np = of_find_compatible_node(NULL, NULL,
> > +                                    "marvell,kirkwood-gating-clock");
> > +       clkspec.np = np;
> > +       clkspec.args[0] = 11;
> > +       priv.powersave_clk = of_clk_get_from_provider(&clkspec);
> > +       if (IS_ERR(priv.powersave_clk)) {
> > +               dev_err(priv.dev, "Unable to get powersave");
> > +               err = PTR_ERR(priv.powersave_clk);
> > +               goto out_ddr;
> > +       }
> > +       clk_prepare(priv.powersave_clk);
> 
> want to check return value?

Not much point. Gated clock drivers don't actually have a prepare
function, so it cannot fail. The parent clock is a fixed clock, which
also does not have a prepare function. All this call is doing is
updating the reference counters.

	 Andrew
