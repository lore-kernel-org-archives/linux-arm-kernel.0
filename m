From: stefan@agner.ch (Stefan Agner)
Date: Tue,  7 Jun 2016 18:04:28 -0700
Subject: [PATCH v2 4/5] mfd: rn5t618: register power off callback optionally
In-Reply-To: <20160608010429.19618-1-stefan@agner.ch>
References: <20160608010429.19618-1-stefan@agner.ch>
Message-ID: <20160608010429.19618-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only register power off if the PMIC is defined as system power
controller (see Documentation/devicetree/bindings/power/
power-controller.txt).

Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mfd/rn5t618.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 7607ced..d9b4d40 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -103,9 +103,13 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (!pm_power_off) {
-		rn5t618_pm_power_off = priv;
-		pm_power_off = rn5t618_power_off;
+	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
+		if (!pm_power_off) {
+			rn5t618_pm_power_off = priv;
+			pm_power_off = rn5t618_power_off;
+		} else {
+			dev_err(&i2c->dev, "Failed to set poweroff capability, already defined\n");
+		}
 	}
 
 	return 0;
-- 
2.8.3
