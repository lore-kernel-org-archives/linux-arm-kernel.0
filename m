From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Apr 2016 19:42:37 -0700
Subject: [PATCH v2 6/6] ARM: Remove arm_pm_restart
In-Reply-To: <1460688157-6551-1-git-send-email-linux@roeck-us.net>
References: <1460688157-6551-1-git-send-email-linux@roeck-us.net>
Message-ID: <1460688157-6551-7-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All users of arm_pm_restart have been converted to use the kernel restart
handler.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebased to v4.6-rc3, added Reviewed/by/Acked-by tags

 arch/arm/include/asm/system_misc.h | 1 -
 arch/arm/kernel/reboot.c           | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index a3d61ad984af..6c952538f1e8 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -11,7 +11,6 @@
 extern void cpu_init(void);
 
 void soft_restart(unsigned long);
-extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 extern void (*arm_pm_idle)(void);
 
 #define UDBG_UNDEFINED	(1 << 0)
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 71a2ff9ec490..4785c39ee3eb 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -20,7 +20,6 @@ typedef void (*phys_reset_t)(unsigned long);
 /*
  * Function pointers to optional machine specific functions
  */
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
@@ -140,10 +139,7 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	if (arm_pm_restart)
-		arm_pm_restart(reboot_mode, cmd);
-	else
-		do_kernel_restart(cmd);
+	do_kernel_restart(cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
-- 
2.5.0
