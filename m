From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 16 Nov 2018 17:24:02 +0100
Subject: [PATCH v2 16/17] power: supply: olpc_battery: Avoid using
 platform_info
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Message-ID: <20181116162403.49854-17-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This wouldn't work on the DT-based ARM platform. Let's read the EC version
directly from the EC driver instead.

This makes the driver no longer x86 specific.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Use uint8_t instead of unsigned char [1] for ecver

 drivers/power/supply/Kconfig        |  2 +-
 drivers/power/supply/olpc_battery.c | 35 +++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f27cf0709500..dd7ae1431098 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -151,7 +151,7 @@ config BATTERY_PMU
 
 config BATTERY_OLPC
 	tristate "One Laptop Per Child battery"
-	depends on X86_32 && OLPC
+	depends on OLPC
 	help
 	  Say Y to enable support for the battery on the OLPC laptop.
 
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 4433eb10a23d..ec5dfb8fcb8a 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -20,8 +20,6 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
-
 
 #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
 #define EC_BAT_CURRENT	0x11	/* int16_t,	*15.625/120, mA   */
@@ -57,6 +55,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_ac;
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
+	int new_proto;
 };
 
 /*********************************************************************
@@ -100,7 +99,7 @@ static const struct power_supply_desc olpc_ac_desc = {
 static int olpc_bat_get_status(struct olpc_battery_data *data,
 		union power_supply_propval *val, uint8_t ec_byte)
 {
-	if (olpc_platform_info.ecver > 0x44) {
+	if (data->new_proto) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (ec_byte & BAT_STAT_DISCHARGING)
@@ -608,14 +607,32 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	struct power_supply_config psy_cfg = {};
 	struct olpc_battery_data *data;
 	uint8_t status;
+	uint8_t ecver;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, data);
+
+	/* See if the EC is already there and get the EC revision */
+	ret = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
+	if (ret) {
+		if (ret == -ENODEV)
+			return -EPROBE_DEFER;
+		return ret;
+	}
 
-	/*
-	 * We've seen a number of EC protocol changes; this driver requires
-	 * the latest EC protocol, supported by 0x44 and above.
-	 */
-	if (olpc_platform_info.ecver < 0x44) {
+	if (ecver > 0x44) {
+		/* XO 1 or 1.5 with a new EC firmware. */
+		data->new_proto = 1;
+	} else if (ecver < 0x44) {
+		/*
+		 * We've seen a number of EC protocol changes; this driver
+		 * requires the latest EC protocol, supported by 0x44 and above.
+		 */
 		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
-			"battery driver.\n", olpc_platform_info.ecver);
+			"battery driver.\n", ecver);
 		return -ENXIO;
 	}
 
-- 
2.19.1
