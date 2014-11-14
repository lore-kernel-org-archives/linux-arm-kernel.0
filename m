From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Nov 2014 00:06:53 +0100
Subject: [PATCHv1 3/6] rtc: rtc-isl12057: add proper handling of oscillator
 failure bit
In-Reply-To: <cover.1416006090.git.arno@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
Message-ID: <2bf30d76514c212644453be840ee2379c0f97ea8.1416006090.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


As suggested by Uwe, instead of clearing oscillator failure bit
unconditionally at driver load, this patch adds proper handling
of the flag. The driver now returns -ENODATA when reading time
from the device and oscillator failure bit is set. The flag
is now cleared only when the a new time value is pushed to the
device.

Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/rtc/rtc-isl12057.c | 47 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index b538fabfcfd3..fe562820a54a 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -164,17 +164,32 @@ static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
 	u8 regs[ISL12057_RTC_SEC_LEN];
+	unsigned int sr;
 	int ret;
 
 	mutex_lock(&data->lock);
+	ret = regmap_read(data->regmap, ISL12057_REG_SR, &sr);
+	if (ret) {
+		dev_err(dev, "%s: unable to read oscillator status flag\n",
+			__func__);
+		goto out;
+	} else {
+		if (sr & ISL12057_REG_SR_OSF) {
+			ret = -ENODATA;
+			goto out;
+		}
+	}
+
 	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
 			       ISL12057_RTC_SEC_LEN);
+	if (ret)
+		dev_err(dev, "%s: unable to read RTC time\n", __func__);
+
+out:
 	mutex_unlock(&data->lock);
 
-	if (ret) {
-		dev_err(dev, "%s: RTC read failed\n", __func__);
+	if (ret)
 		return ret;
-	}
 
 	isl12057_rtc_regs_to_tm(tm, regs);
 
@@ -194,10 +209,22 @@ static int isl12057_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	mutex_lock(&data->lock);
 	ret = regmap_bulk_write(data->regmap, ISL12057_REG_RTC_SC, regs,
 				ISL12057_RTC_SEC_LEN);
-	mutex_unlock(&data->lock);
+	if (ret) {
+		dev_err(dev, "%s: writing RTC time failed\n", __func__);
+		goto out;
+	}
 
-	if (ret)
-		dev_err(dev, "%s: RTC write failed\n", __func__);
+	/*
+	 * Now that RTC time has been updated, let's clear oscillator
+	 * failure flag, if needed.
+	 */
+	ret = regmap_update_bits(data->regmap, ISL12057_REG_SR,
+				 ISL12057_REG_SR_OSF, 0);
+	if (ret < 0)
+		dev_err(dev, "Unable to clear oscillator failure bit\n");
+
+out:
+	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -219,14 +246,6 @@ static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
-	/* Clear oscillator failure bit if needed */
-	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
-				 ISL12057_REG_SR_OSF, 0);
-	if (ret < 0) {
-		dev_err(dev, "Unable to clear oscillator failure bit\n");
-		return ret;
-	}
-
 	/* Clear alarm bit if needed */
 	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
 				 ISL12057_REG_SR_A1F, 0);
-- 
2.1.1
