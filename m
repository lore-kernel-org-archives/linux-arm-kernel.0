From: dilinger@queued.net (Andres Salomon)
Date: Thu, 17 Feb 2011 19:07:12 -0800
Subject: [PATCH 05/29] ab3100: mfd_cell is now implicitly available to drivers
	(v2)
In-Reply-To: <1297998456-7615-1-git-send-email-dilinger@queued.net>
References: <1297998456-7615-1-git-send-email-dilinger@queued.net>
Message-ID: <1297998456-7615-6-git-send-email-dilinger@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cell's platform_data is now accessed with a helper function;
change clients to use that, and remove the now-unused data_size.

v2: add some missing mfd/core.h includes.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/mfd/ab3100-core.c  |    4 +---
 drivers/regulator/ab3100.c |    3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

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
index ed6feaf..2dec589 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/mfd/abx500.h>
+#include <linux/mfd/core.h>
 
 /* LDO registers and some handy masking definitions for AB3100 */
 #define AB3100_LDO_A		0x40
@@ -576,7 +577,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 
 static int __devinit ab3100_regulators_probe(struct platform_device *pdev)
 {
-	struct ab3100_platform_data *plfdata = pdev->dev.platform_data;
+	struct ab3100_platform_data *plfdata = mfd_get_data(pdev);
 	int err = 0;
 	u8 data;
 	int i;
-- 
1.7.2.3
