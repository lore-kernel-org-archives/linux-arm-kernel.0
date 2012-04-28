From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 29 Apr 2012 00:02:37 +0800
Subject: [PATCH v2 4/8] ARM: mxs: request clock for timer
In-Reply-To: <1335628961-1340-1-git-send-email-shawn.guo@linaro.org>
References: <1335628961-1340-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335628961-1340-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When mxs_timer_init() does not have a timer_clk passed in, it should
try to request clock from clkdev system.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/timer.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index 564a632..575e8fd 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -20,6 +20,7 @@
  * MA 02110-1301, USA.
  */
 
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/clockchips.h>
@@ -245,6 +246,14 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
 
 void __init mxs_timer_init(struct clk *timer_clk, int irq)
 {
+	if (!timer_clk) {
+		timer_clk = clk_get_sys("timrot", NULL);
+		if (IS_ERR(timer_clk)) {
+			pr_err("%s: failed to get clk\n", __func__);
+			return;
+		}
+	}
+
 	clk_prepare_enable(timer_clk);
 
 	/*
-- 
1.7.5.4
