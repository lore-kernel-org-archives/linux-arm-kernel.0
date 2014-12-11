From: jean-michel.hautbois@vodalys.com (Jean-Michel Hautbois)
Date: Thu, 11 Dec 2014 09:36:26 +0100
Subject: regulator: tps65023 : Adding support for DT
Message-ID: <CAL8zT=jo2AsK9p_r_C+od_QEovOQNmo7MnNu9JtUHoA=KtsxGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a board with a AM3505 and a tps65023 PMIC.
Until now, this board was running a 2.6.37.
I am trying to use a 3.18.

I started to add support for DT in this regulator, but I can't get a
booting kernel with it. I know it lacks regulator init in the parse_dt
function, but I don't really know what is the best way to do it. I
have used tps6507x as an example until know...

I don't know for instance if a tps_board is needed (it would contain
only a struct regulator_init_data * so probably not very useful) ?

Below is my current status (I also have created a tps65023.dtsi in
arch/arm/boot/dts which is only a copy of tps6507x.dtsi so didn't copy
it here).

diff --git a/drivers/regulator/tps65023-regulator.c
b/drivers/regulator/tps65023-regulator.c
index 7380af8..6e6fd78 100644
--- a/drivers/regulator/tps65023-regulator.c
+++ b/drivers/regulator/tps65023-regulator.c
@@ -19,9 +19,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
@@ -199,6 +202,60 @@ static struct regmap_config tps65023_regmap_config = {
        .val_bits = 8,
 };

+#if defined(CONFIG_OF)
+static const struct of_device_id tps65023_of_match[] = {
+       { .compatible = "ti,tps65023",},
+       {},
+};
+MODULE_DEVICE_TABLE(of, tps65023_of_match);
+
+static struct of_regulator_match tps65023_matches[] = {
+       { .name = "VDCDC1"},
+       { .name = "VDCDC2"},
+       { .name = "VDCDC3"},
+       { .name = "LDO1"},
+       { .name = "LDO2"},
+};
+
+static struct regulator_init_data*
+       of_get_tps65023_platform_data(struct device *dev)
+{
+       struct regulator_init_data *pdata;
+       struct device_node *np = dev->of_node;
+       struct device_node *regulators;
+       struct of_regulator_match *matches;
+       int i, count, ret;
+
+       pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+       if (!pdata)
+               return NULL;
+
+       regulators = of_get_child_by_name(np, "regulators");
+       if (!regulators) {
+               dev_err(dev, "regulator node not found\n");
+               return NULL;
+       }
+
+       count = ARRAY_SIZE(tps65023_matches);
+       matches = tps65023_matches;
+
+       ret = of_regulator_match(dev, regulators, matches, count);
+       of_node_put(regulators);
+       if (ret < 0) {
+               dev_err(dev, "Error parsing regulator init data: %d\n", ret);
+               return NULL;
+       }
+
+       return pdata;
+}
+#else
+static struct regulator_init_data*
+       of_get_tps65023_platform_data(struct device *dev)
+{
+       return NULL;
+}
+#endif
+
 static int tps_65023_probe(struct i2c_client *client,
                                     const struct i2c_device_id *id)
 {
@@ -211,13 +268,27 @@ static int tps_65023_probe(struct i2c_client *client,
        int i;
        int error;

+       if (client->dev.of_node) {
+               const struct of_device_id *match;
+               match = of_match_device(of_match_ptr(tps65023_of_match),
+                                       &client->dev);
+               if (!match) {
+                       dev_err(&client->dev, "Error: No device match found\n");
+                       return -ENODEV;
+               }
+       }
+
        /**
         * init_data points to array of regulator_init structures
         * coming from the board-evm file.
         */
        init_data = dev_get_platdata(&client->dev);
-       if (!init_data)
-               return -EIO;
+       if (!init_data && client->dev.of_node)
+               init_data = of_get_tps65023_platform_data(&client->dev);
+       if(!init_data) {
+               dev_err(&client->dev, "No Platform data\n");
+               return -EINVAL;
+       }

        tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
        if (!tps)
@@ -411,6 +482,7 @@ static struct i2c_driver tps_65023_i2c_driver = {
        .driver = {
                .name = "tps65023",
                .owner = THIS_MODULE,
+               .of_match_table = of_match_ptr(tps65023_of_match),
        },
        .probe = tps_65023_probe,
        .id_table = tps_65023_id,


Thanks,
JM
