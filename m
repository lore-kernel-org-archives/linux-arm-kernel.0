From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 27 May 2014 13:04:47 +0400
Subject: [PATCH 2/2] ARM: i.MX: Remove excess variable
In-Reply-To: <1401181487-25828-1-git-send-email-shc_work@mail.ru>
References: <1401181487-25828-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401181487-25828-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Base address for driver is global, there are no need to use
intermediate variable for it.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/time.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 2d96051..1da2270 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -290,7 +290,7 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
 	return 0;
 }
 
-static void __init _mxc_timer_init(void __iomem *base, int irq,
+static void __init _mxc_timer_init(int irq,
 				   struct clk *clk_per, struct clk *clk_ipg)
 {
 	uint32_t tctl_val;
@@ -305,8 +305,6 @@ static void __init _mxc_timer_init(void __iomem *base, int irq,
 
 	clk_prepare_enable(clk_per);
 
-	timer_base = base;
-
 	/*
 	 * Initialise to a known state (all timers off, and timing reset)
 	 */
@@ -334,21 +332,22 @@ void __init mxc_timer_init(void __iomem *base, int irq)
 	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
 	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
 
-	_mxc_timer_init(base, irq, clk_per, clk_ipg);
+	timer_base = base;
+
+	_mxc_timer_init(irq, clk_per, clk_ipg);
 }
 
 void __init mxc_timer_init_dt(struct device_node *np)
 {
 	struct clk *clk_per, *clk_ipg;
-	void __iomem *base;
 	int irq;
 
-	base = of_iomap(np, 0);
-	WARN_ON(!base);
+	timer_base = of_iomap(np, 0);
+	WARN_ON(!timer_base);
 	irq = irq_of_parse_and_map(np, 0);
 
 	clk_per = of_clk_get_by_name(np, "per");
 	clk_ipg = of_clk_get_by_name(np, "ipg");
 
-	_mxc_timer_init(base, irq, clk_per, clk_ipg);
+	_mxc_timer_init(irq, clk_per, clk_ipg);
 }
-- 
1.8.5.5
