From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:20 -0500
Subject: [PATCH 05/18] ARM: imx: Added one more parameter for
 mxc_clocksource_init
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-6-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more parameter was added for the function of
mxc_clocksource_init, so that we could remove the
global variables later.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index f7403ab..4db233f 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -149,7 +149,8 @@ static unsigned long imx_read_current_timer(void)
 	return __raw_readl(sched_clock_reg);
 }
 
-static int __init mxc_clocksource_init(struct clk *timer_clk)
+static int __init mxc_clocksource_init(struct clk *timer_clk,
+				void __iomem *addr)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 	void __iomem *reg = timer_base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
@@ -355,7 +356,7 @@ static void __init _mxc_timer_init(int irq,
 	__raw_writel(tctl_val, timer_base + MXC_TCTL);
 
 	/* init and register the timer to the framework */
-	mxc_clocksource_init(clk_per);
+	mxc_clocksource_init(clk_per, 0);
 	mxc_clockevent_init(clk_per, 0);
 
 	/* Make irqs happen */
-- 
1.9.1
