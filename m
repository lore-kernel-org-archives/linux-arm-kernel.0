From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 22 Sep 2016 19:25:23 +0200
Subject: [PATCH v3 2/4] regulator: axp20x: duplicate the MFD axp20x-rsb code
In-Reply-To: <cover.1474621107.git.moinejf@free.fr>
References: <cover.1474621107.git.moinejf@free.fr>
Message-ID: <db01bc189cca1f6a5b90cbeebc8d4dc1119cb91c.1474621107.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp20x rsb driver handles many different devices.
Duplicating its code in a generic regulator driver permits
to probe/remove individual devices.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/regulator/axp-regulator.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/regulator/axp-regulator.h |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/regulator/axp-regulator.c b/drivers/regulator/axp-regulator.c
index 0d7adb6..17943fb 100644
--- a/drivers/regulator/axp-regulator.c
+++ b/drivers/regulator/axp-regulator.c
@@ -303,6 +303,45 @@ int axp_regulator_create(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(axp_regulator_create);
 
+/* probe/remove RSB devices */
+int axp_rsb_probe(struct sunxi_rsb_device *rdev,
+		  struct axp20x_dev *axp20x,
+		  const struct axp_cfg *axp_cfg)
+{
+	int ret;
+
+	axp20x->dev = &rdev->dev;
+	axp20x->irq = rdev->irq;
+	dev_set_drvdata(&rdev->dev, axp20x);
+
+	ret = axp20x_match_device(axp20x);
+	if (ret)
+		return ret;
+
+	axp20x->regmap = devm_regmap_init_sunxi_rsb(rdev,
+						    axp20x->regmap_cfg);
+	if (IS_ERR(axp20x->regmap)) {
+		ret = PTR_ERR(axp20x->regmap);
+		dev_err(&rdev->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = axp20x_device_probe(axp20x);
+	if (ret < 0)
+		return ret;
+
+	return axp_regulator_create(&rdev->dev, axp_cfg);
+}
+EXPORT_SYMBOL_GPL(axp_rsb_probe);
+
+int axp_rsb_remove(struct sunxi_rsb_device *rdev)
+{
+	struct axp20x_dev *axp20x = sunxi_rsb_device_get_drvdata(rdev);
+
+	return axp20x_device_remove(axp20x);
+}
+EXPORT_SYMBOL_GPL(axp_rsb_remove);
+
 MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
 MODULE_DESCRIPTION("Regulator Module for AXP PMIC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/axp-regulator.h b/drivers/regulator/axp-regulator.h
index 0adf1b0..085eaa0 100644
--- a/drivers/regulator/axp-regulator.h
+++ b/drivers/regulator/axp-regulator.h
@@ -124,4 +124,10 @@ struct axp_cfg {
 int axp_regulator_create(struct device *dev,
 			 const struct axp_cfg *axp_cfg);
 
+struct sunxi_rsb_device;
+int axp_rsb_probe(struct sunxi_rsb_device *rdev,
+		  struct axp20x_dev *axp20x,
+		  const struct axp_cfg *axp_cfg);
+int axp_rsb_remove(struct sunxi_rsb_device *rdev);
+
 #endif /* __AXP_REGULATOR_H__ */
-- 
2.10.0
