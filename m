From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed,  8 Jul 2015 17:56:31 +0530
Subject: [PATCH-v6 5/6] mfd: 88pm800: Set default interrupt clear method
In-Reply-To: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436358392-15449-6-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
(page 0) controls the method of clearing interrupt
status of 88pm800 family of devices;

  0: clear on read
  1: clear on write

If pdata is not coming from board file, then set the
default irq clear method to "irq clear on write"

Also, as suggested by "Lee Jones" renaming variable field
to appropriate name and removed unnecessary field
pm80x_chip.irq_mode, using platform_data.irq_clr_method.

Signed-off-by: Zhao Ye <zhaoy@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/88pm800.c       | 15 ++++++++++-----
 include/linux/mfd/88pm80x.h |  9 +++++++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 074ba8b..95c8ad4 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -347,8 +347,9 @@ static int device_regulator_init(struct pm80x_chip *chip)
 static int device_irq_init_800(struct pm80x_chip *chip)
 {
 	struct regmap *map = chip->regmap;
+	struct pm80x_platform_data *pdata = dev_get_platdata(chip->dev);
 	unsigned long flags = IRQF_ONESHOT;
-	int data, mask, ret = -EINVAL;
+	int irq_clr_mode, mask, ret = -EINVAL;
 
 	if (!map || !chip->irq) {
 		dev_err(chip->dev, "incorrect parameters\n");
@@ -356,15 +357,16 @@ static int device_irq_init_800(struct pm80x_chip *chip)
 	}
 
 	/*
-	 * irq_mode defines the way of clearing interrupt. it's read-clear by
-	 * default.
+	 * irq_clr_on_wr defines the way of clearing interrupt by
+	 * read/write(0/1).  It's read-clear by default.
 	 */
 	mask =
 	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
 	    PM800_WAKEUP2_INT_MASK;
 
-	data = PM800_WAKEUP2_INT_CLEAR;
-	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, data);
+	irq_clr_mode = pdata->irq_clr_method == PM800_IRQ_CLR_ON_WRITE ?
+		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
+	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, irq_clr_mode);
 
 	if (ret < 0)
 		goto out;
@@ -541,6 +543,9 @@ static int pm800_probe(struct i2c_client *client,
 
 		/* Ensure we only alloc platform data once */
 		client->dev.platform_data = pdata;
+
+		/* by default, set irq clear method on write */
+		pdata->irq_clr_method = PM800_IRQ_CLR_ON_WRITE;
 	}
 
 	ret = pm80x_init(client);
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 8fcad63..9c5773b 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -77,6 +77,8 @@ enum {
 #define PM800_WAKEUP2			(0x0E)
 #define PM800_WAKEUP2_INV_INT		BIT(0)
 #define PM800_WAKEUP2_INT_CLEAR		BIT(1)
+#define PM800_WAKEUP2_INT_READ_CLEAR	(0 << 1)
+#define PM800_WAKEUP2_INT_WRITE_CLEAR	(1 << 1)
 #define PM800_WAKEUP2_INT_MASK		BIT(2)
 
 #define PM800_POWER_UP_LOG		(0x10)
@@ -300,11 +302,14 @@ struct pm80x_chip {
 	struct regmap_irq_chip_data *irq_data;
 	int type;
 	int irq;
-	int irq_mode;
 	unsigned long wu_flag;
 	spinlock_t lock;
 };
 
+/* Used by irq_clr_method */
+#define PM800_IRQ_CLR_ON_READ	0
+#define PM800_IRQ_CLR_ON_WRITE	1
+
 struct pm80x_platform_data {
 	struct pm80x_rtc_pdata *rtc;
 	/*
@@ -315,7 +320,7 @@ struct pm80x_platform_data {
 	 */
 	struct regulator_init_data *regulators[PM800_ID_RG_MAX];
 	unsigned int num_regulators;
-	int irq_mode;		/* Clear interrupt by read/write(0/1) */
+	bool irq_clr_method;		/* Clear interrupt by read/write(0/1) */
 	int batt_det;		/* enable/disable */
 	int (*plat_config)(struct pm80x_chip *chip,
 				struct pm80x_platform_data *pdata);
-- 
1.9.1
