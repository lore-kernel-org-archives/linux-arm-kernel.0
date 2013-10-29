From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Oct 2013 17:50:05 +0530
Subject: [PATCH 4/4] power: reset: as3722: add power-off driver
In-Reply-To: <1383049205-29620-1-git-send-email-ldewangan@nvidia.com>
References: <1383049205-29620-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1383049205-29620-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ams AS3722 supports the power off functionality to turn off
system.

Add power off driver for ams AS3722.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/power/reset/Kconfig           |    6 ++
 drivers/power/reset/Makefile          |    1 +
 drivers/power/reset/as3722-poweroff.c |  101 +++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 drivers/power/reset/as3722-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 9b3ea53..6d452a7 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -6,6 +6,12 @@ menuconfig POWER_RESET
 
 	  Say Y here to enable board reset and power off
 
+config POWER_RESET_AS3722
+	bool "ams AS3722 power-off driver"
+	depends on MFD_AS3722 && POWER_RESET
+	help
+	  This driver supports turning off board via a ams AS3722 power-off.
+
 config POWER_RESET_GPIO
 	bool "GPIO power-off driver"
 	depends on OF_GPIO && POWER_RESET
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 3e6ed88..a5b4a77 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
new file mode 100644
index 0000000..64e7c7f
--- /dev/null
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -0,0 +1,101 @@
+/*
+ * Power off driver for ams AS3722 device.
+ *
+ * Copyright (c) 2013, NVIDIA Corporation.
+ *
+ * Author: Laxman Dewangan <ldewangan@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307, USA
+ */
+
+#include <linux/mfd/as3722.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct as3722_poweroff {
+	struct device *dev;
+	struct as3722 *as3722;
+};
+
+static struct as3722_poweroff *as3722_pm_poweroff;
+
+static void as3722_pm_power_off(void)
+{
+	int ret;
+
+	if (!as3722_pm_poweroff) {
+		pr_err("AS3722 poweroff is not initialised\n");
+		return;
+	}
+
+	ret = as3722_update_bits(as3722_pm_poweroff->as3722,
+		AS3722_RESET_CONTROL_REG, AS3722_POWER_OFF, AS3722_POWER_OFF);
+	if (ret < 0)
+		dev_err(as3722_pm_poweroff->dev,
+			"RESET_CONTROL_REG update failed, %d\n", ret);
+}
+
+static int as3722_poweroff_probe(struct platform_device *pdev)
+{
+	struct as3722_poweroff *as3722_poweroff;
+	struct device_node *np = pdev->dev.parent->of_node;
+
+	if (!np)
+		return -EINVAL;
+
+	if (!of_property_read_bool(np, "ams,system-power-controller"))
+		return 0;
+
+	as3722_poweroff = devm_kzalloc(&pdev->dev, sizeof(*as3722_poweroff),
+				GFP_KERNEL);
+	if (!as3722_poweroff)
+		return -ENOMEM;
+
+	as3722_poweroff->as3722 = dev_get_drvdata(pdev->dev.parent);
+	as3722_poweroff->dev = &pdev->dev;
+	as3722_pm_poweroff = as3722_poweroff;
+	if (!pm_power_off)
+		pm_power_off = as3722_pm_power_off;
+
+	return 0;
+}
+
+static int as3722_poweroff_remove(struct platform_device *pdev)
+{
+	if (pm_power_off == as3722_pm_power_off)
+		pm_power_off = NULL;
+	as3722_pm_poweroff = NULL;
+
+	return 0;
+}
+
+static struct platform_driver as3722_poweroff_driver = {
+	.driver = {
+		.name = "as3722-power-off",
+		.owner = THIS_MODULE,
+	},
+	.probe = as3722_poweroff_probe,
+	.remove = as3722_poweroff_remove,
+};
+
+module_platform_driver(as3722_poweroff_driver);
+
+MODULE_DESCRIPTION("Power off driver for ams AS3722 PMIC Device");
+MODULE_ALIAS("platform:as3722-power-off");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.1.1
