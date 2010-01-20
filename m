From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 21 Jan 2010 09:06:20 +1300
Subject: [PATCH] ep93xx: Add support for Simplemachines Sim.One board
Message-ID: <4B57623C.3050704@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch adds support for the ep9307 based Sim.One board from
Simplemachines. The code is based on the patches from Simplemachines for
the 2.6.24.7 kernel available here:
http://sim1.googlecode.com/files/linux-2.6.24.7-patches-20091001.tgz.
Support for  SPI and Audio is not included since we do not support them
in mainline yet. The framebuffer support has been tested with a standard
desktop monitor. LCD support is not included because I do not have
hardware to test.

I have specified the maintainer for this board as Nuccio Raciti (CC'ed),
who is the maintainer for Simplemachine's 2.6.24.7 patches. If this is
not okay, I can put myself as the maintainer.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Cc: Nuccio Raciti <nuccio.raciti@gmail.com>
Cc: Peter Ivanov <ivanovp@gmail.com>
Cc: Sergio Sorrenti <sergio.sorrenti@gmail.com>
Cc: Hartley Sweeten <hartleys@visionengravers.com>
----

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 9167c3d..a8b2035 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -168,6 +168,13 @@ config MACH_TS72XX
 	  Say 'Y' here if you want your kernel to support the
 	  Technologic Systems TS-72xx board.

+config MACH_SIM_ONE
+        bool "Support Simplemachines Sim.One board"
+        depends on EP93XX_SDCE0_PHYS_OFFSET
+        help
+          Say 'Y' here if you want your kernel to support the
+          Simplemachines Sim.One board.
+
 choice
 	prompt "Select a UART for early kernel messages"

diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index eae6199..01d90e1 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
 obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
 obj-$(CONFIG_MACH_MICRO9)	+= micro9.o
 obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
+obj-$(CONFIG_MACH_SIM_ONE)	+= simone.o
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
new file mode 100644
index 0000000..fb3ef1f
--- /dev/null
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -0,0 +1,77 @@
+/*
+ * arch/arm/mach-ep93xx/simone.c
+ * Simplemachines Sim.One support.
+ *
+ * Copyright (C) 2009 Ryan Mallon <ryan@bluewatersys.com>
+ *
+ * Based on the 2.6.24 support:
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
+	.start		= 0x60000000,
+	.end		= 0x60000000 + SZ_8M - 1,
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
+	.flags		= EP93XXFB_PCLK_FALLING,
+};
+
+static void __init simone_init_machine(void)
+{
+	ep93xx_init_devices();
+	
+	platform_device_register(&simone_flash);
+	ep93xx_register_eth(&simone_eth_data, 1);
+	ep93xx_register_fb(&simone_fb_info);
+}
+
+MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
+/* Maintainer: Nuccio Raciti Simplemachine <nuccio.raciti@gmail.com> */
+	.phys_io	= EP93XX_APB_PHYS_BASE,
+	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x00000100,
+	.map_io		= ep93xx_map_io,
+	.init_irq	= ep93xx_init_irq,
+	.timer		= &ep93xx_timer,
+	.init_machine	= simone_init_machine,
+MACHINE_END
