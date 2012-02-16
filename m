From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Feb 2012 08:32:36 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120214172902.GB3916@opensource.wolfsonmicro.com>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
Message-ID: <20120216073236.GE3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 09:29:04AM -0800, Mark Brown wrote:
> On Tue, Feb 14, 2012 at 11:58:23AM +0100, Sascha Hauer wrote:
> > On Mon, Feb 13, 2012 at 06:48:21AM -0800, Mark Brown wrote:
> 
> > > If the board really has so few software controlled regulators then they
> > > should just be using the dummy regulator support which already exists,
> > > someone should just add a knob to turn it on automatically.
> 
> > I thought we agree that generally turning on the dummy regulator is a
> > bad idea. Now you are advocating for the dummy regulator again.
> 
> Well, no.  I'm saying that people are being far too trigger happy with
> it and that if someone wants to add a mechanism for turning it on they
> need to deal with the fact that it currntly warns every time it does
> anything but there are some resonable use cases, especially on very old
> boards.
> 
> The main thing here is to avoid these driver specific bodges that people
> keep churning out again and again, it's quite depressing really.

I think this churning will continue until we either make the dummy
regulator non optional and drop this warning that gets printed each
time it is used, or we at least provide a way to easily add a fixed
dummy regulator without adding >20 lines of code to each board just
for saying that we don't have a regulator for this particular device.

The following could be an example how to add such a helper.

Sascha

8<-------------------------------------------------

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/Makefile       |    2 +-
 drivers/regulator/fixed-helper.c |   59 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/fixed.h  |   15 +++++++++
 3 files changed, 75 insertions(+), 1 deletions(-)
 create mode 100644 drivers/regulator/fixed-helper.c

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 503bac8..f76deb9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -3,7 +3,7 @@
 #
 
 
-obj-$(CONFIG_REGULATOR) += core.o dummy.o
+obj-$(CONFIG_REGULATOR) += core.o dummy.o fixed-helper.o
 obj-$(CONFIG_OF) += of_regulator.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
new file mode 100644
index 0000000..8c601a9
--- /dev/null
+++ b/drivers/regulator/fixed-helper.c
@@ -0,0 +1,59 @@
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+
+struct fixed_regulator_data {
+	struct fixed_voltage_config cfg;
+	struct regulator_init_data init_data;
+	struct platform_device pdev;
+};
+
+static void regulator_fixed_release(struct device *dev)
+{
+	struct fixed_regulator_data *data = container_of(dev,
+			struct fixed_regulator_data, pdev.dev);
+	kfree(data);
+}
+
+/**
+ * regulator_register_fixed - register a no-op fixed regulator
+ * @name: supply name
+ * @id: platform device id
+ * @microvolts: voltage
+ * @supplies: consumers for this regulator
+ * @num_supplies: number of consumers
+ */
+struct platform_device *regulator_register_fixed(const char *name, int id,
+		int microvolts,
+		struct regulator_consumer_supply *supplies,
+		int num_supplies)
+{
+	struct fixed_regulator_data *data;
+	int size;
+
+	size = sizeof(*data);
+
+	data = kzalloc(size, GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->cfg.supply_name = name;
+	data->cfg.microvolts = microvolts;
+	data->cfg.gpio = -EINVAL;
+	data->cfg.enabled_at_boot = 1;
+	data->cfg.init_data = &data->init_data;
+
+	data->init_data.constraints.always_on = 1;
+	data->init_data.consumer_supplies = supplies;
+	data->init_data.num_consumer_supplies = num_supplies;
+
+	data->pdev.name = "reg-fixed-voltage";
+	data->pdev.id = id;
+	data->pdev.dev.platform_data = &data->cfg;
+	data->pdev.dev.release = regulator_fixed_release;
+
+	platform_device_register(&data->pdev);
+
+	return &data->pdev;
+}
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index ffd7d50..57289c0 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -48,4 +48,19 @@ struct fixed_voltage_config {
 	struct regulator_init_data *init_data;
 };
 
+struct regulator_consumer_supply;
+
+#if IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
+struct platform_device *regulator_register_fixed(const char *name, int id,
+		int microvolts, struct regulator_consumer_supply *supplies,
+		int num_supplies);
+#else
+static struct platform_device *regulator_register_fixed(const char *name, int id,
+		int microvolts, struct regulator_consumer_supply *supplies,
+		int num_supplies)
+{
+	return NULL;
+}
+#endif
+
 #endif
-- 
1.7.9



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
