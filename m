From: zhanzhenbo@gmail.com (Steve zhan)
Date: Tue, 12 Mar 2013 12:58:23 +0800
Subject: [PATCH] ARM: ux500: Remove duplicate ux500_l2x0_unlock function
Message-ID: <20130312045823.GA526@android11.spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus:
    Pls check/apply the below patch.
Thanks.

-----
steve

commit f962757a91b1c83a080e7c5b05cc6fb7828f1d84
Author: steve.zhan <zhanzhenbo@gmail.com>
Date:   Tue Mar 12 00:12:53 2013 +0800

    ARM: ux500: Remove duplicate ux500_l2x0_unlock function
    
    To avoids code duplication, remove reduplicate l2 cache unlock
    function "ux500_l2x0_unlock" in the ux500_l2x0_init, as arm\mm
    \cache-l2x0.c l2x0_init will call l2x0_unlock function to
    make sure that I&D is not locked down when starting.
    
    Signed-off-by: steve.zhan <zhanzhenbo@gmail.com>

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 1c1609d..372bdf6 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -15,26 +15,6 @@
 
 static void __iomem *l2x0_base;
 
-static int __init ux500_l2x0_unlock(void)
-{
-	int i;
-
-	/*
-	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
-	 * apparently locks both caches before jumping to the kernel. The
-	 * l2x0 core will not touch the unlock registers if the l2x0 is
-	 * already enabled, so we do it right here instead. The PL310 has
-	 * 8 sets of registers, one per possible CPU.
-	 */
-	for (i = 0; i < 8; i++) {
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-	}
-	return 0;
-}
-
 static int __init ux500_l2x0_init(void)
 {
 	u32 aux_val = 0x3e000000;
@@ -44,9 +24,6 @@ static int __init ux500_l2x0_init(void)
 	else
 		ux500_unknown_soc();
 
-	/* Unlock before init */
-	ux500_l2x0_unlock();
-
 	/* DB9540's L2 has 128KB way size */
 	if (cpu_is_u9540())
 		/* 128KB way size */
