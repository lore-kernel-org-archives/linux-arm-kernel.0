From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 10 Jun 2016 00:55:26 +0200 (CEST)
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <1162370a4389413d2d4ff0eb79ff13ac@agner.ch>
References: <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
 <alpine.DEB.2.11.1604271212290.3941@nanos> <20160602145915.GA31124@shlinux2>
 <alpine.DEB.2.11.1606061448010.28031@nanos> <20160607070440.GA32573@shlinux2>
 <alpine.DEB.2.11.1606092204590.28031@nanos>
 <1162370a4389413d2d4ff0eb79ff13ac@agner.ch>
Message-ID: <alpine.DEB.2.11.1606100046150.28031@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jun 2016, Stefan Agner wrote:
> On 2016-06-09 13:08, Thomas Gleixner wrote:
> > On Tue, 7 Jun 2016, Dong Aisheng wrote:
> >> Then it may need introduce a lot changes and increase many new core APIs.
> >> Is that a problem?
> > 
> > No. That's all better than each driver having broken workarounds. It's a
> > common problem so it wants to be addressed at the core level. There you have a
> > central point to do this and you can still catch abusers which call stuff from
> > the wrong context. The hacks in the drivers don't allow that because they look
> > at the context, i.e. irq disabled, instead of checking the system state.
> 
> IMHO, the hacky part of my patch was how I detected whether to use sleep
> or delay. That said I am ok with API extension too, I guess it is fairly
> common use case... I found at least 6 clock prepare functions with sleep
> in it (and some udelays, all between 1-100).
> 
> Your proposed solution uses "early_boot_or_suspend_resume" which I did
> not found as a convenient function in the wild :-)
> 
> How would you implement that?

Early boot is simple. Supsend/resume is not that hard either. We have a patch
in RT which does exactly what you need. See below.

Then the state check simply becomes:

     system_state != SYSTEM_RUNNING

Thanks,

	tglx

8<---------------------------

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 350dfb08aee3..5e63b681f58e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -473,6 +473,7 @@ extern enum system_states {
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
+	SYSTEM_SUSPEND,
 } system_state;
 
 #define TAINT_PROPRIETARY_MODULE	0
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index b7342a24f559..bfd9e0982f15 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -285,6 +285,8 @@ static int create_image(int platform_mode)
 
 	local_irq_disable();
 
+	system_state = SYSTEM_SUSPEND;
+
 	error = syscore_suspend();
 	if (error) {
 		printk(KERN_ERR "PM: Some system devices failed to power down, "
@@ -314,6 +316,7 @@ static int create_image(int platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
@@ -437,6 +440,7 @@ static int resume_target_kernel(bool platform_mode)
 		goto Enable_cpus;
 
 	local_irq_disable();
+	system_state = SYSTEM_SUSPEND;
 
 	error = syscore_suspend();
 	if (error)
@@ -470,6 +474,7 @@ static int resume_target_kernel(bool platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
@@ -555,6 +560,7 @@ int hibernation_platform_enter(void)
 		goto Enable_cpus;
 
 	local_irq_disable();
+	system_state = SYSTEM_SUSPEND;
 	syscore_suspend();
 	if (pm_wakeup_pending()) {
 		error = -EAGAIN;
@@ -567,6 +573,7 @@ int hibernation_platform_enter(void)
 
  Power_up:
 	syscore_resume();
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index f9fe133c13e2..80ebc0726290 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -359,6 +359,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
 
+	system_state = SYSTEM_SUSPEND;
+
 	error = syscore_suspend();
 	if (!error) {
 		*wakeup = pm_wakeup_pending();
@@ -375,6 +377,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 		syscore_resume();
 	}
 
+	system_state = SYSTEM_RUNNING;
+
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
 
