From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 25 Jun 2013 17:27:45 +0800
Subject: [PATCH 01/11] ARM: tegra: do v7_invalidate_l1 only when CPU is
 Cortex-A9 in tegra_resume
In-Reply-To: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372152475-18617-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v7_invalidate_l1 was used for the L1 cache that come out from reset
in a undefined state. This is no need for Cortex-A15. We do it for A9
only.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/reset-handler.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 39dc9e7..75285a3 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -40,9 +40,11 @@
  *	  re-enabling sdram.
  *
  *	r6: SoC ID
+ *	r8: CPU part number
  */
 ENTRY(tegra_resume)
-	bl	v7_invalidate_l1
+	check_cpu_part_num 0xc09, r8, r9
+	bleq	v7_invalidate_l1
 
 	cpu_id	r0
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
@@ -70,7 +72,8 @@ no_cpu0_chk:
 	str	r1, [r2]
 1:
 
-	check_cpu_part_num 0xc09, r8, r9
+	mov32	r9, 0xc09
+	cmp	r8, r9
 	bne	not_ca9
 #ifdef CONFIG_HAVE_ARM_SCU
 	/* enable SCU */
-- 
1.8.3.1
