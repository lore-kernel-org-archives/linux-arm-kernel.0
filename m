From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:16:42 +0100
Subject: [PATCH 02/12] firmware: arm_scpi: make freeing mbox channels
 device-managed
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <407a99ae-3e47-913c-b1e1-5548864a4ae5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make freeing the mbox channels device-managed, thus further simplifying
scpi_remove and and one further step to get rid of scpi_remove.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 2a30d255..4447738d 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -889,16 +889,13 @@ static struct attribute *versions_attrs[] = {
 };
 ATTRIBUTE_GROUPS(versions);
 
-static void
-scpi_free_channels(struct device *dev, struct scpi_chan *pchan, int count)
+static void scpi_free_channels(void *data)
 {
+	struct scpi_drvinfo *info = data;
 	int i;
 
-	for (i = 0; i < count && pchan->chan; i++, pchan++) {
-		mbox_free_channel(pchan->chan);
-		devm_kfree(dev, pchan->xfers);
-		devm_iounmap(dev, pchan->rx_payload);
-	}
+	for (i = 0; i < info->num_chans; i++)
+		mbox_free_channel(info->channels[i].chan);
 }
 
 static int scpi_remove(struct platform_device *pdev)
@@ -911,7 +908,6 @@ static int scpi_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(dev);
 	sysfs_remove_groups(&dev->kobj, versions_groups);
-	scpi_free_channels(dev, info->channels, info->num_chans);
 	platform_set_drvdata(pdev, NULL);
 
 	for (i = 0; i < MAX_DVFS_DOMAINS && info->dvfs[i]; i++) {
@@ -950,7 +946,6 @@ static int scpi_probe(struct platform_device *pdev)
 {
 	int count, idx, ret;
 	struct resource res;
-	struct scpi_chan *scpi_chan;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 
@@ -967,13 +962,19 @@ static int scpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	scpi_chan = devm_kcalloc(dev, count, sizeof(*scpi_chan), GFP_KERNEL);
-	if (!scpi_chan)
+	scpi_info->channels = devm_kcalloc(dev, count, sizeof(struct scpi_chan),
+					   GFP_KERNEL);
+	if (!scpi_info->channels)
 		return -ENOMEM;
 
-	for (idx = 0; idx < count; idx++) {
+	ret = devm_add_action(dev, scpi_free_channels, scpi_info);
+	if (ret)
+		return ret;
+
+	for (; scpi_info->num_chans < count; scpi_info->num_chans++) {
 		resource_size_t size;
-		struct scpi_chan *pchan = scpi_chan + idx;
+		int idx = scpi_info->num_chans;
+		struct scpi_chan *pchan = scpi_info->channels + idx;
 		struct mbox_client *cl = &pchan->cl;
 		struct device_node *shmem = of_parse_phandle(np, "shmem", idx);
 
@@ -981,15 +982,14 @@ static int scpi_probe(struct platform_device *pdev)
 		of_node_put(shmem);
 		if (ret) {
 			dev_err(dev, "failed to get SCPI payload mem resource\n");
-			goto err;
+			return ret;
 		}
 
 		size = resource_size(&res);
 		pchan->rx_payload = devm_ioremap(dev, res.start, size);
 		if (!pchan->rx_payload) {
 			dev_err(dev, "failed to ioremap SCPI payload\n");
-			ret = -EADDRNOTAVAIL;
-			goto err;
+			return -EADDRNOTAVAIL;
 		}
 		pchan->tx_payload = pchan->rx_payload + (size >> 1);
 
@@ -1015,14 +1015,9 @@ static int scpi_probe(struct platform_device *pdev)
 				dev_err(dev, "failed to get channel%d err %d\n",
 					idx, ret);
 		}
-err:
-		scpi_free_channels(dev, scpi_chan, idx);
-		scpi_info = NULL;
 		return ret;
 	}
 
-	scpi_info->channels = scpi_chan;
-	scpi_info->num_chans = count;
 	scpi_info->commands = scpi_std_commands;
 
 	platform_set_drvdata(pdev, scpi_info);
-- 
2.15.1
