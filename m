From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Nov 2013 16:05:17 +0100
Subject: [PATCH 1/2] mfd: sec: reorder params in API for regmap consistency
Message-ID: <1383923118-26921-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last two parameters of certain register access functions were in
different order than regmap API. This was confusing and error-prone.

Reorder parameters for register access API to match regmap API:
 - sec_bulk_read() reorder count and buf,
 - sec_bulk_write() reorder count and buf,
 - sec_reg_update() reorder val and mask.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mfd/sec-core.c           |    6 +++---
 drivers/regulator/s5m8767.c      |   26 +++++++++++++-------------
 include/linux/mfd/samsung/core.h |    6 +++---
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index f530e4b..039814e 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -84,7 +84,7 @@ int sec_reg_read(struct sec_pmic_dev *sec_pmic, u8 reg, void *dest)
 }
 EXPORT_SYMBOL_GPL(sec_reg_read);
 
-int sec_bulk_read(struct sec_pmic_dev *sec_pmic, u8 reg, int count, u8 *buf)
+int sec_bulk_read(struct sec_pmic_dev *sec_pmic, u8 reg, u8 *buf, int count)
 {
 	return regmap_bulk_read(sec_pmic->regmap, reg, buf, count);
 }
@@ -96,13 +96,13 @@ int sec_reg_write(struct sec_pmic_dev *sec_pmic, u8 reg, u8 value)
 }
 EXPORT_SYMBOL_GPL(sec_reg_write);
 
-int sec_bulk_write(struct sec_pmic_dev *sec_pmic, u8 reg, int count, u8 *buf)
+int sec_bulk_write(struct sec_pmic_dev *sec_pmic, u8 reg, u8 *buf, int count)
 {
 	return regmap_raw_write(sec_pmic->regmap, reg, buf, count);
 }
 EXPORT_SYMBOL_GPL(sec_bulk_write);
 
-int sec_reg_update(struct sec_pmic_dev *sec_pmic, u8 reg, u8 val, u8 mask)
+int sec_reg_update(struct sec_pmic_dev *sec_pmic, u8 reg, u8 mask, u8 val)
 {
 	return regmap_update_bits(sec_pmic->regmap, reg, mask, val);
 }
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index c24448b..ac10db4 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -243,7 +243,7 @@ static int s5m8767_reg_enable(struct regulator_dev *rdev)
 	if (ret)
 		return ret;
 
-	return sec_reg_update(s5m8767->iodev, reg, enable_ctrl, mask);
+	return sec_reg_update(s5m8767->iodev, reg, mask, enable_ctrl);
 }
 
 static int s5m8767_reg_disable(struct regulator_dev *rdev)
@@ -256,7 +256,7 @@ static int s5m8767_reg_disable(struct regulator_dev *rdev)
 	if (ret)
 		return ret;
 
-	return sec_reg_update(s5m8767->iodev, reg, ~mask, mask);
+	return sec_reg_update(s5m8767->iodev, reg, mask, ~mask);
 }
 
 static int s5m8767_get_vsel_reg(int reg_id, struct s5m8767_info *s5m8767)
@@ -820,14 +820,14 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 	if (pdata->buck2_gpiodvs || pdata->buck3_gpiodvs ||
 	   pdata->buck4_gpiodvs) {
 		sec_reg_update(s5m8767->iodev, S5M8767_REG_BUCK2CTRL,
-				(pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1),
-				1 << 1);
+				1 << 1,
+				(pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1));
 		sec_reg_update(s5m8767->iodev, S5M8767_REG_BUCK3CTRL,
-				(pdata->buck3_gpiodvs) ? (1 << 1) : (0 << 1),
-				1 << 1);
+				1 << 1,
+				(pdata->buck3_gpiodvs) ? (1 << 1) : (0 << 1));
 		sec_reg_update(s5m8767->iodev, S5M8767_REG_BUCK4CTRL,
-				(pdata->buck4_gpiodvs) ? (1 << 1) : (0 << 1),
-				1 << 1);
+				1 << 1,
+				(pdata->buck4_gpiodvs) ? (1 << 1) : (0 << 1));
 	}
 
 	/* Initialize GPIO DVS registers */
@@ -862,19 +862,19 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 		switch (s5m8767->ramp_delay) {
 		case 5:
 			sec_reg_update(s5m8767->iodev, S5M8767_REG_DVSRAMP,
-					0x40, 0xf0);
+					0xf0, 0x40);
 			break;
 		case 10:
 			sec_reg_update(s5m8767->iodev, S5M8767_REG_DVSRAMP,
-					0x90, 0xf0);
+					0xf0, 0x90);
 			break;
 		case 25:
 			sec_reg_update(s5m8767->iodev, S5M8767_REG_DVSRAMP,
-					0xd0, 0xf0);
+					0xf0, 0xd0);
 			break;
 		case 50:
 			sec_reg_update(s5m8767->iodev, S5M8767_REG_DVSRAMP,
-					0xe0, 0xf0);
+					0xf0, 0xe0);
 			break;
 		case 100:
 			sec_reg_update(s5m8767->iodev, S5M8767_REG_DVSRAMP,
@@ -882,7 +882,7 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 			break;
 		default:
 			sec_reg_update(s5m8767->iodev, S5M8767_REG_DVSRAMP,
-					0x90, 0xf0);
+					0xf0, 0x90);
 		}
 	}
 
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 378ae8a..b04509e 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -58,10 +58,10 @@ void sec_irq_exit(struct sec_pmic_dev *sec_pmic);
 int sec_irq_resume(struct sec_pmic_dev *sec_pmic);
 
 extern int sec_reg_read(struct sec_pmic_dev *sec_pmic, u8 reg, void *dest);
-extern int sec_bulk_read(struct sec_pmic_dev *sec_pmic, u8 reg, int count, u8 *buf);
+extern int sec_bulk_read(struct sec_pmic_dev *sec_pmic, u8 reg, u8 *buf, int count);
 extern int sec_reg_write(struct sec_pmic_dev *sec_pmic, u8 reg, u8 value);
-extern int sec_bulk_write(struct sec_pmic_dev *sec_pmic, u8 reg, int count, u8 *buf);
-extern int sec_reg_update(struct sec_pmic_dev *sec_pmic, u8 reg, u8 val, u8 mask);
+extern int sec_bulk_write(struct sec_pmic_dev *sec_pmic, u8 reg, u8 *buf, int count);
+extern int sec_reg_update(struct sec_pmic_dev *sec_pmic, u8 reg, u8 mask, u8 val);
 
 struct sec_platform_data {
 	struct sec_regulator_data	*regulators;
-- 
1.7.9.5
