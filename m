From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 15 Aug 2016 12:17:37 -0600
Subject: [PATCH RFC] perf tools: Adding event type for HW tracers
Message-ID: <1471285057-8327-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now possible to use the kernel's perf filter framework to
reduce the amount of trace collected by IntelPT and CoreSight tracers.

To collect address filter specifics from the perf tool command line
function parse_filter() is used, which in turn calls set_filter().  In
the latter only events with a PERF_TYPE_TRACEPOINT attribute type are
accepted.

Since IntelPT and CoreSight PMUs don't have a PERF_TYPE_TRACEPOINT
type, filter specification from the command line fails.

This patch adds a new PERF_TYPE_HW_TRACER PMU type.  From there
set_filter() is enhanced to accept filter definition for tracepoint and
HW tracer PMUs.

CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/x86/events/intel/pt.c                       |  2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c |  4 +++-
 include/uapi/linux/perf_event.h                  |  1 +
 tools/include/uapi/linux/perf_event.h            |  1 +
 tools/perf/util/parse-events.c                   | 10 ++++++++--
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 5178c5de0b19..f828eae05a0e 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1419,7 +1419,7 @@ static __init int pt_init(void)
 	pt_pmu.pmu.nr_addr_filters       =
 		pt_cap_get(PT_CAP_num_address_ranges);
 
-	ret = perf_pmu_register(&pt_pmu.pmu, "intel_pt", -1);
+	ret = perf_pmu_register(&pt_pmu.pmu, "intel_pt", PERF_TYPE_HW_TRACER);
 
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 7ae2a884ae5c..0b0bc81b58ba 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -631,7 +631,9 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
 
-	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
+	ret = perf_pmu_register(&etm_pmu,
+				CORESIGHT_ETM_PMU_NAME,
+				PERF_TYPE_HW_TRACER);
 	if (ret == 0)
 		etm_perf_up = true;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ce969677dab3..8b223d66694a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -32,6 +32,7 @@ enum perf_type_id {
 	PERF_TYPE_HW_CACHE			= 3,
 	PERF_TYPE_RAW				= 4,
 	PERF_TYPE_BREAKPOINT			= 5,
+	PERF_TYPE_HW_TRACER			= 6,
 
 	PERF_TYPE_MAX,				/* non-ABI */
 };
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ce969677dab3..8b223d66694a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -32,6 +32,7 @@ enum perf_type_id {
 	PERF_TYPE_HW_CACHE			= 3,
 	PERF_TYPE_RAW				= 4,
 	PERF_TYPE_BREAKPOINT			= 5,
+	PERF_TYPE_HW_TRACER			= 6,
 
 	PERF_TYPE_MAX,				/* non-ABI */
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2eb8b1ed4cc8..bb14cd63cba9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1761,9 +1761,15 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 {
 	const char *str = arg;
 
-	if (evsel == NULL || evsel->attr.type != PERF_TYPE_TRACEPOINT) {
+	if (evsel == NULL)
+		return -1;
+
+	if (evsel->attr.type != PERF_TYPE_TRACEPOINT &&
+	    evsel->attr.type != PERF_TYPE_HW_TRACER) {
 		fprintf(stderr,
-			"--filter option should follow a -e tracepoint option\n");
+			"--filter option should follow a -e tracepoint or HW tracer option\n");
+		fprintf(stderr, "evsel->name: %s type: 0x%x\n",
+			evsel->name, evsel->attr.type);
 		return -1;
 	}
 
-- 
2.7.4
