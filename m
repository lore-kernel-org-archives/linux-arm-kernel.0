From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:29 -0500
Subject: [PATCH 14/18] ARM: imx: Removed the global variable "timer_base"
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-15-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed the global variable "timer_base" by the
use of the input parameter.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 9a89bcf..29105ca 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -100,8 +100,6 @@ struct imx_timer {
 static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
-static void __iomem *timer_base;
-
 static void gpt_irq_disable_v0_v1(struct imx_timer *tm)
 {
 	unsigned int tmp;
@@ -482,14 +480,11 @@ void __init mxc_timer_init(unsigned long pbase, int irq, int ver)
 	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
 	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
 
-	timer_base = ioremap(pbase, SZ_4K);
-	BUG_ON(!timer_base);
-
 	timer = kzalloc(sizeof(struct imx_timer), GFP_KERNEL);
 	if (!timer)
 		panic("Can't allocate timer struct\n");
 
-	timer->timer_base = timer_base;
+	timer->timer_base = (void __iomem *)pbase;
 	timer->version = ver;
 	timer->evt.name = "mxc_timer1";
 	timer->evt.rating = 200;
@@ -527,7 +522,7 @@ static void __init mxc_timer_init_dt(struct device_node *np)
 	int irq, i, ret, ver;
 	struct imx_timer *timer;
 
-	if (timer_base)
+	if (sched_clock_reg)
 		return;
 
 	for (i =  0; i < sizeof(imx_timer_tables) /
@@ -551,9 +546,8 @@ static void __init mxc_timer_init_dt(struct device_node *np)
 		panic("Can't allocate timer struct\n");
 
 	timer->timer_base = of_iomap(np, 0);
+	WARN_ON(!timer->timer_base || !ret);
 
-	timer_base = of_iomap(np, 0);
-	WARN_ON(!timer_base);
 	irq = irq_of_parse_and_map(np, 0);
 
 	clk_ipg = of_clk_get_by_name(np, "ipg");
-- 
1.9.1
