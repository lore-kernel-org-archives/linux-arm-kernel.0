From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 17 Aug 2010 17:30:49 +0900
Subject: [PATCH] ARM: S5PC210: OneNAND device support
Message-ID: <20100817083049.GA20042@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

OneNAND device support on s5pc210 SoC.
It's same as s5pc110 controller

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 331b5bd..6a8427d 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -25,6 +25,11 @@ config S5PV310_SETUP_I2C2
 	help
 	  Common setup code for i2c bus 2.
 
+config S5PC210_DEV_ONENAND
+	bool
+	help
+	  Compile in platform device definition for OneNAND controller
+
 # machine support
 
 config MACH_SMDKV310
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index d5b51c7..9e585a3 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 
 obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
+obj-$(CONFIG_S5PC210_DEV_ONENAND)	+= dev-onenand.o
diff --git a/arch/arm/mach-s5pv310/dev-onenand.c b/arch/arm/mach-s5pv310/dev-onenand.c
new file mode 100644
index 0000000..9090711
--- /dev/null
+++ b/arch/arm/mach-s5pv310/dev-onenand.c
@@ -0,0 +1,46 @@
+/*
+ * linux/arch/arm/mach-s5pv310/dev-onenand.c
+ *
+ *  Copyright (c) 2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * S5PC210 series device definition for OneNAND devices
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+static struct resource s5pc210_onenand_resources[] = {
+	[0] = {
+		.start	= S5PC210_PA_ONENAND,
+		.end	= S5PC210_PA_ONENAND + SZ_128K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= S5PC210_PA_ONENAND_DMA,
+		.end	= S5PC210_PA_ONENAND_DMA + SZ_8K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= IRQ_ONENAND_AUDI,
+		.end	= IRQ_ONENAND_AUDI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5pc210_device_onenand = {
+	/* It's same as s5pc110 */
+	.name		= "s5pc110-onenand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5pc210_onenand_resources),
+	.resource	= s5pc210_onenand_resources,
+};
diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 56885ca..f7fb2b8 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -66,6 +66,8 @@
 
 #define IRQ_IIC			COMBINER_IRQ(27, 0)
 
+#define IRQ_ONENAND_AUDI	COMBINER_IRQ(34, 0)
+
 /* Set the default NR_IRQS */
 #define NR_IRQS			COMBINER_IRQ(MAX_COMBINER_NR, 0)
 
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 87697c9..f714620 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -23,6 +23,9 @@
 
 #include <plat/map-s5p.h>
 
+#define S5PC210_PA_ONENAND		(0x0C000000)
+#define S5PC210_PA_ONENAND_DMA		(0x0C600000)
+
 #define S5PV310_PA_CHIPID		(0x10000000)
 #define S5P_PA_CHIPID			S5PV310_PA_CHIPID
 
