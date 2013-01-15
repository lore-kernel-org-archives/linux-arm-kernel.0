From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:56:00 +0000
Subject: [PATCH 20/26] mfd ab8500-gpadc: Introduce new AB version detection
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-21-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel JAOUEN <michel.jaouen@stericsson.com>

Add support for AB8505 and AB9540

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@stericsson.com>
Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Reviewed-by: Rabin VINCENT <rabin.vincent@stericsson.com>
---
 drivers/mfd/ab8500-gpadc.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 3883b93..6f97c599 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -102,10 +102,10 @@ struct adc_cal_data {
 
 /**
  * struct ab8500_gpadc - AB8500 GPADC device information
- * @chip_id			ABB chip id
  * @dev:			pointer to the struct device
  * @node:			a list of AB8500 GPADCs, hence prepared for
 				reentrance
+ * @parent:			pointer to the struct ab8500
  * @ab8500_gpadc_complete:	pointer to the struct completion, to indicate
  *				the completion of gpadc conversion
  * @ab8500_gpadc_lock:		structure of type mutex
@@ -114,9 +114,9 @@ struct adc_cal_data {
  * @cal_data			array of ADC calibration data structs
  */
 struct ab8500_gpadc {
-	u8 chip_id;
 	struct device *dev;
 	struct list_head node;
+	struct ab8500 *parent;
 	struct completion ab8500_gpadc_complete;
 	struct mutex ab8500_gpadc_lock;
 	struct regulator *regu;
@@ -332,7 +332,7 @@ int ab8500_gpadc_read_raw(struct ab8500_gpadc *gpadc, u8 channel)
 			EN_BUF | EN_ICHAR);
 		break;
 	case BTEMP_BALL:
-		if (gpadc->chip_id >= AB8500_CUT3P0) {
+		if (!is_ab8500_2p0_or_earlier(gpadc->parent)) {
 			/* Turn on btemp pull-up on ABB 3.0 */
 			ret = abx500_mask_and_set_register_interruptible(
 				gpadc->dev,
@@ -591,6 +591,7 @@ static int __devinit ab8500_gpadc_probe(struct platform_device *pdev)
 	}
 
 	gpadc->dev = &pdev->dev;
+	gpadc->parent = dev_get_drvdata(pdev->dev.parent);
 	mutex_init(&gpadc->ab8500_gpadc_lock);
 
 	/* Initialize completion used to notify completion of conversion */
@@ -607,14 +608,6 @@ static int __devinit ab8500_gpadc_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	/* Get Chip ID of the ABB ASIC  */
-	ret = abx500_get_chip_id(gpadc->dev);
-	if (ret < 0) {
-		dev_err(gpadc->dev, "failed to get chip ID\n");
-		goto fail_irq;
-	}
-	gpadc->chip_id = (u8) ret;
-
 	/* VTVout LDO used to power up ab8500-GPADC */
 	gpadc->regu = regulator_get(&pdev->dev, "vddadc");
 	if (IS_ERR(gpadc->regu)) {
-- 
1.7.9.5
