From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:21 -0600
Subject: [PATCH V2 04/30] coresight: etm3x: splitting struct etm_drvdata
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Structure "etm_drvdata" carries the tracer's static configuration
(as laid out in hardware) and the session specific configuration
determined by users.  This doesn't work when tracers are to support
multiple, simultaneous, tracing session.

As such splitting "etm_drvdata" in two sections, one for the HW
specific data and another for user configuration.  The latter is
a pointer to a newly created "etm_config" structure.

That way several tracing session configuration can be created and
associated, when required, to a tracer.

Also taking care of up-lifting all the code affected by this new
arrangement.  No loss or gain of functionality (other than what is
mentioned above) is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h        | 102 ++---
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 460 +++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c      | 176 +++++---
 3 files changed, 504 insertions(+), 234 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 9a30aa392ed9..9317510d555f 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -136,29 +136,9 @@
 #define ETM_DEFAULT_EVENT_VAL	(ETM_HARD_WIRE_RES_A	|	\
 				 ETM_ADD_COMP_0		|	\
 				 ETM_EVENT_NOT_A)
+
 /**
- * struct etm_drvdata - specifics associated to an ETM component
- * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated to this component.
- * @atclk:	optional clock for the core parts of the ETM.
- * @csdev:	component vitals needed by the framework.
- * @spinlock:	only one at a time pls.
- * @cpu:	the cpu this component is affined to.
- * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
- * @arch:	ETM/PTM version number.
- * @use_cpu14:	true if management registers need to be accessed via CP14.
- * @enable:	is this ETM/PTM currently tracing.
- * @sticky_enable: true if ETM base configuration has been done.
- * @boot_enable:true if we should start tracing at boot time.
- * @os_unlock:	true if access to management registers is allowed.
- * @nr_addr_cmp:Number of pairs of address comparators as found in ETMCCR.
- * @nr_cntr:	Number of counters as found in ETMCCR bit 13-15.
- * @nr_ext_inp:	Number of external input as found in ETMCCR bit 17-19.
- * @nr_ext_out:	Number of external output as found in ETMCCR bit 20-22.
- * @nr_ctxid_cmp: Number of contextID comparators as found in ETMCCR bit 24-25.
- * @etmccr:	value of register ETMCCR.
- * @etmccer:	value of register ETMCCER.
- * @traceid:	value of the current ID for this component.
+ * struct etm_config - configuration information related to an ETM
  * @mode:	controls various modes supported by this ETM/PTM.
  * @ctrl:	used in conjunction with @mode.
  * @trigger_event: setting for register ETMTRIGGER.
@@ -189,30 +169,9 @@
  * @ctxid_mask: mask applicable to all the context IDs.
  * @sync_freq:	Synchronisation frequency.
  * @timestamp_event: Defines an event that requests the insertion
-		     of a timestamp into the trace stream.
+ *		     of a timestamp into the trace stream.
  */
-struct etm_drvdata {
-	void __iomem			*base;
-	struct device			*dev;
-	struct clk			*atclk;
-	struct coresight_device		*csdev;
-	spinlock_t			spinlock;
-	int				cpu;
-	int				port_size;
-	u8				arch;
-	bool				use_cp14;
-	bool				enable;
-	bool				sticky_enable;
-	bool				boot_enable;
-	bool				os_unlock;
-	u8				nr_addr_cmp;
-	u8				nr_cntr;
-	u8				nr_ext_inp;
-	u8				nr_ext_out;
-	u8				nr_ctxid_cmp;
-	u32				etmccr;
-	u32				etmccer;
-	u32				traceid;
+struct etm_config {
 	u32				mode;
 	u32				ctrl;
 	u32				trigger_event;
@@ -244,6 +203,56 @@ struct etm_drvdata {
 	u32				timestamp_event;
 };
 
+/**
+ * struct etm_drvdata - specifics associated to an ETM component
+ * @base:	memory mapped base address for this component.
+ * @dev:	the device entity associated to this component.
+ * @atclk:	optional clock for the core parts of the ETM.
+ * @csdev:	component vitals needed by the framework.
+ * @spinlock:	only one at a time pls.
+ * @cpu:	the cpu this component is affined to.
+ * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
+ * @arch:	ETM/PTM version number.
+ * @use_cpu14:	true if management registers need to be accessed via CP14.
+ * @enable:	is this ETM/PTM currently tracing.
+ * @sticky_enable: true if ETM base configuration has been done.
+ * @boot_enable:true if we should start tracing at boot time.
+ * @os_unlock:	true if access to management registers is allowed.
+ * @nr_addr_cmp:Number of pairs of address comparators as found in ETMCCR.
+ * @nr_cntr:	Number of counters as found in ETMCCR bit 13-15.
+ * @nr_ext_inp:	Number of external input as found in ETMCCR bit 17-19.
+ * @nr_ext_out:	Number of external output as found in ETMCCR bit 20-22.
+ * @nr_ctxid_cmp: Number of contextID comparators as found in ETMCCR bit 24-25.
+ * @etmccr:	value of register ETMCCR.
+ * @etmccer:	value of register ETMCCER.
+ * @traceid:	value of the current ID for this component.
+ * @config:	structure holding configuration parameters.
+ */
+struct etm_drvdata {
+	void __iomem			*base;
+	struct device			*dev;
+	struct clk			*atclk;
+	struct coresight_device		*csdev;
+	spinlock_t			spinlock;
+	int				cpu;
+	int				port_size;
+	u8				arch;
+	bool				use_cp14;
+	bool				enable;
+	bool				sticky_enable;
+	bool				boot_enable;
+	bool				os_unlock;
+	u8				nr_addr_cmp;
+	u8				nr_cntr;
+	u8				nr_ext_inp;
+	u8				nr_ext_out;
+	u8				nr_ctxid_cmp;
+	u32				etmccr;
+	u32				etmccer;
+	u32				traceid;
+	struct etm_config		*config;
+};
+
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
 	ETM_ADDR_TYPE_SINGLE,
@@ -283,5 +292,6 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
 
 extern const struct attribute_group *coresight_etm_groups[];
 int etm_get_trace_id(struct etm_drvdata *drvdata);
-void etm_set_default(struct etm_drvdata *drvdata);
+void etm_set_default(struct etm_config *config);
+struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index f409f5a88e95..410d29e2b90c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -78,6 +78,10 @@ static ssize_t reset_store(struct device *dev,
 	int i, ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -85,19 +89,19 @@ static ssize_t reset_store(struct device *dev,
 
 	if (val) {
 		spin_lock(&drvdata->spinlock);
-		drvdata->mode = ETM_MODE_EXCLUDE;
-		drvdata->ctrl = 0x0;
-		drvdata->trigger_event = ETM_DEFAULT_EVENT_VAL;
-		drvdata->startstop_ctrl = 0x0;
-		drvdata->addr_idx = 0x0;
+		config->mode = ETM_MODE_EXCLUDE;
+		config->ctrl = 0x0;
+		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
+		config->startstop_ctrl = 0x0;
+		config->addr_idx = 0x0;
 		for (i = 0; i < drvdata->nr_addr_cmp; i++) {
-			drvdata->addr_val[i] = 0x0;
-			drvdata->addr_acctype[i] = 0x0;
-			drvdata->addr_type[i] = ETM_ADDR_TYPE_NONE;
+			config->addr_val[i] = 0x0;
+			config->addr_acctype[i] = 0x0;
+			config->addr_type[i] = ETM_ADDR_TYPE_NONE;
 		}
-		drvdata->cntr_idx = 0x0;
+		config->cntr_idx = 0x0;
 
-		etm_set_default(drvdata);
+		etm_set_default(config);
 		spin_unlock(&drvdata->spinlock);
 	}
 
@@ -110,8 +114,12 @@ static ssize_t mode_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->mode;
+	val = config->mode;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -122,48 +130,52 @@ static ssize_t mode_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->mode = val & ETM_MODE_ALL;
+	config->mode = val & ETM_MODE_ALL;
 
-	if (drvdata->mode & ETM_MODE_EXCLUDE)
-		drvdata->enable_ctrl1 |= ETMTECR1_INC_EXC;
+	if (config->mode & ETM_MODE_EXCLUDE)
+		config->enable_ctrl1 |= ETMTECR1_INC_EXC;
 	else
-		drvdata->enable_ctrl1 &= ~ETMTECR1_INC_EXC;
+		config->enable_ctrl1 &= ~ETMTECR1_INC_EXC;
 
-	if (drvdata->mode & ETM_MODE_CYCACC)
-		drvdata->ctrl |= ETMCR_CYC_ACC;
+	if (config->mode & ETM_MODE_CYCACC)
+		config->ctrl |= ETMCR_CYC_ACC;
 	else
-		drvdata->ctrl &= ~ETMCR_CYC_ACC;
+		config->ctrl &= ~ETMCR_CYC_ACC;
 
-	if (drvdata->mode & ETM_MODE_STALL) {
+	if (config->mode & ETM_MODE_STALL) {
 		if (!(drvdata->etmccr & ETMCCR_FIFOFULL)) {
 			dev_warn(drvdata->dev, "stall mode not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
 		}
-		drvdata->ctrl |= ETMCR_STALL_MODE;
+		config->ctrl |= ETMCR_STALL_MODE;
 	 } else
-		drvdata->ctrl &= ~ETMCR_STALL_MODE;
+		config->ctrl &= ~ETMCR_STALL_MODE;
 
-	if (drvdata->mode & ETM_MODE_TIMESTAMP) {
+	if (config->mode & ETM_MODE_TIMESTAMP) {
 		if (!(drvdata->etmccer & ETMCCER_TIMESTAMP)) {
 			dev_warn(drvdata->dev, "timestamp not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
 		}
-		drvdata->ctrl |= ETMCR_TIMESTAMP_EN;
+		config->ctrl |= ETMCR_TIMESTAMP_EN;
 	} else
-		drvdata->ctrl &= ~ETMCR_TIMESTAMP_EN;
+		config->ctrl &= ~ETMCR_TIMESTAMP_EN;
 
-	if (drvdata->mode & ETM_MODE_CTXID)
-		drvdata->ctrl |= ETMCR_CTXID_SIZE;
+	if (config->mode & ETM_MODE_CTXID)
+		config->ctrl |= ETMCR_CTXID_SIZE;
 	else
-		drvdata->ctrl &= ~ETMCR_CTXID_SIZE;
+		config->ctrl &= ~ETMCR_CTXID_SIZE;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -179,8 +191,12 @@ static ssize_t trigger_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->trigger_event;
+	val = config->trigger_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -191,12 +207,16 @@ static ssize_t trigger_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->trigger_event = val & ETM_EVENT_MASK;
+	config->trigger_event = val & ETM_EVENT_MASK;
 
 	return size;
 }
@@ -207,8 +227,12 @@ static ssize_t enable_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->enable_event;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->enable_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -219,12 +243,16 @@ static ssize_t enable_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->enable_event = val & ETM_EVENT_MASK;
+	config->enable_event = val & ETM_EVENT_MASK;
 
 	return size;
 }
@@ -235,8 +263,12 @@ static ssize_t fifofull_level_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->fifofull_level;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->fifofull_level;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -247,12 +279,16 @@ static ssize_t fifofull_level_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->fifofull_level = val;
+	config->fifofull_level = val;
 
 	return size;
 }
@@ -263,8 +299,12 @@ static ssize_t addr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->addr_idx;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->addr_idx;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -275,6 +315,10 @@ static ssize_t addr_idx_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -288,7 +332,7 @@ static ssize_t addr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->addr_idx = val;
+	config->addr_idx = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -301,16 +345,20 @@ static ssize_t addr_single_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	idx = config->addr_idx;
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
-	val = drvdata->addr_val[idx];
+	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -324,21 +372,25 @@ static ssize_t addr_single_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	idx = config->addr_idx;
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
-	drvdata->addr_val[idx] = val;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
+	config->addr_val[idx] = val;
+	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -351,23 +403,27 @@ static ssize_t addr_range_show(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (idx % 2 != 0) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
-	if (!((drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
-	      (drvdata->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val1 = drvdata->addr_val[idx];
-	val2 = drvdata->addr_val[idx + 1];
+	val1 = config->addr_val[idx];
+	val2 = config->addr_val[idx + 1];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx %#lx\n", val1, val2);
@@ -380,6 +436,10 @@ static ssize_t addr_range_store(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
 		return -EINVAL;
@@ -388,24 +448,24 @@ static ssize_t addr_range_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (idx % 2 != 0) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
-	if (!((drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
-	      (drvdata->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	drvdata->addr_val[idx] = val1;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
-	drvdata->addr_val[idx + 1] = val2;
-	drvdata->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
-	drvdata->enable_ctrl1 |= (1 << (idx/2));
+	config->addr_val[idx] = val1;
+	config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
+	config->addr_val[idx + 1] = val2;
+	config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
+	config->enable_ctrl1 |= (1 << (idx/2));
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -418,16 +478,20 @@ static ssize_t addr_start_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	idx = config->addr_idx;
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = drvdata->addr_val[idx];
+	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -441,23 +505,27 @@ static ssize_t addr_start_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	idx = config->addr_idx;
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	drvdata->addr_val[idx] = val;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_START;
-	drvdata->startstop_ctrl |= (1 << idx);
-	drvdata->enable_ctrl1 |= BIT(25);
+	config->addr_val[idx] = val;
+	config->addr_type[idx] = ETM_ADDR_TYPE_START;
+	config->startstop_ctrl |= (1 << idx);
+	config->enable_ctrl1 |= BIT(25);
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -470,16 +538,20 @@ static ssize_t addr_stop_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	idx = config->addr_idx;
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = drvdata->addr_val[idx];
+	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -493,23 +565,27 @@ static ssize_t addr_stop_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	idx = config->addr_idx;
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	drvdata->addr_val[idx] = val;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_STOP;
-	drvdata->startstop_ctrl |= (1 << (idx + 16));
-	drvdata->enable_ctrl1 |= ETMTECR1_START_STOP;
+	config->addr_val[idx] = val;
+	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
+	config->startstop_ctrl |= (1 << (idx + 16));
+	config->enable_ctrl1 |= ETMTECR1_START_STOP;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -521,9 +597,13 @@ static ssize_t addr_acctype_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val = drvdata->addr_acctype[drvdata->addr_idx];
+	val = config->addr_acctype[config->addr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -536,13 +616,17 @@ static ssize_t addr_acctype_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->addr_acctype[drvdata->addr_idx] = val;
+	config->addr_acctype[config->addr_idx] = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -554,8 +638,12 @@ static ssize_t cntr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->cntr_idx;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->cntr_idx;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -566,6 +654,10 @@ static ssize_t cntr_idx_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -578,7 +670,7 @@ static ssize_t cntr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->cntr_idx = val;
+	config->cntr_idx = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -590,9 +682,13 @@ static ssize_t cntr_rld_val_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val = drvdata->cntr_rld_val[drvdata->cntr_idx];
+	val = config->cntr_rld_val[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -605,13 +701,17 @@ static ssize_t cntr_rld_val_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->cntr_rld_val[drvdata->cntr_idx] = val;
+	config->cntr_rld_val[config->cntr_idx] = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -623,9 +723,13 @@ static ssize_t cntr_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val = drvdata->cntr_event[drvdata->cntr_idx];
+	val = config->cntr_event[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -638,13 +742,17 @@ static ssize_t cntr_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->cntr_event[drvdata->cntr_idx] = val & ETM_EVENT_MASK;
+	config->cntr_event[config->cntr_idx] = val & ETM_EVENT_MASK;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -656,9 +764,13 @@ static ssize_t cntr_rld_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val = drvdata->cntr_rld_event[drvdata->cntr_idx];
+	val = config->cntr_rld_event[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -671,13 +783,17 @@ static ssize_t cntr_rld_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->cntr_rld_event[drvdata->cntr_idx] = val & ETM_EVENT_MASK;
+	config->cntr_rld_event[config->cntr_idx] = val & ETM_EVENT_MASK;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -690,12 +806,16 @@ static ssize_t cntr_val_show(struct device *dev,
 	int i, ret = 0;
 	u32 val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	if (!drvdata->enable) {
 		spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
 			ret += sprintf(buf, "counter %d: %x\n",
-				       i, drvdata->cntr_val[i]);
+				       i, config->cntr_val[i]);
 		spin_unlock(&drvdata->spinlock);
 		return ret;
 	}
@@ -715,13 +835,17 @@ static ssize_t cntr_val_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->cntr_val[drvdata->cntr_idx] = val;
+	config->cntr_val[config->cntr_idx] = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -733,8 +857,12 @@ static ssize_t seq_12_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->seq_12_event;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->seq_12_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -745,12 +873,16 @@ static ssize_t seq_12_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->seq_12_event = val & ETM_EVENT_MASK;
+	config->seq_12_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_12_event);
@@ -760,8 +892,12 @@ static ssize_t seq_21_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->seq_21_event;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->seq_21_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -772,12 +908,16 @@ static ssize_t seq_21_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->seq_21_event = val & ETM_EVENT_MASK;
+	config->seq_21_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_21_event);
@@ -787,8 +927,12 @@ static ssize_t seq_23_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->seq_23_event;
+	val = config->seq_23_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -799,12 +943,16 @@ static ssize_t seq_23_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->seq_23_event = val & ETM_EVENT_MASK;
+	config->seq_23_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_23_event);
@@ -814,8 +962,12 @@ static ssize_t seq_31_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->seq_31_event;
+	val = config->seq_31_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -826,12 +978,16 @@ static ssize_t seq_31_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->seq_31_event = val & ETM_EVENT_MASK;
+	config->seq_31_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_31_event);
@@ -841,8 +997,12 @@ static ssize_t seq_32_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->seq_32_event;
+	val = config->seq_32_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -853,12 +1013,16 @@ static ssize_t seq_32_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->seq_32_event = val & ETM_EVENT_MASK;
+	config->seq_32_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_32_event);
@@ -868,8 +1032,12 @@ static ssize_t seq_13_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->seq_13_event;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->seq_13_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -880,12 +1048,16 @@ static ssize_t seq_13_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->seq_13_event = val & ETM_EVENT_MASK;
+	config->seq_13_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_13_event);
@@ -895,9 +1067,13 @@ static ssize_t seq_curr_state_show(struct device *dev,
 {
 	unsigned long val, flags;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	if (!drvdata->enable) {
-		val = drvdata->seq_curr_state;
+		val = config->seq_curr_state;
 		goto out;
 	}
 
@@ -921,6 +1097,10 @@ static ssize_t seq_curr_state_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -929,7 +1109,7 @@ static ssize_t seq_curr_state_store(struct device *dev,
 	if (val > ETM_SEQ_STATE_MAX_VAL)
 		return -EINVAL;
 
-	drvdata->seq_curr_state = val;
+	config->seq_curr_state = val;
 
 	return size;
 }
@@ -940,8 +1120,12 @@ static ssize_t ctxid_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
 
-	val = drvdata->ctxid_idx;
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
+
+	val = config->ctxid_idx;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -952,6 +1136,10 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -965,7 +1153,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->ctxid_idx = val;
+	config->ctxid_idx = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -977,9 +1165,13 @@ static ssize_t ctxid_pid_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val = drvdata->ctxid_vpid[drvdata->ctxid_idx];
+	val = config->ctxid_vpid[config->ctxid_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -992,6 +1184,10 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	int ret;
 	unsigned long vpid, pid;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &vpid);
 	if (ret)
@@ -1000,8 +1196,8 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	pid = coresight_vpid_to_pid(vpid);
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->ctxid_pid[drvdata->ctxid_idx] = pid;
-	drvdata->ctxid_vpid[drvdata->ctxid_idx] = vpid;
+	config->ctxid_pid[config->ctxid_idx] = pid;
+	config->ctxid_vpid[config->ctxid_idx] = vpid;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -1013,8 +1209,12 @@ static ssize_t ctxid_mask_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->ctxid_mask;
+	val = config->ctxid_mask;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -1025,12 +1225,16 @@ static ssize_t ctxid_mask_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->ctxid_mask = val;
+	config->ctxid_mask = val;
 	return size;
 }
 static DEVICE_ATTR_RW(ctxid_mask);
@@ -1040,8 +1244,12 @@ static ssize_t sync_freq_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->sync_freq;
+	val = config->sync_freq;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -1052,12 +1260,16 @@ static ssize_t sync_freq_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->sync_freq = val & ETM_SYNC_MASK;
+	config->sync_freq = val & ETM_SYNC_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(sync_freq);
@@ -1067,8 +1279,12 @@ static ssize_t timestamp_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
-	val = drvdata->timestamp_event;
+	val = config->timestamp_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -1079,12 +1295,16 @@ static ssize_t timestamp_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	drvdata->timestamp_event = val & ETM_EVENT_MASK;
+	config->timestamp_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(timestamp_event);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 737b6164f4a5..966955f5b0f9 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -41,6 +41,7 @@ module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 /* The number of ETM/PTM currently registered */
 static int etm_count;
 static struct etm_drvdata *etmdrvdata[NR_CPUS];
+static void etm_init_default_data(struct etm_config *config);
 
 /*
  * Memory mapped writes to clear os lock are not supported on some processors
@@ -186,36 +187,57 @@ static void etm_clr_prog(struct etm_drvdata *drvdata)
 	}
 }
 
-void etm_set_default(struct etm_drvdata *drvdata)
+struct etm_config *get_etm_config(struct etm_drvdata *drvdata)
 {
-	int i;
+	struct  etm_config *config;
 
-	drvdata->trigger_event = ETM_DEFAULT_EVENT_VAL;
-	drvdata->enable_event = ETM_HARD_WIRE_RES_A;
+	if (drvdata->config)
+		goto out;
 
-	drvdata->seq_12_event = ETM_DEFAULT_EVENT_VAL;
-	drvdata->seq_21_event = ETM_DEFAULT_EVENT_VAL;
-	drvdata->seq_23_event = ETM_DEFAULT_EVENT_VAL;
-	drvdata->seq_31_event = ETM_DEFAULT_EVENT_VAL;
-	drvdata->seq_32_event = ETM_DEFAULT_EVENT_VAL;
-	drvdata->seq_13_event = ETM_DEFAULT_EVENT_VAL;
-	drvdata->timestamp_event = ETM_DEFAULT_EVENT_VAL;
+	config = kzalloc(sizeof(struct etm_config), GFP_KERNEL);
+	if (!config)
+		return NULL;
 
-	for (i = 0; i < drvdata->nr_cntr; i++) {
-		drvdata->cntr_rld_val[i] = 0x0;
-		drvdata->cntr_event[i] = ETM_DEFAULT_EVENT_VAL;
-		drvdata->cntr_rld_event[i] = ETM_DEFAULT_EVENT_VAL;
-		drvdata->cntr_val[i] = 0x0;
+	/* Set default config */
+	etm_init_default_data(config);
+	drvdata->config = config;
+out:
+	return drvdata->config;
+}
+
+void etm_set_default(struct etm_config *config)
+{
+	int i;
+
+	if (WARN_ON_ONCE(!config))
+		return;
+
+	config->trigger_event = ETM_DEFAULT_EVENT_VAL;
+	config->enable_event = ETM_HARD_WIRE_RES_A;
+
+	config->seq_12_event = ETM_DEFAULT_EVENT_VAL;
+	config->seq_21_event = ETM_DEFAULT_EVENT_VAL;
+	config->seq_23_event = ETM_DEFAULT_EVENT_VAL;
+	config->seq_31_event = ETM_DEFAULT_EVENT_VAL;
+	config->seq_32_event = ETM_DEFAULT_EVENT_VAL;
+	config->seq_13_event = ETM_DEFAULT_EVENT_VAL;
+	config->timestamp_event = ETM_DEFAULT_EVENT_VAL;
+
+	for (i = 0; i < ETM_MAX_CNTR; i++) {
+		config->cntr_rld_val[i] = 0x0;
+		config->cntr_event[i] = ETM_DEFAULT_EVENT_VAL;
+		config->cntr_rld_event[i] = ETM_DEFAULT_EVENT_VAL;
+		config->cntr_val[i] = 0x0;
 	}
 
-	drvdata->seq_curr_state = 0x0;
-	drvdata->ctxid_idx = 0x0;
-	for (i = 0; i < drvdata->nr_ctxid_cmp; i++) {
-		drvdata->ctxid_pid[i] = 0x0;
-		drvdata->ctxid_vpid[i] = 0x0;
+	config->seq_curr_state = 0x0;
+	config->ctxid_idx = 0x0;
+	for (i = 0; i < ETM_MAX_CTXID_CMP; i++) {
+		config->ctxid_pid[i] = 0x0;
+		config->ctxid_vpid[i] = 0x0;
 	}
 
-	drvdata->ctxid_mask = 0x0;
+	config->ctxid_mask = 0x0;
 }
 
 static void etm_enable_hw(void *info)
@@ -223,6 +245,10 @@ static void etm_enable_hw(void *info)
 	int i;
 	u32 etmcr;
 	struct etm_drvdata *drvdata = info;
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -238,39 +264,39 @@ static void etm_enable_hw(void *info)
 	etmcr = etm_readl(drvdata, ETMCR);
 	etmcr &= (ETMCR_PWD_DWN | ETMCR_ETM_PRG);
 	etmcr |= drvdata->port_size;
-	etm_writel(drvdata, drvdata->ctrl | etmcr, ETMCR);
-	etm_writel(drvdata, drvdata->trigger_event, ETMTRIGGER);
-	etm_writel(drvdata, drvdata->startstop_ctrl, ETMTSSCR);
-	etm_writel(drvdata, drvdata->enable_event, ETMTEEVR);
-	etm_writel(drvdata, drvdata->enable_ctrl1, ETMTECR1);
-	etm_writel(drvdata, drvdata->fifofull_level, ETMFFLR);
+	etm_writel(drvdata, config->ctrl | etmcr, ETMCR);
+	etm_writel(drvdata, config->trigger_event, ETMTRIGGER);
+	etm_writel(drvdata, config->startstop_ctrl, ETMTSSCR);
+	etm_writel(drvdata, config->enable_event, ETMTEEVR);
+	etm_writel(drvdata, config->enable_ctrl1, ETMTECR1);
+	etm_writel(drvdata, config->fifofull_level, ETMFFLR);
 	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
-		etm_writel(drvdata, drvdata->addr_val[i], ETMACVRn(i));
-		etm_writel(drvdata, drvdata->addr_acctype[i], ETMACTRn(i));
+		etm_writel(drvdata, config->addr_val[i], ETMACVRn(i));
+		etm_writel(drvdata, config->addr_acctype[i], ETMACTRn(i));
 	}
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-		etm_writel(drvdata, drvdata->cntr_rld_val[i], ETMCNTRLDVRn(i));
-		etm_writel(drvdata, drvdata->cntr_event[i], ETMCNTENRn(i));
-		etm_writel(drvdata, drvdata->cntr_rld_event[i],
+		etm_writel(drvdata, config->cntr_rld_val[i], ETMCNTRLDVRn(i));
+		etm_writel(drvdata, config->cntr_event[i], ETMCNTENRn(i));
+		etm_writel(drvdata, config->cntr_rld_event[i],
 			   ETMCNTRLDEVRn(i));
-		etm_writel(drvdata, drvdata->cntr_val[i], ETMCNTVRn(i));
+		etm_writel(drvdata, config->cntr_val[i], ETMCNTVRn(i));
 	}
-	etm_writel(drvdata, drvdata->seq_12_event, ETMSQ12EVR);
-	etm_writel(drvdata, drvdata->seq_21_event, ETMSQ21EVR);
-	etm_writel(drvdata, drvdata->seq_23_event, ETMSQ23EVR);
-	etm_writel(drvdata, drvdata->seq_31_event, ETMSQ31EVR);
-	etm_writel(drvdata, drvdata->seq_32_event, ETMSQ32EVR);
-	etm_writel(drvdata, drvdata->seq_13_event, ETMSQ13EVR);
-	etm_writel(drvdata, drvdata->seq_curr_state, ETMSQR);
+	etm_writel(drvdata, config->seq_12_event, ETMSQ12EVR);
+	etm_writel(drvdata, config->seq_21_event, ETMSQ21EVR);
+	etm_writel(drvdata, config->seq_23_event, ETMSQ23EVR);
+	etm_writel(drvdata, config->seq_31_event, ETMSQ31EVR);
+	etm_writel(drvdata, config->seq_32_event, ETMSQ32EVR);
+	etm_writel(drvdata, config->seq_13_event, ETMSQ13EVR);
+	etm_writel(drvdata, config->seq_curr_state, ETMSQR);
 	for (i = 0; i < drvdata->nr_ext_out; i++)
 		etm_writel(drvdata, ETM_DEFAULT_EVENT_VAL, ETMEXTOUTEVRn(i));
 	for (i = 0; i < drvdata->nr_ctxid_cmp; i++)
-		etm_writel(drvdata, drvdata->ctxid_pid[i], ETMCIDCVRn(i));
-	etm_writel(drvdata, drvdata->ctxid_mask, ETMCIDCMR);
-	etm_writel(drvdata, drvdata->sync_freq, ETMSYNCFR);
+		etm_writel(drvdata, config->ctxid_pid[i], ETMCIDCVRn(i));
+	etm_writel(drvdata, config->ctxid_mask, ETMCIDCMR);
+	etm_writel(drvdata, config->sync_freq, ETMSYNCFR);
 	/* No external input selected */
 	etm_writel(drvdata, 0x0, ETMEXTINSELR);
-	etm_writel(drvdata, drvdata->timestamp_event, ETMTSEVR);
+	etm_writel(drvdata, config->timestamp_event, ETMTSEVR);
 	/* No auxiliary control selected */
 	etm_writel(drvdata, 0x0, ETMAUXCR);
 	etm_writel(drvdata, drvdata->traceid, ETMTRACEIDR);
@@ -278,7 +304,7 @@ static void etm_enable_hw(void *info)
 	etm_writel(drvdata, 0x0, ETMVMIDCVR);
 
 	/* Ensures trace output is enabled from this ETM */
-	etm_writel(drvdata, drvdata->ctrl | ETMCR_ETM_EN | etmcr, ETMCR);
+	etm_writel(drvdata, config->ctrl | ETMCR_ETM_EN | etmcr, ETMCR);
 
 	etm_clr_prog(drvdata);
 	CS_LOCK(drvdata->base);
@@ -357,6 +383,10 @@ static void etm_disable_hw(void *info)
 {
 	int i;
 	struct etm_drvdata *drvdata = info;
+	struct etm_config *config = get_etm_config(drvdata);
+
+	if (WARN_ON_ONCE(!config))
+		return;
 
 	CS_UNLOCK(drvdata->base);
 	etm_set_prog(drvdata);
@@ -365,10 +395,14 @@ static void etm_disable_hw(void *info)
 	etm_writel(drvdata, ETM_HARD_WIRE_RES_A | ETM_EVENT_NOT_A, ETMTEEVR);
 
 	/* Read back sequencer and counters for post trace analysis */
-	drvdata->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
+	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 
 	for (i = 0; i < drvdata->nr_cntr; i++)
-		drvdata->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
+		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
+
+	kfree(drvdata->config);
+	/* Get ready for another session */
+	drvdata->config = NULL;
 
 	etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
@@ -517,14 +551,8 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_default_data(struct etm_drvdata *drvdata)
+static void etm_init_default_data(struct etm_config *config)
 {
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and will be just as good.
-	 */
-	static int etm3x_traceid = 0x10;
-
 	u32 flags = (1 << 0 | /* instruction execute*/
 		     3 << 3 | /* ARM instruction */
 		     0 << 5 | /* No data value comparison */
@@ -532,6 +560,29 @@ static void etm_init_default_data(struct etm_drvdata *drvdata)
 		     0 << 8 | /* Ignore context ID */
 		     0 << 10); /* Security ignored */
 
+	if (WARN_ON_ONCE(!config))
+		return;
+
+	config->ctrl = (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN);
+	config->enable_ctrl1 = ETMTECR1_ADDR_COMP_1;
+	config->addr_val[0] = (u32) _stext;
+	config->addr_val[1] = (u32) _etext;
+	config->addr_acctype[0] = flags;
+	config->addr_acctype[1] = flags;
+	config->addr_type[0] = ETM_ADDR_TYPE_RANGE;
+	config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
+
+	etm_set_default(config);
+}
+
+static void etm_init_trace_id(struct etm_drvdata *drvdata)
+{
+	/*
+	 * A trace ID of value 0 is invalid, so let's start at some
+	 * random value that fits in 7 bits and will be just as good.
+	 */
+	static int etm3x_traceid = 0x10;
+
 	/*
 	 * Initial configuration only - guarantees sources handled by
 	 * this driver have a unique ID at startup time but not between
@@ -539,18 +590,6 @@ static void etm_init_default_data(struct etm_drvdata *drvdata)
 	 * framework.
 	 */
 	drvdata->traceid = etm3x_traceid++;
-	drvdata->ctrl = (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN);
-	drvdata->enable_ctrl1 = ETMTECR1_ADDR_COMP_1;
-	if (drvdata->nr_addr_cmp >= 2) {
-		drvdata->addr_val[0] = (u32) _stext;
-		drvdata->addr_val[1] = (u32) _etext;
-		drvdata->addr_acctype[0] = flags;
-		drvdata->addr_acctype[1] = flags;
-		drvdata->addr_type[0] = ETM_ADDR_TYPE_RANGE;
-		drvdata->addr_type[1] = ETM_ADDR_TYPE_RANGE;
-	}
-
-	etm_set_default(drvdata);
 }
 
 static int etm_probe(struct amba_device *adev, const struct amba_id *id)
@@ -618,7 +657,8 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = -EINVAL;
 		goto err_arch_supported;
 	}
-	etm_init_default_data(drvdata);
+
+	etm_init_trace_id(drvdata);
 
 	desc->type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
-- 
1.9.1
