From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:31:58 -0600
Subject: [PATCH 2/7] ARM: realview: init clocks early and add sp804 clock
In-Reply-To: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
Message-ID: <1294875123-14086-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move clock initialization to mdesc->init_early and add a clock for
sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-realview/core.c            |   12 ++++++++----
 arch/arm/mach-realview/core.h            |    1 +
 arch/arm/mach-realview/realview_eb.c     |    1 +
 arch/arm/mach-realview/realview_pb1176.c |    1 +
 arch/arm/mach-realview/realview_pb11mp.c |    1 +
 arch/arm/mach-realview/realview_pba8.c   |    1 +
 arch/arm/mach-realview/realview_pbx.c    |    1 +
 7 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1c6602c..16b8a81 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -314,6 +314,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup lookups[] = {
@@ -356,10 +360,13 @@ static struct clk_lookup lookups[] = {
 	}, {	/* SSP */
 		.dev_id		= "dev:ssp0",
 		.clk		= &ref24_clk,
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
 	}
 };
 
-static int __init clk_init(void)
+void __init realview_init_early(void)
 {
 	if (machine_is_realview_pb1176())
 		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC0_OFFSET;
@@ -367,10 +374,7 @@ static int __init clk_init(void)
 		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC4_OFFSET;
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	return 0;
 }
-core_initcall(clk_init);
 
 /*
  * CLCD support.
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 693239d..cb44595 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -65,6 +65,7 @@ extern int realview_eth_register(const char *name, struct resource *res);
 extern int realview_usb_register(struct resource *res);
 extern void realview_fixup(struct machine_desc *mdesc, struct tag *tags,
 			   char **from, struct meminfo *meminfo);
+extern void realview_init_early(void);
 extern void (*realview_reset)(char);
 
 #endif
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
1.7.1
