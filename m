From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:17:29 +0800
Subject: [PATCH 3/6] ARM: mxs: get timrot base address from device tree
In-Reply-To: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224652-28332-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using static defines, it gets timrot base address with
mapping from device tree.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/timer.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index f5142aa..c8cda18 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -26,6 +26,7 @@
 #include <linux/clockchips.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 
 #include <asm/mach/time.h>
@@ -79,7 +80,7 @@
 static struct clock_event_device mxs_clockevent_device;
 static enum clock_event_mode mxs_clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
-static void __iomem *mxs_timrot_base = MXS_IO_ADDRESS(MXS_TIMROT_BASE_ADDR);
+static void __iomem *mxs_timrot_base;
 static u32 timrot_major_version;
 
 static inline void timrot_irq_disable(void)
@@ -247,6 +248,9 @@ static void __init mxs_timer_init(struct device_node *np)
 	struct clk *timer_clk;
 	int irq;
 
+	mxs_timrot_base = of_iomap(np, 0);
+	WARN_ON(!mxs_timrot_base);
+
 	timer_clk = of_clk_get(np, 0);
 	if (IS_ERR(timer_clk)) {
 		pr_err("%s: failed to get clk\n", __func__);
-- 
1.7.9.5
