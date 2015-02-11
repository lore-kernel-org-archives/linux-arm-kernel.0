From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Feb 2015 02:25:23 +0000 (UTC)
Subject: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only
 Kconfigs
In-Reply-To: <54D9E42C.7010105@gmail.com>
References: <alpine.DEB.2.02.1502070020530.3767@utopia.booyaka.com>
 <54D9CFBC.3070405@nvidia.com> <54D9E42C.7010105@gmail.com>
Message-ID: <alpine.DEB.2.02.1502110218090.3767@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

thanks for the review,

On Tue, 10 Feb 2015, Jon Hunter wrote:

> On 07/02/2015 00:23, Paul Walmsley wrote:
> > 
> > Building an OMAP1510-only Kconfig generates the following warnings:
> > 
> > arch/arm/mach-omap1/pm.c: In function ?omap1_pm_idle?:
> > arch/arm/mach-omap1/pm.c:123:2: warning: #warning Enable 32kHz OS timer
> > in order to allow sleep states in idle [-Wcpp]
> >  #warning Enable 32kHz OS timer in order to allow sleep states in idle
> >   ^
> > arch/arm/mach-omap1/pm.c: At top level:
> > arch/arm/mach-omap1/pm.c:76:23: warning: ?enable_dyn_sleep? defined but
> > not used [-Wunused-variable]
> >  static unsigned short enable_dyn_sleep = 0;
> >                        ^
> > 
> > These are not so easy to fix in an obviously correct fashion, since I
> > don't have these devices up and running in my testbed.  So, use
> > arch/arm/plat-omap/Kconfig and the existing pm.c source as a guide,
> > and posit that deep power saving states are only supported on OMAP16xx
> > chips with kernels built with both CONFIG_OMAP_DM_TIMER=y and
> > CONFIG_OMAP_32K_TIMER=y.
> > 
> > While here, clean up a few printk()s and unnecessary #ifdefs.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: linux-omap at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > ---
> > 
> > Hi folks, if anyone out there is still experimenting with OMAP1 PM, or has
> > a copy of the OMAP1510 TRMs, could you please check this patch?  I'm
> > unable to test it since I don't have any OMAP1 devices currently active
> > in the testbed.  It at least compiles and deals with the build warnings:
> 
> You can find the omap5910 documents here [1]. The omap5910 is equivalent
> to the omap1510. 

OK good to be reminded of that :-)

> Unfortunately, there is not a single TRM for the omap5910 but individual 
> documents for each chapter in the original TRM. Check out the "OMAP5910 
> Dual-Core Processor Timer Reference Guide" and possibly the "OMAP5910 
> Dual-Core Processor Clock Generation and System Reset Management 
> Reference Guide"
> 
> The omap15xx/5910 did have a 32k timer but as you can see it appears it
> was never supported by the kernel for this device (not sure why). I do
> recall that there is some errata regarding the 32k timer, if you look at
> the omap5910 errata document and search for 32k you should find it.

OK thanks for the context.  I probably am not going to investigate adding 
support for this timer on OMAP1510/5910 - am primarily trying to avoid 
causing a regression on the existing platforms.

> I no longer have access to omap15xx h/w to test. However, I do have
> omap5912 if you want me to test.

Only if you feel like it!  Am fine with just having the review.

> > http://www.pwsan.com/omap/testlogs/fix-omap-warnings-v3.21/20150206154619/
> > 
> > Non-critical; targeted for v3.20-rc1 or v3.21-rc1.
> > 
> > 
> >  arch/arm/mach-omap1/pm.c | 42 +++++++++++++++++++++---------------------
> >  1 file changed, 21 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> > index 34b4c0044961..d46d8a222fbb 100644
> > --- a/arch/arm/mach-omap1/pm.c
> > +++ b/arch/arm/mach-omap1/pm.c
> > @@ -71,13 +71,7 @@ static unsigned int
> > mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
> >  static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
> >  static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
> > 
> > -#ifndef CONFIG_OMAP_32K_TIMER
> > -
> > -static unsigned short enable_dyn_sleep = 0;
> > -
> > -#else
> > -
> > -static unsigned short enable_dyn_sleep = 1;
> > +static unsigned short enable_dyn_sleep;
> > 
> >  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  			 char *buf)
> > @@ -90,8 +84,9 @@ static ssize_t idle_store(struct kobject *kobj, struct
> > kobj_attribute *attr,
> >  {
> >  	unsigned short value;
> >  	if (sscanf(buf, "%hu", &value) != 1 ||
> > -	    (value != 0 && value != 1)) {
> > -		printk(KERN_ERR "idle_sleep_store: Invalid value\n");
> > +	    (value != 0 && value != 1) ||
> > +	    (value != 0 && !IS_ENABLED(CONFIG_OMAP_32K_TIMER))) {
> > +		pr_err("idle_sleep_store: Invalid value\n");
> >  		return -EINVAL;
> >  	}
> >  	enable_dyn_sleep = value;
> > @@ -101,7 +96,6 @@ static ssize_t idle_store(struct kobject *kobj,
> > struct kobj_attribute *attr,
> >  static struct kobj_attribute sleep_while_idle_attr =
> >  	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
> > 
> > -#endif
> > 
> >  static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) =
> > NULL;
> > 
> > @@ -120,12 +114,11 @@ void omap1_pm_idle(void)
> >  	local_fiq_disable();
> > 
> >  #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
> > -#warning Enable 32kHz OS timer in order to allow sleep states in idle
> >  	use_idlect1 = use_idlect1 & ~(1 << 9);
> > -#else
> > +#endif
> > +
> >  	if (enable_dyn_sleep)
> >  		do_sleep = 1;
> 
> Do we still need this do_sleep variable now? Looking at the code, I
> think we could use enable_dyn_sleep directly.

OK dropped it.

> 
> > -#endif
> > 
> >  #ifdef CONFIG_OMAP_DM_TIMER
> >  	use_idlect1 = omap_dm_timer_modify_idlect_mask(use_idlect1);
> > @@ -635,15 +628,24 @@ static const struct platform_suspend_ops
> > omap_pm_ops = {
> > 
> >  static int __init omap_pm_init(void)
> >  {
> > -
> > -#ifdef CONFIG_OMAP_32K_TIMER
> > -	int error;
> > -#endif
> > +	int error = 0;
> > 
> >  	if (!cpu_class_is_omap1())
> >  		return -ENODEV;
> > 
> > -	printk("Power Management for TI OMAP.\n");
> > +	pr_info("Power Management for TI OMAP.\n");
> > +
> > +	if (!IS_ENABLED(CONFIG_OMAP_32K_TIMER))
> > +		pr_info("OMAP1 PM: sleep states in idle disabled due to no 32KiHz
> > timer\n");
> > +
> > +	if (!IS_ENABLED(CONFIG_OMAP_DM_TIMER))
> > +		pr_info("OMAP1 PM: sleep states in idle disabled due to no DMTIMER
> > support\n");
> > +
> > +	if (IS_ENABLED(CONFIG_OMAP_32K_TIMER) &&
> > +	    IS_ENABLED(CONFIG_OMAP_DM_TIMER) && cpu_is_omap16xx()) {
> 
> Do you need cpu_is_omap16xx() here? I believe DM_TIMER is only available
> on omap16xx onwards.

Makes sense, I'll drop the cpu_is* test.

> > +		pr_info("OMAP1 PM: sleep states in idle enabled\n");
> > +		enable_dyn_sleep = 1;
> > +	}
> > 
> >  	/*
> >  	 * We copy the assembler sleep/wakeup routines to SRAM.
> > @@ -693,17 +695,15 @@ static int __init omap_pm_init(void)
> >  	omap_pm_init_debugfs();
> >  #endif
> > 
> > -#ifdef CONFIG_OMAP_32K_TIMER
> >  	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
> >  	if (error)
> >  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> > -#endif
> > 
> >  	if (cpu_is_omap16xx()) {
> >  		/* configure LOW_PWR pin */
> >  		omap_cfg_reg(T20_1610_LOW_PWR);
> >  	}
> > 
> > -	return 0;
> > +	return error;
> >  }
> >  __initcall(omap_pm_init);
> > 
> 
> Otherwise ...
> 
> Acked-by: Jon Hunter <jgchunter@gmail.com>
> 
> Cheers Jon

Updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 6 Feb 2015 15:56:07 -0700
Subject: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only Kconfigs

Building an OMAP1510-only Kconfig generates the following warnings:

arch/arm/mach-omap1/pm.c: In function ?omap1_pm_idle?:
arch/arm/mach-omap1/pm.c:123:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle [-Wcpp]
 #warning Enable 32kHz OS timer in order to allow sleep states in idle
  ^
arch/arm/mach-omap1/pm.c: At top level:
arch/arm/mach-omap1/pm.c:76:23: warning: ?enable_dyn_sleep? defined but not used [-Wunused-variable]
 static unsigned short enable_dyn_sleep = 0;
                       ^

These are not so easy to fix in an obviously correct fashion, since I
don't have these devices up and running in my testbed.  So, use
arch/arm/plat-omap/Kconfig and the existing pm.c source as a guide,
and posit that deep power saving states are only supported on OMAP16xx
chips with kernels built with both CONFIG_OMAP_DM_TIMER=y and
CONFIG_OMAP_32K_TIMER=y.

While here, clean up a few printk()s and unnecessary #ifdefs.

This second version of the patch incorporates several suggestions from
Jon Hunter <jgchunter@gmail.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Acked-by: Jon Hunter <jgchunter@gmail.com>
---
 arch/arm/mach-omap1/pm.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 34b4c0044961..dd94567c3628 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -71,13 +71,7 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
 
-#ifndef CONFIG_OMAP_32K_TIMER
-
-static unsigned short enable_dyn_sleep = 0;
-
-#else
-
-static unsigned short enable_dyn_sleep = 1;
+static unsigned short enable_dyn_sleep;
 
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
@@ -90,8 +84,9 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	unsigned short value;
 	if (sscanf(buf, "%hu", &value) != 1 ||
-	    (value != 0 && value != 1)) {
-		printk(KERN_ERR "idle_sleep_store: Invalid value\n");
+	    (value != 0 && value != 1) ||
+	    (value != 0 && !IS_ENABLED(CONFIG_OMAP_32K_TIMER))) {
+		pr_err("idle_sleep_store: Invalid value\n");
 		return -EINVAL;
 	}
 	enable_dyn_sleep = value;
@@ -101,7 +96,6 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute sleep_while_idle_attr =
 	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
 
-#endif
 
 static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) = NULL;
 
@@ -115,16 +109,11 @@ void omap1_pm_idle(void)
 {
 	extern __u32 arm_idlect1_mask;
 	__u32 use_idlect1 = arm_idlect1_mask;
-	int do_sleep = 0;
 
 	local_fiq_disable();
 
 #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
-#warning Enable 32kHz OS timer in order to allow sleep states in idle
 	use_idlect1 = use_idlect1 & ~(1 << 9);
-#else
-	if (enable_dyn_sleep)
-		do_sleep = 1;
 #endif
 
 #ifdef CONFIG_OMAP_DM_TIMER
@@ -134,10 +123,12 @@ void omap1_pm_idle(void)
 	if (omap_dma_running())
 		use_idlect1 &= ~(1 << 6);
 
-	/* We should be able to remove the do_sleep variable and multiple
+	/*
+	 * We should be able to remove the do_sleep variable and multiple
 	 * tests above as soon as drivers, timer and DMA code have been fixed.
-	 * Even the sleep block count should become obsolete. */
-	if ((use_idlect1 != ~0) || !do_sleep) {
+	 * Even the sleep block count should become obsolete.
+	 */
+	if ((use_idlect1 != ~0) || !enable_dyn_sleep) {
 
 		__u32 saved_idlect1 = omap_readl(ARM_IDLECT1);
 		if (cpu_is_omap15xx())
@@ -635,15 +626,25 @@ static const struct platform_suspend_ops omap_pm_ops = {
 
 static int __init omap_pm_init(void)
 {
-
-#ifdef CONFIG_OMAP_32K_TIMER
-	int error;
-#endif
+	int error = 0;
 
 	if (!cpu_class_is_omap1())
 		return -ENODEV;
 
-	printk("Power Management for TI OMAP.\n");
+	pr_info("Power Management for TI OMAP.\n");
+
+	if (!IS_ENABLED(CONFIG_OMAP_32K_TIMER))
+		pr_info("OMAP1 PM: sleep states in idle disabled due to no 32KiHz timer\n");
+
+	if (!IS_ENABLED(CONFIG_OMAP_DM_TIMER))
+		pr_info("OMAP1 PM: sleep states in idle disabled due to no DMTIMER support\n");
+
+	if (IS_ENABLED(CONFIG_OMAP_32K_TIMER) &&
+	    IS_ENABLED(CONFIG_OMAP_DM_TIMER)) {
+		/* OMAP16xx only */
+		pr_info("OMAP1 PM: sleep states in idle enabled\n");
+		enable_dyn_sleep = 1;
+	}
 
 	/*
 	 * We copy the assembler sleep/wakeup routines to SRAM.
@@ -693,17 +694,15 @@ static int __init omap_pm_init(void)
 	omap_pm_init_debugfs();
 #endif
 
-#ifdef CONFIG_OMAP_32K_TIMER
 	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
-#endif
 
 	if (cpu_is_omap16xx()) {
 		/* configure LOW_PWR pin */
 		omap_cfg_reg(T20_1610_LOW_PWR);
 	}
 
-	return 0;
+	return error;
 }
 __initcall(omap_pm_init);
-- 
2.1.4
