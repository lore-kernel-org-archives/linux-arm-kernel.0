From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Nov 2014 00:07:17 +0100
Subject: [PATCHv1 5/6] rtc: rtc-isl12057: report error code upon failure in
 dev_err() calls
In-Reply-To: <cover.1416006090.git.arno@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
Message-ID: <7ff908c71200e28b65afbcca1a183233246803cf.1416006090.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


As pointed by Mark, it is generally useful to log the error code when
reporting a failure. This patch improves existing calls to dev_err()
in ISL12057 driver to also report error code.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/rtc/rtc-isl12057.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index 31eaa6a9c2b2..a783e16cfd2f 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -170,8 +170,8 @@ static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	mutex_lock(&data->lock);
 	ret = regmap_read(data->regmap, ISL12057_REG_SR, &sr);
 	if (ret) {
-		dev_err(dev, "%s: unable to read oscillator status flag\n",
-			__func__);
+		dev_err(dev, "%s: unable to read oscillator status flag (%d)\n",
+			__func__, ret);
 		goto out;
 	} else {
 		if (sr & ISL12057_REG_SR_OSF) {
@@ -183,7 +183,8 @@ static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
 			       ISL12057_RTC_SEC_LEN);
 	if (ret)
-		dev_err(dev, "%s: unable to read RTC time\n", __func__);
+		dev_err(dev, "%s: unable to read RTC time section (%d)\n",
+			__func__, ret);
 
 out:
 	mutex_unlock(&data->lock);
@@ -210,7 +211,8 @@ static int isl12057_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	ret = regmap_bulk_write(data->regmap, ISL12057_REG_RTC_SC, regs,
 				ISL12057_RTC_SEC_LEN);
 	if (ret) {
-		dev_err(dev, "%s: writing RTC time failed\n", __func__);
+		dev_err(dev, "%s: unable to write RTC time section (%d)\n",
+			__func__, ret);
 		goto out;
 	}
 
@@ -221,7 +223,8 @@ static int isl12057_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	ret = regmap_update_bits(data->regmap, ISL12057_REG_SR,
 				 ISL12057_REG_SR_OSF, 0);
 	if (ret < 0)
-		dev_err(dev, "Unable to clear oscillator failure bit\n");
+		dev_err(dev, "%s: unable to clear osc. failure bit (%d)\n",
+			__func__, ret);
 
 out:
 	mutex_unlock(&data->lock);
@@ -242,7 +245,8 @@ static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
 	ret = regmap_update_bits(regmap, ISL12057_REG_INT,
 				 ISL12057_REG_INT_EOSC, 0);
 	if (ret < 0) {
-		dev_err(dev, "Unable to enable oscillator\n");
+		dev_err(dev, "%s: unable to enable oscillator (%d)\n",
+			__func__, ret);
 		return ret;
 	}
 
@@ -250,7 +254,8 @@ static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
 	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
 				 ISL12057_REG_SR_A1F, 0);
 	if (ret < 0) {
-		dev_err(dev, "Unable to clear alarm bit\n");
+		dev_err(dev, "%s: unable to clear alarm bit (%d)\n",
+			__func__, ret);
 		return ret;
 	}
 
@@ -284,7 +289,8 @@ static int isl12057_probe(struct i2c_client *client,
 	regmap = devm_regmap_init_i2c(client, &isl12057_rtc_regmap_config);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
-		dev_err(dev, "regmap allocation failed: %d\n", ret);
+		dev_err(dev, "%s: regmap allocation failed (%d)\n",
+			__func__, ret);
 		return ret;
 	}
 
-- 
2.1.1
