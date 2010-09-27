From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 27 Sep 2010 14:32:24 +0200
Subject: [PATCH v3 2/5] mfd: regulator: max8998: Support for ICs compliant with
	max8998
In-Reply-To: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285590747-32404-3-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mfd/max8998.c               |    5 +++--
 include/linux/mfd/max8998-private.h |   11 +++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

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
index 170f665..0ff4211 100644
--- a/include/linux/mfd/max8998-private.h
+++ b/include/linux/mfd/max8998-private.h
@@ -101,6 +101,13 @@ enum {
 	MAX8998_IRQ_NR,
 };
 
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
@@ -123,6 +130,8 @@ enum {
 #define MAX8998_IRQ_LOBAT1_MASK		(1 << 0)
 #define MAX8998_IRQ_LOBAT2_MASK		(1 << 1)
 
+#define MAX8998_ENRAMP                  (1 << 4)
+
 /**
  * struct max8998_dev - max8998 master device for sub-drivers
  * @dev: master device of the chip (can be used to access platform data)
@@ -135,6 +144,7 @@ enum {
  * @ono: power onoff IRQ number for max8998
  * @irq_masks_cur: currently active value
  * @irq_masks_cache: cached hardware value
+ * @type: indicate which max8998 "variant" is used
  */
 struct max8998_dev {
 	struct device *dev;
@@ -148,6 +158,7 @@ struct max8998_dev {
 	int ono;
 	u8 irq_masks_cur[MAX8998_NUM_IRQ_REGS];
 	u8 irq_masks_cache[MAX8998_NUM_IRQ_REGS];
+	int type;
 };
 
 int max8998_irq_init(struct max8998_dev *max8998);
-- 
1.7.1
