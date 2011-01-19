From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 12:25:39 -0800
Subject: [PATCH v2 03/11] msm: Generalize QGIC registers
In-Reply-To: <1295468747-22796-1-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1295468747-22796-4-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The QGIC registers are mapped to the same virtual addresses across
targets, only the physical address changes.  Move the BASE address out
of target-specific files, and add a SOC name to the base addresses.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |   10 ++++------
 arch/arm/mach-msm/include/mach/msm_iomap.h      |    2 ++
 arch/arm/mach-msm/io.c                          |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
index d5482d6..5bd18db 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
@@ -35,13 +35,11 @@
  *
  */
 
-#define MSM_QGIC_DIST_BASE	IOMEM(0xF0000000)
-#define MSM_QGIC_DIST_PHYS	0x02080000
-#define MSM_QGIC_DIST_SIZE	SZ_4K
+#define MSM8X60_QGIC_DIST_PHYS	0x02080000
+#define MSM8X60_QGIC_DIST_SIZE	SZ_4K
 
-#define MSM_QGIC_CPU_BASE	IOMEM(0xF0001000)
-#define MSM_QGIC_CPU_PHYS	0x02081000
-#define MSM_QGIC_CPU_SIZE	SZ_4K
+#define MSM8X60_QGIC_CPU_PHYS	0x02081000
+#define MSM8X60_QGIC_CPU_SIZE	SZ_4K
 
 #define MSM_ACC_BASE		IOMEM(0xF0002000)
 #define MSM_ACC_PHYS		0x02001000
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/include/mach/msm_iomap.h
index 0243bd0..bb42de3 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap.h
@@ -55,6 +55,8 @@
 
 /* Virtual addressses shared across all MSM targets. */
 #define MSM_CSR_BASE		IOMEM(0xE0001000)
+#define MSM_QGIC_DIST_BASE	IOMEM(0xF0000000)
+#define MSM_QGIC_CPU_BASE	IOMEM(0xF0001000)
 #define MSM_TMR_BASE		IOMEM(0xF0200000)
 #define MSM_TMR0_BASE		IOMEM(0xF0201000)
 
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 47d699f..5dd0d1b9 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -103,8 +103,8 @@ void __init msm_map_qsd8x50_io(void)
 
 #ifdef CONFIG_ARCH_MSM8X60
 static struct map_desc msm8x60_io_desc[] __initdata = {
-	MSM_DEVICE(QGIC_DIST),
-	MSM_DEVICE(QGIC_CPU),
+	MSM_CHIP_DEVICE(QGIC_DIST, MSM8X60),
+	MSM_CHIP_DEVICE(QGIC_CPU, MSM8X60),
 	MSM_CHIP_DEVICE(TMR, MSM8X60),
 	MSM_CHIP_DEVICE(TMR0, MSM8X60),
 	MSM_DEVICE(ACC),
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
