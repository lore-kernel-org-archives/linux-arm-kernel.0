From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed, 18 Nov 2015 17:56:22 +0800
Subject: [PATCH v3 3/5] soc: rockchip: add reboot notifier driver
In-Reply-To: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1447840582-19850-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip platform have a protocol to pass the kernel reboot
mode to bootloader by some special registers when system reboot.
By this way the bootloader can take different action according
to the different kernel reboot mode, for example, command
"reboot loader" will reboot the board to rockusb mode, this is
a very convenient way to get the board enter download mode.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3:
 - move from mach-rockchip to drivers/soc/rockchip, as the tegra does
 - use dts pass the related register

Changes in v2:
  - check cpu dt node
  - remove a unnecessary of_put_node in function rockchip_get_pmu_regmap
  - fix a align issue
  - use reboot_notifier instead of restart_handler

 drivers/soc/rockchip/Kconfig  |  7 ++++
 drivers/soc/rockchip/Makefile |  1 +
 drivers/soc/rockchip/loader.h | 22 ++++++++++
 drivers/soc/rockchip/reboot.c | 98 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 drivers/soc/rockchip/loader.h
 create mode 100644 drivers/soc/rockchip/reboot.c

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 7140ff8..4edbc44 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -15,4 +15,11 @@ config ROCKCHIP_PM_DOMAINS
 
           If unsure, say N.
 
+config ROCKCHIP_REBOOT
+	bool "Rockchip reboot notifier driver"
+	help
+	  Say y here will enable reboot notifier support.
+	  This will get reboot mode arguments from userspace and
+	  store it in special register.
+
 endif
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index 3d73d06..9817496 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -2,3 +2,4 @@
 # Rockchip Soc drivers
 #
 obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
+obj-$(CONFIG_ROCKCHIP_REBOOT) += reboot.o
diff --git a/drivers/soc/rockchip/loader.h b/drivers/soc/rockchip/loader.h
new file mode 100644
index 0000000..bf51baa
--- /dev/null
+++ b/drivers/soc/rockchip/loader.h
@@ -0,0 +1,22 @@
+#ifndef __MACH_ROCKCHIP_LOADER_H
+#define __MACH_ROCKCHIP_LOADER_H
+
+/*high 24 bits is tag, low 8 bits is type*/
+#define SYS_LOADER_REBOOT_FLAG   0x5242C300
+
+enum {
+	BOOT_NORMAL = 0, /* normal boot */
+	BOOT_LOADER,     /* enter loader rockusb mode */
+	BOOT_MASKROM,    /* enter maskrom rockusb mode (not support now) */
+	BOOT_RECOVER,    /* enter recover */
+	BOOT_NORECOVER,  /* do not enter recover */
+	BOOT_SECONDOS,   /* boot second OS (not support now)*/
+	BOOT_WIPEDATA,   /* enter recover and wipe data. */
+	BOOT_WIPEALL,    /* enter recover and wipe all data. */
+	BOOT_CHECKIMG,   /* check firmware img with backup part*/
+	BOOT_FASTBOOT,   /* enter fast boot mode */
+	BOOT_SECUREBOOT_DISABLE,
+	BOOT_CHARGING,   /* enter charge mode */
+	BOOT_MAX         /* MAX VALID BOOT TYPE.*/
+};
+#endif
diff --git a/drivers/soc/rockchip/reboot.c b/drivers/soc/rockchip/reboot.c
new file mode 100644
index 0000000..048aeb0b
--- /dev/null
+++ b/drivers/soc/rockchip/reboot.c
@@ -0,0 +1,98 @@
+/*
+ * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include "loader.h"
+
+struct rockchip_reboot {
+	struct device *dev;
+	struct regmap *map;
+	u32 offset;
+	struct notifier_block reboot_notifier;
+};
+
+static void rockchip_get_reboot_flag(const char *cmd, u32 *flag)
+{
+	*flag = SYS_LOADER_REBOOT_FLAG + BOOT_NORMAL;
+
+	if (cmd) {
+		if (!strcmp(cmd, "loader") || !strcmp(cmd, "bootloader"))
+			*flag = SYS_LOADER_REBOOT_FLAG + BOOT_LOADER;
+		else if (!strcmp(cmd, "recovery"))
+			*flag = SYS_LOADER_REBOOT_FLAG + BOOT_RECOVER;
+		else if (!strcmp(cmd, "charge"))
+			*flag = SYS_LOADER_REBOOT_FLAG + BOOT_CHARGING;
+		else if (!strcmp(cmd, "fastboot"))
+			*flag = SYS_LOADER_REBOOT_FLAG + BOOT_FASTBOOT;
+	}
+}
+
+static int rockchip_reboot_notify(struct notifier_block *this,
+				  unsigned long mode, void *cmd)
+{
+	struct rockchip_reboot *reboot;
+	u32 flag;
+
+	reboot = container_of(this, struct rockchip_reboot, reboot_notifier);
+	rockchip_get_reboot_flag(cmd, &flag);
+	regmap_write(reboot->map, reboot->offset, flag);
+
+	return NOTIFY_DONE;
+}
+
+static int __init rockchip_reboot_probe(struct platform_device *pdev)
+{
+	struct rockchip_reboot *reboot;
+	int ret;
+
+	reboot = devm_kzalloc(&pdev->dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	reboot->dev = &pdev->dev;
+	reboot->map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						      "rockchip,regmap");
+	if (IS_ERR(reboot->map))
+		return PTR_ERR(reboot->map);
+
+	if (of_property_read_u32(pdev->dev.of_node, "offset", &reboot->offset))
+		return -EINVAL;
+
+	reboot->reboot_notifier.notifier_call = rockchip_reboot_notify;
+	ret = register_reboot_notifier(&reboot->reboot_notifier);
+	if (ret)
+		dev_err(reboot->dev, "can't register reboot notifier\n");
+
+	return ret;
+}
+
+static const struct of_device_id rockchip_reboot_of_match[] = {
+	{ .compatible = "rockchip,reboot" },
+	{}
+};
+
+static struct platform_driver rockchip_reboot_driver = {
+	.probe = rockchip_reboot_probe,
+	.driver = {
+		.name = "rockchip-reboot",
+		.of_match_table = rockchip_reboot_of_match,
+	},
+};
+module_platform_driver(rockchip_reboot_driver);
+
+MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
+MODULE_DESCRIPTION("Rockchip platform reboot notifier driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
