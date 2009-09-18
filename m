From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 18 Sep 2009 09:54:03 +0900
Subject: [PATCH] Samsung SoCs: OneNAND device support
Message-ID: <20090918005403.GA27504@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C64XX, S5PC1XX series OneNAND device support

All SoCs use samsung-onenand drivers

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 8931c5f..c18cc10 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -203,4 +203,9 @@ config S3C_DEV_NAND
 	help
 	  Compile in platform device definition for NAND controller
 
+config S3C_DEV_ONENAND
+	bool
+	help
+	  Compile in platform device definition for OneNAND controller
+
 endif
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 3c09109..c239889 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
+obj-$(CONFIG_S3C_DEV_ONENAND)	+= dev-onenand.o
diff --git a/arch/arm/plat-s3c/dev-onenand.c b/arch/arm/plat-s3c/dev-onenand.c
new file mode 100644
index 0000000..af348c4
--- /dev/null
+++ b/arch/arm/plat-s3c/dev-onenand.c
@@ -0,0 +1,111 @@
+/*
+ * linux/arch/arm/plat-s3c/dev-onenand.c
+ *
+ *  Copyright (c) 2008-2009 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * S3C64XX/S5PC1XX series device definition for OneNAND devices
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
+#include <plat/irqs.h>
+#include <plat/regs-onenand.h>
+
+#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_CPU_S5PC100)
+static struct resource samsung_onenand_resources[] = {
+	[0] = {
+		.start	= SAMSUNG_ONENAND_BASE,
+		.end	= SAMSUNG_ONENAND_BASE + 0x400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_ONENAND,
+		.end	= IRQ_ONENAND,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device samsung_device_onenand = {
+	.name		= "samsung-onenand",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(samsung_onenand_resources),
+	.resource	= samsung_onenand_resources,
+};
+
+void samsung_onenand_set_platdata(struct onenand_platform_data *pdata)
+{
+	struct onenand_platform_data *pd;
+
+	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
+	if (!pd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	samsung_device_onenand.dev.platform_data = pd;
+}
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+static struct resource s3c64xx_onenand1_resources[] = {
+        [0] = {
+                .start  = S3C64XX_ONENAND1_BASE,
+                .end    = S3C64XX_ONENAND1_BASE + 0x400 - 1,
+                .flags  = IORESOURCE_MEM,
+        },
+        [1] = {
+                .start = IRQ_ONENAND1,
+                .end   = IRQ_ONENAND1,
+                .flags = IORESOURCE_IRQ,
+        },
+};
+
+struct platform_device s3c_device_onenand1 = {
+        .name           = "samsung-onenand",
+        .id             = 1,
+        .num_resources  = ARRAY_SIZE(s3c64xx_onenand1_resources),
+        .resource       = s3c64xx_onenand1_resources,
+};
+
+void s3c_onenand1_set_platdata(struct onenand_platform_data *pdata)
+{
+	struct onenand_platform_data *pd;
+
+	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
+	if (!pd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	s3c_device_onenand1.dev.platform_data = pd;
+}
+#endif
+
+#ifdef CONFIG_CPU_S5PC110
+static struct resource s5pc110_onenand_resources[] = {
+	{
+		.start	= S5PC110_ONENAND_BASE,
+		.end	= S5PC110_ONENAND_BASE + SZ_128K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device s5pc110_device_onenand = {
+	.name		= "samsung-onenand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5pc110_onenand_resources),
+	.resource	= s5pc110_onenand_resources,
+};
+
+void s5pc110_onenand_set_platdata(struct onenand_platform_data *pdata)
+{
+	struct onenand_platform_data *pd;
+
+	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
+	if (!pd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	s5pc110_device_onenand.dev.platform_data = pd;
+}
+#endif
