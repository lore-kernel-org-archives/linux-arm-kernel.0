From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jan 2017 12:05:11 +0100
Subject: [PATCH 5/6] ARM64: Remove arm_pm_restart()
In-Reply-To: <20170130110512.6943-1-thierry.reding@gmail.com>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
Message-ID: <20170130110512.6943-6-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guenter Roeck <linux@roeck-us.net>

All users of arm_pm_restart() have been converted to use the kernel
restart handler.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/include/asm/system_misc.h | 2 --
 arch/arm64/kernel/process.c          | 7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index bc812435bc76..97398214061f 100644
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
index 0b07d42819da..138918269b3a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -68,8 +68,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 /*
  * This is our default idle handler.
  */
@@ -155,10 +153,7 @@ void machine_restart(char *cmd)
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
2.11.0
