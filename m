From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 15:20:49 -0800
Subject: buggy usage of pm_idle by omap1 code
In-Reply-To: <20111219213445.GL14542@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1112162208390.2907@xanadu.home>
 <20111219173518.GH6464@atomide.com>
 <20111219213445.GL14542@n2100.arm.linux.org.uk>
Message-ID: <20111219232049.GU6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111219 13:02]:
> On Mon, Dec 19, 2011 at 09:35:19AM -0800, Tony Lindgren wrote:
> > Good catch. Here's a patch to deal with that issue, want to take this
> > into your idle series? I'll try out your idle series today at some
> > point.
> 
> Two points:
> 
> 1. It's good practice to call cpu_idle_wait() after modifying pm_idle,
> even on UP - it allows static checking of this.

Hmm, looks like we're not using that anywhere right now. Should
we have a function or macro set_arm_idle() that does that
automatically?
 
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 19 Dec 2011 09:11:11 -0800
> > Subject: [PATCH] ARM: OMAP1: Fix pm_idle during suspend
> > 
> > Commit 9ccdac3662dbf3c75e8f8851a214bdf7d365a4bd ([ARM] idle:
> > clean up pm_idle calling, obey hlt_counter) removed a check
> > for NULL pm_idle.
> > 
> > On omap1 the system hits an equivalent of suspend during idle.
> > If we are suspending, we need to make sure so we don't call
> > omap1_pm_idle during the suspend process.
> > 
> > Fix this by setting the pm_idle function to a an empty
> > function while suspending.
> 
> 2. what's wrong with calling disable_hlt() to prevent the pm_idle function
> being called?  Why solve it this complicated way of changing the pm_idle
> pointer when there's some infrastructure which can fix it for you already?

Thanks that allows removal of few lines of code. Updated
patch below.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 19 Dec 2011 09:11:11 -0800
Subject: [PATCH] Subject: [PATCH] ARM: OMAP1: Fix pm_idle during suspend

Commit 9ccdac3662dbf3c75e8f8851a214bdf7d365a4bd ([ARM] idle:
clean up pm_idle calling, obey hlt_counter) removed a check
for NULL pm_idle.

On omap1 the system hits an equivalent of suspend during idle.
If we are suspending, we need to make sure so we don't call
omap1_pm_idle during the suspend process.

Fix this by using disable_hlt and enable_hlt for the suspend
as pointed out by Russell King <linux@arm.linux.org.uk>. This
allows us to remove the saved_idle.

Reported-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -583,8 +583,6 @@ static void omap_pm_init_proc(void)
 
 #endif /* DEBUG && CONFIG_PROC_FS */
 
-static void (*saved_idle)(void) = NULL;
-
 /*
  *	omap_pm_prepare - Do preliminary suspend work.
  *
@@ -592,8 +590,7 @@ static void (*saved_idle)(void) = NULL;
 static int omap_pm_prepare(void)
 {
 	/* We cannot sleep in idle until we have resumed */
-	saved_idle = pm_idle;
-	pm_idle = NULL;
+	disable_hlt();
 
 	return 0;
 }
@@ -630,7 +627,7 @@ static int omap_pm_enter(suspend_state_t state)
 
 static void omap_pm_finish(void)
 {
-	pm_idle = saved_idle;
+	enable_hlt();
 }
 
 
