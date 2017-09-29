From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 29 Sep 2017 23:44:09 +0200
Subject: [PATCH 4/5] firmware: arm_scpi: make freeing mbox channels
 device-managed
In-Reply-To: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
Message-ID: <2626ebba-5145-cd06-7d7f-ff9fbc96d7f1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make freeing the mbox channels device-managed, thus further simplifying
scpi_remove and and one further step to get rid of scpi_remove.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index fd79adb5..c91f3241 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -902,16 +902,13 @@ static struct attribute *versions_attrs[] = {
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
@@ -920,7 +917,6 @@ static int scpi_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(dev);
 	sysfs_remove_groups(&dev->kobj, versions_groups);
-	scpi_free_channels(dev, scpi_info->channels, scpi_info->num_chans);
 
 	return 0;
 }
@@ -953,7 +949,6 @@ static int scpi_probe(struct platform_device *pdev)
 {
 	int count, idx, ret;
 	struct resource res;
-	struct scpi_chan *scpi_chan;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 
@@ -970,13 +965,19 @@ static int scpi_probe(struct platform_device *pdev)
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
 
@@ -984,15 +985,14 @@ static int scpi_probe(struct platform_device *pdev)
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
 
@@ -1018,14 +1018,9 @@ static int scpi_probe(struct platform_device *pdev)
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
 	scpi_info->scpi_ops = &scpi_ops;
 
-- 
2.14.2
