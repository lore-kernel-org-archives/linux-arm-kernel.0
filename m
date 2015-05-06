From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 May 2015 11:50:27 -0500
Subject: [PATCH] i2c: omap: implement bus recovery
Message-ID: <1430931027-19955-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

implement bus recovery methods for i2c-omap
so we can recover from situations where SCL/SDA
are stuck low.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

rebased on 4.1-rc2, switched over to generic i2c recover mechanism,
retested on am437x sk and beaglebone black.

 drivers/i2c/busses/i2c-omap.c | 69 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0e894193accf..dcf559ac92c5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -481,10 +481,8 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 
 	timeout = jiffies + OMAP_I2C_TIMEOUT;
 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
-		if (time_after(jiffies, timeout)) {
-			dev_warn(dev->dev, "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
-		}
+		if (time_after(jiffies, timeout))
+			return i2c_recover_bus(&dev->adapter);
 		msleep(1);
 	}
 
@@ -1209,6 +1207,68 @@ MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
 #define OMAP_I2C_SCHEME_0		0
 #define OMAP_I2C_SCHEME_1		1
 
+static int omap_i2c_get_scl(struct i2c_adapter *adap)
+{
+	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+
+	return reg & OMAP_I2C_SYSTEST_SCL_I_FUNC;
+}
+
+static int omap_i2c_get_sda(struct i2c_adapter *adap)
+{
+	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+
+	return reg & OMAP_I2C_SYSTEST_SDA_I_FUNC;
+}
+
+static void omap_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	if (val)
+		reg |= OMAP_I2C_SYSTEST_SCL_O;
+	else
+		reg &= ~OMAP_I2C_SYSTEST_SCL_O;
+	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
+}
+
+static void omap_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	reg |= OMAP_I2C_SYSTEST_ST_EN;
+	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
+}
+
+static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	reg &= ~OMAP_I2C_SYSTEST_ST_EN;
+	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
+}
+
+static struct i2c_bus_recovery_info omap_i2c_bus_recovery_info = {
+	.get_scl		= omap_i2c_get_scl,
+	.get_sda		= omap_i2c_get_sda,
+	.set_scl		= omap_i2c_set_scl,
+	.prepare_recovery	= omap_i2c_prepare_recovery,
+	.unprepare_recovery	= omap_i2c_unprepare_recovery,
+	.recover_bus		= i2c_generic_scl_recovery,
+};
+
 static int
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -1358,6 +1418,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
+	adap->bus_recovery_info = &omap_i2c_bus_recovery_info;
 
 	/* i2c device drivers may be active on return from add_adapter() */
 	adap->nr = pdev->id;
-- 
2.4.0.rc3
