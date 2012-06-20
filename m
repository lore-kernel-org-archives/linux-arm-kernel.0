From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:44 +0100
Subject: [PATCH 08/15] regulator: Stop initialising AB8500's registers during
 bring-up
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to initialise the AB8500's regulator registers, as
most of this work is already carried out by framework features.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c       |  234 --------------------------------------
 include/linux/regulator/ab8500.h |   12 --
 2 files changed, 246 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 6745bd2..adb32cb 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -531,221 +531,6 @@ static struct ab8500_regulator_info
 
 };
 
-struct ab8500_reg_init {
-	u8 bank;
-	u8 addr;
-	u8 mask;
-};
-
-#define REG_INIT(_id, _bank, _addr, _mask)	\
-	[_id] = {				\
-		.bank = _bank,			\
-		.addr = _addr,			\
-		.mask = _mask,			\
-	}
-
-static struct ab8500_reg_init ab8500_reg_init[] = {
-	/*
-	 * 0x30, VanaRequestCtrl
-	 * 0x0C, VpllRequestCtrl
-	 * 0xc0, VextSupply1RequestCtrl
-	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL2,	0x03, 0x04, 0xfc),
-	/*
-	 * 0x03, VextSupply2RequestCtrl
-	 * 0x0c, VextSupply3RequestCtrl
-	 * 0x30, Vaux1RequestCtrl
-	 * 0xc0, Vaux2RequestCtrl
-	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL3,	0x03, 0x05, 0xff),
-	/*
-	 * 0x03, Vaux3RequestCtrl
-	 * 0x04, SwHPReq
-	 */
-	REG_INIT(AB8500_REGUREQUESTCTRL4,	0x03, 0x06, 0x07),
-	/*
-	 * 0x08, VanaSysClkReq1HPValid
-	 * 0x20, Vaux1SysClkReq1HPValid
-	 * 0x40, Vaux2SysClkReq1HPValid
-	 * 0x80, Vaux3SysClkReq1HPValid
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID1,	0x03, 0x07, 0xe8),
-	/*
-	 * 0x10, VextSupply1SysClkReq1HPValid
-	 * 0x20, VextSupply2SysClkReq1HPValid
-	 * 0x40, VextSupply3SysClkReq1HPValid
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQ1HPVALID2,	0x03, 0x08, 0x70),
-	/*
-	 * 0x08, VanaHwHPReq1Valid
-	 * 0x20, Vaux1HwHPReq1Valid
-	 * 0x40, Vaux2HwHPReq1Valid
-	 * 0x80, Vaux3HwHPReq1Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ1VALID1,	0x03, 0x09, 0xe8),
-	/*
-	 * 0x01, VextSupply1HwHPReq1Valid
-	 * 0x02, VextSupply2HwHPReq1Valid
-	 * 0x04, VextSupply3HwHPReq1Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ1VALID2,	0x03, 0x0a, 0x07),
-	/*
-	 * 0x08, VanaHwHPReq2Valid
-	 * 0x20, Vaux1HwHPReq2Valid
-	 * 0x40, Vaux2HwHPReq2Valid
-	 * 0x80, Vaux3HwHPReq2Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ2VALID1,	0x03, 0x0b, 0xe8),
-	/*
-	 * 0x01, VextSupply1HwHPReq2Valid
-	 * 0x02, VextSupply2HwHPReq2Valid
-	 * 0x04, VextSupply3HwHPReq2Valid
-	 */
-	REG_INIT(AB8500_REGUHWHPREQ2VALID2,	0x03, 0x0c, 0x07),
-	/*
-	 * 0x20, VanaSwHPReqValid
-	 * 0x80, Vaux1SwHPReqValid
-	 */
-	REG_INIT(AB8500_REGUSWHPREQVALID1,	0x03, 0x0d, 0xa0),
-	/*
-	 * 0x01, Vaux2SwHPReqValid
-	 * 0x02, Vaux3SwHPReqValid
-	 * 0x04, VextSupply1SwHPReqValid
-	 * 0x08, VextSupply2SwHPReqValid
-	 * 0x10, VextSupply3SwHPReqValid
-	 */
-	REG_INIT(AB8500_REGUSWHPREQVALID2,	0x03, 0x0e, 0x1f),
-	/*
-	 * 0x02, SysClkReq2Valid1
-	 * ...
-	 * 0x80, SysClkReq8Valid1
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQVALID1,	0x03, 0x0f, 0xfe),
-	/*
-	 * 0x02, SysClkReq2Valid2
-	 * ...
-	 * 0x80, SysClkReq8Valid2
-	 */
-	REG_INIT(AB8500_REGUSYSCLKREQVALID2,	0x03, 0x10, 0xfe),
-	/*
-	 * 0x02, VTVoutEna
-	 * 0x04, Vintcore12Ena
-	 * 0x38, Vintcore12Sel
-	 * 0x40, Vintcore12LP
-	 * 0x80, VTVoutLP
-	 */
-	REG_INIT(AB8500_REGUMISC1,		0x03, 0x80, 0xfe),
-	/*
-	 * 0x02, VaudioEna
-	 * 0x04, VdmicEna
-	 * 0x08, Vamic1Ena
-	 * 0x10, Vamic2Ena
-	 */
-	REG_INIT(AB8500_VAUDIOSUPPLY,		0x03, 0x83, 0x1e),
-	/*
-	 * 0x01, Vamic1_dzout
-	 * 0x02, Vamic2_dzout
-	 */
-	REG_INIT(AB8500_REGUCTRL1VAMIC,		0x03, 0x84, 0x03),
-	/*
-	 * 0x0c, VanaRegu
-	 * 0x03, VpllRegu
-	 */
-	REG_INIT(AB8500_VPLLVANAREGU,		0x04, 0x06, 0x0f),
-	/*
-	 * 0x01, VrefDDREna
-	 * 0x02, VrefDDRSleepMode
-	 */
-	REG_INIT(AB8500_VREFDDR,		0x04, 0x07, 0x03),
-	/*
-	 * 0x03, VextSupply1Regu
-	 * 0x0c, VextSupply2Regu
-	 * 0x30, VextSupply3Regu
-	 * 0x40, ExtSupply2Bypass
-	 * 0x80, ExtSupply3Bypass
-	 */
-	REG_INIT(AB8500_EXTSUPPLYREGU,		0x04, 0x08, 0xff),
-	/*
-	 * 0x03, Vaux1Regu
-	 * 0x0c, Vaux2Regu
-	 */
-	REG_INIT(AB8500_VAUX12REGU,		0x04, 0x09, 0x0f),
-	/*
-	 * 0x03, Vaux3Regu
-	 */
-	REG_INIT(AB8500_VRF1VAUX3REGU,		0x04, 0x0a, 0x03),
-	/*
-	 * 0x3f, Vsmps1Sel1
-	 */
-	REG_INIT(AB8500_VSMPS1SEL1,		0x04, 0x13, 0x3f),
-	/*
-	 * 0x0f, Vaux1Sel
-	 */
-	REG_INIT(AB8500_VAUX1SEL,		0x04, 0x1f, 0x0f),
-	/*
-	 * 0x0f, Vaux2Sel
-	 */
-	REG_INIT(AB8500_VAUX2SEL,		0x04, 0x20, 0x0f),
-	/*
-	 * 0x07, Vaux3Sel
-	 */
-	REG_INIT(AB8500_VRF1VAUX3SEL,		0x04, 0x21, 0x07),
-	/*
-	 * 0x01, VextSupply12LP
-	 */
-	REG_INIT(AB8500_REGUCTRL2SPARE,		0x04, 0x22, 0x01),
-	/*
-	 * 0x04, Vaux1Disch
-	 * 0x08, Vaux2Disch
-	 * 0x10, Vaux3Disch
-	 * 0x20, Vintcore12Disch
-	 * 0x40, VTVoutDisch
-	 * 0x80, VaudioDisch
-	 */
-	REG_INIT(AB8500_REGUCTRLDISCH,		0x04, 0x43, 0xfc),
-	/*
-	 * 0x02, VanaDisch
-	 * 0x04, VdmicPullDownEna
-	 * 0x10, VdmicDisch
-	 */
-	REG_INIT(AB8500_REGUCTRLDISCH2,		0x04, 0x44, 0x16),
-};
-
-static __devinit int
-ab8500_regulator_init_registers(struct platform_device *pdev, int id, int value)
-{
-	int err;
-
-	if (value & ~ab8500_reg_init[id].mask) {
-		dev_err(&pdev->dev,
-			"Configuration error: value outside mask.\n");
-		return -EINVAL;
-	}
-
-	err = abx500_mask_and_set_register_interruptible(
-		&pdev->dev,
-		ab8500_reg_init[id].bank,
-		ab8500_reg_init[id].addr,
-		ab8500_reg_init[id].mask,
-		value);
-	if (err < 0) {
-		dev_err(&pdev->dev,
-			"Failed to initialize 0x%02x, 0x%02x.\n",
-			ab8500_reg_init[id].bank,
-			ab8500_reg_init[id].addr);
-		return err;
-	}
-
-	dev_vdbg(&pdev->dev,
-		"init: 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
-		ab8500_reg_init[id].bank,
-		ab8500_reg_init[id].addr,
-		ab8500_reg_init[id].mask,
-		value);
-
-	return 0;
-}
-
 static __devinit int ab8500_regulator_register(struct platform_device *pdev,
 					struct regulator_init_data *init_data,
 					int id,
@@ -860,25 +645,6 @@ static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* initialize registers */
-	for (i = 0; i < pdata->num_regulator_reg_init; i++) {
-		int id, value;
-
-		id = pdata->regulator_reg_init[i].id;
-		value = pdata->regulator_reg_init[i].value;
-
-		/* check for configuration errors */
-		if (id >= AB8500_NUM_REGULATOR_REGISTERS) {
-			dev_err(&pdev->dev,
-				"Configuration error: id outside range.\n");
-			return -EINVAL;
-		}
-
-		err = ab8500_regulator_init_registers(pdev, id, value);
-		if (err < 0)
-			return err;
-	}
-
 	/* register all regulators */
 	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
 		err = ab8500_regulator_register(pdev, &pdata->regulator[i], i, NULL);
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 7bd73bb..0e89945 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -45,18 +45,6 @@ enum ab9540_regulator_id {
 	AB9540_NUM_REGULATORS,
 };
 
-/* AB8500 and AB9540 register initialization */
-struct ab8500_regulator_reg_init {
-	int id;
-	u8 value;
-};
-
-#define INIT_REGULATOR_REGISTER(_id, _value)	\
-	{					\
-		.id = _id,			\
-		.value = _value,		\
-	}
-
 /* AB8500 registers */
 enum ab8500_regulator_reg {
 	AB8500_REGUREQUESTCTRL2,
-- 
1.7.9.5
