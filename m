From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri,  6 Jul 2012 10:59:58 +0800
Subject: [V3 2/4] mfd: 88pm860x: add pre-regulator device for 88pm860x
In-Reply-To: <20120705141541.GO4111@opensource.wolfsonmicro.com>
References: <20120705141541.GO4111@opensource.wolfsonmicro.com>
Message-ID: <1341543598-6477-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
it needs to be enabled for charging battery, and will be disabled in
some exception condition like over-temp.
Add the pre-regulator device init data and resource for mfd subdev.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |   23 +++++++++++++++++++++++
 include/linux/mfd/88pm860x.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 87bd5ba..d09918c 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -90,6 +90,10 @@ static struct resource charger_resources[] __devinitdata = {
 	{PM8607_IRQ_VCHG, PM8607_IRQ_VCHG, "vchg voltage",    IORESOURCE_IRQ,},
 };
 
+static struct resource preg_resources[] __devinitdata = {
+	{PM8606_ID_PREG,  PM8606_ID_PREG,  "preg",   IORESOURCE_IO,},
+};
+
 static struct resource rtc_resources[] __devinitdata = {
 	{PM8607_IRQ_RTC, PM8607_IRQ_RTC, "rtc", IORESOURCE_IRQ,},
 };
@@ -142,9 +146,19 @@ static struct mfd_cell codec_devs[] = {
 	{"88pm860x-codec", -1,},
 };
 
+static struct regulator_consumer_supply preg_supply[] = {
+	REGULATOR_SUPPLY("preg", "charger-manager"),
+};
+
+static struct regulator_init_data preg_init_data = {
+	.num_consumer_supplies	= ARRAY_SIZE(preg_supply),
+	.consumer_supplies	= &preg_supply[0],
+};
+
 static struct mfd_cell power_devs[] = {
 	{"88pm860x-battery", -1,},
 	{"88pm860x-charger", -1,},
+	{"88pm860x-preg",    -1,},
 };
 
 static struct mfd_cell rtc_devs[] = {
@@ -768,6 +782,15 @@ static void __devinit device_power_init(struct pm860x_chip *chip,
 			      &charger_resources[0], chip->irq_base);
 	if (ret < 0)
 		dev_err(chip->dev, "Failed to add charger subdev\n");
+
+	power_devs[2].platform_data = &preg_init_data;
+	power_devs[2].pdata_size = sizeof(struct regulator_init_data);
+	power_devs[2].num_resources = ARRAY_SIZE(preg_resources);
+	power_devs[2].resources = &preg_resources[0],
+	ret = mfd_add_devices(chip->dev, 0, &power_devs[2], 1,
+			      &preg_resources[0], chip->irq_base);
+	if (ret < 0)
+		dev_err(chip->dev, "Failed to add preg subdev\n");
 }
 
 static void __devinit device_onkey_init(struct pm860x_chip *chip,
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 84d071a..7b24943 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -136,6 +136,7 @@ enum {
 	PM8607_ID_LDO13,
 	PM8607_ID_LDO14,
 	PM8607_ID_LDO15,
+	PM8606_ID_PREG,
 
 	PM8607_ID_RG_MAX,
 };
-- 
1.7.0.4
