From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 27 Apr 2013 10:29:25 +0400
Subject: [PATCH v2 2/2] regulator: mc13783: Add device tree probe support
In-Reply-To: <1367044165-6373-1-git-send-email-shc_work@mail.ru>
References: <1367044165-6373-1-git-send-email-shc_work@mail.ru>
Message-ID: <1367044165-6373-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds device tree probe support for mc13783-regulator driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/mfd/mc13xxx.txt | 36 +++++++++++++++++--
 drivers/regulator/mc13783-regulator.c             | 44 +++++++++++++++--------
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
index baf0798..abd9e3c 100644
--- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
+++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
@@ -10,10 +10,40 @@ Optional properties:
 - fsl,mc13xxx-uses-touch : Indicate the touchscreen controller is being used
 
 Sub-nodes:
-- regulators : Contain the regulator nodes.  The MC13892 regulators are
-  bound using their names as listed below with their registers and bits
-  for enabling.
+- regulators : Contain the regulator nodes. The regulators are bound using
+  their names as listed below with their registers and bits for enabling.
 
+MC13783 regulators:
+    sw1a      : regulator SW1A      (register 24, bit 0)
+    sw1b      : regulator SW1B      (register 25, bit 0)
+    sw2a      : regulator SW2A      (register 26, bit 0)
+    sw2b      : regulator SW2B      (register 27, bit 0)
+    sw3       : regulator SW3       (register 29, bit 20)
+    vaudio    : regulator VAUDIO    (register 32, bit 0)
+    viohi     : regulator VIOHI     (register 32, bit 3)
+    violo     : regulator VIOLO     (register 32, bit 6)
+    vdig      : regulator VDIG      (register 32, bit 9)
+    vgen      : regulator VGEN      (register 32, bit 12)
+    vrfdig    : regulator VRFDIG    (register 32, bit 15)
+    vrfref    : regulator VRFREF    (register 32, bit 18)
+    vrfcp     : regulator VRFCP     (register 32, bit 21)
+    vsim      : regulator VSIM      (register 33, bit 0)
+    vesim     : regulator VESIM     (register 33, bit 3)
+    vcam      : regulator VCAM      (register 33, bit 6)
+    vrfbg     : regulator VRFBG     (register 33, bit 9)
+    vvib      : regulator VVIB      (register 33, bit 11)
+    vrf1      : regulator VRF1      (register 33, bit 12)
+    vrf2      : regulator VRF2      (register 33, bit 15)
+    vmmc1     : regulator VMMC1     (register 33, bit 18)
+    vmmc2     : regulator VMMC2     (register 33, bit 21)
+    gpo1      : regulator GPO1      (register 34, bit 6)
+    gpo2      : regulator GPO2      (register 34, bit 8)
+    gpo3      : regulator GPO3      (register 34, bit 10)
+    gpo4      : regulator GPO4      (register 34, bit 12)
+    pwgt1spi  : regulator PWGT1SPI  (register 34, bit 15)
+    pwgt2spi  : regulator PWGT2SPI  (register 34, bit 16)
+
+MC13892 regulators:
     vcoincell : regulator VCOINCELL (register 13, bit 23)
     sw1       : regulator SW1	    (register 24, bit 0)
     sw2       : regulator SW2	    (register 25, bit 0)
diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index c46c670..fdf7f0a 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -398,33 +398,51 @@ static int mc13783_regulator_probe(struct platform_device *pdev)
 	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
 	struct mc13xxx_regulator_platform_data *pdata =
 		dev_get_platdata(&pdev->dev);
-	struct mc13xxx_regulator_init_data *init_data;
+	struct mc13xxx_regulator_init_data *mc13xxx_data;
 	struct regulator_config config = { };
-	int i, ret;
+	int i, ret, num_regulators;
 
-	dev_dbg(&pdev->dev, "%s id %d\n", __func__, pdev->id);
+	num_regulators = mc13xxx_get_num_regulators_dt(pdev);
 
-	if (!pdata)
+	if (num_regulators <= 0 && pdata)
+		num_regulators = pdata->num_regulators;
+	if (num_regulators <= 0)
 		return -EINVAL;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv) +
-			pdata->num_regulators * sizeof(priv->regulators[0]),
+			num_regulators * sizeof(priv->regulators[0]),
 			GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_regulators = num_regulators;
 	priv->mc13xxx_regulators = mc13783_regulators;
 	priv->mc13xxx = mc13783;
+	platform_set_drvdata(pdev, priv);
 
-	for (i = 0; i < pdata->num_regulators; i++) {
-		struct regulator_desc *desc;
+	mc13xxx_data = mc13xxx_parse_regulators_dt(pdev, mc13783_regulators,
+					ARRAY_SIZE(mc13783_regulators));
 
-		init_data = &pdata->regulators[i];
-		desc = &mc13783_regulators[init_data->id].desc;
+	for (i = 0; i < priv->num_regulators; i++) {
+		struct regulator_init_data *init_data;
+		struct regulator_desc *desc;
+		struct device_node *node = NULL;
+		int id;
+
+		if (mc13xxx_data) {
+			id = mc13xxx_data[i].id;
+			init_data = mc13xxx_data[i].init_data;
+			node = mc13xxx_data[i].node;
+		} else {
+			id = pdata->regulators[i].id;
+			init_data = pdata->regulators[i].init_data;
+		}
+		desc = &mc13783_regulators[id].desc;
 
 		config.dev = &pdev->dev;
-		config.init_data = init_data->init_data;
+		config.init_data = init_data;
 		config.driver_data = priv;
+		config.of_node = node;
 
 		priv->regulators[i] = regulator_register(desc, &config);
 		if (IS_ERR(priv->regulators[i])) {
@@ -435,8 +453,6 @@ static int mc13783_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	return 0;
 err:
 	while (--i >= 0)
@@ -448,13 +464,11 @@ err:
 static int mc13783_regulator_remove(struct platform_device *pdev)
 {
 	struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
-	struct mc13xxx_regulator_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
 	int i;
 
 	platform_set_drvdata(pdev, NULL);
 
-	for (i = 0; i < pdata->num_regulators; i++)
+	for (i = 0; i < priv->num_regulators; i++)
 		regulator_unregister(priv->regulators[i]);
 
 	return 0;
-- 
1.8.1.5
