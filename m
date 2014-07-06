From: linux@roeck-us.net (Guenter Roeck)
Date: Sun,  6 Jul 2014 16:38:15 -0700
Subject: [PATCH v2 2/7] arm64: Support restart through restart notifier call
 chain
In-Reply-To: <1404689900-27421-1-git-send-email-linux@roeck-us.net>
References: <1404689900-27421-1-git-send-email-linux@roeck-us.net>
Message-ID: <1404689900-27421-3-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a notifier call chain to restart
the system. Call it if arm_pm_restart is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Only call notifier call chain if arm_pm_restart is not set
    Do not include linux/watchdog.h

 arch/arm64/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 43b7c34..585ebe2 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -174,6 +174,9 @@ void machine_restart(char *cmd)
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
+	else
+		blocking_notifier_call_chain(&restart_notifier_list,
+					     reboot_mode, cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
1.9.1
