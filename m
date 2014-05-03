From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 03 May 2014 15:11:39 +0900
Subject: [PATCH 3/4] misc: exynos-chipid: Add Exynos Chipid driver support
In-Reply-To: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399097500-4052-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos SoCs have Chipid IP, for identification of product IDs
and SoC revistions. Till now we are using static macros
such as soc_is_exynosxxxx and #ifdefs for run time identification
of SoCs and their revisions. This is leading to add new Kconfig,
soc_is_exynosXXXX definitions each time new SoC support is getting
added. So this driver intends to provide initialization code
all these functionalites and thus helping in removing macros.

CC: Arnd Bergmann <arnd@arndb.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/misc/Kconfig         |    7 ++++
 drivers/misc/Makefile        |    1 +
 drivers/misc/exynos-chipid.c |   83 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/exynos-soc.h   |   46 +++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 drivers/misc/exynos-chipid.c
 create mode 100644 include/linux/exynos-soc.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1cb7408..f313bd3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -515,6 +515,13 @@ config SRAM
 	  the genalloc API. It is supposed to be used for small on-chip SRAM
 	  areas found on many SoCs.
 
+config EXYNOS_CHIPID
+	tristate "Support Exynos CHIPID"
+	default y
+	depends on ARCH_EXYNOS || ARM64
+	help
+	  If you say Y here you get support for the Exynos CHIP id.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7eb4b69..48c8fb5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_SRAM)		+= sram.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
+obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
diff --git a/drivers/misc/exynos-chipid.c b/drivers/misc/exynos-chipid.c
new file mode 100644
index 0000000..eb23339
--- /dev/null
+++ b/drivers/misc/exynos-chipid.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * EXYNOS - CHIP ID support
+ * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/exynos-soc.h>
+
+#define EXYNOS4_SOC_MASK	0xFFFE0
+#define EXYNOS5_SOC_MASK	0xFFFFF
+
+#define PROD_ID_SHIFT	(12)
+
+static void __iomem	*exynos_chipid_base;
+unsigned int exynos_soc_id = EXYNOS_SOC_UNKNOWN;
+unsigned int exynos_soc_rev;
+
+struct exynos_chipid_data {
+	unsigned int product_id_mask;
+	unsigned int product_id_shift;
+};
+
+static struct exynos_chipid_data exynos4_chipid_data = {
+	.product_id_mask	= EXYNOS4_SOC_MASK,
+	.product_id_shift	= PROD_ID_SHIFT,
+};
+
+static struct exynos_chipid_data exynos5_chipid_data = {
+	.product_id_mask	= EXYNOS5_SOC_MASK,
+	.product_id_shift	= PROD_ID_SHIFT,
+};
+
+static struct of_device_id of_exynos_chipid_ids[] = {
+	{
+		.compatible	= "samsung,exynos4-chipid",
+		.data		= (void *)&exynos4_chipid_data,
+	},
+	{
+		.compatible	= "samsung,exynos5-chipid",
+		.data		= (void *)&exynos5_chipid_data,
+	},
+	{},
+};
+
+/**
+ * early_exynos_chipid_init - Early chipid initialization
+ */
+void __init early_exynos_chipid_init(void)
+{
+	struct device_node *np = NULL;
+	const struct of_device_id *match;
+	struct exynos_chipid_data *chipid_data;
+	int pro_id;
+
+	if (!exynos_chipid_base) {
+		np = of_find_matching_node_and_match(NULL,
+				of_exynos_chipid_ids, &match);
+		if (!np)
+			panic("%s, failed to find chipid node\n", __func__);
+
+		chipid_data = (struct exynos_chipid_data *) match->data;
+		exynos_chipid_base = of_iomap(np, 0);
+
+		if (!exynos_chipid_base)
+			panic("%s: failed to map registers\n", __func__);
+
+		pro_id  = __raw_readl(exynos_chipid_base);
+		exynos_soc_id = (pro_id >> chipid_data->product_id_shift)
+			& chipid_data->product_id_mask;
+		exynos_soc_rev = pro_id & 0xFF;
+		pr_info("Exynos: CPUID[0x%x] CPU_REV[0x%x] Detected\n",
+				exynos_soc_id, exynos_soc_rev);
+	}
+}
diff --git a/include/linux/exynos-soc.h b/include/linux/exynos-soc.h
new file mode 100644
index 0000000..cb3ae06
--- /dev/null
+++ b/include/linux/exynos-soc.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header for EXYNOS SoC Chipid support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __EXYNOS_SOC_H
+#define __EXYNOS_SOC_H
+
+/* enum holding product id of Exynos SoC
+ * Any new Exynos SoC product id should be added here
+ */
+enum exynos_soc_id {
+	EXYNOS4210 = 0xE4210,
+	EXYNOS4212 = 0xE4412,
+	EXYNOS4412 = 0xE4412,
+	EXYNOS5250 = 0x43520,
+	EXYNOS5420 = 0xE5420,
+	EXYNOS5440 = 0xE5440,
+	EXYNOS_SOC_UNKNOWN = -1,
+};
+
+/* enum holding revision id of Exynos SoC
+ * Any new Exynos SoC revision id should be added here
+ */
+enum exynos_soc_rev {
+	EXYNOS4210_REV_0	= 0x0,
+	EXYNOS4210_REV_1_0	= 0x10,
+	EXYNOS4210_REV_1_1	= 0x11,
+};
+
+/* Since we need chipid to be initialized as early as possible
+ * during secondary core bootup adding early initialization function
+ * Note: This should be called only after device tree gets unflatten
+ */
+extern void early_exynos_chipid_init(void);
+
+extern unsigned int exynos_soc_id;
+extern unsigned int exynos_soc_rev;
+
+#endif /* __EXYNOS_SOC_H */
-- 
1.7.10.4
