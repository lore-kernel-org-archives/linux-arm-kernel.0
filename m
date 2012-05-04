From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:24 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device Tree
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we setup the ab8500 regulator driver for DT. We first do
this in the normal way, by providing a match structure during
initialisation, but then we provide information so that
whilst probing we can use existing data structures to do DT
look-ups. We do that by embedding DT property names into
ab8500_reg_init, so that we may look-up initial register data
values directly.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |  129 ++++++++++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index e403a0f..67de2a6 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -18,9 +18,12 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
+#include <linux/of.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/ab8500.h>
+#include <linux/slab.h>
 
 /**
  * struct ab8500_regulator_info - ab8500 regulator information
@@ -556,16 +559,18 @@ static struct ab8500_regulator_info
 };
 
 struct ab8500_reg_init {
+	const char *of_name;
 	u8 bank;
 	u8 addr;
 	u8 mask;
 };
 
-#define REG_INIT(_id, _bank, _addr, _mask)	\
-	[_id] = {				\
-		.bank = _bank,			\
-		.addr = _addr,			\
-		.mask = _mask,			\
+#define REG_INIT(_id, _of_name, _bank, _addr, _mask)	\
+	[_id] = {					\
+		.bank    = _bank,			\
+		.of_name = _of_name,			\
+		.addr    = _addr,			\
+		.mask    = _mask,			\
 	}
 
 static struct ab8500_reg_init ab8500_reg_init[] = {
@@ -574,63 +579,63 @@ static struct ab8500_reg_init ab8500_reg_init[] = {
 	 * 0x0C, VpllRequestCtrl
 	 * 0xc0, VextSupply1RequestCtrl
 	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL2,	0x03, 0x04, 0xfc),
+	REG_INIT(AB8500_REGUREQUESTCTRL2, "stericsson,regurequestctrl2", 0x03, 0x04, 0xfc),
 	/*
 	 * 0x03, VextSupply2RequestCtrl
 	 * 0x0c, VextSupply3RequestCtrl
 	 * 0x30, Vaux1RequestCtrl
 	 * 0xc0, Vaux2RequestCtrl
 	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL3,	0x03, 0x05, 0xff),
+	REG_INIT(AB8500_REGUREQUESTCTRL3, "stericsson,regurequestctrl3", 0x03, 0x05, 0xff),
 	/*
 	 * 0x03, Vaux3RequestCtrl
 	 * 0x04, SwHPReq
 	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
+	REG_INIT(AB8500_REGUREQUESTCTRL4, "stericsson,regurequestctrl4", 0x03, 0x06, 0x07),
 	/*
 	 * 0x08, VanaSysClkReq1HPValid
 	 * 0x20, Vaux1SysClkReq1HPValid
 	 * 0x40, Vaux2SysClkReq1HPValid
 	 * 0x80, Vaux3SysClkReq1HPValid
 	 */
-	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xe8),
+	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID1,"stericsson,regusysclkreq1hpvalid1", 0x03, 0x07, 0xe8),
 	/*
 	 * 0x10, VextSupply1SysClkReq1HPValid
 	 * 0x20, VextSupply2SysClkReq1HPValid
 	 * 0x40, VextSupply3SysClkReq1HPValid
 	 */
-	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x70),
+	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID2,	 "stericsson,regusysclkreq1hpvalid2", 0x03, 0x08, 0x70),
 	/*
 	 * 0x08, VanaHwHPReq1Valid
 	 * 0x20, Vaux1HwHPReq1Valid
 	 * 0x40, Vaux2HwHPReq1Valid
 	 * 0x80, Vaux3HwHPReq1Valid
 	 */
-	REG_INIT(AB8500_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xe8),
+	REG_INIT(AB8500_REGUHWHPREQ1VALID1, "stericsson,reguhwhpreq1valid1", 0x03, 0x09, 0xe8),
 	/*
 	 * 0x01, VextSupply1HwHPReq1Valid
 	 * 0x02, VextSupply2HwHPReq1Valid
 	 * 0x04, VextSupply3HwHPReq1Valid
 	 */
-	REG_INIT(AB8500_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x07),
+	REG_INIT(AB8500_REGUHWHPREQ1VALID2, "stericsson,reguhwhpreq1valid2", 0x03, 0x0a, 0x07),
 	/*
 	 * 0x08, VanaHwHPReq2Valid
 	 * 0x20, Vaux1HwHPReq2Valid
 	 * 0x40, Vaux2HwHPReq2Valid
 	 * 0x80, Vaux3HwHPReq2Valid
 	 */
-	REG_INIT(AB8500_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xe8),
+	REG_INIT(AB8500_REGUHWHPREQ2VALID1, "stericsson,reguhwhpreq2valid1", 0x03, 0x0b, 0xe8),
 	/*
 	 * 0x01, VextSupply1HwHPReq2Valid
 	 * 0x02, VextSupply2HwHPReq2Valid
 	 * 0x04, VextSupply3HwHPReq2Valid
 	 */
-	REG_INIT(AB8500_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x07),
+	REG_INIT(AB8500_REGUHWHPREQ2VALID2, "stericsson,reguhwhpreq2valid2", 0x03, 0x0c, 0x07),
 	/*
 	 * 0x20, VanaSwHPReqValid
 	 * 0x80, Vaux1SwHPReqValid
 	 */
-	REG_INIT(AB8500_REGUSWHPREQVALID1,	0x03, 0x0d, 0xa0),
+	REG_INIT(AB8500_REGUSWHPREQVALID1, "stericsson,reguswhpreqvalid1", 0x03, 0x0d, 0xa0),
 	/*
 	 * 0x01, Vaux2SwHPReqValid
 	 * 0x02, Vaux3SwHPReqValid
@@ -638,19 +643,19 @@ static struct ab8500_reg_init ab8500_reg_init[] = {
 	 * 0x08, VextSupply2SwHPReqValid
 	 * 0x10, VextSupply3SwHPReqValid
 	 */
-	REG_INIT(AB8500_REGUSWHPREQVALID2,	0x03, 0x0e, 0x1f),
+	REG_INIT(AB8500_REGUSWHPREQVALID2, "stericsson,reguswhpreqvalid2", 0x03, 0x0e, 0x1f),
 	/*
 	 * 0x02, SysClkReq2Valid1
 	 * ...
 	 * 0x80, SysClkReq8Valid1
 	 */
-	REG_INIT(AB8500_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0xfe),
+	REG_INIT(AB8500_REGUSYSCLKREQVALID1, "stericsson,regusysclkreqvalid1", 0x03, 0x0f, 0xfe),
 	/*
 	 * 0x02, SysClkReq2Valid2
 	 * ...
 	 * 0x80, SysClkReq8Valid2
 	 */
-	REG_INIT(AB8500_REGUSYSCLKREQVALID2,	0x03, 0x10, 0xfe),
+	REG_INIT(AB8500_REGUSYSCLKREQVALID2, "stericsson,regusysclkreqvalid2", 0x03, 0x10, 0xfe),
 	/*
 	 * 0x02, VTVoutEna
 	 * 0x04, Vintcore12Ena
@@ -658,29 +663,29 @@ static struct ab8500_reg_init ab8500_reg_init[] = {
 	 * 0x40, Vintcore12LP
 	 * 0x80, VTVoutLP
 	 */
-	REG_INIT(AB8500_REGUMISC1,		0x03, 0x80, 0xfe),
+	REG_INIT(AB8500_REGUMISC1, "stericsson,regumisc1", 0x03, 0x80, 0xfe),
 	/*
 	 * 0x02, VaudioEna
 	 * 0x04, VdmicEna
 	 * 0x08, Vamic1Ena
 	 * 0x10, Vamic2Ena
 	 */
-	REG_INIT(AB8500_VAUDIOSUPPLY,		0x03, 0x83, 0x1e),
+	REG_INIT(AB8500_VAUDIOSUPPLY, "stericsson,vaudiosupply", 0x03, 0x83, 0x1e),
 	/*
 	 * 0x01, Vamic1_dzout
 	 * 0x02, Vamic2_dzout
 	 */
-	REG_INIT(AB8500_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
+	REG_INIT(AB8500_REGUCTRL1VAMIC, "stericsson,reguctrl1vamic", 0x03, 0x84, 0x03),
 	/*
 	 * 0x0c, VanaRegu
 	 * 0x03, VpllRegu
 	 */
-	REG_INIT(AB8500_VPLLVANAREGU,		0x04, 0x06, 0x0f),
+	REG_INIT(AB8500_VPLLVANAREGU, "stericsson,vpllvanaregu", 0x04, 0x06, 0x0f),
 	/*
 	 * 0x01, VrefDDREna
 	 * 0x02, VrefDDRSleepMode
 	 */
-	REG_INIT(AB8500_VREFDDR,		0x04, 0x07, 0x03),
+	REG_INIT(AB8500_VREFDDR, "stericsson,vrefddr", 0x04, 0x07, 0x03),
 	/*
 	 * 0x03, VextSupply1Regu
 	 * 0x0c, VextSupply2Regu
@@ -688,36 +693,36 @@ static struct ab8500_reg_init ab8500_reg_init[] = {
 	 * 0x40, ExtSupply2Bypass
 	 * 0x80, ExtSupply3Bypass
 	 */
-	REG_INIT(AB8500_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
+	REG_INIT(AB8500_EXTSUPPLYREGU, "stericsson,extsupplyregu", 0x04, 0x08, 0xff),
 	/*
 	 * 0x03, Vaux1Regu
 	 * 0x0c, Vaux2Regu
 	 */
-	REG_INIT(AB8500_VAUX12REGU,		0x04, 0x09, 0x0f),
+	REG_INIT(AB8500_VAUX12REGU, "stericsson,vaux12regu", 0x04, 0x09, 0x0f),
 	/*
 	 * 0x03, Vaux3Regu
 	 */
-	REG_INIT(AB8500_VRF1VAUX3REGU,		0x04, 0x0a, 0x03),
+	REG_INIT(AB8500_VRF1VAUX3REGU, "stericsson,vrf1vaux3regu", 0x04, 0x0a, 0x03),
 	/*
 	 * 0x3f, Vsmps1Sel1
 	 */
-	REG_INIT(AB8500_VSMPS1SEL1,		0x04, 0x13, 0x3f),
+	REG_INIT(AB8500_VSMPS1SEL1, "stericsson,vsmps1sel1", 0x04, 0x13, 0x3f),
 	/*
 	 * 0x0f, Vaux1Sel
 	 */
-	REG_INIT(AB8500_VAUX1SEL,		0x04, 0x1f, 0x0f),
+	REG_INIT(AB8500_VAUX1SEL, "stericsson,vaux1sel", 0x04, 0x1f, 0x0f),
 	/*
 	 * 0x0f, Vaux2Sel
 	 */
-	REG_INIT(AB8500_VAUX2SEL,		0x04, 0x20, 0x0f),
+	REG_INIT(AB8500_VAUX2SEL, "stericsson,vaux2sel", 0x04, 0x20, 0x0f),
 	/*
 	 * 0x07, Vaux3Sel
 	 */
-	REG_INIT(AB8500_VRF1VAUX3SEL,		0x04, 0x21, 0x07),
+	REG_INIT(AB8500_VRF1VAUX3SEL, "stericsson,vrf1vaux3sel", 0x04, 0x21, 0x07),
 	/*
 	 * 0x01, VextSupply12LP
 	 */
-	REG_INIT(AB8500_REGUCTRL2SPARE,		0x04, 0x22, 0x01),
+	REG_INIT(AB8500_REGUCTRL2SPARE, "stericsson,reguctrl2spare", 0x04, 0x22, 0x01),
 	/*
 	 * 0x04, Vaux1Disch
 	 * 0x08, Vaux2Disch
@@ -726,13 +731,13 @@ static struct ab8500_reg_init ab8500_reg_init[] = {
 	 * 0x40, VTVoutDisch
 	 * 0x80, VaudioDisch
 	 */
-	REG_INIT(AB8500_REGUCTRLDISCH,		0x04, 0x43, 0xfc),
+	REG_INIT(AB8500_REGUCTRLDISCH, "stericsson,reguctrldisch", 0x04, 0x43, 0xfc),
 	/*
 	 * 0x02, VanaDisch
 	 * 0x04, VdmicPullDownEna
 	 * 0x10, VdmicDisch
 	 */
-	REG_INIT(AB8500_REGUCTRLDISCH2,		0x04, 0x44, 0x16),
+	REG_INIT(AB8500_REGUCTRLDISCH2, "stericsson,reguctrldisch2", 0x04, 0x44, 0x16),
 };
 
 static __devinit int
@@ -815,22 +820,70 @@ static __devinit int ab8500_regulator_register(struct platform_device *pdev,
 	return 0;
 }
 
+static __devinit int
+ab8500_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
+{
+	struct regulator_init_data *ab8500_regulator;
+	struct device_node *child;
+	int err, value, i, id = 0;
+
+	/* Initialise regulator registers to platform specific values. */
+	for (i = 0; i < ARRAY_SIZE(ab8500_reg_init); i++) {
+		err = of_property_read_u32(np, ab8500_reg_init[i].of_name, &value);
+		if (err < 0)
+			return err;
+
+		err = ab8500_regulator_init_registers(pdev, i, value);
+		if (err < 0)
+			return err;
+	}
+
+	/* Register each ab8500 regulator found in the Device Tree. */
+	for_each_child_of_node(np, child) {
+		ab8500_regulator = of_get_regulator_init_data(&pdev->dev, child);
+		if (!ab8500_regulator) {
+			dev_err(&pdev->dev,
+				"failed to fetch regulator data for child %s\n", child->full_name);
+			return -EINVAL;
+		}
+
+		if (strcmp(ab8500_regulator->constraints.name, "dummy"))
+			ab8500_regulator_register(pdev, ab8500_regulator, id, child);
+
+		id++;
+	}
+
+	return 0;
+}
+
 static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
 	int i, err;
 
 	if (!ab8500) {
 		dev_err(&pdev->dev, "null mfd parent\n");
 		return -EINVAL;
 	}
+
+	if (!ab8500->dev) {
+		dev_err(&pdev->dev, "no device data for parent found\n");
+		return -EINVAL;
+	}
+
 	pdata = dev_get_platdata(ab8500->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "null pdata\n");
+	if (!pdata && !np) {
+		dev_err(&pdev->dev, "null pdata and no device tree found\n");
 		return -EINVAL;
 	}
 
+	if (!pdata) {
+		err = ab8500_regulator_of_probe(pdev, np);
+		return err;
+	}
+
 	/* make sure the platform data has the correct size */
 	if (pdata->num_regulator != ARRAY_SIZE(ab8500_regulator_info)) {
 		dev_err(&pdev->dev, "Configuration error: size mismatch.\n");
@@ -883,12 +936,18 @@ static __devexit int ab8500_regulator_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ab8500_regulator_match[] = {
+        { .compatible = "stericsson,ab8500-regulator", },
+        {}
+};
+
 static struct platform_driver ab8500_regulator_driver = {
 	.probe = ab8500_regulator_probe,
 	.remove = __devexit_p(ab8500_regulator_remove),
 	.driver         = {
 		.name   = "ab8500-regulator",
 		.owner  = THIS_MODULE,
+		.of_match_table = ab8500_regulator_match,
 	},
 };
 
-- 
1.7.9.5
