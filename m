From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Tue, 4 Dec 2012 17:49:22 +0530
Subject: [PATCH 1/2 v2] ab8500: Remove initial "UNKNOWN" battery-type string
 assignment
Message-ID: <1354623562-4712-1-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

DT property 'stericsson,battery-type' shall be one of
supported technology type

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
---
 drivers/power/ab8500_bmdata.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/ab8500_bmdata.c
index 03cc528..2230b2c 100644
--- a/drivers/power/ab8500_bmdata.c
+++ b/drivers/power/ab8500_bmdata.c
@@ -461,7 +461,6 @@ bmdevs_of_probe(struct device *dev,
 	struct  device_node *np_bat_supply;
 	struct	abx500_bm_data *bat;
 	const char *btech;
-	char bat_tech[8];
 	int i, thermistor;
 
 	*battery = &ab8500_bm_data;
@@ -488,12 +487,10 @@ bmdevs_of_probe(struct device *dev,
 		"stericsson,battery-type", NULL);
 	if (!btech) {
 		dev_warn(dev, "missing property battery-name/type\n");
-		strcpy(bat_tech, "UNKNOWN");
-	} else {
-		strcpy(bat_tech, btech);
+		of_node_put(np_bat_supply);
+		return -EINVAL;
 	}
-
-	if (strncmp(bat_tech, "LION", 4) == 0) {
+	if (strncmp(btech, "LION", 4) == 0) {
 		bat->no_maintenance  = true;
 		bat->chg_unknown_bat = true;
 		bat->bat_type[BATTERY_UNKNOWN].charge_full_design = 2600;
@@ -508,7 +505,7 @@ bmdevs_of_probe(struct device *dev,
 		if (thermistor == NTC_EXTERNAL) {
 			btype->batres_tbl =
 				temp_to_batres_tbl_ext_thermistor;
-		} else if (strncmp(bat_tech, "LION", 4) == 0) {
+		} else if (strncmp(btech, "LION", 4) == 0) {
 			btype->batres_tbl =
 				temp_to_batres_tbl_9100;
 		} else {
-- 
1.7.10.4
