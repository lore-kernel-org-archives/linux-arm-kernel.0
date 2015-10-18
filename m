From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:35 -0600
Subject: [PATCH V2 18/30] coresight: etb10: moving to local atomic operations
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-19-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving to use local atomic operations to take advantage of the
lockless implementation, something that will come handy when
the ETB is accessed from the Perf subsystem.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 77d0f9c1118d..ecdbe0dd4d08 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -84,7 +84,7 @@ struct etb_drvdata {
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
-	atomic_t		in_use;
+	local_t			in_use;
 	u8			*buf;
 	u32			buffer_depth;
 	bool			enable;
@@ -281,7 +281,7 @@ static int etb_open(struct inode *inode, struct file *file)
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
 
-	if (atomic_cmpxchg(&drvdata->in_use, 0, 1))
+	if (local_cmpxchg(&drvdata->in_use, 0, 1))
 		return -EBUSY;
 
 	dev_dbg(drvdata->dev, "%s: successfully opened\n", __func__);
@@ -317,7 +317,7 @@ static int etb_release(struct inode *inode, struct file *file)
 {
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
-	atomic_set(&drvdata->in_use, 0);
+	local_set(&drvdata->in_use, 0);
 
 	dev_dbg(drvdata->dev, "%s: released\n", __func__);
 	return 0;
-- 
1.9.1
