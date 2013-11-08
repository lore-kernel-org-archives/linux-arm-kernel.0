From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Nov 2013 16:05:18 +0100
Subject: [PATCH 2/2] mfd: max77693: reorder params in API for regmap
 consistency
In-Reply-To: <1383923118-26921-1-git-send-email-k.kozlowski@samsung.com>
References: <1383923118-26921-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1383923118-26921-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last two parameters of certain register access functions were in
different order than regmap API. This was confusing and error-prone.

Reorder parameters for register access API to match regmap API:
 - max77693_bulk_read() reorder count and buf,
 - max77693_bulk_write() reorder count and buf,
 - max77693_update_reg() reorder val and mask.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/extcon/extcon-max77693.c     |   14 +++++++-------
 drivers/mfd/max77693-irq.c           |    2 +-
 drivers/mfd/max77693.c               |    6 +++---
 include/linux/mfd/max77693-private.h |   10 +++++-----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index da268fb..602d948 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -257,8 +257,8 @@ static int max77693_muic_set_debounce_time(struct max77693_muic_info *info,
 	case ADC_DEBOUNCE_TIME_38_62MS:
 		ret = max77693_update_reg(info->max77693->regmap_muic,
 					  MAX77693_MUIC_REG_CTRL3,
-					  time << CONTROL3_ADCDBSET_SHIFT,
-					  CONTROL3_ADCDBSET_MASK);
+					  CONTROL3_ADCDBSET_MASK,
+					  time << CONTROL3_ADCDBSET_SHIFT);
 		if (ret) {
 			dev_err(info->dev, "failed to set ADC debounce time\n");
 			return ret;
@@ -294,7 +294,7 @@ static int max77693_muic_set_path(struct max77693_muic_info *info,
 		ctrl1 = CONTROL1_SW_OPEN;
 
 	ret = max77693_update_reg(info->max77693->regmap_muic,
-			MAX77693_MUIC_REG_CTRL1, ctrl1, COMP_SW_MASK);
+			MAX77693_MUIC_REG_CTRL1, COMP_SW_MASK, ctrl1);
 	if (ret < 0) {
 		dev_err(info->dev, "failed to update MUIC register\n");
 		return ret;
@@ -306,8 +306,8 @@ static int max77693_muic_set_path(struct max77693_muic_info *info,
 		ctrl2 |= CONTROL2_LOWPWR_MASK;	/* LowPwr=1, CPEn=0 */
 
 	ret = max77693_update_reg(info->max77693->regmap_muic,
-			MAX77693_MUIC_REG_CTRL2, ctrl2,
-			CONTROL2_LOWPWR_MASK | CONTROL2_CPEN_MASK);
+			MAX77693_MUIC_REG_CTRL2,
+			CONTROL2_LOWPWR_MASK | CONTROL2_CPEN_MASK, ctrl2);
 	if (ret < 0) {
 		dev_err(info->dev, "failed to update MUIC register\n");
 		return ret;
@@ -970,7 +970,7 @@ static void max77693_muic_irq_work(struct work_struct *work)
 			irq_type = muic_irqs[i].irq;
 
 	ret = max77693_bulk_read(info->max77693->regmap_muic,
-			MAX77693_MUIC_REG_STATUS1, 2, info->status);
+			MAX77693_MUIC_REG_STATUS1, info->status, 2);
 	if (ret) {
 		dev_err(info->dev, "failed to read MUIC register\n");
 		mutex_unlock(&info->mutex);
@@ -1043,7 +1043,7 @@ static int max77693_muic_detect_accessory(struct max77693_muic_info *info)
 
 	/* Read STATUSx register to detect accessory */
 	ret = max77693_bulk_read(info->max77693->regmap_muic,
-			MAX77693_MUIC_REG_STATUS1, 2, info->status);
+			MAX77693_MUIC_REG_STATUS1, info->status, 2);
 	if (ret) {
 		dev_err(info->dev, "failed to read MUIC register\n");
 		mutex_unlock(&info->mutex);
diff --git a/drivers/mfd/max77693-irq.c b/drivers/mfd/max77693-irq.c
index 1029d01..8718927 100644
--- a/drivers/mfd/max77693-irq.c
+++ b/drivers/mfd/max77693-irq.c
@@ -207,7 +207,7 @@ static irqreturn_t max77693_irq_thread(int irq, void *data)
 	if (irq_src & MAX77693_IRQSRC_MUIC)
 		/* MUIC INT1 ~ INT3 */
 		max77693_bulk_read(max77693->regmap_muic, MAX77693_MUIC_REG_INT1,
-			MAX77693_NUM_IRQ_MUIC_REGS, &irq_reg[MUIC_INT1]);
+			&irq_reg[MUIC_INT1], MAX77693_NUM_IRQ_MUIC_REGS);
 
 	/* Apply masking */
 	for (i = 0; i < MAX77693_IRQ_GROUP_NR; i++) {
diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index c04723e..54f1a7f 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -60,7 +60,7 @@ int max77693_read_reg(struct regmap *map, u8 reg, u8 *dest)
 }
 EXPORT_SYMBOL_GPL(max77693_read_reg);
 
-int max77693_bulk_read(struct regmap *map, u8 reg, int count, u8 *buf)
+int max77693_bulk_read(struct regmap *map, u8 reg, u8 *buf, int count)
 {
 	int ret;
 
@@ -80,7 +80,7 @@ int max77693_write_reg(struct regmap *map, u8 reg, u8 value)
 }
 EXPORT_SYMBOL_GPL(max77693_write_reg);
 
-int max77693_bulk_write(struct regmap *map, u8 reg, int count, u8 *buf)
+int max77693_bulk_write(struct regmap *map, u8 reg, u8 *buf, int count)
 {
 	int ret;
 
@@ -90,7 +90,7 @@ int max77693_bulk_write(struct regmap *map, u8 reg, int count, u8 *buf)
 }
 EXPORT_SYMBOL_GPL(max77693_bulk_write);
 
-int max77693_update_reg(struct regmap *map, u8 reg, u8 val, u8 mask)
+int max77693_update_reg(struct regmap *map, u8 reg, u8 mask, u8 val)
 {
 	int ret;
 
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 244fb0d..40fd954 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -334,12 +334,12 @@ enum max77693_types {
 };
 
 extern int max77693_read_reg(struct regmap *map, u8 reg, u8 *dest);
-extern int max77693_bulk_read(struct regmap *map, u8 reg, int count,
-				u8 *buf);
+extern int max77693_bulk_read(struct regmap *map, u8 reg, u8 *buf,
+				int count);
 extern int max77693_write_reg(struct regmap *map, u8 reg, u8 value);
-extern int max77693_bulk_write(struct regmap *map, u8 reg, int count,
-				u8 *buf);
-extern int max77693_update_reg(struct regmap *map, u8 reg, u8 val, u8 mask);
+extern int max77693_bulk_write(struct regmap *map, u8 reg, u8 *buf,
+				int count);
+extern int max77693_update_reg(struct regmap *map, u8 reg, u8 mask, u8 val);
 
 extern int max77693_irq_init(struct max77693_dev *max77686);
 extern void max77693_irq_exit(struct max77693_dev *max77686);
-- 
1.7.9.5
