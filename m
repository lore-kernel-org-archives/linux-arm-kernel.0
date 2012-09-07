From: gerg@snapgear.com (gerg at snapgear.com)
Date: Fri, 7 Sep 2012 15:24:09 +1000
Subject: [PATCH] ARM: ks8695: add board support for the SnapGear boards based
 on the KS8695
Message-ID: <1346995449-5436-1-git-send-email-gerg@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

A number of boards produced by SnapGear are based on the Micrel KS8695 SoC.
Add board support to the KS8695 kernel code to support them.

The following machine type entries will need to be added back into the
mach-types file with these in mainline:

    lite300      MACH_LITE300     LITE300      408
    se4200       MACH_SE4200      SE4200       809
    sg310        MACH_SG310       SG310        1564

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-ks8695/Kconfig    |   22 +++++++
 arch/arm/mach-ks8695/Makefile   |    3 +
 arch/arm/mach-ks8695/board-sg.c |  121 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ks8695/board-sg.c

diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
index f5c39a8..f6b737e 100644
--- a/arch/arm/mach-ks8695/Kconfig
+++ b/arch/arm/mach-ks8695/Kconfig
@@ -21,6 +21,28 @@ config MACH_ACS5K
 	  say 'Y' here if you want your kernel to run on the Brivo
 	  Systems LLC, ACS-5000 Master board.
 
+config MACH_LITE300
+	bool "SecureComputing SG300"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  SecureComputing / SnapGear SG300 VPN Internet Router.
+	  See http://www.securecomputing.com for more details.
+
+config MACH_SG310
+	bool "McAfee SG310"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  McAfee / SnapGear SG310 VPN Internet Router.
+	  See http://www.mcafee.com for more details.
+
+config MACH_SE4200
+	bool "SecureComputing SE4200"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  SecureComputing / SnapGear SE4200 Secure Wireless VPN
+	  Internet Router.
+	  See http://www.securecomputing.com for more details.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-ks8695/Makefile b/arch/arm/mach-ks8695/Makefile
index 853efd9..9673c0c 100644
--- a/arch/arm/mach-ks8695/Makefile
+++ b/arch/arm/mach-ks8695/Makefile
@@ -18,3 +18,6 @@ obj-$(CONFIG_LEDS)		+= leds.o
 obj-$(CONFIG_MACH_KS8695)	+= board-micrel.o
 obj-$(CONFIG_MACH_DSM320)	+= board-dsm320.o
 obj-$(CONFIG_MACH_ACS5K)	+= board-acs5k.o
+obj-$(CONFIG_MACH_LITE300)	+= board-sg.o
+obj-$(CONFIG_MACH_SG310)	+= board-sg.o
+obj-$(CONFIG_MACH_SE4200)	+= board-sg.o
diff --git a/arch/arm/mach-ks8695/board-sg.c b/arch/arm/mach-ks8695/board-sg.c
new file mode 100644
index 0000000..f35b98b
--- /dev/null
+++ b/arch/arm/mach-ks8695/board-sg.c
@@ -0,0 +1,121 @@
+/*
+ * board-sg.c -- support for the SnapGear KS8695 based boards
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/partitions.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/devices.h>
+#include "generic.h"
+
+/*
+ * The SG310 machine type is fitted with a conventional 8MB Strataflash
+ * device. Define its partitioning.
+ */
+#define	FL_BASE		0x02000000
+#define	FL_SIZE		SZ_8M
+
+static struct mtd_partition sg_mtd_partitions[] = {
+	[0] = {
+		.name	= "SnapGear Boot Loader",
+		.size	= SZ_128K,
+	},
+	[1] = {
+		.name	= "SnapGear non-volatile configuration",
+		.size	= SZ_512K,
+		.offset	= SZ_256K,
+	},
+	[2] = {
+		.name	= "SnapGear image",
+		.offset	= SZ_512K + SZ_256K,
+	},
+	[3] = {
+		.name	= "SnapGear StrataFlash",
+	},
+	[4] = {
+		.name	= "SnapGear Boot Tags",
+		.size	= SZ_128K,
+		.offset	= SZ_128K,
+	},
+};
+
+static struct physmap_flash_data sg_mtd_pdata = {
+	.width		= 1,
+	.nr_parts	= ARRAY_SIZE(sg_mtd_partitions),
+	.parts		= sg_mtd_partitions,
+};
+
+
+static struct resource sg_mtd_resource[] = {
+	[0] = {
+		.start = FL_BASE,
+		.end   = FL_BASE + FL_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device sg_mtd_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(sg_mtd_resource),
+	.resource	= sg_mtd_resource,
+	.dev		= {
+		.platform_data = &sg_mtd_pdata,
+	},
+};
+
+static void __init sg_init(void)
+{
+	ks8695_add_device_lan();
+	ks8695_add_device_wan();
+
+	if (machine_is_sg310())
+		platform_device_register(&sg_mtd_device);
+}
+
+#ifdef CONFIG_MACH_LITE300
+MACHINE_START(LITE300, "SecureComputing/SG300")
+	/* SnapGear */
+	.atag_offset	= 0x100,
+	.map_io		= ks8695_map_io,
+	.init_irq	= ks8695_init_irq,
+	.init_machine	= sg_init,
+	.timer		= &ks8695_timer,
+	.restart	= ks8695_restart,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_SG310
+MACHINE_START(SG310, "McAfee/SG310")
+	/* SnapGear */
+	.atag_offset	= 0x100,
+	.map_io		= ks8695_map_io,
+	.init_irq	= ks8695_init_irq,
+	.init_machine	= sg_init,
+	.timer		= &ks8695_timer,
+	.restart	= ks8695_restart,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_SE4200
+MACHINE_START(SE4200, "SecureComputing/SE4200")
+	/* SnapGear */
+	.atag_offset	= 0x100,
+	.map_io		= ks8695_map_io,
+	.init_irq	= ks8695_init_irq,
+	.init_machine	= sg_init,
+	.timer		= &ks8695_timer,
+	.restart	= ks8695_restart,
+MACHINE_END
+#endif
-- 
1.7.0.4
