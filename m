From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 21:55:02 +0100
Subject: [PATCH 2/5] ARM: SP804: make Integrator/CP timer pick clock from DT
Message-ID: <1390251302-6285-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This modifies the SP804 driver so that the clock will be taken
from the device tree node for the timer.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/timer-sp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index ce922d0ea7aa..a0648d296055 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -271,10 +271,14 @@ static void __init integrator_cp_of_init(struct device_node *np)
 	void __iomem *base;
 	int irq;
 	const char *name = of_get_property(np, "compatible", NULL);
+	struct clk *clk;
 
 	base = of_iomap(np, 0);
 	if (WARN_ON(!base))
 		return;
+	clk = of_clk_get(np, 0);
+	if (WARN_ON(IS_ERR(clk)))
+		return;
 
 	/* Ensure timer is disabled */
 	writel(0, base + TIMER_CTRL);
@@ -283,13 +287,13 @@ static void __init integrator_cp_of_init(struct device_node *np)
 		goto err;
 
 	if (!init_count)
-		sp804_clocksource_init(base, name);
+		__sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
 	else {
 		irq = irq_of_parse_and_map(np, 0);
 		if (irq <= 0)
 			goto err;
 
-		sp804_clockevents_init(base, irq, name);
+		__sp804_clockevents_init(base, irq, clk, name);
 	}
 
 	init_count++;
-- 
1.8.4.2
