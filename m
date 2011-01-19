From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 12:25:47 -0800
Subject: [PATCH v2 11/11] msm: Support for the MSM8960 RUMI3 target
In-Reply-To: <1295468747-22796-1-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1295468747-22796-12-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stepan Moskovchenko <stepanm@codeaurora.org>

Add the machine record, init code, and build support for
the MSM8960 RUMI3.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig         |    8 +++++++-
 arch/arm/mach-msm/board-msm8960.c |   10 ++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index adca96c..df9d74e 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -51,7 +51,7 @@ config ARCH_MSM8X60
 config ARCH_MSM8960
 	bool "MSM8960"
 	select ARCH_MSM_SCORPIONMP
-	select MACH_MSM8960_SIM
+	select MACH_MSM8960_SIM if (!MACH_MSM8960_RUMI3)
 	select ARM_GIC
 	select CPU_V7
 	select MSM_V2_TLMM
@@ -141,6 +141,12 @@ config MACH_MSM8960_SIM
 	help
 	  Support for the Qualcomm MSM8960 simulator.
 
+config MACH_MSM8960_RUMI3
+	depends on ARCH_MSM8960
+	bool "MSM8960 RUMI3"
+	help
+	  Support for the Qualcomm MSM8960 RUMI3 emulator.
+
 endmenu
 
 config IOMMU_PGTABLES_L2
diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index 90efd54..2b09573 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -41,6 +41,9 @@ static void __init msm8960_init_irq(void)
 	/* Edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
 	writel(0xFFFFD7FF, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
 
+	if (machine_is_msm8960_rumi3())
+		writel(0x0000FFFF, MSM_QGIC_DIST_BASE + GIC_DIST_ENABLE_SET);
+
 	/* FIXME: Not installing AVS_SVICINT and AVS_SVICINTSWDONE yet
 	 * as they are configured as level, which does not play nice with
 	 * handle_percpu_irq.
@@ -56,3 +59,10 @@ MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
 	.init_irq = msm8960_init_irq,
 	.timer = &msm_timer,
 MACHINE_END
+
+MACHINE_START(MSM8960_RUMI3, "QCT MSM8960 RUMI3")
+	.map_io = msm8960_map_io,
+	.init_irq = msm8960_init_irq,
+	.timer = &msm_timer,
+MACHINE_END
+
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
