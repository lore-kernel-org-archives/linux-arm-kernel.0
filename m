From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 19 Oct 2010 17:28:51 +0800
Subject: [PATCHv3] cpufreq for freescale mx51
In-Reply-To: <20101018101314.GA4395@pengutronix.de>
References: <1287390105-3706-1-git-send-email-yong.shen@linaro.org>
	<20101018101314.GA4395@pengutronix.de>
Message-ID: <AANLkTik=UWF0PpAUKGE3KwmJbZNgxUj-8o6ouD+LYcSx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>
>
> > +#include <linux/kernel.h>
> > +
> > +static struct cpu_op mx51_cpu_op[] = {
> > +     {
> > +     .cpu_rate = 160000000,},
> > +     {
> > +     .cpu_rate = 800000000,},
> > +};
>
> Why did you remove the values between 800MHz and 160MHz? 400MHz and
> 200Mhz should work also, no?
>
> It proved that those operating points don't work well.


> > +
> > +struct cpu_op *mx51_get_cpu_op(int *op)
> > +{
> > +     *op = ARRAY_SIZE(mx51_cpu_op);
> > +     return mx51_cpu_op;
> > +}
> > diff --git a/arch/arm/mach-mx5/cpu_op-mx51.h
> b/arch/arm/mach-mx5/cpu_op-mx51.h
> > new file mode 100644
> > index 0000000..97477fe
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/cpu_op-mx51.h
> > @@ -0,0 +1,14 @@
> > +/*
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + */
> > +
> > +/*
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +extern struct cpu_op *mx51_get_cpu_op(int *op);
> > diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> > index 78d405e..a833d38 100644
> > --- a/arch/arm/plat-mxc/Makefile
> > +++ b/arch/arm/plat-mxc/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_MXC_ULPI) += ulpi.o
> >  obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
> >  obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
> >  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
> > +obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
> >  ifdef CONFIG_SND_IMX_SOC
> >  obj-y += ssi-fiq.o
> >  obj-y += ssi-fiq-ksym.o
> > diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
> > new file mode 100644
> > index 0000000..9cabeb9
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/cpufreq.c
> > @@ -0,0 +1,202 @@
> > +/*
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + */
> > +
> > +/*
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +/*
> > + * A driver for the Freescale Semiconductor i.MXC CPUfreq module.
> > + * The CPUFREQ driver is for controling CPU frequency. It allows you to
> change
> > + * the CPU clock speed on the fly.
> > + */
> > +
> > +#include <linux/cpufreq.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <mach/hardware.h>
> > +#include <mach/clock.h>
> > +
> > +#define CLK32_FREQ   32768
> > +#define NANOSECOND   (1000 * 1000 * 1000)
> > +
> > +static int cpu_freq_khz_min;
> > +static int cpu_freq_khz_max;
> > +static int arm_normal_clk;
> > +
> > +static struct clk *cpu_clk;
> > +static struct cpufreq_frequency_table *imx_freq_table;
> > +
> > +static int cpu_op_nr;
> > +static struct cpu_op *cpu_op_tbl;
> > +
> > +static int set_cpu_freq(int freq)
> > +{
> > +     int ret = 0;
> > +     int org_cpu_rate;
> > +
> > +     org_cpu_rate = clk_get_rate(cpu_clk);
> > +     if (org_cpu_rate == freq)
> > +             return ret;
>
> You already checked this in mxc_set_target. Once is enough.
>

Well, this fucntion is not only used in mxc_set_target, so it is safer to
still keep checking here.

>
> > +
> > +     ret = clk_set_rate(cpu_clk, freq);
> > +     if (ret != 0) {
> > +             printk(KERN_DEBUG "cannot set CPU clock rate\n");
> > +             return ret;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int mxc_verify_speed(struct cpufreq_policy *policy)
> > +{
> > +     if (policy->cpu != 0)
> > +             return -EINVAL;
> > +
> > +     return cpufreq_frequency_table_verify(policy, imx_freq_table);
> > +}
> > +
> > +static unsigned int mxc_get_speed(unsigned int cpu)
> > +{
> > +     if (cpu)
> > +             return 0;
> > +
> > +     return clk_get_rate(cpu_clk) / 1000;
> > +}
> > +
> > +static int mxc_set_target(struct cpufreq_policy *policy,
> > +                       unsigned int target_freq, unsigned int relation)
> > +{
> > +     struct cpufreq_freqs freqs;
> > +     int freq_Hz;
> > +     int ret = 0;
> > +     unsigned int index;
> > +
> > +     cpufreq_frequency_table_target(policy, imx_freq_table,
> > +                     target_freq, relation, &index);
> > +     freq_Hz = imx_freq_table[index].frequency * 1000;
> > +
> > +     freqs.old = clk_get_rate(cpu_clk) / 1000;
> > +     freqs.new = freq_Hz / 1000;
> > +     freqs.cpu = 0;
> > +     freqs.flags = 0;
> > +     cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +
> > +     if (freqs.old != freqs.new)
> > +             ret = set_cpu_freq(freq_Hz);
> > +
> > +     cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > +
> > +     return ret;
> > +}
> > +
> > +static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
> > +{
> > +     int ret;
> > +     int i;
> > +
> > +     printk(KERN_INFO "i.MXC CPU frequency driver\n");
> > +
> > +     if (policy->cpu != 0)
> > +             return -EINVAL;
> > +
> > +     cpu_clk = clk_get(NULL, "cpu_clk");
> > +     if (IS_ERR(cpu_clk)) {
> > +             printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
> > +             return PTR_ERR(cpu_clk);
> > +     }
> > +
> > +     cpu_op_tbl = get_cpu_op(&cpu_op_nr);
>
> This will crash every board except the babbage board which happens to
> set this function pointer.
>
Add a checking here should avoid that.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/68fec7b5/attachment-0001.html>
