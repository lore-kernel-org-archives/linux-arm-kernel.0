From: lukma@denx.de (Lukasz Majewski)
Date: Fri, 17 Nov 2017 00:22:39 +0100
Subject: [PATCH 4/4] ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx
 derivative
In-Reply-To: <20171116232239.16823-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
Message-ID: <20171116232239.16823-5-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BK3 board is a derivative of the ts72xx reference design. Hence, it
can re-use code from the ts72xx-common.c file.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/mach-ep93xx/Kconfig  |  7 ++++
 arch/arm/mach-ep93xx/Makefile |  1 +
 arch/arm/mach-ep93xx/bk3.c    | 88 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.h |  5 +++
 arch/arm/tools/mach-types     |  1 +
 5 files changed, 102 insertions(+)
 create mode 100644 arch/arm/mach-ep93xx/bk3.c

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 16c5d6eedf45..18a93b404d5e 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -21,6 +21,13 @@ config MACH_ADSSPHERE
 	  Say 'Y' here if you want your kernel to support the ADS
 	  Sphere board.
 
+config MACH_BK3
+	bool "Support Liebherr BK3.1"
+	select TS72XX_COMMON
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Liebherr controller BK3.1.
+
 config MACH_EDB93XX
 	bool
 
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index f2692a072864..fb5bdb7cb944 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
 
 obj-$(CONFIG_MACH_ADSSPHERE)	+= adssphere.o
+obj-$(CONFIG_MACH_BK3)          += bk3.o
 obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
 obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
 obj-$(CONFIG_MACH_MICRO9)	+= micro9.o
diff --git a/arch/arm/mach-ep93xx/bk3.c b/arch/arm/mach-ep93xx/bk3.c
new file mode 100644
index 000000000000..6fb4b72500ee
--- /dev/null
+++ b/arch/arm/mach-ep93xx/bk3.c
@@ -0,0 +1,88 @@
+/*
+ * arch/arm/mach-ep93xx/bk3.c
+ * Liebherr HVAC controller bk3.1
+ *
+ * based on arch/arm/mach-ep93xx/ts72xx.c
+ *
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2017
+ * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <asm/io.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/amba/bus.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/map.h>
+#include <asm/mach/arch.h>
+
+#include "soc.h"
+#include "ts72xx.h"
+
+/* NAND definition */
+static struct mtd_partition bk3_nand_parts[] = {
+	{
+		.name		= "System",
+		.offset	= 0x00000000,
+		.size		= 0x01e00000,
+	}, {
+		.name		= "Data",
+		.offset	= 0x01e00000,
+		.size		= 0x05f20000
+	}, {
+		.name		= "RedBoot",
+		.offset	= 0x07d20000,
+		.size		= 0x002e0000,
+		.mask_flags	= MTD_WRITEABLE,	/* force RO */
+	},
+};
+
+static AMBA_APB_DEVICE(i2s1, "apb:i2s", 1, EP93XX_I2S_PHYS_BASE,
+		       { IRQ_EP93XX_SAI }, NULL);
+
+static struct map_desc bk3_io_desc[] __initdata = {
+	{
+		.virtual	= BK3_CPLDVER_VIRT_BASE,
+		.pfn		= __phys_to_pfn(BK3_CPLDVER_PHYS_BASE),
+		.length	= BK3_CPLDVER_SIZE,
+		.type		= MT_DEVICE,
+	}
+};
+
+static void __init bk3_map_io(void)
+{
+	ts72xx_common_map_io();
+	iotable_init(bk3_io_desc, ARRAY_SIZE(bk3_io_desc));
+}
+
+static void __init bk3_init_machine(void)
+{
+	ep93xx_init_devices();
+
+	ts72xx_register_flash(bk3_nand_parts, ARRAY_SIZE(bk3_nand_parts));
+	ts72xx_register_watchdog();
+	ts72xx_register_eth();
+
+	amba_device_register(&i2s1_device, &iomem_resource);
+}
+
+MACHINE_START(BK3, "Liebherr controller BK3.1")
+	/* Maintainer: Lukasz Majewski <lukma@denx.de> */
+	.atag_offset	= 0x100,
+	.map_io	= bk3_map_io,
+	.init_irq	= ep93xx_init_irq,
+	.init_time	= ep93xx_timer_init,
+	.init_machine	= bk3_init_machine,
+	.init_late	= ep93xx_init_late,
+	.restart	= ep93xx_restart,
+MACHINE_END
diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
index a9d3bb49f666..07f6491f35ea 100644
--- a/arch/arm/mach-ep93xx/ts72xx.h
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -44,6 +44,11 @@
 #define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
 #define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
 
+/* BK3 specific defines */
+#define BK3_CPLDVER_PHYS_BASE		0x23400000
+#define BK3_CPLDVER_VIRT_BASE		0xfebfd000
+#define BK3_CPLDVER_SIZE		0x00001000
+
 #ifndef __ASSEMBLY__
 
 static inline int ts72xx_model(void)
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index a9313b66f770..4eac94c1eb6f 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -345,6 +345,7 @@ mxlads			MACH_MXLADS		MXLADS			1851
 linkstation_mini	MACH_LINKSTATION_MINI	LINKSTATION_MINI	1858
 afeb9260		MACH_AFEB9260		AFEB9260		1859
 imx27ipcam		MACH_IMX27IPCAM		IMX27IPCAM		1871
+bk3			MACH_BK3		BK3			1880
 rd88f6183ap_ge		MACH_RD88F6183AP_GE	RD88F6183AP_GE		1894
 realview_pba8		MACH_REALVIEW_PBA8	REALVIEW_PBA8		1897
 realview_pbx		MACH_REALVIEW_PBX	REALVIEW_PBX		1901
-- 
2.11.0
