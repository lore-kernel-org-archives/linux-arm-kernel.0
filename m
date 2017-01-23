From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Jan 2017 10:41:23 -0700
Subject: [PATCH 2/3] coresight: etm4x: Fix enabling of cycle accurate tracing
 in perf.
In-Reply-To: <1485193284-31636-1-git-send-email-mathieu.poirier@linaro.org>
References: <1485193284-31636-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1485193284-31636-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Leach <mike.leach@linaro.org>

Using perf record 'cyclacc' option in cs_etm event was not setting up cycle
accurate trace correctly.

Corrects bit set in TRCCONFIGR to enable cycle accurate trace.
Programs TRCCCCTLR with a valid threshold value as required by ETMv4 spec.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 7 +++++--
 drivers/hwtracing/coresight/coresight-etm4x.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 031480f2c34d..f432febdda49 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -216,8 +216,11 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 		goto out;
 
 	/* Go from generic option to ETMv4 specifics */
-	if (attr->config & BIT(ETM_OPT_CYCACC))
-		config->cfg |= ETMv4_MODE_CYCACC;
+	if (attr->config & BIT(ETM_OPT_CYCACC)) {
+		config->cfg |= BIT(4);
+		/* TRM: Must program this for cycacc to work */
+		config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
+	}
 	if (attr->config & BIT(ETM_OPT_TS))
 		config->cfg |= ETMv4_MODE_TIMESTAMP;
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ba8d3f86de21..b3b5ea7b7fb3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -146,6 +146,7 @@
 #define ETM_ARCH_V4			0x40
 #define ETMv4_SYNC_MASK			0x1F
 #define ETM_CYC_THRESHOLD_MASK		0xFFF
+#define ETM_CYC_THRESHOLD_DEFAULT       0x100
 #define ETMv4_EVENT_MASK		0xFF
 #define ETM_CNTR_MAX_VAL		0xFFFF
 #define ETM_TRACEID_MASK		0x3f
-- 
2.7.4
