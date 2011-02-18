From: dilinger@queued.net (Andres Salomon)
Date: Thu, 17 Feb 2011 19:07:11 -0800
Subject: [PATCH 04/29] ab3550: mfd_cell is now implicitly available to drivers
In-Reply-To: <1297998456-7615-1-git-send-email-dilinger@queued.net>
References: <1297998456-7615-1-git-send-email-dilinger@queued.net>
Message-ID: <1297998456-7615-5-git-send-email-dilinger@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No clients (in mainline kernel, I'm told that drivers exist in external
trees that are planned for mainline inclusion) make use of this, nor
do they make use of platform_data, so nothing really had to change here.

The .data_size field is unused, so its usage gets removed.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/mfd/ab3550-core.c  |    4 +---
 include/linux/mfd/abx500.h |    1 -
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ab3550-core.c b/drivers/mfd/ab3550-core.c
index 5fbca34..d849087 100644
--- a/drivers/mfd/ab3550-core.c
+++ b/drivers/mfd/ab3550-core.c
@@ -1320,10 +1320,8 @@ static int __init ab3550_probe(struct i2c_client *client,
 		goto exit_no_ops;
 
 	/* Set up and register the platform devices. */
-	for (i = 0; i < AB3550_NUM_DEVICES; i++) {
+	for (i = 0; i < AB3550_NUM_DEVICES; i++)
 		ab3550_devs[i].platform_data = ab3550_plf_data->dev_data[i];
-		ab3550_devs[i].data_size = ab3550_plf_data->dev_data_sz[i];
-	}
 
 	err = mfd_add_devices(&client->dev, 0, ab3550_devs,
 		ARRAY_SIZE(ab3550_devs), NULL,
diff --git a/include/linux/mfd/abx500.h b/include/linux/mfd/abx500.h
index 67bd6f7..7d9b6ae 100644
--- a/include/linux/mfd/abx500.h
+++ b/include/linux/mfd/abx500.h
@@ -186,7 +186,6 @@ struct abx500_init_settings {
 struct ab3550_platform_data {
 	struct {unsigned int base; unsigned int count; } irq;
 	void *dev_data[AB3550_NUM_DEVICES];
-	size_t dev_data_sz[AB3550_NUM_DEVICES];
 	struct abx500_init_settings *init_settings;
 	unsigned int init_settings_sz;
 };
-- 
1.7.2.3
