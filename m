From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:46:46 +0000
Subject: [PATCH 03/11] ARM: realview: use new init_early for clock tree and
	sched_clock init
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSBS-0003p1-QT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the clock tree and our sched_clock() early.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/core.c            |   19 ++++++-------------
 arch/arm/mach-realview/core.h            |    1 +
 arch/arm/mach-realview/realview_eb.c     |    1 +
 arch/arm/mach-realview/realview_pb1176.c |    1 +
 arch/arm/mach-realview/realview_pb11mp.c |    1 +
 arch/arm/mach-realview/realview_pba8.c   |    1 +
 arch/arm/mach-realview/realview_pbx.c    |    1 +
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index a18a5a6..75dbc87 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -360,18 +360,19 @@ static struct clk_lookup lookups[] = {
 	}
 };
 
-static int __init clk_init(void)
+void __init realview_init_early(void)
 {
+	void __iomem *sys = __io_address(REALVIEW_SYS_BASE);
+
 	if (machine_is_realview_pb1176())
-		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC0_OFFSET;
+		oscvco_clk.vcoreg = sys + REALVIEW_SYS_OSC0_OFFSET;
 	else
-		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC4_OFFSET;
+		oscvco_clk.vcoreg = sys + REALVIEW_SYS_OSC4_OFFSET;
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-	return 0;
+	versatile_sched_clock_init(sys + REALVIEW_SYS_24MHz_OFFSET, 24000000);
 }
-core_initcall(clk_init);
 
 /*
  * CLCD support.
@@ -510,12 +511,6 @@ void realview_leds_event(led_event_t ledevt)
 #endif	/* CONFIG_LEDS */
 
 /*
- * The sched_clock counter
- */
-#define REFCOUNTER		(__io_address(REALVIEW_SYS_BASE) + \
-				 REALVIEW_SYS_24MHz_OFFSET)
-
-/*
  * Where is the timer (VA)?
  */
 void __iomem *timer0_va_base;
@@ -530,8 +525,6 @@ void __init realview_timer_init(unsigned int timer_irq)
 {
 	u32 val;
 
-	versatile_sched_clock_init(REFCOUNTER, 24000000);
-
 	/* 
 	 * set clock frequency: 
 	 *	REALVIEW_REFCLK is 32KHz
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 693239d..27c9273 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -63,6 +63,7 @@ extern void realview_timer_init(unsigned int timer_irq);
 extern int realview_flash_register(struct resource *res, u32 num);
 extern int realview_eth_register(const char *name, struct resource *res);
 extern int realview_usb_register(struct resource *res);
+extern void realview_init_early(void);
 extern void realview_fixup(struct machine_desc *mdesc, struct tag *tags,
 			   char **from, struct meminfo *meminfo);
 extern void (*realview_reset)(char);
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 6ef5c5e..c00e527 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -487,6 +487,7 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
+	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_eb_timer,
 	.init_machine	= realview_eb_init,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index cbdc97a..f0447bb 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -382,6 +382,7 @@ MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
+	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb1176_timer,
 	.init_machine	= realview_pb1176_init,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 8e8ab7d..3b4f788 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -384,6 +384,7 @@ MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
+	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb11mp_timer,
 	.init_machine	= realview_pb11mp_init,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 841118e..f98d4fa 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -334,6 +334,7 @@ MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
+	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pba8_timer,
 	.init_machine	= realview_pba8_init,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 02b755b..b0521e1 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -417,6 +417,7 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
+	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pbx_timer,
 	.init_machine	= realview_pbx_init,
-- 
1.6.2.5
