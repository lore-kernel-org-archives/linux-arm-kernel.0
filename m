From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 14 Nov 2017 22:41:08 +0100
Subject: [PATCH 2/8] mfd: mtk-mmsys: Add mmsys driver
In-Reply-To: <20171114214114.15793-1-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
Message-ID: <20171114214114.15793-3-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMSYS subsystem includes clocks and drm components.
This patch adds a MFD device to probe both drivers from the same
device tree compatible.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/mfd/Kconfig       |  9 +++++
 drivers/mfd/Makefile      |  2 ++
 drivers/mfd/mtk-mmsys.c   | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mmsys.h | 18 ++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 drivers/mfd/mtk-mmsys.c
 create mode 100644 include/linux/mfd/mmsys.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fc5e4fef89d2..3250ce5d205a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -368,6 +368,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MEDIATEK_MMSYS
+	tristate "Mediatek MMSYS interface"
+	select MDF_CORE
+	select REGMAP_MMIO
+	help
+	  Select this if you have a MMSYS subsystem in your SoC. The
+	  MMSYS subsystem has at least a clock driver part and some
+	  DRM components.
+
 config MFD_MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8703ff17998e..d4fc99df784c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -100,6 +100,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
+obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
+
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
new file mode 100644
index 000000000000..102b491aa28f
--- /dev/null
+++ b/drivers/mfd/mtk-mmsys.c
@@ -0,0 +1,91 @@
+/*
+ * mtk-mmsys.c  --  Mediatek MMSYS multi-function driver
+ *
+ *  Copyright (c) 2017 Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * Author: Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * For licencing details see kernel-base/COPYING
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mmsys.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+enum {
+	MMSYS_MT2701 = 1,
+};
+
+static const struct mfd_cell mmsys_mt2701_devs[] = {
+	{ .name = "clk-mt2701-mm", },
+	{ .name = "drm-mt2701-mm", },
+};
+
+static int mmsys_probe(struct platform_device *pdev)
+{
+	struct mmsys_dev *private;
+	const struct mfd_cell *mmsys_cells;
+	int nr_cells;
+	long id;
+	int ret;
+
+	id = (long) of_device_get_match_data(&pdev->dev);
+	if (!id) {
+		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
+		return -EINVAL;
+	}
+
+	switch (id) {
+	case MMSYS_MT2701:
+		mmsys_cells = mmsys_mt2701_devs;
+		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	private = devm_kzalloc(&pdev->dev, sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
+
+	private->dev = &pdev->dev;
+	dev_set_drvdata(private->dev, private);
+
+	private->of_node = pdev->dev.of_node;
+
+	ret = devm_mfd_add_devices(private->dev, 0, mmsys_cells, nr_cells,
+					NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+};
+
+static const struct of_device_id of_match_mmsys[] = {
+	{ .compatible = "mediatek,mt2701-mmsys",
+	  .data = (void *) MMSYS_MT2701,
+	},
+	{ /* sentinel */ },
+};
+
+static struct platform_driver mmsys_drv = {
+	.probe = mmsys_probe,
+	.driver = {
+		.name = "mediatek-mmysys",
+		.of_match_table = of_match_ptr(of_match_mmsys),
+	},
+};
+
+builtin_platform_driver(mmsys_drv);
+
+MODULE_DESCRIPTION("Mediatek MMSYS multi-function driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/mmsys.h b/include/linux/mfd/mmsys.h
new file mode 100644
index 000000000000..274b9ee03ada
--- /dev/null
+++ b/include/linux/mfd/mmsys.h
@@ -0,0 +1,18 @@
+/* Header of MMSYS MFD core driver for Mediatek platforms
+ *
+ * Copyright (c) 2017 Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#ifndef __MEDIATEK_MMSYS__H__
+#define __MEDIATEK_MMSYS__H__
+
+struct mmsys_dev {
+	struct device		*dev;
+	struct device_node	*of_node;
+};
+
+#endif
-- 
2.14.2
