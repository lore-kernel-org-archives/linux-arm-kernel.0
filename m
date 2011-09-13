From: khilman@ti.com (Kevin Hilman)
Date: Tue, 13 Sep 2011 11:18:44 -0700
Subject: [PATCH] OMAP3: PM: fix UART handling when using no_console_suspend
Message-ID: <mailman.131.1315938260.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the idle/suspend path, we expect the console lock to be held so
that no console output is done during/after the UARTs are idled.

However, when using the no_console_suspend argument on the
command-line, the console driver does not take the console lock.  This
allows the possibility of console activity after UARTs have been
disabled.

To fix, update the current is_suspending() to also check the
console_suspend_enabled flag.

NOTE: this is short-term workaround until the OMAP serial driver
      is fully converted to use runtime PM.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..c8cbd00 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -55,7 +55,7 @@
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
 static inline bool is_suspending(void)
 {
-	return (suspend_state != PM_SUSPEND_ON);
+	return (suspend_state != PM_SUSPEND_ON) && console_suspend_enabled;
 }
 #else
 static inline bool is_suspending(void)
-- 
1.7.6



[2]
commit e83df17f178360a8e7874441bca04a710c869e42
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Wed Dec 8 22:40:40 2010 +0000

    OMAP2+: PM/serial: fix console semaphore acquire during suspend
    
    commit 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6 (OMAP2+: PM/serial:
    hold console semaphore while OMAP UARTs are disabled) added use of the
    console semaphore to protect UARTs from being accessed after disabled
    during idle, but this causes problems in suspend.
    
    During suspend, the console semaphore is acquired by the console
    suspend method (console_suspend()) so the try_acquire_console_sem()
    will always fail and suspend will be aborted.
    
    To fix, introduce a check so the console semaphore is only attempted
    during idle, and not during suspend.  Also use the same check so that
    the console semaphore is not prematurely released during resume.
    
    Thanks to Paul Walmsley for suggesting adding the same check during
    resume.
    
    Cc: Paul Walmsley <paul@pwsan.com>
    Tested-by: Jean Pihet <j-pihet@ti.com>
    Tested-by: Paul Walmsley <paul@pwsan.com>
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>
