From: adrienverge@gmail.com (=?UTF-8?q?Adrien=20Verg=C3=A9?=)
Date: Thu, 30 Jan 2014 11:11:09 -0500
Subject: [PATCH V3 4/5] ARM CoreSight: ETM: Add address control support
In-Reply-To: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
References: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
Message-ID: <1391098270-8867-5-git-send-email-adrienverge@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the same manner as for enabling tracing, an entry is created
in sysfs to set the address range that triggers tracing.

Signed-off-by: Adrien Verg? <adrienverge@gmail.com>
---
 arch/arm/kernel/etm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index b3e6713..fa42e32 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -44,6 +44,8 @@ struct tracectx {
 	struct device	*dev;
 	struct clk	*emu_clk;
 	struct mutex	mutex;
+	unsigned long	addrrange_start;
+	unsigned long	addrrange_end;
 };
 
 static struct tracectx tracer;
@@ -53,6 +55,13 @@ static inline bool trace_isrunning(struct tracectx *t)
 	return !!(t->flags & TRACER_RUNNING);
 }
 
+/*
+ * Setups ETM to trace only when:
+ *   - address between start and end
+ *     or address not between start and end (if exclude)
+ *   - trace executed instructions
+ *     or trace loads and stores (if data)
+ */
 static int etm_setup_address_range(struct tracectx *t, int n,
 		unsigned long start, unsigned long end, int exclude, int data)
 {
@@ -115,8 +124,8 @@ static int trace_start(struct tracectx *t)
 		return -EFAULT;
 	}
 
-	etm_setup_address_range(t, 1, (unsigned long)_stext,
-			(unsigned long)_etext, 0, 0);
+	etm_setup_address_range(t, 1, t->addrrange_start, t->addrrange_end,
+				0, 0);
 	etm_writel(t, 0, ETMR_TRACEENCTRL2);
 	etm_writel(t, 0, ETMR_TRACESSCTRL);
 	etm_writel(t, 0x6f, ETMR_TRACEENEVT);
@@ -530,6 +539,36 @@ static ssize_t trace_mode_store(struct device *dev,
 
 DEVICE_ATTR(trace_mode, S_IRUGO|S_IWUSR, trace_mode_show, trace_mode_store);
 
+static ssize_t trace_addrrange_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%08lx - %08lx\n", tracer.addrrange_start,
+		       tracer.addrrange_end);
+}
+
+static ssize_t trace_addrrange_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t n)
+{
+	unsigned long start, end;
+
+	if (tracer.flags & TRACER_RUNNING)
+		return -EBUSY;
+
+	if (sscanf(buf, "%08lx - %08lx", &start, &end) != 2)
+		return -EINVAL;
+
+	mutex_lock(&tracer.mutex);
+	tracer.addrrange_start = start;
+	tracer.addrrange_end = end;
+	mutex_unlock(&tracer.mutex);
+
+	return n;
+}
+
+DEVICE_ATTR(trace_addrrange, S_IRUGO|S_IWUSR,
+	    trace_addrrange_show, trace_addrrange_store);
+
 static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct tracectx *t = &tracer;
@@ -557,6 +596,8 @@ static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 	t->dev = &dev->dev;
 	t->flags = TRACER_CYCLE_ACC;
 	t->etm_portsz = 1;
+	t->addrrange_start = (unsigned long) _stext;
+	t->addrrange_end = (unsigned long) _etext;
 
 	etm_unlock(t);
 	(void)etm_readl(t, ETMMR_PDSR);
@@ -571,7 +612,7 @@ static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto out_unmap;
 
-	/* failing to create any of these two is not fatal */
+	/* failing to create any of these three is not fatal */
 	ret = device_create_file(&dev->dev, &dev_attr_trace_info);
 	if (ret)
 		dev_dbg(&dev->dev, "Failed to create trace_info in sysfs\n");
@@ -580,6 +621,10 @@ static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		dev_dbg(&dev->dev, "Failed to create trace_mode in sysfs\n");
 
+	ret = device_create_file(&dev->dev, &dev_attr_trace_addrrange);
+	if (ret)
+		dev_dbg(&dev->dev, "Failed to create trace_addrrange in sysfs\n");
+
 	dev_dbg(t->dev, "ETM AMBA driver initialized.\n");
 
 out:
@@ -609,6 +654,7 @@ static int etm_remove(struct amba_device *dev)
 	device_remove_file(&dev->dev, &dev_attr_trace_running);
 	device_remove_file(&dev->dev, &dev_attr_trace_info);
 	device_remove_file(&dev->dev, &dev_attr_trace_mode);
+	device_remove_file(&dev->dev, &dev_attr_trace_addrrange);
 
 	return 0;
 }
-- 
1.8.5.3
