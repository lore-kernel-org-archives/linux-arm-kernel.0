From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Apr 2012 23:57:20 +0800
Subject: [PATCH 8/8] ARM: mxs: remove now unused timer_clk argument from
 mxs_timer_init
In-Reply-To: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335023840-1394-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With old mxs clock support removed, the timer_clk argument of
mxs_timer_init is unused now, so remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/common.h |    4 +---
 arch/arm/mach-mxs/timer.c               |   14 +++++++-------
 drivers/clk/mxs/clk-imx23.c             |    2 +-
 drivers/clk/mxs/clk-imx28.c             |    2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index e1237ab..9bdc953 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -11,11 +11,9 @@
 #ifndef __MACH_MXS_COMMON_H__
 #define __MACH_MXS_COMMON_H__
 
-struct clk;
-
 extern const u32 *mxs_get_ocotp(void);
 extern int mxs_reset_block(void __iomem *);
-extern void mxs_timer_init(struct clk *, int);
+extern void mxs_timer_init(int);
 extern void mxs_restart(char, const char *);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index 575e8fd..02d36de 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -244,14 +244,14 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
 	return 0;
 }
 
-void __init mxs_timer_init(struct clk *timer_clk, int irq)
+void __init mxs_timer_init(int irq)
 {
-	if (!timer_clk) {
-		timer_clk = clk_get_sys("timrot", NULL);
-		if (IS_ERR(timer_clk)) {
-			pr_err("%s: failed to get clk\n", __func__);
-			return;
-		}
+	struct clk *timer_clk;
+
+	timer_clk = clk_get_sys("timrot", NULL);
+	if (IS_ERR(timer_clk)) {
+		pr_err("%s: failed to get clk\n", __func__);
+		return;
 	}
 
 	clk_prepare_enable(timer_clk);
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 6cce512..ef9c3cf 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -189,7 +189,7 @@ int __init mx23_clocks_init(void)
 	if (ret)
 		return ret;
 
-	mxs_timer_init(NULL, MX23_INT_TIMER0);
+	mxs_timer_init(MX23_INT_TIMER0);
 
 	return 0;
 }
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 0837f1d..70108cb 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -312,7 +312,7 @@ int __init mx28_clocks_init(void)
 	if (ret)
 		return ret;
 
-	mxs_timer_init(NULL, MX28_INT_TIMER0);
+	mxs_timer_init(MX28_INT_TIMER0);
 
 	return 0;
 }
-- 
1.7.5.4
