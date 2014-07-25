From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jul 2014 15:23:45 +0200
Subject: [PATCH 3/6] power: reset: driver for the Versatile syscon reboot
In-Reply-To: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1406294628-16079-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver enabled us to drive the reboot of the Versatile family
of ARM reference boards. Even though only the RealView boards are
supported initially, these boards all have the same procedure for
reboot:

- Write a magic value into an unlocking register
- Write another magic value into a reset control register

The driver will be reusable for Versatile and possibly also the
Integrator family of reference boards.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/reset/Kconfig                |   9 +++
 drivers/power/reset/Makefile               |   1 +
 drivers/power/reset/arm-versatile-reboot.c | 121 +++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/power/reset/arm-versatile-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bdcf5173e377..3dde8fd5e3a0 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -58,6 +58,15 @@ config POWER_RESET_SUN6I
 	help
 	  Reboot support for the Allwinner A31 SoCs.
 
+config POWER_RESET_VERSATILE
+	bool "ARM Versatile family reboot driver"
+	depends on ARM
+	depends on MFD_SYSCON
+	depends on OF
+	help
+	  Power off and restart support for ARM Versatile family of
+	  reference boards.
+
 config POWER_RESET_VEXPRESS
 	bool "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index dde2e8bbac53..5b2ec9521dc6 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_SUN6I) += sun6i-reboot.o
+obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
 obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
 obj-$(CONFIG_POWER_RESET_XGENE) += xgene-reboot.o
 obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
diff --git a/drivers/power/reset/arm-versatile-reboot.c b/drivers/power/reset/arm-versatile-reboot.c
new file mode 100644
index 000000000000..b2fca4678970
--- /dev/null
+++ b/drivers/power/reset/arm-versatile-reboot.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <asm/system_misc.h>
+
+#define REALVIEW_SYS_LOCK_OFFSET	0x20
+#define REALVIEW_SYS_LOCK_VAL		0xA05F
+#define REALVIEW_SYS_RESETCTL_OFFSET	0x40
+
+/*
+ * We detect the different syscon types from the compatible strings.
+ */
+enum versatile_reboot {
+	REALVIEW_REBOOT_EB,
+	REALVIEW_REBOOT_PB1176,
+	REALVIEW_REBOOT_PB11MP,
+	REALVIEW_REBOOT_PBA8,
+	REALVIEW_REBOOT_PBX,
+};
+
+/* Pointer to the system controller */
+static struct regmap *syscon_regmap;
+static enum versatile_reboot versatile_reboot_type;
+
+static const struct of_device_id versatile_reboot_of_match[] = {
+	{
+		.compatible = "arm,realview-eb-reboot",
+		.data = (void *)REALVIEW_REBOOT_EB,
+	},
+	{
+		.compatible = "arm,realview-pb1176-reboot",
+		.data = (void *)REALVIEW_REBOOT_PB1176,
+	},
+	{
+		.compatible = "arm,realview-pb11mp-reboot",
+		.data = (void *)REALVIEW_REBOOT_PB11MP,
+	},
+	{
+		.compatible = "arm,realview-pba8-reboot",
+		.data = (void *)REALVIEW_REBOOT_PBA8,
+	},
+	{
+		.compatible = "arm,realview-pbx-reboot",
+		.data = (void *)REALVIEW_REBOOT_PBX,
+	},
+};
+
+static void versatile_reboot(enum reboot_mode mode, const char *cmd)
+{
+	/* Unlock the reset register */
+	regmap_write(syscon_regmap, REALVIEW_SYS_LOCK_OFFSET,
+		     REALVIEW_SYS_LOCK_VAL);
+	/* Then hit reset on the different machines */
+	switch (versatile_reboot_type) {
+	case REALVIEW_REBOOT_EB:
+		regmap_write(syscon_regmap,
+			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0008);
+		break;
+	case REALVIEW_REBOOT_PB1176:
+		regmap_write(syscon_regmap,
+			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0100);
+		break;
+	case REALVIEW_REBOOT_PB11MP:
+	case REALVIEW_REBOOT_PBA8:
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x0000);
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x0004);
+		break;
+	case REALVIEW_REBOOT_PBX:
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x00f0);
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x00f4);
+		break;
+	}
+	dsb();
+}
+
+static int versatile_reboot_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *reboot_id;
+	struct device_node *np;
+
+	np = of_find_matching_node_and_match(NULL, versatile_reboot_of_match,
+						 &reboot_id);
+	if (!np)
+		return -ENODEV;
+	versatile_reboot_type = (enum versatile_reboot)reboot_id->data;
+
+	syscon_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							"regmap");
+	if (IS_ERR(syscon_regmap))
+		return PTR_ERR(syscon_regmap);
+
+	arm_pm_restart = versatile_reboot;
+	dev_info(&pdev->dev, "versatile reboot driver registered\n");
+	return 0;
+}
+
+static struct platform_driver versatile_reboot_driver = {
+	.probe = versatile_reboot_probe,
+	.driver = {
+		.name = "realview-reboot",
+		.of_match_table = versatile_reboot_of_match,
+	},
+};
+module_platform_driver(versatile_reboot_driver);
-- 
1.9.3
