From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Sep 2018 23:06:50 +0200
Subject: [PATCH 3/3] mfd: ti-lmu: use of_device_get_match_data() helper
In-Reply-To: <20180911210344.GB32497@amd>
References: <20180911210133.GA32497@amd>
 <20180911210344.GB32497@amd>
Message-ID: <20180911210650.GC32497@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace of_match_device() with of_device_get_match_data(), which
slightly decreases lines of code and allows to move the DT table
next to the I2C table.
    
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index de76298..ce16c89 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -142,34 +142,21 @@ TI_LMU_DATA(lm3633, LM3633_MAX_REG);
 TI_LMU_DATA(lm3695, LM3695_MAX_REG);
 TI_LMU_DATA(lm3697, LM3697_MAX_REG);
 
-static const struct of_device_id ti_lmu_of_match[] = {
-	{ .compatible = "ti,lm3532", .data = &lm3532_data },
-	{ .compatible = "ti,lm3631", .data = &lm3631_data },
-	{ .compatible = "ti,lm3632", .data = &lm3632_data },
-	{ .compatible = "ti,lm3633", .data = &lm3633_data },
-	{ .compatible = "ti,lm3695", .data = &lm3695_data },
-	{ .compatible = "ti,lm3697", .data = &lm3697_data },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
-
 static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 {
 	struct device *dev = &cl->dev;
-	const struct of_device_id *match;
 	const struct ti_lmu_data *data;
 	struct regmap_config regmap_cfg;
 	struct ti_lmu *lmu;
 	int ret;
 
-	match = of_match_device(ti_lmu_of_match, dev);
-	if (!match)
-		return -ENODEV;
 	/*
 	 * Get device specific data from of_match table.
 	 * This data is defined by using TI_LMU_DATA() macro.
 	 */
-	data = (struct ti_lmu_data *)match->data;
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
 
 	lmu = devm_kzalloc(dev, sizeof(*lmu), GFP_KERNEL);
 	if (!lmu)
@@ -217,6 +204,17 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 				    data->num_cells, NULL, 0, NULL);
 }
 
+static const struct of_device_id ti_lmu_of_match[] = {
+	{ .compatible = "ti,lm3532", .data = &lm3532_data },
+	{ .compatible = "ti,lm3631", .data = &lm3631_data },
+	{ .compatible = "ti,lm3632", .data = &lm3632_data },
+	{ .compatible = "ti,lm3633", .data = &lm3633_data },
+	{ .compatible = "ti,lm3695", .data = &lm3695_data },
+	{ .compatible = "ti,lm3697", .data = &lm3697_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
+
 static const struct i2c_device_id ti_lmu_ids[] = {
 	{ "lm3532", LM3532 },
 	{ "lm3631", LM3631 },


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180911/a58e887f/attachment.sig>
