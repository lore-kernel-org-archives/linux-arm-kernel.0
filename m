From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:26 -0500
Subject: [PATCH 11/18] ARM: imx: Enabled the unused parameter
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-12-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabled the unused parameter in the following two functions:
mx1_2_set_next_event
v2_set_next_event
and removed the use of the global variable of "timer_base".

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index ddbb3e7..b20ee80 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -218,29 +218,31 @@ static int __init mxc_clocksource_init(struct clk *timer_clk,
 /* clock event */
 
 static int mx1_2_set_next_event(unsigned long evt,
-			      struct clock_event_device *unused)
+			      struct clock_event_device *evt_dev)
 {
 	unsigned long tcmp;
+	struct imx_timer *tm = container_of(evt_dev, struct imx_timer, evt);
 
-	tcmp = __raw_readl(timer_base + MX1_2_TCN) + evt;
+	tcmp = __raw_readl(tm->timer_base + MX1_2_TCN) + evt;
 
-	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
+	__raw_writel(tcmp, tm->timer_base + MX1_2_TCMP);
 
-	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
+	return (int)(tcmp - __raw_readl(tm->timer_base + MX1_2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
 static int v2_set_next_event(unsigned long evt,
-			      struct clock_event_device *unused)
+			      struct clock_event_device *evt_dev)
 {
 	unsigned long tcmp;
+	struct imx_timer *tm = container_of(evt_dev, struct imx_timer, evt);
 
-	tcmp = __raw_readl(timer_base + V2_TCN) + evt;
+	tcmp = __raw_readl(tm->timer_base + V2_TCN) + evt;
 
-	__raw_writel(tcmp, timer_base + V2_TCMP);
+	__raw_writel(tcmp, tm->timer_base + V2_TCMP);
 
 	return evt < 0x7fffffff &&
-		(int)(tcmp - __raw_readl(timer_base + V2_TCN)) < 0 ?
+		(int)(tcmp - __raw_readl(tm->timer_base + V2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
-- 
1.9.1
