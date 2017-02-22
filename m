From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 22 Feb 2017 11:10:17 -0600
Subject: [PATCHv2 3/5] reset: Add Altera Arria10 SR Reset Controller
In-Reply-To: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
References: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1487783419-10912-4-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch adds the reset controller functionality for
Peripheral PHYs to the Arria10 System Resource Chip.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
V2  Rename and move new Kconfig to correct alphabetical order.
    Update Makefile with better Kconfig name.
    Alphabetize MAINTAINER drivers entry.
    Remove unused include files.
    Replace 16 reset size with actual size. Enumerate size in
    header file.
    Remove extra id in-range checks since framework checks this.
    Return error code from regmap_read() fail instead of fixed error.
    Remove device_node validation since framework handles this.
    Remove device_node and device local variables in cleanup.
    Delete a10sr_reset_remove() since using devm_ functions.
    Delete .remove function and .owner from platform_driver struct.
    Minor cleanup of commit header and commit description.
---
 MAINTAINERS                 |   1 +
 drivers/reset/Kconfig       |   7 +++
 drivers/reset/Makefile      |   1 +
 drivers/reset/reset-a10sr.c | 138 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/reset/reset-a10sr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b714bd..35ffb92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -653,6 +653,7 @@ M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
 F:	drivers/gpio/gpio-altera-a10sr.c
 F:	drivers/mfd/altera-a10sr.c
+F:	drivers/reset/reset-a10sr.c
 F:	include/linux/mfd/altera-a10sr.h
 F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index f4cdfe9..54e4b8b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -14,6 +14,13 @@ menuconfig RESET_CONTROLLER
 
 if RESET_CONTROLLER
 
+config RESET_A10SR
+	tristate "Altera Arria10 System Resource Reset"
+	depends on MFD_ALTERA_A10SR
+	help
+	  This option enables support for the external reset functions for
+	  peripheral PHYs on the Altera Arria10 System Resource Chip.
+
 config RESET_ATH79
 	bool "AR71xx Reset Driver" if COMPILE_TEST
 	default ATH79
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 2cd3f6c..8f6eb57 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -2,6 +2,7 @@ obj-y += core.o
 obj-y += hisilicon/
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
+obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
diff --git a/drivers/reset/reset-a10sr.c b/drivers/reset/reset-a10sr.c
new file mode 100644
index 0000000..37496bd
--- /dev/null
+++ b/drivers/reset/reset-a10sr.c
@@ -0,0 +1,138 @@
+/*
+ *  Copyright Intel Corporation (C) 2017. All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Reset driver for Altera Arria10 MAX5 System Resource Chip
+ *
+ * Adapted from reset-socfpga.c
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/altera-a10sr.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/reset/altr,rst-mgr-a10sr.h>
+
+struct a10sr_reset {
+	struct reset_controller_dev     rcdev;
+	struct regmap *regmap;
+};
+
+static inline struct a10sr_reset *to_a10sr_rst(struct reset_controller_dev *rc)
+{
+	return container_of(rc, struct a10sr_reset, rcdev);
+}
+
+static inline int a10sr_reset_shift(unsigned long id)
+{
+	switch (id) {
+	case A10SR_RESET_ENET_HPS:
+		return 1;
+	case A10SR_RESET_PCIE:
+	case A10SR_RESET_FILE:
+	case A10SR_RESET_BQSPI:
+	case A10SR_RESET_USB:
+		return id + 11;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int a10sr_reset_update(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
+{
+	struct a10sr_reset *a10r = to_a10sr_rst(rcdev);
+	int offset = a10sr_reset_shift(id);
+	u8 mask = ALTR_A10SR_REG_BIT_MASK(offset);
+	int index = ALTR_A10SR_HPS_RST_REG + ALTR_A10SR_REG_OFFSET(offset);
+
+	return regmap_update_bits(a10r->regmap, index, mask, assert ? 0 : mask);
+}
+
+static int a10sr_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return a10sr_reset_update(rcdev, id, true);
+}
+
+static int a10sr_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return a10sr_reset_update(rcdev, id, false);
+}
+
+static int a10sr_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	int ret;
+	struct a10sr_reset *a10r = to_a10sr_rst(rcdev);
+	int offset = a10sr_reset_shift(id);
+	u8 mask = ALTR_A10SR_REG_BIT_MASK(offset);
+	int index = ALTR_A10SR_HPS_RST_REG + ALTR_A10SR_REG_OFFSET(offset);
+	unsigned int value;
+
+	ret = regmap_read(a10r->regmap, index, &value);
+	if (ret < 0)
+		return ret;
+
+	return !!(value & mask);
+}
+
+static const struct reset_control_ops a10sr_reset_ops = {
+	.assert		= a10sr_reset_assert,
+	.deassert	= a10sr_reset_deassert,
+	.status		= a10sr_reset_status,
+};
+
+static int a10sr_reset_probe(struct platform_device *pdev)
+{
+	struct altr_a10sr *a10sr = dev_get_drvdata(pdev->dev.parent);
+	struct a10sr_reset *a10r;
+
+	a10r = devm_kzalloc(&pdev->dev, sizeof(struct a10sr_reset),
+			    GFP_KERNEL);
+	if (!a10r)
+		return -ENOMEM;
+
+	a10r->rcdev.owner = THIS_MODULE;
+	a10r->rcdev.nr_resets = A10SR_RESET_NUM;
+	a10r->rcdev.ops = &a10sr_reset_ops;
+	a10r->rcdev.of_node = pdev->dev.of_node;
+	a10r->regmap = a10sr->regmap;
+
+	platform_set_drvdata(pdev, a10r);
+
+	return devm_reset_controller_register(&pdev->dev, &a10r->rcdev);
+}
+
+static const struct of_device_id a10sr_reset_of_match[] = {
+	{ .compatible = "altr,a10sr-reset" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, a10sr_reset_of_match);
+
+static struct platform_driver a10sr_reset_driver = {
+	.probe	= a10sr_reset_probe,
+	.driver = {
+		.name		= "altr_a10sr_reset",
+	},
+};
+module_platform_driver(a10sr_reset_driver);
+
+MODULE_AUTHOR("Thor Thayer <thor.thayer@linux.intel.com>");
+MODULE_DESCRIPTION("Altera Arria10 System Resource Reset Controller Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
