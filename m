From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Jul 2016 13:51:29 -0600
Subject: [PATCH 08/10] coresight: etm4x: adding configurable address range
 filtering
In-Reply-To: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468871491-10997-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the capability to specify address ranges from
the perf cmd line using the --filter option.  If the IP
falls within the range(s) program flow traces are generated.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 128 ++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 9eba6d8f4633..b807333ce6a1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -46,7 +46,9 @@ module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 /* The number of ETMv4 currently registered */
 static int etm4_count;
 static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
-static void etm4_set_default(struct etmv4_config *config);
+static void etm4_set_default_config(struct etmv4_config *config);
+static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
+				  struct perf_event *event);
 
 static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 {
@@ -195,11 +197,14 @@ static void etm4_enable_hw(void *info)
 static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 				   struct perf_event *event)
 {
+	int ret = 0;
 	struct etmv4_config *config = &drvdata->config;
 	struct perf_event_attr *attr = &event->attr;
 
-	if (!attr)
-		return -EINVAL;
+	if (!attr) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Clear configuration from previous run */
 	memset(config, 0, sizeof(struct etmv4_config));
@@ -211,7 +216,12 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 		config->mode = ETM_MODE_EXCL_USER;
 
 	/* Always start from the default config */
-	etm4_set_default(config);
+	etm4_set_default_config(config);
+
+	/* Configure filters specified on the perf cmd line, if any. */
+	ret = etm4_set_event_filters(drvdata, event);
+	if (ret)
+		goto out;
 
 	/* Go from generic option to ETMv4 specifics */
 	if (attr->config & BIT(ETM_OPT_CYCACC))
@@ -219,23 +229,30 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 	if (attr->config & BIT(ETM_OPT_TS))
 		config->cfg |= ETMv4_MODE_TIMESTAMP;
 
-	return 0;
+out:
+	return ret;
 }
 
 static int etm4_enable_perf(struct coresight_device *csdev,
 			    struct perf_event *event)
 {
+	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
-		return -EINVAL;
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id())) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Configure the tracer based on the session's specifics */
-	etm4_parse_event_config(drvdata, event);
+	ret = etm4_parse_event_config(drvdata, event);
+	if (ret)
+		goto out;
 	/* And enable it */
 	etm4_enable_hw(drvdata);
 
-	return 0;
+out:
+	return ret;
 }
 
 static int etm4_enable_sysfs(struct coresight_device *csdev)
@@ -685,6 +702,99 @@ static void etm4_set_default(struct etmv4_config *config)
 	etm4_set_default_filter(config);
 }
 
+static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
+{
+	int nr_comparator, index = 0;
+	struct etmv4_config *config = &drvdata->config;
+
+	/*
+	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
+	 * for the total number of comparators.
+	 */
+	nr_comparator = drvdata->nr_addr_cmp * 2;
+
+	/* Go through the tally of comparators looking for a free one. */
+	while (index < nr_comparator) {
+		switch (type) {
+		case ETM_ADDR_TYPE_RANGE:
+			if (config->addr_type[index] == ETM_ADDR_TYPE_NONE &&
+			    config->addr_type[index + 1] == ETM_ADDR_TYPE_NONE)
+				return index;
+
+			/* Address range comparators go in pairs */
+			index += 2;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* If we are here all the comparators have been used. */
+	return -ENOSPC;
+}
+
+static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
+				  struct perf_event *event)
+{
+	int i, comparator, ret = 0;
+	struct etmv4_config *config = &drvdata->config;
+	struct etm_filters *filters = event->hw.addr_filters;
+
+	if (!filters)
+		goto default_filter;
+
+	/* Sync events with what Perf got */
+	perf_event_addr_filters_sync(event);
+
+	/*
+	 * If there are no filters to deal with simply go ahead with
+	 * the default filter, i.e the entire address range.
+	 */
+	if (!filters->nr_filters)
+		goto default_filter;
+
+	for (i = 0; i < filters->nr_filters; i++) {
+		struct etm_filter *filter = &filters->filter[i];
+		enum etm_addr_type type = filter->type;
+
+		/* See if a comparator is free. */
+		comparator = etm4_get_next_comparator(drvdata, type);
+		if (comparator < 0) {
+			ret = comparator;
+			goto out;
+		}
+
+		switch (type) {
+		case ETM_ADDR_TYPE_RANGE:
+			etm4_set_comparator_filter(config,
+						   filter->start_addr,
+						   filter->stop_addr,
+						   comparator);
+			/*
+			 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
+			 * in the started state
+			 */
+			config->vinst_ctrl |= BIT(9);
+
+			/* No start-stop filtering for ViewInst */
+			config->vissctlr = 0x0;
+			break;
+		default:
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	goto out;
+
+
+default_filter:
+	etm4_set_default_filter(config);
+
+out:
+	return ret;
+}
+
 void etm4_config_trace_mode(struct etmv4_config *config)
 {
 	u32 addr_acc, mode;
-- 
2.7.4
