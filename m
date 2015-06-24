From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 24 Jun 2015 14:51:12 +0530
Subject: [PATCH-v3 2/3] mfd: 88pm800: Allow configuration of interrupt clear
 method
In-Reply-To: <1435137673-1629-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435137673-1629-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1435137673-1629-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
(page 0) controls the method of clearing interrupt
status of 88pm800 family of devices;

  0: clear on read
  1: clear on write

This patch allows to configure this field, through DT.

Also, as suggested by "Lee Jones" renaming DT property and variable
field to appropriate name.

Signed-off-by: Zhao Ye <zhaoy@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c       | 15 ++++++++++-----
 include/linux/mfd/88pm80x.h |  6 ++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 059f01a..c1a6306 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -376,7 +376,7 @@ static int device_irq_init_800(struct pm80x_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 	unsigned long flags = IRQF_ONESHOT;
-	int data, mask, ret = -EINVAL;
+	int irq_clr_mode, mask, ret = -EINVAL;
 
 	if (!map || !chip->irq) {
 		dev_err(chip->dev, "incorrect parameters\n");
@@ -384,15 +384,16 @@ static int device_irq_init_800(struct pm80x_chip *chip)
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
+	irq_clr_mode = (chip->irq_clr_on_wr) ?
+		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
+	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, irq_clr_mode);
 
 	if (ret < 0)
 		goto out;
@@ -514,6 +515,7 @@ static int device_800_init(struct pm80x_chip *chip,
 	}
 
 	chip->regmap_irq_chip = &pm800_irq_chip;
+	chip->irq_clr_on_wr = pdata->irq_clr_on_wr;
 
 	ret = device_irq_init_800(chip);
 	if (ret < 0) {
@@ -568,6 +570,9 @@ static int pm800_probe(struct i2c_client *client,
 			dev_err(&client->dev, "failed to allocaate memory\n");
 			return -ENOMEM;
 		}
+
+		pdata->irq_clr_on_wr = of_property_read_bool(np,
+					"marvell,irq-clr-on-write");
 	}
 
 	ret = pm80x_init(client);
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 97cb283..94b3dcd 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -77,6 +77,8 @@ enum {
 #define PM800_WAKEUP2		(0x0E)
 #define PM800_WAKEUP2_INV_INT		(1 << 0)
 #define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
+#define PM800_WAKEUP2_INT_READ_CLEAR		(0 << 1)
+#define PM800_WAKEUP2_INT_WRITE_CLEAR		(1 << 1)
 #define PM800_WAKEUP2_INT_MASK		(1 << 2)
 
 #define PM800_POWER_UP_LOG	(0x10)
@@ -300,7 +302,7 @@ struct pm80x_chip {
 	struct regmap_irq_chip_data *irq_data;
 	int type;
 	int irq;
-	int irq_mode;
+	int irq_clr_on_wr;	/* '1': Clear on write, '0': Clear on read*/
 	unsigned long wu_flag;
 	spinlock_t lock;
 };
@@ -315,7 +317,7 @@ struct pm80x_platform_data {
 	 */
 	struct regulator_init_data *regulators[PM800_ID_RG_MAX];
 	unsigned int num_regulators;
-	int irq_mode;		/* Clear interrupt by read/write(0/1) */
+	int irq_clr_on_wr;		/* Clear interrupt by read/write(0/1) */
 	int batt_det;		/* enable/disable */
 	int (*plat_config)(struct pm80x_chip *chip,
 				struct pm80x_platform_data *pdata);
-- 
1.9.1
