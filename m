From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 08:47:41 -0600
Subject: [PATCH] coresight: etm3x: adding cpu affinity to sysFS interface
Message-ID: <1442587661-1796-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without access to the device tree, it is impossible to know
what CPU a tracer is affined to.  As such adding a new sysFS
interface to convey the information.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index bf2476ed9356..4797f56e7f13 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1545,6 +1545,18 @@ static ssize_t status_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(status);
 
+static ssize_t cpu_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int val;
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	val = drvdata->cpu;
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+
+}
+static DEVICE_ATTR_RO(cpu);
+
 static ssize_t traceid_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -1621,6 +1633,7 @@ static struct attribute *coresight_etm_attrs[] = {
 	&dev_attr_timestamp_event.attr,
 	&dev_attr_status.attr,
 	&dev_attr_traceid.attr,
+	&dev_attr_cpu.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(coresight_etm);
-- 
1.9.1
