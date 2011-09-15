From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 15 Sep 2011 17:28:29 +0100
Subject: [PATCH v2 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <1316097926-913-7-git-send-email-shawn.guo@linaro.org>
References: <1316097926-913-1-git-send-email-shawn.guo@linaro.org>
	<1316097926-913-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110915162829.GA4797@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 03:45:26PM +0100, Shawn Guo wrote:
> It adds suspend/resume support for imx6q.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/Makefile              |    2 +-
>  arch/arm/mach-imx/head-v7.S             |   27 +++++++++
>  arch/arm/mach-imx/pm-imx6q.c            |   88 +++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/common.h |    8 +++
>  4 files changed, 124 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-imx/pm-imx6q.c
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 16737ba..c787151 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -70,4 +70,4 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
>  obj-$(CONFIG_SMP) += platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
>  obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
> -obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
> +obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
> diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> index ede908b..0a86685 100644
> --- a/arch/arm/mach-imx/head-v7.S
> +++ b/arch/arm/mach-imx/head-v7.S
> @@ -69,3 +69,30 @@ ENTRY(v7_secondary_startup)
>  	b	secondary_startup
>  ENDPROC(v7_secondary_startup)
>  #endif
> +
> +ENTRY(v7_cpu_resume)
> +	bl	v7_invalidate_l1
> +
> +	/*
> +	 * Restore L2 AUX_CTRL register saved by suspend procedure
> +	 * and enable L2
> +	 */
> +	adr	r4, 1f
> +	ldmia	r4, {r5, r6, r7}
> +	sub	r4, r4, r5
> +	add	r6, r6, r4
> +	add	r7, r7, r4
> +	ldr	r0, [r6]
> +	ldr	r7, [r7]
> +	ldr	r1, [r7]
> +	str	r1, [r0, #L2X0_AUX_CTRL]
> +	ldr	r1, =0x1
> +	str	r1, [r0, #L2X0_CTRL]
> +
> +	b	cpu_resume
> +
> +	.align
> +1:	.long	.
> +	.long	pl310_pbase
> +	.long	pl310_aux_ctrl_paddr

Would not something like:

	adr	r4, pl310_pbase
	ldmia	r4, {r6, r7}
	[...]

pl310_pbase:
	.long 0
pl310_aux_ctrl:
	.long 0

be better and faster ? Why play with virtual addresses ?
Of course you should initialize the values, but then you can access them
through a PC relative load when running physical.
Your code should be in the .data section for it to be writable (adr does not
work across sections), have a look at Russell's code in sleep.S it is
very well commented and similar to what you need.

> +ENDPROC(v7_cpu_resume)
> diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
> new file mode 100644
> index 0000000..124bcd5
> --- /dev/null
> +++ b/arch/arm/mach-imx/pm-imx6q.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/suspend.h>
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +
> +static void __iomem *pl310_vbase;
> +void __iomem *pl310_pbase;
> +
> +static volatile unsigned long pl310_aux_ctrl;
> +volatile unsigned long pl310_aux_ctrl_paddr;

I think that by defining those variables in assembly you would make
your life much simpler.
I think you know your L2 is already initialized here to make sure you
save the right aux value. Hence you should clean the variables above from
L2 to make sure they are available at reset from DRAM (L2 is retained
and you do not clean it on suspend, correct ?)

I do not think that code to save/restore L2 config belongs here though.
More below.

> +
> +static int imx6q_suspend_finish(unsigned long val)
> +{
> +	cpu_do_idle();
> +	return 0;
> +}
> +
> +static int imx6q_pm_enter(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		imx6q_set_lpm(STOP_POWER_OFF);
> +		imx_gpc_pre_suspend();
> +		imx_set_cpu_jump(0, v7_cpu_resume);
> +		/* Zzz ... */
> +		cpu_suspend(0, imx6q_suspend_finish);
> +		imx_smp_prepare();
> +		imx_gpc_post_resume();
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_suspend_ops imx6q_pm_ops = {
> +	.enter = imx6q_pm_enter,
> +	.valid = suspend_valid_only_mem,
> +};
> +
> +void __init imx6q_pm_init(void)
> +{
> +	struct device_node *np;
> +	u32 reg[2];
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
> +	of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
> +	pl310_vbase = ioremap(reg[0], reg[1]);

Mmmm...is this vma ever released ? L2 is already mapped in the L2
driver from DT or through static mappings. 
Overall, I think that code to restore PL310 belongs in cache-l2x0.c, not here.
We can easily write an assembly stub that reinitialize L2 before
resume if that's something we should and can do (security ?).

Lorenzo
