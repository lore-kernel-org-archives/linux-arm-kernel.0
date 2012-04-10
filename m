From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:32 +0200
Subject: [PATCH 19/40] ARM i.MX timer: request correct clock
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-20-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to pass the timer clock directly to mxc_timer_init. We
should instead request the correct clock. This is an intermediate
step: For now we request the clock in the timer code when NULL
is passed as clock.
Also, the gpt on some i.MX have an additional ipg clock which can
be gated. Request and enable this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/time.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 7daf7c9..99f958c 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/clockchips.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/sched_clock.h>
@@ -282,6 +283,19 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
 void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 {
 	uint32_t tctl_val;
+	struct clk *timer_ipg_clk;
+
+	if (!timer_clk) {
+		timer_clk = clk_get_sys("imx-gpt.0", "per");
+		if (IS_ERR(timer_clk)) {
+			pr_err("i.MX timer: unable to get clk\n");
+			return;
+		}
+
+		timer_ipg_clk = clk_get_sys("imx-gpt.0", "ipg");
+		if (!IS_ERR(timer_ipg_clk))
+			clk_prepare_enable(timer_ipg_clk);
+	}
 
 	clk_prepare_enable(timer_clk);
 
-- 
1.7.9.5
