From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 22 Jan 2010 08:42:20 +1300
Subject: [PATCH updated] ep93xx: Add support for Simplemachines Sim.One board
Message-ID: <4B58AE1C.8070408@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch adds support for the Simplemachines Sim.One board. I
have updated the patch with fixes suggested by Hartley. Sergio Sorrenti
from Simplemachines is okay with the patch, and has asked that I put
myself as the maintainer.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Cc: Hartley Sweeten <hartleys@visionengravers.com>
Cc: Sergio Sorrenti <sergio.sorrenti@gmail.com>
----

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 9167c3d..5231a3a 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -161,6 +161,13 @@ config MACH_MICRO9S
 	  Say 'Y' here if you want your kernel to support the
 	  Contec Micro9-Slim board.
 
+config MACH_SIM_ONE
+        bool "Support Simplemachines Sim.One board"
+        depends on EP93XX_SDCE0_PHYS_OFFSET
+        help
+          Say 'Y' here if you want your kernel to support the
+          Simplemachines Sim.One board.
+
 config MACH_TS72XX
 	bool "Support Technologic Systems TS-72xx SBC"
 	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index eae6199..c731fa9 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_MACH_ADSSPHERE)	+= adssphere.o
 obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
 obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
 obj-$(CONFIG_MACH_MICRO9)	+= micro9.o
+obj-$(CONFIG_MACH_SIM_ONE)	+= simone.o
 obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
new file mode 100644
index 0000000..cd93990
--- /dev/null
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -0,0 +1,97 @@
+/*
+ * arch/arm/mach-ep93xx/simone.c
+ * Simplemachines Sim.One support.
+ *
+ * Copyright (C) 2010 Ryan Mallon <ryan@bluewatersys.com>
+ *
+ * Based on the 2.6.24.7 support:
+ *   Copyright (C) 2009 Simplemachines
+ *   MMC support by Peter Ivanov <ivanovp@gmail.com>, 2007
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+
+#include <mach/hardware.h>
+#include <mach/fb.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static struct physmap_flash_data simone_flash_data = {
+	.width		= 2,
+};
+
+static struct resource simone_flash_resource = {
+	.start		= EP93XX_CS6_PHYS_BASE,
+	.end		= EP93XX_CS6_PHYS_BASE + SZ_8M - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device simone_flash = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.num_resources	= 1,
+	.resource	= &simone_flash_resource,
+	.dev = {
+		.platform_data	= &simone_flash_data,
+	},
+};
+
+static struct ep93xx_eth_data simone_eth_data = {
+	.phy_id		= 1,
+};
+
+static struct ep93xxfb_mach_info simone_fb_info = {
+	.num_modes	= EP93XXFB_USE_MODEDB,
+	.bpp		= 16,
+	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
+};
+
+static struct i2c_gpio_platform_data simone_i2c_gpio_data = {
+	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
+	.sda_is_open_drain	= 0,
+	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
+	.scl_is_open_drain	= 0,
+	.udelay			= 0,
+	.timeout		= 0,
+};
+
+static struct i2c_board_info __initdata simone_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("ds1337", 0x68),
+	},
+};
+
+static void __init simone_init_machine(void)
+{
+	ep93xx_init_devices();
+
+	platform_device_register(&simone_flash);
+	ep93xx_register_eth(&simone_eth_data, 1);
+	ep93xx_register_fb(&simone_fb_info);
+	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
+			    ARRAY_SIZE(simone_i2c_board_info));
+}
+
+MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
+/* Maintainer: Ryan Mallon <ryan@bluewatersys.com> */
+	.phys_io	= EP93XX_APB_PHYS_BASE,
+	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.map_io		= ep93xx_map_io,
+	.init_irq	= ep93xx_init_irq,
+	.timer		= &ep93xx_timer,
+	.init_machine	= simone_init_machine,
+MACHINE_END
