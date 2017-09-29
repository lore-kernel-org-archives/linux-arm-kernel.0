From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 29 Sep 2017 23:44:05 +0200
Subject: [PATCH 3/5] firmware: arm_scpi: pre-populate dvfs info in scpi_probe
In-Reply-To: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
Message-ID: <c8c0ff86-de14-f157-68e0-9df005defffa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pre-populating the dvfs info data in scpi_probe allows to make all
memory allocations device-managed. This helps to simplify scpi_remove
and eventually to get rid of scpi_remove completely.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 57 ++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index d80d11ae..fd79adb5 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -644,35 +644,35 @@ static int opp_cmp_func(const void *opp1, const void *opp2)
 }
 
 static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
+{
+	if (domain >= MAX_DVFS_DOMAINS)
+		return ERR_PTR(-EINVAL);
+
+	return scpi_info->dvfs[domain] ?: ERR_PTR(-EINVAL);
+}
+
+static int scpi_dvfs_populate_info(struct device *dev, u8 domain)
 {
 	struct scpi_dvfs_info *info;
 	struct scpi_opp *opp;
 	struct dvfs_info buf;
 	int ret, i;
 
-	if (domain >= MAX_DVFS_DOMAINS)
-		return ERR_PTR(-EINVAL);
-
-	if (scpi_info->dvfs[domain])	/* data already populated */
-		return scpi_info->dvfs[domain];
-
 	ret = scpi_send_message(CMD_GET_DVFS_INFO, &domain, sizeof(domain),
 				&buf, sizeof(buf));
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kmalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	info->count = DVFS_OPP_COUNT(buf.header);
 	info->latency = DVFS_LATENCY(buf.header) * 1000; /* uS to nS */
 
-	info->opps = kcalloc(info->count, sizeof(*opp), GFP_KERNEL);
-	if (!info->opps) {
-		kfree(info);
-		return ERR_PTR(-ENOMEM);
-	}
+	info->opps = devm_kcalloc(dev, info->count, sizeof(*opp), GFP_KERNEL);
+	if (!info->opps)
+		return -ENOMEM;
 
 	for (i = 0, opp = info->opps; i < info->count; i++, opp++) {
 		opp->freq = le32_to_cpu(buf.opps[i].freq);
@@ -682,7 +682,20 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	sort(info->opps, info->count, sizeof(*opp), opp_cmp_func, NULL);
 
 	scpi_info->dvfs[domain] = info;
-	return info;
+	return 0;
+}
+
+static int scpi_dvfs_populate(struct device *dev)
+{
+	int ret, i;
+
+	for (i = 0; i < MAX_DVFS_DOMAINS; i++) {
+		ret = scpi_dvfs_populate_info(dev, i);
+		if (ret)
+			break;
+	}
+
+	return i > 0 ? 0 : ret;
 }
 
 static int scpi_dev_domain_id(struct device *dev)
@@ -903,18 +916,12 @@ scpi_free_channels(struct device *dev, struct scpi_chan *pchan, int count)
 
 static int scpi_remove(struct platform_device *pdev)
 {
-	int i;
 	struct device *dev = &pdev->dev;
 
 	of_platform_depopulate(dev);
 	sysfs_remove_groups(&dev->kobj, versions_groups);
 	scpi_free_channels(dev, scpi_info->channels, scpi_info->num_chans);
 
-	for (i = 0; i < MAX_DVFS_DOMAINS && scpi_info->dvfs[i]; i++) {
-		kfree(scpi_info->dvfs[i]->opps);
-		kfree(scpi_info->dvfs[i]);
-	}
-
 	return 0;
 }
 
@@ -1020,6 +1027,7 @@ static int scpi_probe(struct platform_device *pdev)
 	scpi_info->channels = scpi_chan;
 	scpi_info->num_chans = count;
 	scpi_info->commands = scpi_std_commands;
+	scpi_info->scpi_ops = &scpi_ops;
 
 	if (scpi_info->is_legacy) {
 		/* Replace with legacy variants */
@@ -1039,13 +1047,18 @@ static int scpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = scpi_dvfs_populate(dev);
+	if (ret) {
+		scpi_remove(pdev);
+		return ret;
+	}
+
 	_dev_info(dev, "SCP Protocol %d.%d Firmware %d.%d.%d version\n",
 		  PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
 		  PROTOCOL_REV_MINOR(scpi_info->protocol_version),
 		  FW_REV_MAJOR(scpi_info->firmware_version),
 		  FW_REV_MINOR(scpi_info->firmware_version),
 		  FW_REV_PATCH(scpi_info->firmware_version));
-	scpi_info->scpi_ops = &scpi_ops;
 
 	ret = sysfs_create_groups(&dev->kobj, versions_groups);
 	if (ret)
-- 
2.14.2
