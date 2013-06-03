From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 3 Jun 2013 16:10:04 +0800
Subject: [PATCH] ARM: tegra: remove the ifdef of ARCH SoC in the tegra_resume
Message-ID: <1370247004-31846-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing the ifdef of ARCH_TEGRA_SoC in the tegra_resume function. Because
we always build with all Tegra SoCs support and had a runtime chip
detection code there. And we expect most of the chips would need the code
in the future.

We also fix a typo of a macro name that cause a build error.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/reset-handler.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index d2042ac..39dc9e7 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -54,12 +54,11 @@ ENTRY(tegra_resume)
 	bne	cpu_resume			@ no
 no_cpu0_chk:
 
-#ifndef CONFIG_ARCH_TEGRA_2x_SOC
 	/* Are we on Tegra20? */
 	cmp	r6, #TEGRA20
 	beq	1f				@ Yes
 	/* Clear the flow controller flags for this CPU. */
-	cpu_to_csr_req r1, r0
+	cpu_to_csr_reg r1, r0
 	mov32	r2, TEGRA_FLOW_CTRL_BASE
 	ldr	r1, [r2, r1]
 	/* Clear event & intr flag */
@@ -70,7 +69,6 @@ no_cpu0_chk:
 	bic	r1, r1, r0
 	str	r1, [r2]
 1:
-#endif
 
 	check_cpu_part_num 0xc09, r8, r9
 	bne	not_ca9
-- 
1.8.3
