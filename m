From: dilinger@queued.net (Andres Salomon)
Date: Wed, 2 Feb 2011 20:03:02 -0800
Subject: [PATCH 04/19] ab3100: mfd_cell is now implicitly available to drivers
In-Reply-To: <20110202195417.228e2656@queued.net>
References: <20110202195417.228e2656@queued.net>
Message-ID: <20110202200302.0e05c3d0@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


No need to explicitly set the cell's platform_data/data_size.

In this case, move the ab3100_platform_data pointer from platform_data
to driver_data.  The only client who makes use of it is also changed.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/mfd/ab3100-core.c  |    6 ++----
 drivers/regulator/ab3100.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 4193af5..244c2a2 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -949,10 +949,8 @@ static int __devinit ab3100_probe(struct i2c_client *client,
 		goto exit_no_ops;
 
 	/* Set up and register the platform devices. */
-	for (i = 0; i < ARRAY_SIZE(ab3100_devs); i++) {
-		ab3100_devs[i].platform_data = ab3100_plf_data;
-		ab3100_devs[i].data_size = sizeof(struct ab3100_platform_data);
-	}
+	for (i = 0; i < ARRAY_SIZE(ab3100_devs); i++)
+		ab3100_devs[i].driver_data = ab3100_plf_data;
 
 	err = mfd_add_devices(&client->dev, 0, ab3100_devs,
 		ARRAY_SIZE(ab3100_devs), NULL, 0);
diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index ed6feaf..1f266b9 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -576,7 +576,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 
 static int __devinit ab3100_regulators_probe(struct platform_device *pdev)
 {
-	struct ab3100_platform_data *plfdata = pdev->dev.platform_data;
+	struct ab3100_platform_data *plfdata = platform_get_drvdata(pdev);
 	int err = 0;
 	u8 data;
 	int i;
-- 
1.7.2.3
