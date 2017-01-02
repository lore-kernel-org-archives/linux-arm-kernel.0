From: mike.leach@linaro.org (Mike Leach)
Date: Mon,  2 Jan 2017 22:55:19 +0000
Subject: [PATCH] coresight: etm4x: Fix enabling of cycle accurate tracing in
 perf.
Message-ID: <1483397719-22235-1-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using perf record 'cyclacc' option in cs_etm event was not setting up cycle
accurate trace correctly.

Corrects bit set in TRCCONFIGR to enable cycle accurate trace.
Programs TRCCCCTLR with a valid threshold value as required by ETMv4 spec.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 7 +++++--
 drivers/hwtracing/coresight/coresight-etm4x.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 4db8d6a..07be032 100644
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
index ba8d3f8..8a62c6c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -146,6 +146,7 @@
 #define ETM_ARCH_V4			0x40
 #define ETMv4_SYNC_MASK			0x1F
 #define ETM_CYC_THRESHOLD_MASK		0xFFF
+#define ETM_CYC_THRESHOLD_DEFAULT       256
 #define ETMv4_EVENT_MASK		0xFF
 #define ETM_CNTR_MAX_VAL		0xFFFF
 #define ETM_TRACEID_MASK		0x3f
-- 
2.7.4
