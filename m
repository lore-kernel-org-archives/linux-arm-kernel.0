From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Nov 2013 16:36:03 -0800
Subject: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the device
 tree case
In-Reply-To: <1384562167-14725-1-git-send-email-tony@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
Message-ID: <1384562167-14725-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we still need to rely on a mix of device tree initialized
drivers and legacy platform data initialize drivers, let's fix
the passing of platform data to twl4030-gpio.

As the twl4030 GPIO is initialized by twl-core.c, we need to register
the auxdata for twl4030 GPIO in twl-core.c.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Samuel & Lee, I'd like to merge this fix via arm-soc tree if this looks
OK to you as I have other patches that depend on this.

---
 drivers/mfd/twl-core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 29473c2..d5b3dd8 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1133,6 +1133,11 @@ static int twl_remove(struct i2c_client *client)
 	return 0;
 }
 
+static struct of_dev_auxdata twl_auxdata_lookup[] = {
+	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
+	{ /* sentinel */ },
+};
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
@@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
 	}
 
-	if (node)
-		status = of_platform_populate(node, NULL, NULL, &client->dev);
-	else
+	if (node) {
+		if (pdata)
+			twl_auxdata_lookup[0].platform_data = pdata->gpio;
+		status = of_platform_populate(node, NULL, twl_auxdata_lookup,
+					      &client->dev);
+	} else {
 		status = add_children(pdata, irq_base, id->driver_data);
+	}
 
 fail:
 	if (status < 0)
-- 
1.8.1.1
