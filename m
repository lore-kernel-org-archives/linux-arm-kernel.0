From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:17:31 +0800
Subject: [PATCH 5/6] ARM: mxs: select STMP_DEVICE and use it for timer code
In-Reply-To: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224652-28332-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select STMP_DEVICE and in timer code replace mxs_reset_block() with
stmp_reset_block(), use STMP_OFFSET_REG_SET/CLR to replace
__mxs_setl/clrl.

As the result, <mach/mxs.h> and <mach/common.h> includsion can be
removed from timer.c now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig          |    1 +
 arch/arm/mach-mxs/timer.c |   17 ++++++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d57fc3d..6f61286 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -481,6 +481,7 @@ config ARCH_MXS
 	select MULTI_IRQ_HANDLER
 	select PINCTRL
 	select SPARSE_IRQ
+	select STMP_DEVICE
 	select USE_OF
 	help
 	  Support for Freescale MXS-based family of processors
diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index f4dd96ff..a4d469b 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -28,11 +28,10 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/stmp_device.h>
 
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
-#include <mach/mxs.h>
-#include <mach/common.h>
 
 /*
  * There are 2 versions of the timrot on Freescale MXS-based SoCs.
@@ -85,20 +84,20 @@ static u32 timrot_major_version;
 
 static inline void timrot_irq_disable(void)
 {
-	__mxs_clrl(BM_TIMROT_TIMCTRLn_IRQ_EN,
-			mxs_timrot_base + HW_TIMROT_TIMCTRLn(0));
+	__raw_writel(BM_TIMROT_TIMCTRLn_IRQ_EN, mxs_timrot_base +
+		     HW_TIMROT_TIMCTRLn(0) + STMP_OFFSET_REG_CLR);
 }
 
 static inline void timrot_irq_enable(void)
 {
-	__mxs_setl(BM_TIMROT_TIMCTRLn_IRQ_EN,
-			mxs_timrot_base + HW_TIMROT_TIMCTRLn(0));
+	__raw_writel(BM_TIMROT_TIMCTRLn_IRQ_EN, mxs_timrot_base +
+		     HW_TIMROT_TIMCTRLn(0) + STMP_OFFSET_REG_SET);
 }
 
 static void timrot_irq_acknowledge(void)
 {
-	__mxs_clrl(BM_TIMROT_TIMCTRLn_IRQ,
-			mxs_timrot_base + HW_TIMROT_TIMCTRLn(0));
+	__raw_writel(BM_TIMROT_TIMCTRLn_IRQ, mxs_timrot_base +
+		     HW_TIMROT_TIMCTRLn(0) + STMP_OFFSET_REG_CLR);
 }
 
 static cycle_t timrotv1_get_cycles(struct clocksource *cs)
@@ -262,7 +261,7 @@ static void __init mxs_timer_init(struct device_node *np)
 	/*
 	 * Initialize timers to a known state
 	 */
-	mxs_reset_block(mxs_timrot_base + HW_TIMROT_ROTCTRL);
+	stmp_reset_block(mxs_timrot_base + HW_TIMROT_ROTCTRL);
 
 	/* get timrot version */
 	timrot_major_version = __raw_readl(mxs_timrot_base +
-- 
1.7.9.5
