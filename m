From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 24 Feb 2012 10:30:03 +0800
Subject: [V2 1/3] mfd: add power control interface for pm8606 chip
Message-ID: <1330050603-8887-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reference group and internal oscillator are shared by sub-devs
like led, backlight and vibrator in PM8606 chip. Now introduce a
voting mechanism to enable/disable it.

Add pm8606_osc_enable() and pm8606_osc_disable() interface and
related defines to support this. This interface will be called by
vibrator led and backlight driver.The refernce group and internal
oscillator are enabled only when at least one of it's clients holds
it on or disabled only all the clients don't use it any more based
on the above mechanism.

Besides, collect all the sub-devices of pm8606 initialization into
device_pm8606_init() for code clean up.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |  106 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/88pm860x.h |   22 +++++++++
 2 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 17dfe9b..439f4d0 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -503,6 +503,97 @@ static void device_irq_exit(struct pm860x_chip *chip)
 		free_irq(chip->core_irq, chip);
 }
 
+int pm8606_osc_enable(struct pm860x_chip *chip, unsigned short client)
+{
+	int ret = -EIO;
+	struct i2c_client *i2c = (chip->id == CHIP_PM8606) ?
+		chip->client : chip->companion;
+
+	dev_dbg(chip->dev, "%s(B): client=0x%x\n", __func__, client);
+	dev_dbg(chip->dev, "%s(B): vote=0x%x status=%d\n",
+			__func__, chip->osc_vote,
+			chip->osc_status);
+
+	mutex_lock(&chip->osc_lock);
+	/* Update voting status */
+	chip->osc_vote |= client;
+	/* If reference group is off - turn on*/
+	if (chip->osc_status != PM8606_REF_GP_OSC_ON) {
+		chip->osc_status = PM8606_REF_GP_OSC_UNKNOWN;
+		/* Enable Reference group Vsys */
+		if (pm860x_set_bits(i2c, PM8606_VSYS,
+				PM8606_VSYS_EN, PM8606_VSYS_EN))
+			break;
+		/*Enable Internal Oscillator */
+		if (pm860x_set_bits(i2c, PM8606_MISC,
+				PM8606_MISC_OSC_EN, PM8606_MISC_OSC_EN))
+			break;
+		/* Update status (only if writes succeed) */
+		chip->osc_status = PM8606_REF_GP_OSC_ON;
+		ret = 0;
+	} else
+		ret = 0;
+	mutex_unlock(&chip->osc_lock);
+
+	dev_dbg(chip->dev, "%s(A): vote=0x%x status=%d ret=%d\n",
+			__func__, chip->osc_vote,
+			chip->osc_status, ret);
+	return ret;
+}
+
+int pm8606_osc_disable(struct pm860x_chip *chip, unsigned short client)
+{
+	int ret = -EIO;
+	struct i2c_client *i2c = (chip->id == CHIP_PM8606) ?
+		chip->client : chip->companion;
+
+	dev_dbg(chip->dev, "%s(B): client=0x%x\n", __func__, client);
+	dev_dbg(chip->dev, "%s(B): vote=0x%x status=%d\n",
+			__func__, chip->osc_vote,
+			chip->osc_status);
+
+	mutex_lock(&chip->osc_lock);
+	/*Update voting status */
+	chip->osc_vote &= ~(client);
+	/* If reference group is off and this is the last client to release
+	 * - turn off */
+	if ((chip->osc_status != PM8606_REF_GP_OSC_OFF) &&
+			(chip->osc_vote == REF_GP_NO_CLIENTS)) {
+		chip->osc_status = PM8606_REF_GP_OSC_UNKNOWN;
+		/* Disable Reference group Vsys */
+		if (pm860x_set_bits(i2c, PM8606_VSYS, PM8606_VSYS_EN, 0))
+			break;
+		/* Disable Internal Oscillator */
+		if (pm860x_set_bits(i2c, PM8606_MISC, PM8606_MISC_OSC_EN, 0))
+			break;
+		chip->osc_status = PM8606_REF_GP_OSC_OFF;
+		ret = 0;
+	} else
+		ret = 0;
+	mutex_unlock(&chip->osc_lock);
+
+	dev_dbg(chip->dev, "%s(A): vote=0x%x status=%d ret=%d\n",
+			__func__, chip->osc_vote,
+			chip->osc_status, ret);
+	return ret;
+}
+
+static void __devinit device_osc_init(struct i2c_client *i2c)
+{
+	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+
+	mutex_init(&chip->osc_lock);
+	/* init portofino reference group voting and status */
+	/* Disable Reference group Vsys */
+	pm860x_set_bits(i2c, PM8606_VSYS, PM8606_VSYS_EN, 0);
+	/* Disable Internal Oscillator */
+	pm860x_set_bits(i2c, PM8606_MISC, PM8606_MISC_OSC_EN, 0);
+
+	chip->osc_vote = REF_GP_NO_CLIENTS;
+	chip->osc_status = PM8606_REF_GP_OSC_OFF;
+}
+
+
 static void __devinit device_bk_init(struct pm860x_chip *chip,
 				     struct pm860x_platform_data *pdata)
 {
@@ -767,6 +858,15 @@ out:
 	return;
 }
 
+static void __devinit device_8606_init(struct pm860x_chip *chip,
+				       struct i2c_client *i2c,
+				       struct pm860x_platform_data *pdata)
+{
+	device_osc_init(i2c);
+	device_bk_init(chip, pdata);
+	device_led_init(chip, pdata);
+}
+
 int __devinit pm860x_device_init(struct pm860x_chip *chip,
 		       struct pm860x_platform_data *pdata)
 {
@@ -774,8 +874,7 @@ int __devinit pm860x_device_init(struct pm860x_chip *chip,
 
 	switch (chip->id) {
 	case CHIP_PM8606:
-		device_bk_init(chip, pdata);
-		device_led_init(chip, pdata);
+		device_8606_init(chip, chip->client, pdata);
 		break;
 	case CHIP_PM8607:
 		device_8607_init(chip, chip->client, pdata);
@@ -785,8 +884,7 @@ int __devinit pm860x_device_init(struct pm860x_chip *chip,
 	if (chip->companion) {
 		switch (chip->id) {
 		case CHIP_PM8607:
-			device_bk_init(chip, pdata);
-			device_led_init(chip, pdata);
+			device_8606_init(chip, chip->companion, pdata);
 			break;
 		case CHIP_PM8606:
 			device_8607_init(chip, chip->companion, pdata);
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 92be347..bc4967a 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -263,6 +263,22 @@ enum {
 #define PM8607_PD_PREBIAS_MASK		(0x1F << 0)
 #define PM8607_PD_PRECHG_MASK		(7 << 5)
 
+#define PM8606_REF_GP_OSC_OFF         0
+#define PM8606_REF_GP_OSC_ON          1
+#define PM8606_REF_GP_OSC_UNKNOWN     2
+
+/* Clients of reference group and 8MHz oscillator in 88PM8606 */
+enum pm8606_ref_gp_and_osc_clients {
+	REF_GP_NO_CLIENTS       = 0,
+	WLED1_DUTY              = (1<<0), /*PF 0x02.7:0*/
+	WLED2_DUTY              = (1<<1), /*PF 0x04.7:0*/
+	WLED3_DUTY              = (1<<2), /*PF 0x06.7:0*/
+	RGB1_ENABLE             = (1<<3), /*PF 0x07.1*/
+	RGB2_ENABLE             = (1<<4), /*PF 0x07.2*/
+	LDO_VBR_EN              = (1<<5), /*PF 0x12.0*/
+	REF_GP_MAX_CLIENT       = 0xFFFF
+};
+
 /* Interrupt Number in 88PM8607 */
 enum {
 	PM8607_IRQ_ONKEY,
@@ -298,6 +314,7 @@ enum {
 struct pm860x_chip {
 	struct device		*dev;
 	struct mutex		irq_lock;
+	struct mutex		osc_lock;
 	struct i2c_client	*client;
 	struct i2c_client	*companion;	/* companion chip client */
 	struct regmap           *regmap;
@@ -305,11 +322,13 @@ struct pm860x_chip {
 
 	int			buck3_double;	/* DVC ramp slope double */
 	unsigned short		companion_addr;
+	unsigned short		osc_vote;
 	int			id;
 	int			irq_mode;
 	int			irq_base;
 	int			core_irq;
 	unsigned char		chip_version;
+	unsigned char		osc_status;
 
 };
 
@@ -369,6 +388,9 @@ struct pm860x_platform_data {
 	int		num_regulators;
 };
 
+extern int pm8606_osc_enable(struct pm860x_chip *, unsigned short);
+extern int pm8606_osc_disable(struct pm860x_chip *, unsigned short);
+
 extern int pm860x_reg_read(struct i2c_client *, int);
 extern int pm860x_reg_write(struct i2c_client *, int, unsigned char);
 extern int pm860x_bulk_read(struct i2c_client *, int, int, unsigned char *);
-- 
1.7.0.4
