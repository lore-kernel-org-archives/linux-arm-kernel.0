From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:19 -0600
Subject: [PATCH 25/26] perf: cs-etm: Fix ETMv4 CONFIGR entry in perf.data file
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-26-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Leach <mike.leach@linaro.org>

The value passed into the perf.data file for the CONFIGR register in ETMv4
was incorrectly being set to the command line options/ETMv3 value.

Adds bit definitions and function to remap this value to the correct ETMv4
CONFIGR bit values for all selected options.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 include/linux/coresight-pmu.h       |  5 +++++
 tools/include/linux/coresight-pmu.h |  5 +++++
 tools/perf/arch/arm/util/cs-etm.c   | 28 +++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 45852c2cd096..edfeaba95429 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -26,6 +26,11 @@
 #define ETM_OPT_TS      28
 #define ETM_OPT_RETSTK	29
 
+/* ETMv4 CONFIGR programming bits for the ETM OPTs */
+#define ETM4_CFG_BIT_CYCACC	4
+#define ETM4_CFG_BIT_TS		11
+#define ETM4_CFG_BIT_RETSTK	12
+
 static inline int coresight_get_trace_id(int cpu)
 {
 	/*
diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 45852c2cd096..edfeaba95429 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -26,6 +26,11 @@
 #define ETM_OPT_TS      28
 #define ETM_OPT_RETSTK	29
 
+/* ETMv4 CONFIGR programming bits for the ETM OPTs */
+#define ETM4_CFG_BIT_CYCACC	4
+#define ETM4_CFG_BIT_TS		11
+#define ETM4_CFG_BIT_RETSTK	12
+
 static inline int coresight_get_trace_id(int cpu)
 {
 	/*
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 7ce3d1a25133..fbfc055d3f4d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -266,6 +266,32 @@ static u64 cs_etm_get_config(struct auxtrace_record *itr)
 	return config;
 }
 
+#ifndef BIT
+#define BIT(N) (1UL << (N))
+#endif
+
+static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
+{
+	u64 config = 0;
+	u64 config_opts = 0;
+
+	/*
+	 * The perf event variable config bits represent both
+	 * the command line options and register programming
+	 * bits in ETMv3/PTM. For ETMv4 we must remap options
+	 * to real bits
+	 */
+	config_opts = cs_etm_get_config(itr);
+	if (config_opts & BIT(ETM_OPT_CYCACC))
+		config |= BIT(ETM4_CFG_BIT_CYCACC);
+	if (config_opts & BIT(ETM_OPT_TS))
+		config |= BIT(ETM4_CFG_BIT_TS);
+	if (config_opts & BIT(ETM_OPT_RETSTK))
+		config |= BIT(ETM4_CFG_BIT_RETSTK);
+
+	return config;
+}
+
 static size_t
 cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		      struct perf_evlist *evlist __maybe_unused)
@@ -363,7 +389,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 		magic = __perf_cs_etmv4_magic;
 		/* Get trace configuration register */
 		info->priv[*offset + CS_ETMV4_TRCCONFIGR] =
-						cs_etm_get_config(itr);
+						cs_etmv4_get_config(itr);
 		/* Get traceID from the framework */
 		info->priv[*offset + CS_ETMV4_TRCTRACEIDR] =
 						coresight_get_trace_id(cpu);
-- 
2.7.4
