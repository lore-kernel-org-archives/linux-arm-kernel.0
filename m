From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 13 Sep 2018 16:05:48 +0800
Subject: [PATCH] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Message-ID: <20180913160548.6ed41c43@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, the sda/scl pins are muxed with gpio functions, so
they could be used for recovery. Select the gpio/default pin function
when prepare/unprepare recovery.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/i2c/busses/i2c-designware-core.h   |  3 +++
 drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index e367b1af4ab2..01d5f01691a4 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -271,6 +271,9 @@ struct dw_i2c_dev {
 	int			(*init)(struct dw_i2c_dev *dev);
 	int			mode;
 	struct i2c_bus_recovery_info rinfo;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pins_default;
+	struct pinctrl_state	*pins_gpio;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 94d94b4a9a0d..c1b5b51e3ecc 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -629,6 +630,9 @@ static void i2c_dw_prepare_recovery(struct i2c_adapter *adap)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 
+	if (dev->pinctrl && dev->pins_gpio)
+		pinctrl_select_state(dev->pinctrl, dev->pins_gpio);
+
 	i2c_dw_disable(dev);
 	reset_control_assert(dev->rst);
 	i2c_dw_prepare_clk(dev, false);
@@ -641,6 +645,9 @@ static void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
 	i2c_dw_prepare_clk(dev, true);
 	reset_control_deassert(dev->rst);
 	i2c_dw_init_master(dev);
+
+	if (dev->pinctrl && dev->pins_default)
+		pinctrl_select_state(dev->pinctrl, dev->pins_default);
 }
 
 static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
@@ -648,6 +655,8 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
 	struct i2c_adapter *adap = &dev->adapter;
 	struct gpio_desc *gpio;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *s;
 	int r;
 
 	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
@@ -664,6 +673,19 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 		return PTR_ERR(gpio);
 	rinfo->sda_gpiod = gpio;
 
+	pinctrl = devm_pinctrl_get(dev->dev);
+	if (PTR_ERR(pinctrl) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (pinctrl && !IS_ERR(pinctrl)) {
+		dev->pinctrl = pinctrl;
+		s = pinctrl_lookup_state(pinctrl, PINCTRL_STATE_DEFAULT);
+		if (s && !IS_ERR(s))
+			dev->pins_default = s;
+		s = pinctrl_lookup_state(dev->pinctrl, "gpio");
+		if (s && !IS_ERR(s))
+			dev->pins_gpio = s;
+	}
+
 	rinfo->recover_bus = i2c_generic_scl_recovery;
 	rinfo->prepare_recovery = i2c_dw_prepare_recovery;
 	rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
-- 
2.19.0.rc2
