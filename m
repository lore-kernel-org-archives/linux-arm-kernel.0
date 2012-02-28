From: jtzhou@marvell.com (Jett.Zhou)
Date: Tue, 28 Feb 2012 10:58:42 +0800
Subject: [V4 2/4] mfd: code clean for pm8606 sub-dev initialization
Message-ID: <1330397922-31739-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Collect all the sub-devices of pm8606 initialization into
device_pm8606_init() for code clean up.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-core.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 78c3a9e..6ed8de7 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -860,6 +860,15 @@ out:
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
@@ -867,9 +876,7 @@ int __devinit pm860x_device_init(struct pm860x_chip *chip,
 
 	switch (chip->id) {
 	case CHIP_PM8606:
-		device_osc_init(chip->client);
-		device_bk_init(chip, pdata);
-		device_led_init(chip, pdata);
+		device_8606_init(chip, chip->client, pdata);
 		break;
 	case CHIP_PM8607:
 		device_8607_init(chip, chip->client, pdata);
@@ -879,9 +886,7 @@ int __devinit pm860x_device_init(struct pm860x_chip *chip,
 	if (chip->companion) {
 		switch (chip->id) {
 		case CHIP_PM8607:
-			device_osc_init(chip->companion);
-			device_bk_init(chip, pdata);
-			device_led_init(chip, pdata);
+			device_8606_init(chip, chip->companion, pdata);
 			break;
 		case CHIP_PM8606:
 			device_8607_init(chip, chip->companion, pdata);
-- 
1.7.0.4
