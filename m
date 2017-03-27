From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 27 Mar 2017 11:09:32 -0600
Subject: [PATCH 2/3] coresight: etm3x: Correctly output counter values in
 sysfs node
In-Reply-To: <1490634573-11068-1-git-send-email-mathieu.poirier@linaro.org>
References: <1490634573-11068-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1490634573-11068-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olav Haugan <ohaugan@codeaurora.org>

cntr_val_show function does not print the intended information. It is only
printing the latest counter value. Fix this.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 4cbbd1313331..62acf07d604b 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -730,19 +730,29 @@ static ssize_t cntr_val_show(struct device *dev,
 	u32 val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
+	int buf_size = PAGE_SIZE;
 
 	if (!local_read(&drvdata->mode)) {
 		spin_lock(&drvdata->spinlock);
-		for (i = 0; i < drvdata->nr_cntr; i++)
-			ret += scnprintf(buf, PAGE_SIZE, "counter %d: %x\n",
-				       i, config->cntr_val[i]);
+		for (i = 0; i < drvdata->nr_cntr; i++) {
+			ret += scnprintf(&buf[ret], buf_size,
+					 "counter %d: %x\n",
+					 i, config->cntr_val[i]);
+			buf_size -= ret;
+			if (buf_size <= 0)
+				break;
+		}
 		spin_unlock(&drvdata->spinlock);
 		return ret;
 	}
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		val = etm_readl(drvdata, ETMCNTVRn(i));
-		ret += scnprintf(buf, PAGE_SIZE, "counter %d: %x\n", i, val);
+		ret += scnprintf(&buf[ret], buf_size,
+				 "counter %d: %x\n", i, val);
+		buf_size -= ret;
+		if (buf_size <= 0)
+			break;
 	}
 
 	return ret;
-- 
2.7.4
