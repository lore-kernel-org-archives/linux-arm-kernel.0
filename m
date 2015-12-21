From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 21 Dec 2015 19:39:08 +0800
Subject: [PATCH 4/6] soc: rockchip: add reboot mode driver
In-Reply-To: <1450697249-29994-1-git-send-email-andy.yan@rock-chips.com>
References: <1450697249-29994-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1450697948-30205-1-git-send-email-andy.yan@rock-chips.com>
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

 drivers/soc/rockchip/Kconfig  |  8 ++++++
 drivers/soc/rockchip/Makefile |  1 +
 drivers/soc/rockchip/loader.h | 22 +++++++++++++++
 drivers/soc/rockchip/reboot.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 drivers/soc/rockchip/loader.h
 create mode 100644 drivers/soc/rockchip/reboot.c

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 7140ff8..855d518 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -15,4 +15,12 @@ config ROCKCHIP_PM_DOMAINS
 
           If unsure, say N.
 
+config ROCKCHIP_REBOOT
+	bool "Rockchip reboot mode driver"
+	select REBOOT_MODE
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
index 0000000..eb580b5
--- /dev/null
+++ b/drivers/soc/rockchip/reboot.c
@@ -0,0 +1,66 @@
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
+struct regmap *map;
+u32 offset;
+
+static int rockchip_reboot_mode_write(int magic)
+{
+	pr_info("%s---------magic:%x\n", __func__, magic);
+	regmap_write(map, offset, magic);
+
+}
+
+static int __init rockchip_reboot_probe(struct platform_device *pdev)
+{
+	struct rockchip_reboot *reboot;
+	int ret;
+
+	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						      "rockchip,regmap");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	if (of_property_read_u32(pdev->dev.of_node, "offset", &offset))
+		return -EINVAL;
+
+	ret = reboot_mode_register(&pdev->dev, rockchip_reboot_mode_write);
+	if (ret)
+		dev_err(&pdev->dev, "can't register reboot mode\n");
+
+	return ret;
+}
+
+static const struct of_device_id rockchip_reboot_of_match[] = {
+	{ .compatible = "rockchip,reboot-mode" },
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
