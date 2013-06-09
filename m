From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sun,  9 Jun 2013 10:36:42 +0800
Subject: [PATCH 2/2] i2c: designware: Add i2c-designware-hs
In-Reply-To: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
References: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1370745402-11844-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support hisilicon i2c driver, which reuse designware i2c ip

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-designware-hs.txt  |   30 +++
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-designware-hs.c             |  194 ++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt
 create mode 100644 drivers/i2c/busses/i2c-designware-hs.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt b/Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt
new file mode 100644
index 0000000..08908fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt
@@ -0,0 +1,30 @@
+* Hisilicon I2C Controller
+
+Required properties :
+
+ - compatible : should be "hisilicon,designware-i2c"
+ - reg : Offset and length of the register set for the device
+ - interrupts : <IRQ> where IRQ is the interrupt number.
+
+Example :
+
+	i2c0: i2c at fcb08000 {
+		compatible = "hs,designware-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0xfcb08000 0x1000>;
+		interrupts = <0 28 4>;
+		clocks = <&pclk>;
+		status = "disabled";
+	};
+
+	Client in i2c0 bus with add 0x58 could be added as example
+	i2c0: i2c at fcb08000 {
+		status = "ok";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+		i2c_client1: i2c_client at 58 {
+			compatible = "hisilicon,i2c_client_tpa2028";
+			reg = <0x58>;
+		};
+	};
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 631736e..4405476 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -419,6 +419,16 @@ config I2C_DESIGNWARE_PCI
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-designware-pci.
 
+config I2C_DESIGNWARE_HS
+	tristate "Synopsys DesignWare Hisilicon"
+	depends on ARCH_HI3xxx
+	depends on HAVE_CLK
+	select I2C_DESIGNWARE_CORE
+	help
+	  If you say yes to this option, support will be included for the
+	  Synopsys DesignWare I2C adapter on Hisilicon.
+	  Only master mode is supported.
+
 config I2C_EG20T
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 8f4fc23..2408932 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c-designware-platform.o
 i2c-designware-platform-objs := i2c-designware-platdrv.o
 obj-$(CONFIG_I2C_DESIGNWARE_PCI)	+= i2c-designware-pci.o
 i2c-designware-pci-objs := i2c-designware-pcidrv.o
+obj-$(CONFIG_I2C_DESIGNWARE_HS)	+= i2c-designware-hs.o
 obj-$(CONFIG_I2C_EG20T)		+= i2c-eg20t.o
 obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
 obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
diff --git a/drivers/i2c/busses/i2c-designware-hs.c b/drivers/i2c/busses/i2c-designware-hs.c
new file mode 100644
index 0000000..94d1496
--- /dev/null
+++ b/drivers/i2c/busses/i2c-designware-hs.c
@@ -0,0 +1,194 @@
+/*
+ * Hisilicon Synopsys DesignWare I2C adapter driver (master only).
+ *
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/of_i2c.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/pinctrl/consumer.h>
+#include "i2c-designware-core.h"
+
+static struct i2c_algorithm hs_i2c_dw_algo = {
+	.master_xfer	= i2c_dw_xfer,
+	.functionality	= i2c_dw_func,
+};
+static u32 hs_i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
+{
+	return clk_get_rate(dev->clk)/1000;
+}
+
+static int hs_dw_i2c_probe(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *d;
+	struct i2c_adapter *adap;
+	struct resource *iores;
+	struct pinctrl *pinctrl;
+	int r;
+
+	d = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	/* NOTE: driver uses the static register mapping */
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores)
+		return -EINVAL;
+
+	d->base = devm_request_and_ioremap(&pdev->dev, iores);
+	if (!d->base)
+		return -EADDRNOTAVAIL;
+
+	d->irq = platform_get_irq(pdev, 0);
+	if (d->irq < 0) {
+		dev_err(&pdev->dev, "no irq resource?\n");
+		return d->irq; /* -ENXIO */
+	}
+
+	r = devm_request_irq(&pdev->dev, d->irq,
+		i2c_dw_isr, IRQF_DISABLED, pdev->name, d);
+	if (r) {
+		dev_err(&pdev->dev, "failure requesting irq %i\n", d->irq);
+		return -EINVAL;
+	}
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+			"pins are not configured from the driver\n");
+
+	d->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(d->clk))
+		return -ENODEV;
+
+	d->get_clk_rate_khz = hs_i2c_dw_get_clk_rate_khz;
+	clk_prepare_enable(d->clk);
+	init_completion(&d->cmd_complete);
+	mutex_init(&d->lock);
+	d->dev = get_device(&pdev->dev);
+
+	d->functionality =
+		I2C_FUNC_I2C |
+		I2C_FUNC_10BIT_ADDR |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK;
+	d->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
+	d->accessor_flags = ACCESS_32BIT;
+	d->tx_fifo_depth = 16;
+	d->rx_fifo_depth = 16;
+
+	r = i2c_dw_init(d);
+	if (r)
+		goto err;
+
+	i2c_dw_disable_int(d);
+
+	adap = &d->adapter;
+	i2c_set_adapdata(adap, d);
+	adap->owner = THIS_MODULE;
+	adap->class = I2C_CLASS_HWMON;
+	strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
+			sizeof(adap->name));
+	adap->algo = &hs_i2c_dw_algo;
+	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;
+
+	adap->nr = pdev->id;
+	r = i2c_add_numbered_adapter(adap);
+	if (r) {
+		dev_err(&pdev->dev, "failure adding adapter\n");
+		goto err;
+	}
+	of_i2c_register_devices(adap);
+	platform_set_drvdata(pdev, d);
+
+	return 0;
+err:
+	clk_disable_unprepare(d->clk);
+	put_device(&pdev->dev);
+	return r;
+}
+
+static int hs_dw_i2c_remove(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *d = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	i2c_del_adapter(&d->adapter);
+	put_device(&pdev->dev);
+	clk_disable_unprepare(d->clk);
+	i2c_dw_disable(d);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id hs_dw_i2c_of_match[] = {
+	{ .compatible = "hisilicon,designware-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hs_dw_i2c_of_match);
+#endif
+
+#ifdef CONFIG_PM
+static int hs_dw_i2c_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(i_dev->clk);
+
+	return 0;
+}
+
+static int hs_dw_i2c_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	clk_prepare_enable(i_dev->clk);
+	i2c_dw_init(i_dev);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(hs_dw_i2c_dev_pm_ops, hs_dw_i2c_suspend,
+			hs_dw_i2c_resume);
+
+static struct platform_driver hs_dw_i2c_driver = {
+	.probe		= hs_dw_i2c_probe,
+	.remove		= hs_dw_i2c_remove,
+	.driver		= {
+		.name	= "i2c_designware-hs",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(hs_dw_i2c_of_match),
+		.pm	= &hs_dw_i2c_dev_pm_ops,
+	},
+};
+module_platform_driver(hs_dw_i2c_driver);
+
+MODULE_DESCRIPTION("HS Synopsys DesignWare I2C bus adapter");
+MODULE_ALIAS("platform:i2c_designware-hs");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
