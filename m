From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Apr 2016 19:42:36 -0700
Subject: [PATCH v2 5/6] ARM64: Remove arm_pm_restart
In-Reply-To: <1460688157-6551-1-git-send-email-linux@roeck-us.net>
References: <1460688157-6551-1-git-send-email-linux@roeck-us.net>
Message-ID: <1460688157-6551-6-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All users of arm_pm_restart have been converted to use the kernel restart
handler.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebased to v4.6-rc3, added Reviewed/by/Acked-by/Tested-by tags

 arch/arm64/include/asm/system_misc.h | 2 --
 arch/arm64/kernel/process.c          | 7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 57f110bea6a8..f1d865b7d38d 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -43,8 +43,6 @@ struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
 
-extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 #define show_unhandled_signals_ratelimited()				\
 ({									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 80624829db61..29c29984eca0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -66,8 +66,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 /*
  * This is our default idle handler.
  */
@@ -153,10 +151,7 @@ void machine_restart(char *cmd)
 		efi_reboot(reboot_mode, NULL);
 
 	/* Now call the architecture specific reboot code. */
-	if (arm_pm_restart)
-		arm_pm_restart(reboot_mode, cmd);
-	else
-		do_kernel_restart(cmd);
+	do_kernel_restart(cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
2.5.0
