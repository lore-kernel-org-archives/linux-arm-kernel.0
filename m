From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Jan 2017 10:41:24 -0700
Subject: [PATCH 3/3] coresight: etm4x: Fix timestamp configuration when
 working from perf
In-Reply-To: <1485193284-31636-1-git-send-email-mathieu.poirier@linaro.org>
References: <1485193284-31636-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1485193284-31636-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the ETM4x tracers from the perf interface two trace options are
available: cycle accurate and timestamp.

Enabling the timestamp feature is done by setting TRCCONFIGR.TS (bit 11).
The position of the timestamp bit in that register coincidentally happens
to be the same as what was chosen to enable timestamping from the 'mode'
sysFS entry.  The code does the right thing but the semantic is wrong.

This patch sets TRCCONFIGR.TS explicitly, as it is done from the sysFS
interface.  That way timestamps are set the same way from both perf and
sysFS and there is no misunderstanding as to what is intended.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index f432febdda49..d1340fb4e457 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -222,7 +222,8 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 		config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
 	}
 	if (attr->config & BIT(ETM_OPT_TS))
-		config->cfg |= ETMv4_MODE_TIMESTAMP;
+		/* bit[11], Global timestamp tracing bit */
+		config->cfg |= BIT(11);
 
 out:
 	return ret;
-- 
2.7.4
