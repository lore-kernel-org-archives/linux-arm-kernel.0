From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 29 Jul 2010 15:05:22 +0200
Subject: [PATCH] ARM: fix regression in RealView after the introduction of pclk
Message-ID: <1280408722-31995-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch to add the apb_pclk to the AMBA/PrimeCell bus broke
RealView, since the clockdevice is not registered at probe() time.
This moves clock initialization to interrupt initialization on
par with e.g ux500.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-realview/core.c            |    3 +--
 arch/arm/mach-realview/core.h            |    1 +
 arch/arm/mach-realview/realview_eb.c     |    2 ++
 arch/arm/mach-realview/realview_pb1176.c |    2 ++
 arch/arm/mach-realview/realview_pb11mp.c |    2 ++
 arch/arm/mach-realview/realview_pba8.c   |    2 ++
 arch/arm/mach-realview/realview_pbx.c    |    2 ++
 7 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index d8179ea..154d10b 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -359,7 +359,7 @@ static struct clk_lookup lookups[] = {
 	}
 };
 
-static int __init clk_init(void)
+int __init realview_clk_init(void)
 {
 	if (machine_is_realview_pb1176())
 		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC0_OFFSET;
@@ -370,7 +370,6 @@ static int __init clk_init(void)
 
 	return 0;
 }
-arch_initcall(clk_init);
 
 /*
  * CLCD support.
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 781bca6..5536068 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -59,6 +59,7 @@ extern void __iomem *timer1_va_base;
 extern void __iomem *timer2_va_base;
 extern void __iomem *timer3_va_base;
 
+extern int realview_clk_init(void);
 extern void realview_leds_event(led_event_t ledevt);
 extern void realview_timer_init(unsigned int timer_irq);
 extern int realview_flash_register(struct resource *res, u32 num);
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 991c1f8..200bec0 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -353,6 +353,8 @@ static struct platform_device char_lcd_device = {
 
 static void __init gic_init_irq(void)
 {
+	/* Initialize clocks early so they are available */
+	realview_clk_init();
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
 		unsigned int pldctrl;
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index d2be12e..0ffc872 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -303,6 +303,8 @@ static struct platform_device char_lcd_device = {
 
 static void __init gic_init_irq(void)
 {
+	/* Initialize clocks early so they are available */
+	realview_clk_init();
 	/* ARM1176 DevChip GIC, primary */
 	gic_cpu_base_addr = __io_address(REALVIEW_DC1176_GIC_CPU_BASE);
 	gic_dist_init(0, __io_address(REALVIEW_DC1176_GIC_DIST_BASE), IRQ_DC1176_GIC_START);
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index d591bc0..a6d02e6 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -301,6 +301,8 @@ static void __init gic_init_irq(void)
 {
 	unsigned int pldctrl;
 
+	/* Initialize clocks early so they are available */
+	realview_clk_init();
 	/* new irq mode with no DCC */
 	writel(0x0000a05f, __io_address(REALVIEW_SYS_LOCK));
 	pldctrl = readl(__io_address(REALVIEW_SYS_BASE)	+ REALVIEW_PB11MP_SYS_PLD_CTRL1);
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 6c37621..c226006 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -272,6 +272,8 @@ static struct platform_device pmu_device = {
 
 static void __init gic_init_irq(void)
 {
+	/* Initialize clocks early so they are available */
+	realview_clk_init();
 	/* ARM PB-A8 on-board GIC */
 	gic_cpu_base_addr = __io_address(REALVIEW_PBA8_GIC_CPU_BASE);
 	gic_dist_init(0, __io_address(REALVIEW_PBA8_GIC_DIST_BASE), IRQ_PBA8_GIC_START);
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 9428eff..96bac42 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -311,6 +311,8 @@ static struct platform_device pmu_device = {
 
 static void __init gic_init_irq(void)
 {
+	/* Initialize clocks early so they are available */
+	realview_clk_init();
 	/* ARM PBX on-board GIC */
 	if (core_tile_pbx11mp() || core_tile_pbxa9mp()) {
 		gic_cpu_base_addr = __io_address(REALVIEW_PBX_TILE_GIC_CPU_BASE);
-- 
1.7.2
