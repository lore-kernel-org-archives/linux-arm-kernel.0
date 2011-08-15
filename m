From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:34:22 +0100
Subject: [PATCH] ARM: s3c24xx: ensure cpu_reset is only called when memory is
	flat-mapped
Message-ID: <1313429662-3145-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c24xx_pm_restart makes a direct call to arch_reset, without first
establishing a 1:1 memory mapping. arch_reset will then call
cpu_reset(0), which is designed to be called only with an identity map
in place.

Following the discussion here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/057281.html

This patch ensures that arch_reset is only called via arm_machine_restart
so that we have a consistent flat mapping requirement for the MMU-off
code.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-s3c24xx/cpu.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index c1fc6c6..528930c 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -198,18 +198,6 @@ static unsigned long s3c24xx_read_idcode_v4(void)
  */
 static void s3c24xx_pm_restart(char mode, const char *cmd)
 {
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
 	arm_machine_restart(mode, cmd);
 }
 
-- 
1.7.0.4
