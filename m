From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 19 Aug 2016 12:51:31 +0100
Subject: [PATCH 2/2] ARM: sa1100: register clocks early
Message-ID: <E1baiKh-0004yg-OF@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we switched to use pxa_timer, we need to provide the OSTIMER0
clock.  However, as the clock is initialised early, we need to provide
the clock early as well, so that pxa_timer can find it.  Adding the
clock to the clkdev table at core_initcall() time is way too late.

Move the initialisation earlier.

Fixes: ee3a4020f7c9 ("ARM: 8250/1: sa1100: provide OSTIMER0 clock for pxa_timer")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/clock.c   | 3 +--
 arch/arm/mach-sa1100/generic.c | 1 +
 arch/arm/mach-sa1100/generic.h | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index 0bf3220988ef..0db46895c82a 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -142,9 +142,8 @@ static struct clk_lookup sa11xx_clkregs[] = {
 	CLKDEV_INIT(NULL, "OSTIMER0", &clk_36864),
 };
 
-static int __init sa11xx_clk_init(void)
+int __init sa11xx_clk_init(void)
 {
 	clkdev_add_table(sa11xx_clkregs, ARRAY_SIZE(sa11xx_clkregs));
 	return 0;
 }
-core_initcall(sa11xx_clk_init);
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 345e63f4eb71..2e2c35b8e0d4 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -388,6 +388,7 @@ void __init sa1100_init_irq(void)
 	sa11x0_init_irq_nodt(IRQ_GPIO0_SC, irq_resource.start);
 
 	sa1100_init_gpio();
+	sa11xx_clk_init();
 }
 
 /*
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 0d92e119b36b..68199b603ff7 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -44,3 +44,5 @@ int sa11x0_pm_init(void);
 #else
 static inline int sa11x0_pm_init(void) { return 0; }
 #endif
+
+int sa11xx_clk_init(void);
-- 
2.1.0
