From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Jun 2017 16:44:01 -0700
Subject: [PATCH/RFT 3/3] HACK: ARM: davinci: add cdce913 clock controller
In-Reply-To: <20170602234401.24721-1-khilman@baylibre.com>
References: <20170602234401.24721-1-khilman@baylibre.com>
Message-ID: <20170602234401.24721-4-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850-evm UI board has a ti,cdce913 clock controller with a 27MHz
crystal to provide the master clock to the camera connector.

While there is an upstream driver for the ti,cdce913, it is CCF only,
and since davinci does not currently support CCF, an alternate driver is
needed to make camera sensors that depend on the clock API to work
correctly.

Note that the current driver is very dumb and doesn't even implement
.set_rate, because the default, power-on defaults are sufficient to
provide the 27 MHz clock expected by the aptina,mt9v032 which was used
for testing.
---
 arch/arm/mach-davinci/Makefile       |   2 +-
 arch/arm/mach-davinci/cdce913.c      | 164 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/pdata-quirks.c |   8 +-
 3 files changed, 171 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-davinci/cdce913.c

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index df96ca9eab6d..c91e3a323488 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_AINTC)			+= irq.o
 obj-$(CONFIG_CP_INTC)			+= cp_intc.o
 
 # Board specific
-obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o
+obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o cdce913.o
 obj-$(CONFIG_MACH_DAVINCI_EVM)  	+= board-dm644x-evm.o
 obj-$(CONFIG_MACH_SFFSDR)		+= board-sffsdr.o
 obj-$(CONFIG_MACH_NEUROS_OSD2)		+= board-neuros-osd2.o
diff --git a/arch/arm/mach-davinci/cdce913.c b/arch/arm/mach-davinci/cdce913.c
new file mode 100644
index 000000000000..ef306707f283
--- /dev/null
+++ b/arch/arm/mach-davinci/cdce913.c
@@ -0,0 +1,164 @@
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+
+#include <mach/common.h>
+#include <mach/da8xx.h>
+#include "clock.h"
+
+static struct i2c_client *cdce913;
+
+static void cdce_enable(struct clk *clk)
+{
+	pr_debug("%s: %s\n", __func__, clk->name);
+	return;
+}
+
+static void cdce_disable(struct clk *clk)
+{
+	pr_debug("%s: %s\n", __func__, clk->name);
+	return;
+}
+
+int cdce_set_rate(struct clk *clk, unsigned long rate)
+{
+	WARN_ON(!cdce913);
+	pr_warn("%s: %s: rate = %lu; WARNING  not implemented\n",
+		__func__, clk->name, rate);
+	return 0;
+}
+
+#define CAMERA_XTAL_FREQ	27000000
+
+static struct clk cdce913_clk = {
+	.name		= "cdce913",
+	.clk_enable	= cdce_enable,
+	.clk_disable	= cdce_disable,
+	.rate		= CAMERA_XTAL_FREQ,
+	.set_rate	= cdce_set_rate,
+};
+		
+static struct clk_lookup cdce913_clks[] = {
+        /* HACK: needs i2c address as dev name for proper lookup */
+	CLK("1-004c",		NULL,		&cdce913_clk), 
+};
+
+#define CDCE925_I2C_COMMAND_BLOCK_TRANSFER      0x00
+#define CDCE925_I2C_COMMAND_BYTE_TRANSFER       0x80
+
+static int cdce925_i2c_write(const void *data, size_t count)
+{
+	struct i2c_client *i2c = cdce913;
+	int ret;
+	u8 reg_data[2];
+
+	if (count != 2)
+		return -ENOTSUPP;
+
+	/* First byte is command code */
+	reg_data[0] = CDCE925_I2C_COMMAND_BYTE_TRANSFER | ((u8 *)data)[0];
+	reg_data[1] = ((u8 *)data)[1];
+
+	ret = i2c_master_send(i2c, reg_data, count);
+	if (likely(ret == count))
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+/*
+ * NOTE: i2c read/write functions lifted directly from CCF driver:
+ *       drivers/clk/clk-cdce925.c
+ */
+
+static int cdce925_i2c_read(
+	const void *reg, size_t reg_size, void *val, size_t val_size)
+{
+	struct i2c_client *i2c = cdce913;
+	struct i2c_msg xfer[2];
+	int ret;
+	u8 reg_data[2];
+
+	if (reg_size != 1)
+		return -ENOTSUPP;
+
+	xfer[0].addr = i2c->addr;
+	xfer[0].flags = 0;
+	xfer[0].buf = reg_data;
+	if (val_size == 1) {
+		reg_data[0] =
+			CDCE925_I2C_COMMAND_BYTE_TRANSFER | ((u8 *)reg)[0];
+		xfer[0].len = 1;
+	} else {
+		reg_data[0] =
+			CDCE925_I2C_COMMAND_BLOCK_TRANSFER | ((u8 *)reg)[0];
+		reg_data[1] = val_size;
+		xfer[0].len = 2;
+	}
+
+	xfer[1].addr = i2c->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = val_size;
+	xfer[1].buf = val;
+
+	ret = i2c_transfer(i2c->adapter, xfer, 2);
+	if (likely(ret == 2)) {
+		return 0;
+	} else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int cdce913_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+        u8 data[16], reg;
+
+	if (cdce913) {
+		dev_warn(&client->dev, "already probed !!\n");
+		return 0;
+	}
+	cdce913 = client;
+	davinci_clk_init(cdce913_clks);
+
+	for (reg = 0; reg < 4; reg++) {
+		cdce925_i2c_read(&reg, 1, &data, 1);
+		dev_dbg(&client->dev, "reg 0x%02x: val=0x%02x\n", reg, data[0]);
+	}
+
+	return 0;
+}
+
+static int cdce913_remove(struct i2c_client *client)
+{
+	cdce913 = NULL;
+	return 0;
+}
+
+static const struct i2c_device_id cdce913_ids[] = {
+	{ "cdce913", 0, },
+	{ /* end of list */ },
+};
+
+static const struct of_device_id cdce913_of_match[] = {
+	{ .compatible = "ti,cdce913", },
+	{ },
+};
+
+static struct i2c_driver cdce913_driver = {
+	.driver = {
+		.name    = "cdce913",
+		.of_match_table = of_match_ptr(cdce913_of_match),
+	},
+	.id_table       = cdce913_ids,
+	.probe          = cdce913_probe,
+	.remove         = cdce913_remove,
+};
+
+void __init da850_evm_camera_capture_init(void)
+{
+	i2c_add_driver(&cdce913_driver);
+}
diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 4858b1cdf31b..2d0c8586f6f0 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -191,6 +191,9 @@ static void __init da850_vpif_display_legacy_init_evm(void)
 			__func__, ret);
 }
 
+	
+extern void __init da850_evm_camera_capture_init(void);
+
 static void pdata_quirks_check(struct pdata_init *quirks)
 {
 	while (quirks->compatible) {
@@ -204,8 +207,9 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 
 static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,da850-lcdk", da850_vpif_capture_legacy_init_lcdk, },
-	{ "ti,da850-evm", da850_vpif_display_legacy_init_evm, },
-	{ "ti,da850-evm", da850_vpif_capture_legacy_init_evm, },
+	{ "ti,da850-evm", da850_evm_camera_capture_init, },
+	/* { "ti,da850-evm", da850_vpif_display_legacy_init_evm, }, */
+	/* { "ti,da850-evm", da850_vpif_capture_legacy_init_evm, }, */
 	{ /* sentinel */ },
 };
 
-- 
2.9.3
