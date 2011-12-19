From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 09:35:19 -0800
Subject: buggy usage of pm_idle by omap1 code
In-Reply-To: <alpine.LFD.2.02.1112162208390.2907@xanadu.home>
References: <alpine.LFD.2.02.1112162208390.2907@xanadu.home>
Message-ID: <20111219173518.GH6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111216 18:53]:
> 
> I just noticed in mach-omap1/cpu.c:omap_pm_prepare() that the function 
> pointer pm_idle is explicitly set to NULL for some vague reason.  
> However this pointer is unconditionally dereferenced in 
> kernel/process.c:cpu_idle().  This is just a oops waiting to happen.  
> And if it doesn't happen in practice, then the code in omap_pm_prepare() 
> must be useless in addition to being wrong.

Good catch. Here's a patch to deal with that issue, want to take this
into your idle series? I'll try out your idle series today at some
point.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 19 Dec 2011 09:11:11 -0800
Subject: [PATCH] ARM: OMAP1: Fix pm_idle during suspend

Commit 9ccdac3662dbf3c75e8f8851a214bdf7d365a4bd ([ARM] idle:
clean up pm_idle calling, obey hlt_counter) removed a check
for NULL pm_idle.

On omap1 the system hits an equivalent of suspend during idle.
If we are suspending, we need to make sure so we don't call
omap1_pm_idle during the suspend process.

Fix this by setting the pm_idle function to a an empty
function while suspending.

Reported-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 89ea20c..b551a62 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -584,6 +584,9 @@ static void omap_pm_init_proc(void)
 #endif /* DEBUG && CONFIG_PROC_FS */
 
 static void (*saved_idle)(void) = NULL;
+static void omap1_dummy_idle(void)
+{
+}
 
 /*
  *	omap_pm_prepare - Do preliminary suspend work.
@@ -593,7 +596,7 @@ static int omap_pm_prepare(void)
 {
 	/* We cannot sleep in idle until we have resumed */
 	saved_idle = pm_idle;
-	pm_idle = NULL;
+	pm_idle = omap1_dummy_idle;
 
 	return 0;
 }
