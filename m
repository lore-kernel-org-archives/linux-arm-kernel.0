From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 22 Dec 2015 17:13:19 +0800
Subject: [PATCH v1 4/6] soc: rockchip: add reboot mode driver
In-Reply-To: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1450775599-24127-1-git-send-email-andy.yan@rock-chips.com>
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

Changes in v1:
- fix the embarrassed compile warning
- correct the maskrom magic number
- check for the normal reboot

 drivers/soc/rockchip/Kconfig                 |  9 ++++
 drivers/soc/rockchip/Makefile                |  1 +
 drivers/soc/rockchip/reboot.c                | 68 ++++++++++++++++++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h | 30 ++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/soc/rockchip/reboot.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 7140ff8..42525f8 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -15,4 +15,13 @@ config ROCKCHIP_PM_DOMAINS
 
           If unsure, say N.
 
+config ROCKCHIP_REBOOT
+	bool "Rockchip reboot mode driver"
+	select REBOOT_MODE
+	help
+	  Say y here will enable reboot mode driver. This will
+	  get reboot mode arguments from userspace and store it
+	  in special register, then the bootloader will read it
+	  to take different action according to the mode.
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
diff --git a/drivers/soc/rockchip/reboot.c b/drivers/soc/rockchip/reboot.c
new file mode 100644
index 0000000..7024532
--- /dev/null
+++ b/drivers/soc/rockchip/reboot.c
@@ -0,0 +1,68 @@
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
+#include <dt-bindings/soc/rockchip_boot-mode.h>
+
+static struct regmap *map;
+static u32 offset;
+
+static int rockchip_reboot_mode_write(int magic)
+{
+	if (!magic)
+		magic = BOOT_NORMAL;
+
+	regmap_write(map, offset, magic);
+
+	return 0;
+}
+
+static int rockchip_reboot_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+					      "rockchip,regmap");
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
diff --git a/include/dt-bindings/soc/rockchip_boot-mode.h b/include/dt-bindings/soc/rockchip_boot-mode.h
new file mode 100644
index 0000000..eedf113
--- /dev/null
+++ b/include/dt-bindings/soc/rockchip_boot-mode.h
@@ -0,0 +1,30 @@
+#ifndef __ROCKCHIP_BOOT_MODE_H
+#define __ROCKCHIP_BOOT_MODE_H
+
+/*high 24 bits is tag, low 8 bits is type*/
+#define	REBOOT_FLAG		0x5242C300
+/* normal boot */
+#define	BOOT_NORMAL		(REBOOT_FLAG + 0)
+/* enter loader rockusb mode */
+#define	BOOT_LOADER		(REBOOT_FLAG + 1)
+/* enter maskrom rockusb mode */
+#define	BOOT_MASKROM		(0xEF08A53C)
+/* enter recovery */
+#define	BOOT_RECOVERY		(REBOOT_FLAG + 3)
+/* do not enter recover */
+#define	BOOT_NORECOVER		(REBOOT_FLAG + 4)
+/* boot second OS*/
+#define	BOOT_SECONDOS		(REBOOT_FLAG + 5)
+/* enter recover and wipe data. */
+#define	BOOT_WIPEDATA		(REBOOT_FLAG + 6)
+/* enter recover and wipe all data. */
+#define	BOOT_WIPEALL		(REBOOT_FLAG + 7)
+/* check firmware img with backup part*/
+#define	BOOT_CHECKIMG		(REBOOT_FLAG + 8)
+ /* enter fast boot mode */
+#define	BOOT_FASTBOOT		(REBOOT_FLAG + 9)
+#define	BOOT_SECUREBOOT_DISABLE	(REBOOT_FLAG + 10)
+/* enter charge mode */
+#define	BOOT_CHARGING		(REBOOT_FLAG + 11)
+
+#endif
-- 
1.9.1
