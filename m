From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 19 Feb 2013 18:16:13 +0800
Subject: [PATCH] ARM: tegra: don't unlock MMIO access to DBGLAR
Message-ID: <1361268973-14584-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to unlock MMIO access to the DBGLAR all the time. Doing
so may even cause problems if a SW bug causes writes to that MMIO region.

Cortex-A15 processors do not support the CP14 register write the code
currently uses to unlock the DBGLAR; the instruction throws an undefined
instruction exceptions. This prevents tegra_secondary_startup() from
executing on Tegra114, and hence prevents SMP.

Remove the code that unlocks this access.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/headsmp.S       | 3 ---
 arch/arm/mach-tegra/reset-handler.S | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index fd473f2..045c16f 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -7,8 +7,5 @@
 
 ENTRY(tegra_secondary_startup)
         bl      v7_invalidate_l1
-	/* Enable coresight */
-	mov32	r0, 0xC5ACCE55
-	mcr	p14, 0, r0, c7, c12, 6
         b       secondary_startup
 ENDPROC(tegra_secondary_startup)
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 54382ce..68b8bfc 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -41,9 +41,6 @@
  */
 ENTRY(tegra_resume)
 	bl	v7_invalidate_l1
-	/* Enable coresight */
-	mov32	r0, 0xC5ACCE55
-	mcr	p14, 0, r0, c7, c12, 6
 
 	cpu_id	r0
 	cmp	r0, #0				@ CPU0?
-- 
1.8.1.1
