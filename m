From: dilinger@queued.net (Andres Salomon)
Date: Fri, 11 Feb 2011 18:05:20 -0800
Subject: [PATCH 05/17] ab3100: mfd_cell is now implicitly available to drivers
Message-ID: <20110211180520.75666fae@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The cell's platform_data is now accessed with a helper function;
change clients to use that, and remove the now-unused data_size.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/mfd/ab3100-core.c  |    4 +---
 drivers/regulator/ab3100.c |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 4193af5..b44c3d9 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -949,10 +949,8 @@ static int __devinit ab3100_probe(struct i2c_client *client,
 		goto exit_no_ops;
 
 	/* Set up and register the platform devices. */
-	for (i = 0; i < ARRAY_SIZE(ab3100_devs); i++) {
+	for (i = 0; i < ARRAY_SIZE(ab3100_devs); i++)
 		ab3100_devs[i].platform_data = ab3100_plf_data;
-		ab3100_devs[i].data_size = sizeof(struct ab3100_platform_data);
-	}
 
 	err = mfd_add_devices(&client->dev, 0, ab3100_devs,
 		ARRAY_SIZE(ab3100_devs), NULL, 0);
diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index ed6feaf..c204f6b 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -576,7 +576,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 
 static int __devinit ab3100_regulators_probe(struct platform_device *pdev)
 {
-	struct ab3100_platform_data *plfdata = pdev->dev.platform_data;
+	struct ab3100_platform_data *plfdata = mfd_get_data(pdev);
 	int err = 0;
 	u8 data;
 	int i;
-- 
1.7.2.3
