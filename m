From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 30 Jun 2014 12:11:35 -0700
Subject: [RFC PATCH 2/6] arm64: Support restart through restart notifier call
 chain
In-Reply-To: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
References: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
Message-ID: <1404155499-21177-3-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a notifier call chain to restart the system.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 43b7c34..9dd2abd 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -43,6 +43,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/personality.h>
 #include <linux/notifier.h>
+#include <linux/watchdog.h>
 
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
@@ -175,6 +176,8 @@ void machine_restart(char *cmd)
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
 
+	blocking_notifier_call_chain(&restart_notifier_list, reboot_mode, cmd);
+
 	/*
 	 * Whoops - the architecture was unable to reboot.
 	 */
-- 
1.9.1
