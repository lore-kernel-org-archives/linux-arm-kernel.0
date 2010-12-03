From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Dec 2010 20:52:44 +0100
Subject: [PATCH 3/4 v2] ARM: S5P: Add platform support for MIPI CSIS devices
In-Reply-To: <1291405965-19482-1-git-send-email-s.nawrocki@samsung.com>
References: <1291405965-19482-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1291405965-19482-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There may be up to two MIPI CSI slave interfaces depending on the SoC version.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/Kconfig                 |   10 ++++++++
 arch/arm/plat-s5p/Makefile                |    2 +
 arch/arm/plat-s5p/dev-csis0.c             |   34 +++++++++++++++++++++++++++++
 arch/arm/plat-s5p/dev-csis1.c             |   34 +++++++++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/csis.h     |   28 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    3 ++
 6 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s5p/dev-csis0.c
 create mode 100644 arch/arm/plat-s5p/dev-csis1.c
 create mode 100644 arch/arm/plat-s5p/include/plat/csis.h

diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 65dbfa8..6a161f3 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -56,3 +56,13 @@ config S5P_DEV_ONENAND
 	bool
 	help
 	  Compile in platform device definition for OneNAND controller
+
+config S5P_DEV_CSIS0
+	bool
+	help
+	  Compile in platform device definitions for MIPI-CSIS channel 0
+
+config S5P_DEV_CSIS1
+	bool
+	help
+	  Compile in platform device definitions for MIPI-CSIS channel 1
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index de65238..2b73173 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -28,3 +28,5 @@ obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
 obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
 obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
 obj-$(CONFIG_S5P_DEV_ONENAND)	+= dev-onenand.o
+obj-$(CONFIG_S5P_DEV_CSIS0)	+= dev-csis0.o
+obj-$(CONFIG_S5P_DEV_CSIS1)	+= dev-csis1.o
diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
new file mode 100644
index 0000000..dfab1c8
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-csis0.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2010 Samsung Electronics
+ *
+ * S5P series device definition for MIPI-CSIS channel 0
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <mach/map.h>
+
+static struct resource s5p_mipi_csis0_resource[] = {
+	[0] = {
+		.start = S5P_PA_MIPI_CSIS0,
+		.end   = S5P_PA_MIPI_CSIS0 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_MIPI_CSIS0,
+		.end   = IRQ_MIPI_CSIS0,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s5p_device_mipi_csis0 = {
+	.name		  = "s5p-mipi-csis",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s5p_mipi_csis0_resource),
+	.resource	  = s5p_mipi_csis0_resource,
+};
diff --git a/arch/arm/plat-s5p/dev-csis1.c b/arch/arm/plat-s5p/dev-csis1.c
new file mode 100644
index 0000000..e3053f2
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-csis1.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2010 Samsung Electronics
+ *
+ * S5P series device definition for MIPI-CSIS channel 1
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <mach/map.h>
+
+static struct resource s5p_mipi_csis1_resource[] = {
+	[0] = {
+		.start = S5P_PA_MIPI_CSIS1,
+		.end   = S5P_PA_MIPI_CSIS1 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_MIPI_CSIS1,
+		.end   = IRQ_MIPI_CSIS1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_mipi_csis1 = {
+	.name		  = "s5p-mipi-csis",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s5p_mipi_csis1_resource),
+	.resource	  = s5p_mipi_csis1_resource,
+};
diff --git a/arch/arm/plat-s5p/include/plat/csis.h b/arch/arm/plat-s5p/include/plat/csis.h
new file mode 100644
index 0000000..51e308c
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/csis.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2010 Samsung Electronics
+ *
+ * S5P series MIPI CSI slave device support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef PLAT_S5P_CSIS_H_
+#define PLAT_S5P_CSIS_H_ __FILE__
+
+/**
+ * struct s5p_platform_mipi_csis - platform data for MIPI-CSIS
+ * @clk_rate: bus clock frequency
+ * @lanes: number of data lanes used
+ * @alignment: data alignment in bits
+ * @hs_settle: HS-RX settle time
+ */
+struct s5p_platform_mipi_csis {
+	unsigned long clk_rate;
+	u8 lanes;
+	u8 alignment;
+	u8 hs_settle;
+};
+
+#endif /* PLAT_S5P_CSIS_H_ */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index dec0ded..01dadee 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -131,6 +131,9 @@ extern struct platform_device s5p_device_fimc0;
 extern struct platform_device s5p_device_fimc1;
 extern struct platform_device s5p_device_fimc2;
 
+extern struct platform_device s5p_device_mipi_csis0;
+extern struct platform_device s5p_device_mipi_csis1;
+
 /* s3c2440 specific devices */
 
 #ifdef CONFIG_CPU_S3C2440
-- 
1.7.3.2
