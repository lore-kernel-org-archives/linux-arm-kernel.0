From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:57:31 +0800
Subject: [PATCH V2 3/4] ARM: tegra: make tegra_resume can work with current
 and later chips
In-Reply-To: <1381485452-3561-1-git-send-email-josephl@nvidia.com>
References: <1381485452-3561-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381485452-3561-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the CPU0 was the first up and the last down core when cluster
power up/down or platform suspend. So only CPU0 needs the rest of the
functions to reset flow controller and re-enable SCU and L2. We also
move the L2 init function for Cortex-A15 to there. The secondery CPU
can just call cpu_resume.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* fix the label name of not_ca9 to end_ca9_scu_l2_resume
---
 arch/arm/mach-tegra/reset-handler.S | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index f527b2c..8c1ba4f 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -45,17 +45,11 @@
 ENTRY(tegra_resume)
 	check_cpu_part_num 0xc09, r8, r9
 	bleq	v7_invalidate_l1
-	blne	tegra_init_l2_for_a15
 
 	cpu_id	r0
-	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
-	cmp	r6, #TEGRA114
-	beq	no_cpu0_chk
-
 	cmp	r0, #0				@ CPU0?
  THUMB(	it	ne )
 	bne	cpu_resume			@ no
-no_cpu0_chk:
 
 	/* Are we on Tegra20? */
 	cmp	r6, #TEGRA20
@@ -75,7 +69,7 @@ no_cpu0_chk:
 
 	mov32	r9, 0xc09
 	cmp	r8, r9
-	bne	not_ca9
+	bne	end_ca9_scu_l2_resume
 #ifdef CONFIG_HAVE_ARM_SCU
 	/* enable SCU */
 	mov32	r0, TEGRA_ARM_PERIF_BASE
@@ -86,7 +80,10 @@ no_cpu0_chk:
 
 	/* L2 cache resume & re-enable */
 	l2_cache_resume r0, r1, r2, l2x0_saved_regs_addr
-not_ca9:
+end_ca9_scu_l2_resume:
+	mov32	r9, 0xc0f
+	cmp	r8, r9
+	bleq	tegra_init_l2_for_a15
 
 	b	cpu_resume
 ENDPROC(tegra_resume)
-- 
1.8.4
