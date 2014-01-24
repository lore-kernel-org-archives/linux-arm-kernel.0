From: adrienverge@gmail.com (=?UTF-8?q?Adrien=20Verg=C3=A9?=)
Date: Fri, 24 Jan 2014 11:40:51 -0500
Subject: [PATCH V2 1/6] ARM CoreSight: ETM: Use device attributes
In-Reply-To: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
References: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
Message-ID: <1390581656-16372-2-git-send-email-adrienverge@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace all kobjects attributes with device attributes.
User experience isn't changed since the same files are created in sysfs.

Signed-off-by: Adrien Verg? <adrienverge@gmail.com>
---
 arch/arm/kernel/etm.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 8ff0ecd..2b1a307 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -430,15 +430,14 @@ static struct amba_driver etb_driver = {
 };
 
 /* use a sysfs file "trace_running" to start/stop tracing */
-static ssize_t trace_running_show(struct kobject *kobj,
-				  struct kobj_attribute *attr,
-				  char *buf)
+static ssize_t trace_running_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%x\n", trace_isrunning(&tracer));
 }
 
-static ssize_t trace_running_store(struct kobject *kobj,
-				   struct kobj_attribute *attr,
+static ssize_t trace_running_store(struct device *dev,
+				   struct device_attribute *attr,
 				   const char *buf, size_t n)
 {
 	unsigned int value;
@@ -454,12 +453,11 @@ static ssize_t trace_running_store(struct kobject *kobj,
 	return ret ? : n;
 }
 
-static struct kobj_attribute trace_running_attr =
-	__ATTR(trace_running, 0644, trace_running_show, trace_running_store);
+DEVICE_ATTR(trace_running, S_IRUGO|S_IWUSR,
+	    trace_running_show, trace_running_store);
 
-static ssize_t trace_info_show(struct kobject *kobj,
-				  struct kobj_attribute *attr,
-				  char *buf)
+static ssize_t trace_info_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	u32 etb_wa, etb_ra, etb_st, etb_fc, etm_ctrl, etm_st;
 	int datalen;
@@ -495,21 +493,19 @@ static ssize_t trace_info_show(struct kobject *kobj,
 			);
 }
 
-static struct kobj_attribute trace_info_attr =
-	__ATTR(trace_info, 0444, trace_info_show, NULL);
+DEVICE_ATTR(trace_info, S_IRUGO, trace_info_show, NULL);
 
-static ssize_t trace_mode_show(struct kobject *kobj,
-				  struct kobj_attribute *attr,
-				  char *buf)
+static ssize_t trace_mode_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d %d\n",
 			!!(tracer.flags & TRACER_CYCLE_ACC),
 			tracer.etm_portsz);
 }
 
-static ssize_t trace_mode_store(struct kobject *kobj,
-				   struct kobj_attribute *attr,
-				   const char *buf, size_t n)
+static ssize_t trace_mode_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t n)
 {
 	unsigned int cycacc, portsz;
 
@@ -528,8 +524,7 @@ static ssize_t trace_mode_store(struct kobject *kobj,
 	return n;
 }
 
-static struct kobj_attribute trace_mode_attr =
-	__ATTR(trace_mode, 0644, trace_mode_show, trace_mode_store);
+DEVICE_ATTR(trace_mode, S_IRUGO|S_IWUSR, trace_mode_show, trace_mode_store);
 
 static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 {
@@ -568,17 +563,16 @@ static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 	etm_writel(t, 0x440, ETMR_CTRL);
 	etm_lock(t);
 
-	ret = sysfs_create_file(&dev->dev.kobj,
-			&trace_running_attr.attr);
+	ret = device_create_file(&dev->dev, &dev_attr_trace_running);
 	if (ret)
 		goto out_unmap;
 
 	/* failing to create any of these two is not fatal */
-	ret = sysfs_create_file(&dev->dev.kobj, &trace_info_attr.attr);
+	ret = device_create_file(&dev->dev, &dev_attr_trace_info);
 	if (ret)
 		dev_dbg(&dev->dev, "Failed to create trace_info in sysfs\n");
 
-	ret = sysfs_create_file(&dev->dev.kobj, &trace_mode_attr.attr);
+	ret = device_create_file(&dev->dev, &dev_attr_trace_mode);
 	if (ret)
 		dev_dbg(&dev->dev, "Failed to create trace_mode in sysfs\n");
 
@@ -608,9 +602,9 @@ static int etm_remove(struct amba_device *dev)
 
 	amba_release_regions(dev);
 
-	sysfs_remove_file(&dev->dev.kobj, &trace_running_attr.attr);
-	sysfs_remove_file(&dev->dev.kobj, &trace_info_attr.attr);
-	sysfs_remove_file(&dev->dev.kobj, &trace_mode_attr.attr);
+	device_remove_file(&dev->dev, &dev_attr_trace_running);
+	device_remove_file(&dev->dev, &dev_attr_trace_info);
+	device_remove_file(&dev->dev, &dev_attr_trace_mode);
 
 	return 0;
 }
-- 
1.8.5.2
