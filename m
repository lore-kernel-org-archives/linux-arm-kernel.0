From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:40:57 +0000
Subject: [PATCH 03/41] ARM: restart: remove s3c24xx restart handler
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6iH-0001Wl-QI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the s3c24xx restart handler, which is trying to work around
a chip bug by keeping caches on but flushed.  As we now only disable
caches when performing a soft reboot, there doesn't need to be a
work-around to do that.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-s3c24xx/cpu.c |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 3c63353..1121df1 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -192,27 +192,6 @@ static unsigned long s3c24xx_read_idcode_v4(void)
 	return __raw_readl(S3C2410_GSTATUS1);
 }
 
-/* Hook for arm_pm_restart to ensure we execute the reset code
- * with the caches enabled. It seems at least the S3C2440 has a problem
- * resetting if there is bus activity interrupted by the reset.
- */
-static void s3c24xx_pm_restart(char mode, const char *cmd)
-{
-	if (mode != 's') {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		__cpuc_flush_kern_all();
-		__cpuc_flush_user_all();
-
-		arch_reset(mode, cmd);
-		local_irq_restore(flags);
-	}
-
-	/* fallback, or unhandled */
-	arm_machine_restart(mode, cmd);
-}
-
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 {
 	/* initialise the io descriptors we need for initialisation */
@@ -226,7 +205,5 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	}
 	s3c24xx_init_cpu();
 
-	arm_pm_restart = s3c24xx_pm_restart;
-
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
-- 
1.7.4.4
