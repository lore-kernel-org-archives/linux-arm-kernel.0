From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue, 22 Apr 2014 16:54:30 +0530
Subject: [PATCH v6 2/2] phy: exynos5-usbdrd: Add facility for VBUS supply
In-Reply-To: <1398165871-20326-1-git-send-email-gautam.vivek@samsung.com>
References: <1398165871-20326-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1398165871-20326-2-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding support to enable/disable VBUS controlled by a
regulator, to enable vbus supply on the port.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

Mistakenly sent a WIP patchset in v5 version of this patch, that gives
build errors. So fixed those.

Changes from v5:
 - Removed any mention about sclk_usbphy30* in the driver.

 drivers/phy/phy-exynos5-usbdrd.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
index ca1f6ab..ad94c98 100644
--- a/drivers/phy/phy-exynos5-usbdrd.c
+++ b/drivers/phy/phy-exynos5-usbdrd.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 /* Exynos USB PHY registers */
 #define EXYNOS5_FSEL_9MHZ6		0x0
@@ -171,6 +172,7 @@ struct exynos5_usbdrd_phy {
 	unsigned int extrefclk;
 	struct clk *ref_clk;
 	unsigned long ref_rate;
+	struct regulator *vbus;
 };
 
 #define to_usbdrd_phy(inst) \
@@ -441,6 +443,7 @@ static int exynos5_usbdrd_phy_exit(struct phy *phy)
 
 static int exynos5_usbdrd_phy_power_on(struct phy *phy)
 {
+	int ret;
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
@@ -448,10 +451,24 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
 
 	clk_prepare_enable(phy_drd->ref_clk);
 
+	/* Enable VBUS supply */
+	if (phy_drd->vbus) {
+		ret = regulator_enable(phy_drd->vbus);
+		if (ret) {
+			dev_err(phy_drd->dev, "Failed to enable VBUS supply\n");
+			goto fail_vbus;
+		}
+	}
+
 	/* Power-on PHY*/
 	inst->phy_cfg->phy_isol(inst, 0);
 
 	return 0;
+
+fail_vbus:
+	clk_disable_unprepare(phy_drd->ref_clk);
+
+	return ret;
 }
 
 static int exynos5_usbdrd_phy_power_off(struct phy *phy)
@@ -464,6 +481,10 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
 	/* Power-off the PHY */
 	inst->phy_cfg->phy_isol(inst, 1);
 
+	/* Disable VBUS supply */
+	if (phy_drd->vbus)
+		regulator_disable(phy_drd->vbus);
+
 	clk_disable_unprepare(phy_drd->ref_clk);
 
 	return 0;
@@ -534,7 +555,7 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 	const struct exynos5_usbdrd_phy_drvdata *drv_data;
 	struct regmap *reg_pmu;
 	u32 pmu_offset;
-	int i;
+	int i, ret;
 
 	phy_drd = devm_kzalloc(dev, sizeof(*phy_drd), GFP_KERNEL);
 	if (!phy_drd)
@@ -577,6 +598,17 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(reg_pmu);
 	}
 
+	/* Get required GPIO for vbus */
+	phy_drd->vbus = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(phy_drd->vbus)) {
+		ret = PTR_ERR(phy_drd->vbus);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_warn(dev, "Failed to get VBUS supply regulator\n");
+		phy_drd->vbus = NULL;
+	}
+
 	if (of_property_read_u32(node, "samsung,pmu-offset", &pmu_offset)) {
 		dev_err(dev, "Missing pmu-offset for phy isolation\n");
 		return -EINVAL;
-- 
1.7.10.4
