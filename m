From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  4 Aug 2014 18:48:53 -0700
Subject: [PATCH v6 2/7] arm64: Support restart through restart handler call
 chain
In-Reply-To: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
References: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
Message-ID: <1407203338-12915-3-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel core now supports a restart handler call chain to restart
the system. Call it if arm_pm_restart is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
v6: No change.
v5: Renamed restart function to do_kernel_restart
v4: No change.
v3: Use wrapper function to execute notifier call chain.
v2: Only call notifier call chain if arm_pm_restart is not set.
    Do not include linux/watchdog.h.

 arch/arm64/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 43b7c34..9591e60 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -174,6 +174,8 @@ void machine_restart(char *cmd)
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
+	else
+		do_kernel_restart(cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
1.9.1
