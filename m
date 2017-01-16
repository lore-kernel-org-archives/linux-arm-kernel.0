From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Mon, 16 Jan 2017 18:56:34 +0800
Subject: [PATCH v2 3/3] reset: zx2967: add reset controller driver for ZTE's
 zx2967 family
In-Reply-To: <1484564194-18530-1-git-send-email-baoyou.xie@linaro.org>
References: <1484564194-18530-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484564194-18530-3-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds reset controller driver for ZTE's zx2967 family.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/reset/Kconfig        |   6 +++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-zx2967.c | 125 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 drivers/reset/reset-zx2967.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 172dc96..f4cdfe9 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -86,6 +86,12 @@ config RESET_UNIPHIER
 	  Say Y if you want to control reset signals provided by System Control
 	  block, Media I/O block, Peripheral Block.
 
+config RESET_ZX2967
+	bool "ZTE ZX2967 Reset Driver"
+	depends on ARCH_ZX || COMPILE_TEST
+	help
+	  This enables the reset controller driver for ZTE's zx2967 family.
+
 config RESET_ZYNQ
 	bool "ZYNQ Reset Driver" if COMPILE_TEST
 	default ARCH_ZYNQ
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 13b346e..2cd3f6c 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
+obj-$(CONFIG_RESET_ZX2967) += reset-zx2967.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
diff --git a/drivers/reset/reset-zx2967.c b/drivers/reset/reset-zx2967.c
new file mode 100644
index 0000000..bc95261
--- /dev/null
+++ b/drivers/reset/reset-zx2967.c
@@ -0,0 +1,125 @@
+/*
+ * ZTE's zx2967 family reset controller driver
+ *
+ * Copyright (C) 2017 ZTE Ltd.
+ *
+ * Author: Baoyou Xie <baoyou.xie@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+struct zx2967_reset {
+	void __iomem			*reg_base;
+	spinlock_t			lock;
+	struct reset_controller_dev	rcdev;
+};
+
+static int zx2967_reset_act(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool assert)
+{
+	struct zx2967_reset *reset = NULL;
+	u32 bank = id / 32;
+	u32 offset = id % 32;
+	u32 reg;
+	unsigned long flags;
+
+	reset = container_of(rcdev, struct zx2967_reset, rcdev);
+
+	spin_lock_irqsave(&reset->lock, flags);
+
+	reg = readl(reset->reg_base + (bank * 4));
+	if (assert)
+		reg &= ~BIT(offset);
+	else
+		reg |= BIT(offset);
+	writel(reg, reset->reg_base + (bank * 4));
+
+	spin_unlock_irqrestore(&reset->lock, flags);
+
+	return 0;
+}
+
+static int zx2967_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return zx2967_reset_act(rcdev, id, true);
+}
+
+static int zx2967_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return zx2967_reset_act(rcdev, id, false);
+}
+
+static struct reset_control_ops zx2967_reset_ops = {
+	.assert		= zx2967_reset_assert,
+	.deassert	= zx2967_reset_deassert,
+};
+
+static int zx2967_reset_probe(struct platform_device *pdev)
+{
+	struct zx2967_reset *reset;
+	struct resource *res;
+
+	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reset->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reset->reg_base))
+		return PTR_ERR(reset->reg_base);
+
+	spin_lock_init(&reset->lock);
+
+	reset->rcdev.owner = THIS_MODULE;
+	reset->rcdev.nr_resets = resource_size(res) * 8;
+	reset->rcdev.ops = &zx2967_reset_ops;
+	reset->rcdev.of_node = pdev->dev.of_node;
+
+	dev_info(&pdev->dev, "reset controller cnt:%d",
+		  reset->rcdev.nr_resets);
+
+	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+}
+
+static int zx2967_reset_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id zx2967_reset_dt_ids[] = {
+	 { .compatible = "zte,zx296718-reset", },
+	 {},
+};
+MODULE_DEVICE_TABLE(of, zx2967_reset_dt_ids);
+
+static struct platform_driver zx2967_reset_driver = {
+	.probe	= zx2967_reset_probe,
+	.remove	= zx2967_reset_remove,
+	.driver = {
+		.name		= "zx2967-reset",
+		.of_match_table	= zx2967_reset_dt_ids,
+	},
+};
+
+static int __init zx2967_reset_init(void)
+{
+	return platform_driver_register(&zx2967_reset_driver);
+}
+arch_initcall(zx2967_reset_init);
+
+static void __exit zx2967_reset_exit(void)
+{
+	platform_driver_unregister(&zx2967_reset_driver);
+}
+module_exit(zx2967_reset_exit);
+
+MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
+MODULE_DESCRIPTION("ZTE zx2967 Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
