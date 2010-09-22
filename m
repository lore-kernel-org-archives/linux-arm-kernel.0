From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 22 Sep 2010 17:30:10 +0200
Subject: [PATCH v2 3/3] mfd: regulator: max8998: mfd code
In-Reply-To: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
References: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285169410-22343-4-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mfd/max8998.c               |    5 ++-
 include/linux/mfd/max8998-private.h |   59 +++++++++++++++++++++++++++++++---
 include/linux/mfd/max8998.h         |   14 ++++++++
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 310fd80..a720f41 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -133,6 +133,7 @@ static int max8998_i2c_probe(struct i2c_client *i2c,
 	max8998->dev = &i2c->dev;
 	max8998->i2c = i2c;
 	max8998->irq = i2c->irq;
+	max8998->type = id->driver_data;
 	if (pdata) {
 		max8998->ono = pdata->ono;
 		max8998->irq_base = pdata->irq_base;
@@ -169,8 +170,8 @@ static int max8998_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id max8998_i2c_id[] = {
-	{ "max8998", 0 },
-	{ "lp3974", 0 },
+	{ "max8998", TYPE_MAX8998 },
+	{ "lp3974", TYPE_LP3974},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8998_i2c_id);
diff --git a/include/linux/mfd/max8998-private.h b/include/linux/mfd/max8998-private.h
index 170f665..332c14e 100644
--- a/include/linux/mfd/max8998-private.h
+++ b/include/linux/mfd/max8998-private.h
@@ -48,12 +48,12 @@ enum {
 	MAX8998_REG_ONOFF2,
 	MAX8998_REG_ONOFF3,
 	MAX8998_REG_ONOFF4,
-	MAX8998_REG_BUCK1_DVSARM1,
-	MAX8998_REG_BUCK1_DVSARM2,
-	MAX8998_REG_BUCK1_DVSARM3,
-	MAX8998_REG_BUCK1_DVSARM4,
-	MAX8998_REG_BUCK2_DVSINT1,
-	MAX8998_REG_BUCK2_DVSINT2,
+	MAX8998_REG_BUCK1_VOL1,
+	MAX8998_REG_BUCK1_VOL2,
+	MAX8998_REG_BUCK1_VOL3,
+	MAX8998_REG_BUCK1_VOL4,
+	MAX8998_REG_BUCK2_VOL1,
+	MAX8998_REG_BUCK2_VOL2,
 	MAX8998_REG_BUCK3,
 	MAX8998_REG_BUCK4,
 	MAX8998_REG_LDO2_LDO3,
@@ -101,6 +101,49 @@ enum {
 	MAX8998_IRQ_NR,
 };
 
+/* MAX8998 output voltages */
+enum {
+	MAX8998_DVS_750mV = 0,
+	MAX8998_DVS_775mV,
+	MAX8998_DVS_800mV,
+	MAX8998_DVS_825mV,
+	MAX8998_DVS_850mV,
+	MAX8998_DVS_875mV,
+	MAX8998_DVS_900mV,
+	MAX8998_DVS_925mV,
+	MAX8998_DVS_950mV,
+	MAX8998_DVS_975mV,
+	MAX8998_DVS_1000mV,
+	MAX8998_DVS_1025mV,
+	MAX8998_DVS_1050mV,
+	MAX8998_DVS_1075mV,
+	MAX8998_DVS_1100mV,
+	MAX8998_DVS_1125mV,
+	MAX8998_DVS_1150mV,
+	MAX8998_DVS_1175mV,
+	MAX8998_DVS_1200mV,
+	MAX8998_DVS_1225mV,
+	MAX8998_DVS_1250mV,
+	MAX8998_DVS_1275mV,
+	MAX8998_DVS_1300mV,
+	MAX8998_DVS_1325mV,
+	MAX8998_DVS_1350mV,
+	MAX8998_DVS_1375mV,
+	MAX8998_DVS_1400mV,
+	MAX8998_DVS_1425mV,
+	MAX8998_DVS_1450mV,
+	MAX8998_DVS_1475mV,
+	MAX8998_DVS_1500mV,
+	MAX8998_DVS_1525mV,
+};
+
+/* MAX8998 various variants */
+enum {
+	TYPE_MAX8998 = 0, /* Default */
+	TYPE_LP3974,	/* National version of MAX8998 */
+	TYPE_LP3979,	/* Added AVS */
+};
+
 #define MAX8998_IRQ_DCINF_MASK		(1 << 2)
 #define MAX8998_IRQ_DCINR_MASK		(1 << 3)
 #define MAX8998_IRQ_JIGF_MASK		(1 << 4)
@@ -123,6 +166,8 @@ enum {
 #define MAX8998_IRQ_LOBAT1_MASK		(1 << 0)
 #define MAX8998_IRQ_LOBAT2_MASK		(1 << 1)
 
+#define MAX8998_ENRAMP                  (1 << 4)
+
 /**
  * struct max8998_dev - max8998 master device for sub-drivers
  * @dev: master device of the chip (can be used to access platform data)
@@ -135,6 +180,7 @@ enum {
  * @ono: power onoff IRQ number for max8998
  * @irq_masks_cur: currently active value
  * @irq_masks_cache: cached hardware value
+ * @type: indicate which max8998 "variant" is used
  */
 struct max8998_dev {
 	struct device *dev;
@@ -148,6 +194,7 @@ struct max8998_dev {
 	int ono;
 	u8 irq_masks_cur[MAX8998_NUM_IRQ_REGS];
 	u8 irq_masks_cache[MAX8998_NUM_IRQ_REGS];
+	int type;
 };
 
 int max8998_irq_init(struct max8998_dev *max8998);
diff --git a/include/linux/mfd/max8998.h b/include/linux/mfd/max8998.h
index d47ed4c..bc9bcc3 100644
--- a/include/linux/mfd/max8998.h
+++ b/include/linux/mfd/max8998.h
@@ -70,12 +70,26 @@ struct max8998_regulator_data {
  * @num_regulators: number of regultors used
  * @irq_base: base IRQ number for max8998, required for IRQs
  * @ono: power onoff IRQ number for max8998
+ * @buck1_vol: BUCK1 voltage levels
+ * @buck2_vol: BUCK2 voltage levels
+ * @buck1_init_idx: BUCK1 initial voltage index
+ * @buck2_init_idx: BUCK2 initial voltage index
+ * @buck1_set1: BUCK1 gpio pin 1 to set output voltage
+ * @buck1_set2: BUCK1 gpio pin 2 to set output voltage
+ * @buck2_set3: BUCK2 gpio pin to set output voltage
  */
 struct max8998_platform_data {
 	struct max8998_regulator_data	*regulators;
 	int				num_regulators;
 	int				irq_base;
 	int				ono;
+	u8                              buck1_vol[4];
+	u8				buck2_vol[2];
+	u8                              buck1_init_idx;
+	u8                              buck2_init_idx;
+	int				buck1_set1;
+	int				buck1_set2;
+	int				buck2_set3;
 };
 
 #endif /*  __LINUX_MFD_MAX8998_H */
-- 
1.7.1
