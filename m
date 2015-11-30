From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 29 Nov 2015 19:14:37 -0700
Subject: [PATCH V5 16/26] coresight: etb10: moving to local atomic operations
In-Reply-To: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448849687-5724-17-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving to use local atomic operations to take advantage of the
lockless implementation, something that will come handy when
the ETB is accessed from the Perf subsystem. Also changing the
name of the variable to something more meaningful.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 1301edc44629..09e306361e4f 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -10,6 +10,7 @@
  * GNU General Public License for more details.
  */
 
+#include <asm/local.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -71,7 +72,7 @@
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.etb" entry.
  * @spinlock:	only one at a time pls.
- * @in_use:	synchronise user space access to etb buffer.
+ * @reading:	synchronise user space access to etb buffer.
  * @buf:	area of memory where ETB buffer content gets sent.
  * @buffer_depth: size of @buf.
  * @enable:	this ETB is being used.
@@ -84,7 +85,7 @@ struct etb_drvdata {
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
-	atomic_t		in_use;
+	local_t			reading;
 	u8			*buf;
 	u32			buffer_depth;
 	bool			enable;
@@ -277,7 +278,7 @@ static int etb_open(struct inode *inode, struct file *file)
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
 
-	if (atomic_cmpxchg(&drvdata->in_use, 0, 1))
+	if (local_cmpxchg(&drvdata->reading, 0, 1))
 		return -EBUSY;
 
 	dev_dbg(drvdata->dev, "%s: successfully opened\n", __func__);
@@ -313,7 +314,7 @@ static int etb_release(struct inode *inode, struct file *file)
 {
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
-	atomic_set(&drvdata->in_use, 0);
+	local_set(&drvdata->reading, 0);
 
 	dev_dbg(drvdata->dev, "%s: released\n", __func__);
 	return 0;
-- 
2.1.4
