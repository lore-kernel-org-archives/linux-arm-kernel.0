From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 18 Jun 2013 15:17:57 +0200
Subject: [PATCH v2 2/5] mfd: twl4030-power: Simplify probing of power scripts
 and resources
In-Reply-To: <1371561480-28325-1-git-send-email-florian.vaussard@epfl.ch>
References: <1371561480-28325-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1371561480-28325-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase lisibility when probing power scripts and resources by
creating dedicated functions.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/mfd/twl4030-power.c |   60 ++++++++++++++++++++++++++++--------------
 1 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 7ade81b..8fa6c7b 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -492,6 +492,39 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
+int twl4030_power_configure_scripts(struct twl4030_power_data *pdata)
+{
+	int err;
+	int i;
+	u8 address = twl4030_start_script_address;
+
+	for (i = 0; i < pdata->num; i++) {
+		err = load_twl4030_script(pdata->scripts[i], address);
+		if (err)
+			return err;
+		address += pdata->scripts[i]->size;
+	}
+
+	return 0;
+}
+
+int twl4030_power_configure_resources(struct twl4030_power_data *pdata)
+{
+	struct twl4030_resconfig *resconfig = pdata->resource_config;
+	int err;
+
+	if (resconfig) {
+		while (resconfig->resource) {
+			err = twl4030_configure_resource(resconfig);
+			if (err)
+				return err;
+			resconfig++;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * In master mode, start the power off sequence.
  * After a successful execution, TWL shuts down the power to the SoC
@@ -511,9 +544,7 @@ int twl4030_power_probe(struct platform_device *pdev)
 {
 	struct twl4030_power_data *pdata = pdev->dev.platform_data;
 	int err = 0;
-	int i;
-	struct twl4030_resconfig *resconfig;
-	u8 val, address = twl4030_start_script_address;
+	u8 val;
 
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG1,
 			       TWL4030_PM_MASTER_PROTECT_KEY);
@@ -525,23 +556,12 @@ int twl4030_power_probe(struct platform_device *pdev)
 	if (err)
 		goto unlock;
 
-	for (i = 0; i < pdata->num; i++) {
-		err = load_twl4030_script(pdata->scripts[i], address);
-		if (err)
-			goto load;
-		address += pdata->scripts[i]->size;
-	}
-
-	resconfig = pdata->resource_config;
-	if (resconfig) {
-		while (resconfig->resource) {
-			err = twl4030_configure_resource(resconfig);
-			if (err)
-				goto resource;
-			resconfig++;
-
-		}
-	}
+	err = twl4030_power_configure_scripts(pdata);
+	if (err)
+		goto load;
+	err = twl4030_power_configure_resources(pdata);
+	if (err)
+		goto resource;
 
 	/* Board has to be wired properly to use this feature */
 	if (pdata->use_poweroff && !pm_power_off) {
-- 
1.7.5.4
