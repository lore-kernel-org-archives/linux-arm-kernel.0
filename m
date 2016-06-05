From: stefan@agner.ch (Stefan Agner)
Date: Sat,  4 Jun 2016 17:17:49 -0700
Subject: [PATCH 5/5] mfd: rn5t618: register restart handler
In-Reply-To: <20160605001749.4062-1-stefan@agner.ch>
References: <20160605001749.4062-1-stefan@agner.ch>
Message-ID: <20160605001749.4062-7-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the PMIC's repower capability for reboots. Register a restart
handler with use a default priority of 128.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mfd/rn5t618.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index d9b4d40..d9bd61c 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -12,13 +12,17 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/rn5t618.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 
+#include <asm/system_misc.h>
+
 static const struct mfd_cell rn5t618_cells[] = {
 	{ .name = "rn5t618-regulator" },
 	{ .name = "rn5t618-wdt" },
@@ -50,17 +54,34 @@ static const struct regmap_config rn5t618_regmap_config = {
 };
 
 static struct rn5t618 *rn5t618_pm_power_off;
+static struct notifier_block rn5t618_restart_handler;
 
-static void rn5t618_power_off(void)
+static void rn5t618_trigger_poweroff_sequence(bool repower)
 {
 	/* disable automatic repower-on */
 	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_REPCNT,
-			   RN5T618_REPCNT_REPWRON, 0);
+			   RN5T618_REPCNT_REPWRON, repower);
 	/* start power-off sequence */
 	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_SLPCNT,
 			   RN5T618_SLPCNT_SWPWROFF, RN5T618_SLPCNT_SWPWROFF);
 }
 
+static void rn5t618_power_off(void)
+{
+	rn5t618_trigger_poweroff_sequence(false);
+}
+
+static int rn5t618_restart(struct notifier_block *this,
+			    unsigned long mode, void *cmd)
+{
+	rn5t618_trigger_poweroff_sequence(true);
+
+	mdelay(10);
+
+	return NOTIFY_DONE;
+}
+
+
 static const struct of_device_id rn5t618_of_match[] = {
 	{ .compatible = "ricoh,rn5t567", .data = (void *)RN5T567 },
 	{ .compatible = "ricoh,rn5t618", .data = (void *)RN5T618 },
@@ -103,13 +124,22 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	rn5t618_pm_power_off = priv;
 	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
-		if (!pm_power_off) {
-			rn5t618_pm_power_off = priv;
+		if (!pm_power_off)
 			pm_power_off = rn5t618_power_off;
-		} else {
+		else
 			dev_err(&i2c->dev, "Failed to set poweroff capability, already defined\n");
-		}
+	}
+
+	rn5t618_restart_handler.notifier_call = rn5t618_restart;
+	rn5t618_restart_handler.priority = 128;
+
+	ret = register_restart_handler(&rn5t618_restart_handler);
+	if (ret) {
+		dev_err(&i2c->dev, "%s: cannot register restart handler, %d\n",
+				__func__, ret);
+		return ret;
 	}
 
 	return 0;
-- 
2.8.3
