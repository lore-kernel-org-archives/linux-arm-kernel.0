From: mike.leach@linaro.org (Mike Leach)
Date: Tue, 11 Jul 2017 12:25:51 +0100
Subject: [PATCH 3/3] coresight: etm4x: Adds trace return stack option
 programming for ETMv4.
In-Reply-To: <1499772351-2210-1-git-send-email-mike.leach@linaro.org>
References: <1499772351-2210-1-git-send-email-mike.leach@linaro.org>
Message-ID: <1499772351-2210-4-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds handling to program the return stack option into ETMv4 hardware if
specified in the perf command line.

If option is not supported by the hardware then it will be ignored.
This allows capture to move between core/ETM combinations that have the
hardware support to those that do not.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index d1340fb..fb3ce34 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -224,6 +224,10 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 	if (attr->config & BIT(ETM_OPT_TS))
 		/* bit[11], Global timestamp tracing bit */
 		config->cfg |= BIT(11);
+	/* return stack - enable if selected and supported */
+	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
+		/* bit[12], Return stack enable bit */
+		config->cfg |= BIT(12);
 
 out:
 	return ret;
-- 
2.7.4
