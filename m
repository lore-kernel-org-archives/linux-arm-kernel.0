From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2011 15:25:25 -0800
Subject: [PATCH] ARM: OMAP: Fix map_io for Amstrad E3
In-Reply-To: <20111109231900.GS31337@atomide.com>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
 <20111109231900.GS31337@atomide.com>
Message-ID: <20111109232525.GT31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7b88e62f5d219a86d81bdf4388012c97dc42e8f8 (ARM: OMAP1: Use generic
map_io, init_early and init_irq) changed omap1 to use generic map_io.

Looks like I missed one board though. Fix this by adding a custom
map_io for Amstrad E3.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---
Untested, does this help?
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -302,8 +302,6 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J19_1610_CAM_D6);
 	omap_cfg_reg(J18_1610_CAM_D7);
 
-	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
-
 	omap_board_config = ams_delta_config;
 	omap_board_config_size = ARRAY_SIZE(ams_delta_config);
 	omap_serial_init();
@@ -373,10 +371,16 @@ static int __init ams_delta_modem_init(void)
 }
 arch_initcall(ams_delta_modem_init);
 
+static void __init ams_delta_map_io(void)
+{
+	omap15xx_map_io();
+	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
+}
+
 MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	/* Maintainer: Jonathan McDowell <noodles@earth.li> */
 	.atag_offset	= 0x100,
-	.map_io		= omap15xx_map_io,
+	.map_io		= ams_delta_map_io,
 	.init_early	= omap1_init_early,
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
