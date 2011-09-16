From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 16 Sep 2011 14:09:00 +0800
Subject: [PATCH v2 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <20110915162829.GA4797@e102568-lin.cambridge.arm.com>
References: <1316097926-913-1-git-send-email-shawn.guo@linaro.org>
	<1316097926-913-7-git-send-email-shawn.guo@linaro.org>
	<20110915162829.GA4797@e102568-lin.cambridge.arm.com>
Message-ID: <20110916060859.GG25928@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Thu, Sep 15, 2011 at 05:28:29PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Sep 15, 2011 at 03:45:26PM +0100, Shawn Guo wrote:
> > It adds suspend/resume support for imx6q.
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/Makefile              |    2 +-
> >  arch/arm/mach-imx/head-v7.S             |   27 +++++++++
> >  arch/arm/mach-imx/pm-imx6q.c            |   88 +++++++++++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/common.h |    8 +++
> >  4 files changed, 124 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-imx/pm-imx6q.c
> > 
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index 16737ba..c787151 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -70,4 +70,4 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
> >  obj-$(CONFIG_SMP) += platsmp.o
> >  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
> >  obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
> > -obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
> > +obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
> > diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> > index ede908b..0a86685 100644
> > --- a/arch/arm/mach-imx/head-v7.S
> > +++ b/arch/arm/mach-imx/head-v7.S
> > @@ -69,3 +69,30 @@ ENTRY(v7_secondary_startup)
> >  	b	secondary_startup
> >  ENDPROC(v7_secondary_startup)
> >  #endif
> > +
> > +ENTRY(v7_cpu_resume)
> > +	bl	v7_invalidate_l1
> > +
> > +	/*
> > +	 * Restore L2 AUX_CTRL register saved by suspend procedure
> > +	 * and enable L2
> > +	 */
> > +	adr	r4, 1f
> > +	ldmia	r4, {r5, r6, r7}
> > +	sub	r4, r4, r5
> > +	add	r6, r6, r4
> > +	add	r7, r7, r4
> > +	ldr	r0, [r6]
> > +	ldr	r7, [r7]
> > +	ldr	r1, [r7]
> > +	str	r1, [r0, #L2X0_AUX_CTRL]
> > +	ldr	r1, =0x1
> > +	str	r1, [r0, #L2X0_CTRL]
> > +
> > +	b	cpu_resume
> > +
> > +	.align
> > +1:	.long	.
> > +	.long	pl310_pbase
> > +	.long	pl310_aux_ctrl_paddr
> 
> Would not something like:
> 
> 	adr	r4, pl310_pbase
> 	ldmia	r4, {r6, r7}
> 	[...]
> 
> pl310_pbase:
> 	.long 0
> pl310_aux_ctrl:
> 	.long 0
> 
> be better and faster ? Why play with virtual addresses ?
> Of course you should initialize the values, but then you can access them
> through a PC relative load when running physical.

Thanks for the comment.  I agree with you that it's better, though my
first thought on the existing approach is I can access the global
variables defined in C file directly from assembly code.

> Your code should be in the .data section for it to be writable (adr does not
> work across sections), have a look at Russell's code in sleep.S it is
> very well commented and similar to what you need.

Thanks for pointing me the example.

> 
> > +ENDPROC(v7_cpu_resume)
> > diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
> > new file mode 100644
> > index 0000000..124bcd5
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/pm-imx6q.c
> > @@ -0,0 +1,88 @@
> > +/*
> > + * Copyright 2011 Freescale Semiconductor, Inc.
> > + * Copyright 2011 Linaro Ltd.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/suspend.h>
> > +#include <asm/proc-fns.h>
> > +#include <asm/suspend.h>
> > +#include <asm/hardware/cache-l2x0.h>
> > +#include <mach/common.h>
> > +#include <mach/hardware.h>
> > +
> > +static void __iomem *pl310_vbase;
> > +void __iomem *pl310_pbase;
> > +
> > +static volatile unsigned long pl310_aux_ctrl;
> > +volatile unsigned long pl310_aux_ctrl_paddr;
> 
> I think that by defining those variables in assembly you would make
> your life much simpler.

Yes.  But I need a function call to learn the address of those variables
from assembly now.

> I think you know your L2 is already initialized here to make sure you
> save the right aux value. Hence you should clean the variables above from
> L2 to make sure they are available at reset from DRAM (L2 is retained
> and you do not clean it on suspend, correct ?)

Yes, agreed.  It's right thing to do for being safe.  Actually, I did it
when I saved the variables during suspend.  If I do not do, it simply
does not work.  But later, when I moved the saving to init function
since it needs to be done for only once, I found it works even without
the cache clean.  Then I dropped it.  To be safe, now I'm adding it
back with following your comment.

> 
> I do not think that code to save/restore L2 config belongs here though.
> More below.
> 
> > +
> > +static int imx6q_suspend_finish(unsigned long val)
> > +{
> > +	cpu_do_idle();
> > +	return 0;
> > +}
> > +
> > +static int imx6q_pm_enter(suspend_state_t state)
> > +{
> > +	switch (state) {
> > +	case PM_SUSPEND_MEM:
> > +		imx6q_set_lpm(STOP_POWER_OFF);
> > +		imx_gpc_pre_suspend();
> > +		imx_set_cpu_jump(0, v7_cpu_resume);
> > +		/* Zzz ... */
> > +		cpu_suspend(0, imx6q_suspend_finish);
> > +		imx_smp_prepare();
> > +		imx_gpc_post_resume();
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct platform_suspend_ops imx6q_pm_ops = {
> > +	.enter = imx6q_pm_enter,
> > +	.valid = suspend_valid_only_mem,
> > +};
> > +
> > +void __init imx6q_pm_init(void)
> > +{
> > +	struct device_node *np;
> > +	u32 reg[2];
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
> > +	of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
> > +	pl310_vbase = ioremap(reg[0], reg[1]);
> 
> Mmmm...is this vma ever released ? L2 is already mapped in the L2
> driver from DT or through static mappings. 

I think we can do another mapping even it's been done in the L2 driver,
no?

> Overall, I think that code to restore PL310 belongs in cache-l2x0.c, not here.
> We can easily write an assembly stub that reinitialize L2 before
> resume if that's something we should and can do (security ?).
> 
I would be definitely happy to see that, but before rmk agrees on that,
I have to find a way around in the platform code.

Here is the updated patch.  If it looks better to you, I will
incorporate it in the v3 of the series.

8<---
diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index ede908b..5a486a9 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -69,3 +69,35 @@ ENTRY(v7_secondary_startup)
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
 #endif
+
+ENTRY(pl310_get_save_ptr)
+	ldr	r0, =pl310_pbase
+	mov	pc, lr
+ENDPROC(pl310_get_save_ptr)
+
+ENTRY(v7_cpu_resume)
+	bl	v7_invalidate_l1
+	bl	pl310_resume
+	b	cpu_resume
+ENDPROC(v7_cpu_resume)
+
+/*
+ * The following code is located into the .data section.  This is to
+ * allow pl310_pbase and pl310_aux_ctrl to be accessed with a relative
+ * load as we are running on physical address here.
+ */
+	.data
+	.align
+ENTRY(pl310_resume)
+	adr	r2, pl310_pbase
+	ldmia	r2, {r0, r1}
+	str	r1, [r0, #L2X0_AUX_CTRL]	@ restore aux_ctrl
+	mov	r1, #0x1
+	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
+	mov	pc, lr
+ENDPROC(pl310_resume)
+
+pl310_pbase:
+	.long	0
+pl310_aux_ctrl:
+	.long	0
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
new file mode 100644
index 0000000..59cb8d2
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/suspend.h>
+#include <asm/cacheflush.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+
+static int imx6q_suspend_finish(unsigned long val)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static int imx6q_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		imx6q_set_lpm(STOP_POWER_OFF);
+		imx_gpc_pre_suspend();
+		imx_set_cpu_jump(0, v7_cpu_resume);
+		/* Zzz ... */
+		cpu_suspend(0, imx6q_suspend_finish);
+		imx_smp_prepare();
+		imx_gpc_post_resume();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct platform_suspend_ops imx6q_pm_ops = {
+	.enter = imx6q_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+void __init imx6q_pm_init(void)
+{
+	struct device_node *np;
+	u32 reg[2], *ptr;
+	void __iomem *base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
+	of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	base = ioremap(reg[0], reg[1]);
+	WARN_ON(!base);
+
+	/*
+	 * On imx6q, during system suspend, ARM core gets powered off,
+	 * but L2 cache is retained.  To avoid cleaning the entire L2,
+	 * we need to save L2 controller registers, and when system gets
+	 * woke up, restore the registers and re-enable L2 before
+	 * calling into cpu_resume().
+	 *
+	 * Most of pl310 configuration upon reset work just fine for
+	 * imx6q, and the only one register we actually need to save is
+	 * AUX_CTRL.  Also since pl310 configuration won't change in a
+	 * live system, we can save it here only once, and restore it
+	 * every time system resumes back from v7_cpu_resume().
+	 */
+	ptr = pl310_get_save_ptr();
+	/* save pl310 physical base address */
+	*ptr = reg[0];
+	/* save pl310 aux_ctrl register */
+	*(ptr + 1) = readl_relaxed(base + L2X0_AUX_CTRL);
+	/* ensure they are written into external memory */
+	__cpuc_flush_dcache_area((void *) ptr, sizeof(*ptr) * 2);
+	outer_clean_range(__pa(ptr), __pa(ptr + 2));
+
+	suspend_set_ops(&imx6q_pm_ops);
+}

-- 
Regards,
Shawn
