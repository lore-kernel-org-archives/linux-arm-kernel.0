From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 Aug 2014 17:45:30 -0700
Subject: [PATCH v7 03/11] arm64: Support restart through restart handler call
 chain
In-Reply-To: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
Message-ID: <1408495538-27480-4-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a restart handler call chain to restart
the system. Call it if arm_pm_restart is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
v7: No change.
v6: No change.
v5: Renamed restart function to do_kernel_restart
v4: No change.
v3: Use wrapper function to execute notifier call chain.
v2: Only call notifier call chain if arm_pm_restart is not set.
    Do not include linux/watchdog.h.

 arch/arm64/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1309d64..0d3fb9f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -180,6 +180,8 @@ void machine_restart(char *cmd)
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
+	else
+		do_kernel_restart(cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
1.9.1
