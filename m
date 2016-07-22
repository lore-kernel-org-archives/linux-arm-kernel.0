From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 22 Jul 2016 11:37:49 +0200
Subject: [PATCH v3 3/4] drivers: reset: Add STM32 reset driver
In-Reply-To: <1469180270-5446-1-git-send-email-gabriel.fernandez@st.com>
References: <1469180270-5446-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1469180270-5446-4-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Coquelin <mcoquelin.stm32@gmail.com>

The STM32 MCUs family IPs can be reset by accessing some registers
from the RCC block.

The list of available reset lines is documented in the DT bindings.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/reset/Makefile      |   1 +
 drivers/reset/reset-stm32.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 drivers/reset/reset-stm32.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 5d65a93..64ebb0c 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
 obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_ARCH_MESON) += reset-meson.o
+obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
diff --git a/drivers/reset/reset-stm32.c b/drivers/reset/reset-stm32.c
new file mode 100644
index 0000000..3a7c8527
--- /dev/null
+++ b/drivers/reset/reset-stm32.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * Heavily based on sunxi driver from Maxime Ripard.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+struct stm32_reset_data {
+	spinlock_t			lock;
+	void __iomem			*membase;
+	struct reset_controller_dev	rcdev;
+};
+
+static int stm32_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct stm32_reset_data *data = container_of(rcdev,
+						     struct stm32_reset_data,
+						     rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset = id % BITS_PER_LONG;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->membase + (bank * 4));
+	writel(reg | BIT(offset), data->membase + (bank * 4));
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct stm32_reset_data *data = container_of(rcdev,
+						     struct stm32_reset_data,
+						     rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset = id % BITS_PER_LONG;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->membase + (bank * 4));
+	writel(reg & ~BIT(offset), data->membase + (bank * 4));
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static const struct reset_control_ops stm32_reset_ops = {
+	.assert		= stm32_reset_assert,
+	.deassert	= stm32_reset_deassert,
+};
+
+static const struct of_device_id stm32_reset_dt_ids[] = {
+	 { .compatible = "st,stm32-rcc", },
+	 { /* sentinel */ },
+};
+
+static int stm32_reset_probe(struct platform_device *pdev)
+{
+	struct stm32_reset_data *data;
+	struct resource *res;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->membase))
+		return PTR_ERR(data->membase);
+
+	spin_lock_init(&data->lock);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = resource_size(res) * 8;
+	data->rcdev.ops = &stm32_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+
+	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
+}
+
+static struct platform_driver stm32_reset_driver = {
+	.probe	= stm32_reset_probe,
+	.driver = {
+		.name		= "stm32-rcc-reset",
+		.of_match_table	= stm32_reset_dt_ids,
+	},
+};
+builtin_platform_driver(stm32_reset_driver);
-- 
1.9.1
