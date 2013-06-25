From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 25 Jun 2013 17:27:47 +0800
Subject: [PATCH 03/11] ARM: tegra114: set up the correct L2 data RAM latency
 for Cortex-A15
In-Reply-To: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372152475-18617-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When there is a cluster power down cycle in suspend, we need to set up
the correct L2 RAM data RAM latency to make L2 cache work correctly. This
is only needed for cluster 0 and needs to be done in tegra_resume before
the cache is enabled.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/reset-handler.S |  1 +
 arch/arm/mach-tegra/sleep.S         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 75285a3..34614bd 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -45,6 +45,7 @@
 ENTRY(tegra_resume)
 	check_cpu_part_num 0xc09, r8, r9
 	bleq	v7_invalidate_l1
+	blne	tegra_init_l2_for_a15
 
 	cpu_id	r0
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 6d6600d..8388113 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -69,6 +69,28 @@ ENDPROC(tegra_disable_clean_inv_dcache)
 
 #ifdef CONFIG_PM_SLEEP
 /*
+ * tegra_init_l2_for_a15
+ *
+ * set up the correct L2 cache data RAM latency
+ */
+ENTRY(tegra_init_l2_for_a15)
+	mrc	p15, 0, r0, c0, c0, 5
+	ubfx	r0, r0, #8, #4
+	tst	r0, #1				@ only need for cluster 0
+	bne	_exit_init_l2_a15
+
+	mrc	p15, 0x1, r0, c9, c0, 2
+	and	r0, r0, #7
+	cmp	r0, #2
+	bicne	r0, r0, #7
+	orrne	r0, r0, #2
+	mcrne	p15, 0x1, r0, c9, c0, 2
+_exit_init_l2_a15:
+
+	mov	pc, lr
+ENDPROC(tegra_init_l2_for_a15)
+
+/*
  * tegra_sleep_cpu_finish(unsigned long v2p)
  *
  * enters suspend in LP2 by turning off the mmu and jumping to
-- 
1.8.3.1
