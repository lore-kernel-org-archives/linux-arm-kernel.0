From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Jun 2012 12:31:59 +0200
Subject: [PATCH 7/9] I2C: MV64XXX: Add Device Tree support
Message-ID: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extends the driver to get properties from device tree. Also extend the
kirkwood DT support to supply the needed properties.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   35 +++++++++++++++++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   13 +++++++
 arch/arm/mach-kirkwood/board-dt.c                  |    2 ++
 drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++++++++++++++++---
 4 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
index b891ee2..89ef899 100644
--- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
@@ -1,4 +1,4 @@
-* I2C
+* Marvell MMP I2C controller
 
 Required properties :
 
@@ -32,3 +32,36 @@ Examples:
 		interrupts = <58>;
 	};
 
+* Marvell MV64XXX I2C controller
+
+Required properties :
+
+ - reg         : Offset and length of the register set for the device
+ - compatible  : should be "marvell,mv64xxx-i2c"
+ - interrupts  : the interrupt number
+ - frequency-m : m factor in baud rate calculation
+
+Recommended properties :
+
+ - frequency-n : n factor in baud rate calculation
+ - timeout-ms  : How long to wait for a transaction to complete
+
+Baud Rate:
+
+The baud rate is calculated thus:
+
+Fscl =          Ftclk
+       ------------------------------------------
+                                (frequency-n + 1)
+       10 *(frequency-m + 1) * 2
+
+Examples:
+
+	i2c at 11000 {
+		compatible = "marvell,mv64xxx-i2c";
+		reg = <0x11000 0x20>;
+		interrupts = <29>;
+		frequency-m = <4>;
+		frequency-n = <4>;
+		timeout-ms = <1000>;
+	};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 7d282ab..3091c01 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -63,5 +63,18 @@
 			/* set partition map and/or chip-delay in board dts */
 			status = "disabled";
 		};
+
+		i2c at 11000 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0x11000 0x20>;
+			interrupt = <29>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <29>;
+			frequency-m = <8>;
+			frequency-n = <3>;
+			timeout-ms = <1000>;
+			status = "disable";
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 0942139..5aa025d 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -28,6 +28,8 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 
 struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
+	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
+		       NULL),
 	{},
 };
 
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 4f44a33..2146984 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -18,6 +18,9 @@
 #include <linux/mv643xx_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_i2c.h>
 
 /* Register defines */
 #define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
@@ -528,7 +531,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
 	int	rc;
 
-	if ((pd->id != 0) || !pdata)
+	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
 		return -ENODEV;
 
 	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
@@ -546,19 +549,35 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	init_waitqueue_head(&drv_data->waitq);
 	spin_lock_init(&drv_data->lock);
 
-	drv_data->freq_m = pdata->freq_m;
-	drv_data->freq_n = pdata->freq_n;
-	drv_data->irq = platform_get_irq(pd, 0);
+	if (pd->dev.of_node) {
+		of_property_read_u32(pd->dev.of_node, "frequency-m",
+				     &drv_data->freq_m);
+		of_property_read_u32(pd->dev.of_node, "frequency-n",
+				     &drv_data->freq_n);
+		drv_data->irq = irq_of_parse_and_map(pd->dev.of_node, 0);
+	} else {
+		drv_data->freq_m = pdata->freq_m;
+		drv_data->freq_n = pdata->freq_n;
+		drv_data->irq = platform_get_irq(pd, 0);
+	}
+
 	if (drv_data->irq < 0) {
 		rc = -ENXIO;
 		goto exit_unmap_regs;
 	}
+
 	drv_data->adapter.dev.parent = &pd->dev;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
 	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
+	if (pd->dev.of_node)
+		drv_data->adapter.timeout = msecs_to_jiffies(
+			of_property_read_u32(pd->dev.of_node, "timeout-ms",
+					     &drv_data->freq_n));
+	else
+		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
 	drv_data->adapter.nr = pd->id;
+	drv_data->adapter.dev.of_node = pd->dev.of_node;
 	platform_set_drvdata(pd, drv_data);
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
@@ -577,6 +596,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		goto exit_free_irq;
 	}
 
+	of_i2c_register_devices(&drv_data->adapter);
+
 	return 0;
 
 	exit_free_irq:
@@ -602,12 +623,19 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	return rc;
 }
 
+static const struct of_device_id mv64xxx_i2c_of_match_table[] __devinitdata = {
+	{ .compatible = "marvell,mv64xxx-i2c", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
+
 static struct platform_driver mv64xxx_i2c_driver = {
 	.probe	= mv64xxx_i2c_probe,
 	.remove	= __devexit_p(mv64xxx_i2c_remove),
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= MV64XXX_I2C_CTLR_NAME,
+		.of_match_table = of_match_ptr(mv64xxx_i2c_of_match_table),
 	},
 };
 
-- 
1.7.10
