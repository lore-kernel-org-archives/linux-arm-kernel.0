From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 12 Nov 2014 14:22:03 +0300
Subject: [patch] coresight-etm: unlock on error paths in mode_store()
Message-ID: <20141112112202.GA28836@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some missing unlocks on the error paths.

Fixes: a939fc5a71ad ('coresight-etm: add CoreSight ETM/PTM driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't have a cross compiler set up so I haven't compiled this.  But
I think it doesn't have any typos.  :)

diff --git a/drivers/coresight/coresight-etm3x.c b/drivers/coresight/coresight-etm3x.c
index d9e3ed6..369cac0 100644
--- a/drivers/coresight/coresight-etm3x.c
+++ b/drivers/coresight/coresight-etm3x.c
@@ -573,7 +573,8 @@ static ssize_t mode_store(struct device *dev,
 	if (drvdata->mode & ETM_MODE_STALL) {
 		if (!(drvdata->etmccr & ETMCCR_FIFOFULL)) {
 			dev_warn(drvdata->dev, "stall mode not supported\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_unlock;
 		}
 		drvdata->ctrl |= ETMCR_STALL_MODE;
 	 } else
@@ -582,7 +583,8 @@ static ssize_t mode_store(struct device *dev,
 	if (drvdata->mode & ETM_MODE_TIMESTAMP) {
 		if (!(drvdata->etmccer & ETMCCER_TIMESTAMP)) {
 			dev_warn(drvdata->dev, "timestamp not supported\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_unlock;
 		}
 		drvdata->ctrl |= ETMCR_TIMESTAMP_EN;
 	} else
@@ -595,6 +597,10 @@ static ssize_t mode_store(struct device *dev,
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
+
+err_unlock:
+	spin_unlock(&drvdata->spinlock);
+	return ret;
 }
 static DEVICE_ATTR_RW(mode);
 
