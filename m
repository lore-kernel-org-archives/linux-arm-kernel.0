From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 2 Jan 2018 19:47:30 +0800
Subject: [PATCH 05/12] mfd: mtk-audsys: add MediaTek audio subsystem driver
In-Reply-To: <cover.1514881870.git.ryder.lee@mediatek.com>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
Message-ID: <fbe22b0d78c41b121f04202dcbfcd0cc23a7590d.1514881870.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a common driver for the top block of the MediaTek audio subsystem.
This is a wrapper which manages resources for audio components.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mfd/Kconfig      |   9 ++++
 drivers/mfd/Makefile     |   2 +
 drivers/mfd/mtk-audsys.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/mfd/mtk-audsys.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1d20a80..ea50b51 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -368,6 +368,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MEDIATEK_AUDSYS
+	tristate "MediaTek audio subsystem interface"
+	select MDF_CORE
+	select REGMAP_MMIO
+	help
+	  Select this if you have a audio subsystem in MediaTek SoC.
+	  The audio subsystem has at least a clock driver part and some
+	  audio components.
+
 config MFD_MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9474ad..3e20927 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -101,6 +101,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
+obj-$(CONFIG_MFD_MEDIATEK_AUDSYS) += mtk-audsys.o
+
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
diff --git a/drivers/mfd/mtk-audsys.c b/drivers/mfd/mtk-audsys.c
new file mode 100644
index 0000000..89399e1
--- /dev/null
+++ b/drivers/mfd/mtk-audsys.c
@@ -0,0 +1,138 @@
+/*
+ * Mediatek audio subsystem core driver
+ *
+ *  Copyright (c) 2017 MediaTek Inc.
+ *
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *
+ * For licencing details see kernel-base/COPYING
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define AUDSYS_MAX_CLK_NUM 3
+
+struct sys_dev {
+	struct device *dev;
+	struct regmap *regmap;
+	int clk_num;
+	struct clk *clks[];
+};
+
+static const struct regmap_config aud_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x15e0,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int mtk_subsys_enable(struct sys_dev *sys)
+{
+	struct device *dev = sys->dev;
+	struct clk *clk;
+	int i, ret;
+
+	for (i = 0; i < sys->clk_num; i++) {
+		clk = of_clk_get(dev->of_node, i);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			break;
+		}
+		sys->clks[i] = clk;
+	}
+
+	for (i = 0; i < sys->clk_num && sys->clks[i]; i++) {
+		ret = clk_prepare_enable(sys->clks[i]);
+		if (ret)
+			goto err_enable_clks;
+	}
+
+	return 0;
+
+err_enable_clks:
+	while (--i >= 0)
+		clk_disable_unprepare(sys->clks[i]);
+
+	return ret;
+}
+
+static int mtk_subsys_probe(struct platform_device *pdev)
+{
+	struct sys_dev *sys;
+	struct resource *res;
+	void __iomem *mmio;
+	int num, ret;
+
+	num = (int)of_device_get_match_data(&pdev->dev);
+	if (!num)
+		return -EINVAL;
+
+	sys = devm_kzalloc(&pdev->dev, sizeof(*sys) +
+			   sizeof(struct clk *) * num, GFP_KERNEL);
+	if (!sys)
+		return -ENOMEM;
+
+	sys->clk_num = num;
+	sys->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = devm_ioremap_resource(sys->dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	sys->regmap = devm_regmap_init_mmio(sys->dev, mmio,
+					    &aud_regmap_config);
+	if (IS_ERR(sys->regmap))
+		return PTR_ERR(sys->regmap);
+
+	platform_set_drvdata(pdev, sys);
+
+	/* Enable top level clocks */
+	ret = mtk_subsys_enable(sys);
+	if (ret)
+		return ret;
+
+	return devm_of_platform_populate(sys->dev);
+};
+
+static int mtk_subsys_remove(struct platform_device *pdev)
+{
+	struct sys_dev *sys = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = sys->clk_num - 1; i >= 0; i--)
+		if (sys->clks[i])
+			clk_disable_unprepare(sys->clks[i]);
+
+	return 0;
+}
+
+static const struct of_device_id of_match_audsys[] = {
+	{
+	  .compatible = "mediatek,mt2701-audsys-core",
+	  .data = (void *)AUDSYS_MAX_CLK_NUM,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, of_match_audsys);
+
+static struct platform_driver audsys_drv = {
+	.probe = mtk_subsys_probe,
+	.remove	= mtk_subsys_remove,
+	.driver = {
+		.name = "mediatek-audsys-core",
+		.of_match_table = of_match_ptr(of_match_audsys),
+	},
+};
+
+builtin_platform_driver(audsys_drv);
+
+MODULE_DESCRIPTION("Mediatek audio subsystem core driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
