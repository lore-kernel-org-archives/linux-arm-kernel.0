From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 15 May 2013 18:27:21 +0800
Subject: [PATCH 3/6] ARM: tegra: make tegra_resume can work for Tegra114
In-Reply-To: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
Message-ID: <1368613644-11863-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra114 is an ARM Cortex-A15 based SoC and some of the flow controller
hardware behavior and configurations are different with other Tegra series.
We fix the common resume function of tegra_resume to make it can work on
Tegra114 by checking SoC ID. And also checking CPU primary part number to
isolate the support code for Cortex A9 and A15.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/reset-handler.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 525f1b9..893f6b7 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -47,22 +47,25 @@ ENTRY(tegra_resume)
  THUMB(	it	ne )
 	bne	cpu_resume			@ no
 
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+#ifndef CONFIG_ARCH_TEGRA_2x_SOC
 	/* Are we on Tegra20? */
 	tegra_check_soc_id TEGRA20, TEGRA_APB_MISC_BASE, r6, r7
 	beq	1f				@ Yes
 	/* Clear the flow controller flags for this CPU. */
-	mov32	r2, TEGRA_FLOW_CTRL_BASE + FLOW_CTRL_CPU0_CSR	@ CPU0 CSR
-	ldr	r1, [r2]
+	cpu_to_csr_req r1, r0
+	mov32	r2, TEGRA_FLOW_CTRL_BASE
+	ldr	r1, [r2, r1]
 	/* Clear event & intr flag */
 	orr	r1, r1, \
 		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
-	movw	r0, #0x0FFD	@ enable, cluster_switch, immed, & bitmaps
+	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, & bitmaps
 	bic	r1, r1, r0
 	str	r1, [r2]
 1:
 #endif
 
+	check_cpu_part_num 0xc09, r8, r9
+	bne	not_ca9
 #ifdef CONFIG_HAVE_ARM_SCU
 	/* enable SCU */
 	mov32	r0, TEGRA_ARM_PERIF_BASE
@@ -73,6 +76,7 @@ ENTRY(tegra_resume)
 
 	/* L2 cache resume & re-enable */
 	l2_cache_resume r0, r1, r2, l2x0_saved_regs_addr
+not_ca9:
 
 	b	cpu_resume
 ENDPROC(tegra_resume)
-- 
1.8.2.2
