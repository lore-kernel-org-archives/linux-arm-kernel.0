From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:44 -0700
Subject: [PATCH 05/20 v2] msm: timer: support 8x60 timers
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-6-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    7 +++++++
 arch/arm/mach-msm/timer.c                       |   23 +++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
index 1f1822b..18ba569 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
@@ -54,4 +54,11 @@
 #define MSM_SHARED_RAM_BASE	IOMEM(0xF0100000)
 #define MSM_SHARED_RAM_SIZE	SZ_1M
 
+#define MSM_TMR_BASE		IOMEM(0xF0200000)
+#define MSM_TMR_PHYS		0x02000000
+#define MSM_TMR_SIZE		(SZ_1M)
+
+#define MSM_GPT_BASE		(MSM_TMR_BASE + 0x4)
+#define MSM_DGT_BASE		(MSM_TMR_BASE + 0x24)
+
 #endif
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index dec5ca6..7689848 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -28,7 +28,6 @@
 #ifndef MSM_DGT_BASE
 #define MSM_DGT_BASE (MSM_GPT_BASE + 0x10)
 #endif
-#define MSM_DGT_SHIFT (5)
 
 #define TIMER_MATCH_VAL         0x0000
 #define TIMER_COUNT_VAL         0x0004
@@ -36,12 +35,28 @@
 #define TIMER_ENABLE_CLR_ON_MATCH_EN    2
 #define TIMER_ENABLE_EN                 1
 #define TIMER_CLEAR             0x000C
-
+#define DGT_CLK_CTL             0x0034
+enum {
+	DGT_CLK_CTL_DIV_1 = 0,
+	DGT_CLK_CTL_DIV_2 = 1,
+	DGT_CLK_CTL_DIV_3 = 2,
+	DGT_CLK_CTL_DIV_4 = 3,
+};
 #define CSR_PROTECTION          0x0020
 #define CSR_PROTECTION_EN               1
 
 #define GPT_HZ 32768
+
+#if defined(CONFIG_ARCH_QSD8X50)
+#define DGT_HZ (19200000 / 4) /* 19.2 MHz / 4 by default */
+#define MSM_DGT_SHIFT (0)
+#elif defined(CONFIG_ARCH_MSM7X30) || defined(CONFIG_ARCH_MSM8X60)
+#define DGT_HZ (24576000 / 4) /* 24.576 MHz (LPXO) / 4 by default */
+#define MSM_DGT_SHIFT (0)
+#else
 #define DGT_HZ 19200000 /* 19.2 MHz or 600 KHz after shift */
+#define MSM_DGT_SHIFT (5)
+#endif
 
 struct msm_clock {
 	struct clock_event_device   clockevent;
@@ -170,6 +185,10 @@ static void __init msm_timer_init(void)
 	int i;
 	int res;
 
+#ifdef CONFIG_ARCH_MSM8X60
+	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
+#endif
+
 	for (i = 0; i < ARRAY_SIZE(msm_clocks); i++) {
 		struct msm_clock *clock = &msm_clocks[i];
 		struct clock_event_device *ce = &clock->clockevent;
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
