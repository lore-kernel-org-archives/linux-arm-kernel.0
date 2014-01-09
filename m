From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Jan 2014 18:19:59 +0100
Subject: [PATCH 1/5] i2c: mv64xxx: Add reset deassert call
In-Reply-To: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1389288003-23187-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31 SoC using that IP has a reset controller maintaining
it reset unless told otherwise.

Add some optional reset support to the driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 1 +
 drivers/i2c/busses/Kconfig                            | 1 +
 drivers/i2c/busses/i2c-mv64xxx.c                      | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 82e8f6f..603003a 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -12,6 +12,7 @@ Optional properties :
 
  - clock-frequency : Desired I2C bus clock frequency in Hz. If not set the
 default frequency is 100kHz
+ - resets          : phandle to the parent reset controller
 
 Examples:
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3b26129..69aa599 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -528,6 +528,7 @@ config I2C_MPC
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
 	depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)
+	select RESET_CONTROLLER
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42..d4e2f32 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/mv643xx_i2c.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -743,6 +744,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 #else
 	const struct of_device_id *device;
 	struct device_node *np = dev->of_node;
+	struct reset_control *rstc;
 	u32 bus_freq, tclk;
 	int rc = 0;
 
@@ -763,6 +765,10 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	}
 	drv_data->irq = irq_of_parse_and_map(np, 0);
 
+	rstc = devm_reset_control_get(dev, NULL);
+	if (!IS_ERR(rstc))
+		reset_control_deassert(rstc);
+
 	/* Its not yet defined how timeouts will be specified in device tree.
 	 * So hard code the value to 1 second.
 	 */
-- 
1.8.4.2
