From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Jan 2015 23:39:05 +0800
Subject: [PATCH v9 3/5] regulators: axp20x: Use "clock-frequency" property for
 dcdc work frequency
In-Reply-To: <1421941147-9682-1-git-send-email-wens@csie.org>
References: <1421941147-9682-1-git-send-email-wens@csie.org>
Message-ID: <1421941147-9682-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the dcdc regulator work frequency is a property of the regulators
DT sub-tree, there is no issue of naming collisions, so we can use the
standard "clock-frequency" binding for this.

The driver sets a reasonable default value (same as the datasheet), and
only 1 dts has the old binding, with the default value.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e4331f5e5d7d..990ac453abc8 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -186,8 +186,10 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 	if (!regulators) {
 		dev_warn(&pdev->dev, "regulators node not found\n");
 	} else {
-		dcdcfreq = 1500;
-		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
+		dcdcfreq = 1500000;
+		of_property_read_u32(regulators, "clock-frequency", &dcdcfreq);
+		/* axp20x_set_dcdc_freq() takes kHZ */
+		dcdcfreq /= 1000;
 		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
-- 
2.1.4
