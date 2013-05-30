From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 30 May 2013 15:51:56 +0200
Subject: [PATCH 3/3] mfd: twl4030-power: Simplify error path
In-Reply-To: <1369921916-7435-1-git-send-email-florian.vaussard@epfl.ch>
References: <1369921916-7435-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1369921916-7435-4-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary goto statements, causing duplicated if
conditions.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/mfd/twl4030-power.c |   37 ++++++++++++++-----------------------
 1 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index d12d748..7eed526 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -567,21 +567,25 @@ int twl4030_power_probe(struct platform_device *pdev)
 
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG1,
 			       TWL4030_PM_MASTER_PROTECT_KEY);
-	if (err)
-		goto unlock;
-
-	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG2,
+	err |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG2,
 			       TWL4030_PM_MASTER_PROTECT_KEY);
-	if (err)
-		goto unlock;
+
+	if (err) {
+		pr_err("TWL4030 Unable to unlock registers\n");
+		return err;
+	}
 
 	if (pdata) {
 		err = twl4030_power_configure_scripts(pdata);
-		if (err)
-			goto load;
+		if (err) {
+			pr_err("TWL4030 failed to load scripts\n");
+			return err;
+		}
 		err = twl4030_power_configure_resources(pdata);
-		if (err)
-			goto resource;
+		if (err) {
+			pr_err("TWL4030 failed to configure resource\n");
+			return err;
+		}
 	}
 
 	/* Board has to be wired properly to use this feature */
@@ -611,19 +615,6 @@ relock:
 	if (err)
 		pr_err("TWL4030 Unable to relock registers\n");
 	return err;
-
-unlock:
-	if (err)
-		pr_err("TWL4030 Unable to unlock registers\n");
-	return err;
-load:
-	if (err)
-		pr_err("TWL4030 failed to load scripts\n");
-	return err;
-resource:
-	if (err)
-		pr_err("TWL4030 failed to configure resource\n");
-	return err;
 }
 
 static int twl4030_power_remove(struct platform_device *pdev)
-- 
1.7.5.4
