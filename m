From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Nov 2015 11:33:13 -0700
Subject: [RESEND PATCH V4 21/26] coresight: introducing a global trace ID
 function
In-Reply-To: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448303598-11249-22-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TraceID values have to be unique for all tracers and
consistent between drivers and user space.  As such
introducing a central function to be used whenever a
traceID value is required.

The patch also account for data traceIDs, which are usually
I(N) + 1.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c |  7 ++-----
 include/linux/coresight-pmu.h                 | 12 ++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index c07b7d3eee86..ebd569986bd4 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
 #include <linux/amba/bus.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
@@ -784,11 +785,7 @@ static void etm_init_arch_data(void *info)
 
 static void etm_init_trace_id(struct etm_drvdata *drvdata)
 {
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.
-	 */
-	drvdata->traceid = 0x10 + drvdata->cpu;
+	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
 }
 
 static int etm_probe(struct amba_device *adev, const struct amba_id *id)
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 6c5386b23b10..7d410260661b 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -19,9 +19,21 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
+#define CORESIGHT_ETM_PMU_SEED  0x10
 
 /* ETMv3.5/PTM's ETMCR config bit */
 #define ETM_OPT_CYCACC  12
 #define ETM_OPT_TS      28
 
+static inline int coresight_get_trace_id(int cpu)
+{
+	/*
+	 * A trace ID of value 0 is invalid, so let's start at some
+	 * random value that fits in 7 bits and go from there.  Since
+	 * the common convention is to have data trace IDs be I(N) + 1,
+	 * set instruction trace IDs as a function of the CPU number.
+	 */
+	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
+}
+
 #endif
-- 
1.9.1
