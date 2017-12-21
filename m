From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 21 Dec 2017 16:20:15 +0800
Subject: [PATCH v3 6/6] coresight: etm4x: Support panic kdump
In-Reply-To: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
References: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1513844415-11427-7-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ETMv4 hardware information and configuration needs to be saved as
metadata; these metadata should be compatible with tool 'perf' and
can be used for tracing data analysis.  ETMv4 usually works as tracer
per CPU, we cannot wait to gather ETM info after the CPU has been panic
and cannot execute dump operations for itself; so should gather
metadata when the corresponding CPU is alive.

Since values in TRCIDR{0, 1, 2, 8} and TRCAUTHSTATUS are read-only and
won't change at the runtime.  Those registers value are filled when
tracers are instantiated.

The configuration and control registers TRCCONFIGR and TRCTRACEIDR are
dynamically configured, we record their value when enabling coresight
path.  When operating from sysFS tracer these two registers are recorded
in etm4_enable_sysfs() and add kdump node into list, and remove the
kdump node in etm4_disable_sysfs().  When operating from perf,
etm_setup_aux() adds all tracers to the dump list and etm4_enable_perf()
is used to record configuration registers and update dump buffer info,
this can avoid unnecessary list addition and deletion operations.
Removal of the tracers from the dump list is done in function
free_event_data().

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 12 +++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.c    | 23 +++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h    | 15 +++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8a0ad77..fec779b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -137,6 +137,12 @@ static void free_event_data(struct work_struct *work)
 	}
 
 	for_each_cpu(cpu, mask) {
+		struct coresight_device *csdev;
+
+		csdev = per_cpu(csdev_src, cpu);
+		if (csdev)
+			coresight_kdump_del(csdev);
+
 		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
 			coresight_release_path(event_data->path[cpu]);
 	}
@@ -195,7 +201,7 @@ static void etm_free_aux(void *data)
 static void *etm_setup_aux(int event_cpu, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	int cpu;
+	int cpu, ret;
 	cpumask_t *mask;
 	struct coresight_device *sink;
 	struct etm_event_data *event_data = NULL;
@@ -238,6 +244,10 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 		event_data->path[cpu] = coresight_build_path(csdev, sink);
 		if (IS_ERR(event_data->path[cpu]))
 			goto err;
+
+		ret = coresight_kdump_add(csdev, cpu);
+		if (ret)
+			goto err;
 	}
 
 	if (!sink_ops(sink)->alloc_buffer)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index cf364a5..cbde398 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -258,10 +258,19 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 static int etm4_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_metadata *metadata = &drvdata->metadata;
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
 
+	/* Update meta data and add into kdump list */
+	metadata->trcconfigr = config->cfg;
+	metadata->trctraceidr = drvdata->trcid;
+
+	coresight_kdump_add(csdev, drvdata->cpu);
+	coresight_kdump_update(csdev, (char *)metadata, sizeof(*metadata));
+
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
@@ -384,6 +393,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	 */
 	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
 
+	/* Delete from kdump list */
+	coresight_kdump_del(csdev);
+
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
@@ -438,6 +450,7 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr4;
 	u32 etmidr5;
 	struct etmv4_drvdata *drvdata = info;
+	struct etmv4_metadata *metadata = &drvdata->metadata;
 
 	/* Make sure all registers are accessible */
 	etm4_os_unlock(drvdata);
@@ -590,6 +603,16 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
+
+	/* Update metadata */
+	metadata->magic = ETM4_METADATA_MAGIC;
+	metadata->cpu = drvdata->cpu;
+	metadata->trcidr0 = readl_relaxed(drvdata->base + TRCIDR0);
+	metadata->trcidr1 = readl_relaxed(drvdata->base + TRCIDR1);
+	metadata->trcidr2 = readl_relaxed(drvdata->base + TRCIDR2);
+	metadata->trcidr8 = readl_relaxed(drvdata->base + TRCIDR8);
+	metadata->trcauthstatus = readl_relaxed(drvdata->base + TRCAUTHSTATUS);
+
 	CS_LOCK(drvdata->base);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index b3b5ea7..08dc8b7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -198,6 +198,20 @@
 #define ETM_EXLEVEL_NS_HYP		BIT(14)
 #define ETM_EXLEVEL_NS_NA		BIT(15)
 
+#define ETM4_METADATA_MAGIC		0x4040404040404040ULL
+
+struct etmv4_metadata {
+	u64 magic;
+	u64 cpu;
+	u64 trcconfigr;
+	u64 trctraceidr;
+	u64 trcidr0;
+	u64 trcidr1;
+	u64 trcidr2;
+	u64 trcidr8;
+	u64 trcauthstatus;
+};
+
 /**
  * struct etmv4_config - configuration information related to an ETMv4
  * @mode:	Controls various modes supported by this ETM.
@@ -393,6 +407,7 @@ struct etmv4_drvdata {
 	bool				atbtrig;
 	bool				lpoverride;
 	struct etmv4_config		config;
+	struct etmv4_metadata		metadata;
 };
 
 /* Address comparator access types */
-- 
2.7.4
