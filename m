From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:27:25 +0800
Subject: [PATCH v2 05/10] power/reset: Add reset driver support for nuc900
In-Reply-To: <1468135649-19980-1-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
Message-ID: <1468135649-19980-6-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is to add reset support for nuc900 series,
currently, it only supports nuc970 SoC reset.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 drivers/power/reset/Kconfig        |  7 +++
 drivers/power/reset/Makefile       |  1 +
 drivers/power/reset/nuc900-reset.c | 93 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/power/reset/nuc900-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 9bb2622..8c84892 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -94,6 +94,13 @@ config POWER_RESET_MSM
 	help
 	  Power off and restart support for Qualcomm boards.
 
+config POWER_RESET_NUC900
+	bool "Nuc900 restart driver"
+	depends on ARCH_W90X900
+	help
+	  Power off and restart support for Nuvoton NUC900 family of
+	  reference boards.
+
 config POWER_RESET_LTC2952
 	bool "LTC2952 PowerPath power-off driver"
 	depends on OF_GPIO
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index ab7aa86..d4df889 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_NUC900) += nuc900-reset.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
diff --git a/drivers/power/reset/nuc900-reset.c b/drivers/power/reset/nuc900-reset.c
new file mode 100644
index 0000000..49986b7
--- /dev/null
+++ b/drivers/power/reset/nuc900-reset.c
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+#define REG_WRPRTR	0x1fc
+#define REG_AHBIPRST	0x060
+
+static struct regmap *syscon;
+
+static int nuc900_restart_handler(struct notifier_block *this,
+				  unsigned long mode, void *cmd)
+{
+	/*0:register protect enable*/
+	int write_protect = 0;
+
+	/*register protection disable*/
+	do {
+		regmap_read(syscon, REG_WRPRTR, &write_protect);
+
+		if (write_protect != 1) {
+			regmap_write(syscon, REG_WRPRTR, 0x59);
+			regmap_write(syscon, REG_WRPRTR, 0x16);
+			regmap_write(syscon, REG_WRPRTR, 0x88);
+		}
+
+	} while (write_protect != 1);
+
+	/*trigger reset*/
+	regmap_write(syscon, REG_AHBIPRST, 0x01);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block nuc900_restart_nb = {
+	.notifier_call = nuc900_restart_handler,
+	.priority = 128,
+};
+
+static int nuc900_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int err;
+
+	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (IS_ERR(syscon)) {
+		pr_err("%s: syscon lookup failed\n", dev->of_node->name);
+		return PTR_ERR(syscon);
+	}
+
+	err = register_restart_handler(&nuc900_restart_nb);
+	if (err)
+		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
+
+	return err;
+}
+
+static const struct of_device_id of_nuc900_reset_match[] = {
+	{ .compatible = "nuvoton,nuc900-reset", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_nuc900_reset_match);
+
+static struct platform_driver nuc900_reset_driver = {
+	.probe = nuc900_reset_probe,
+	.driver = {
+		.name = "nuc900-reset",
+		.of_match_table = of_match_ptr(of_nuc900_reset_match),
+	},
+};
+
+static int __init nuc900_reset_init(void)
+{
+	return platform_driver_register(&nuc900_reset_driver);
+}
+device_initcall(nuc900_reset_init);
-- 
2.7.4
