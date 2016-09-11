From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Sep 2016 18:43:21 +0200
Subject: [PATCH] Revert "Input: bma150 - extend chip detection for bma180"
Message-ID: <20160911164321.23122-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit ef3714fdbc8d ("Input: bma150 - extend chip
detection for bma180").

The bma180 is not compatible with the bma150 at all, it has 14 bits
resolution instead of 10, and it has quite different control registers.

Treating the bma180 as a bma150 wrt its data registers will just result
in throwing away the lowest 4 bits, which is not too bad. But the ctrl
registers are a different story.

It may be that things happen to just work (I don't have a bma180 to
test with) but that certainly does not make this right.

Removing the bma180 id also removes overlap wrt the ids in the iio
bma180 driver which does treat the bma180 properly.

Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/bma150.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index b0d4453..cae4832 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -70,7 +70,6 @@
 #define BMA150_CFG_5_REG	0x11
 
 #define BMA150_CHIP_ID		2
-#define BMA180_CHIP_ID		3
 #define BMA150_CHIP_ID_REG	BMA150_DATA_0_REG
 
 #define BMA150_ACC_X_LSB_REG	BMA150_DATA_2_REG
@@ -539,7 +538,7 @@ static int bma150_probe(struct i2c_client *client,
 	}
 
 	chip_id = i2c_smbus_read_byte_data(client, BMA150_CHIP_ID_REG);
-	if (chip_id != BMA150_CHIP_ID && chip_id != BMA180_CHIP_ID) {
+	if (chip_id != BMA150_CHIP_ID) {
 		dev_err(&client->dev, "BMA150 chip id error: %d\n", chip_id);
 		return -EINVAL;
 	}
@@ -643,7 +642,6 @@ static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
-	{ "bma180", 0 },
 	{ "smb380", 0 },
 	{ "bma023", 0 },
 	{ }
-- 
2.9.3
