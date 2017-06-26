From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 26 Jun 2017 16:22:52 +0100
Subject: [PATCH v2 08/12] coresight tmc: Handle configuration types properly
In-Reply-To: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1498490576-1350-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Coresight SoC 600 defines a new configuration for TMC, Embedded Trace
Streamer (ETS), indicated by 0x3 in MODE:CONFIG_TYPE. This would break
the existing driver which will treat anything other than ETR/ETB as an
ETF. Fix the driver to check the configuration type properly and also
add a warning if we encounter an unsupported configuration (ETS).

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 6bf4170..73184a1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -358,11 +358,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.dev = dev;
 	desc.groups = coresight_tmc_groups;
 
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etb_cs_ops;
-	} else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
+		break;
+	case TMC_CONFIG_TYPE_ETR:
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etr_cs_ops;
@@ -373,10 +375,16 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
 		if (ret)
 			goto out;
-	} else {
+		break;
+	case TMC_CONFIG_TYPE_ETF:
 		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
 		desc.ops = &tmc_etf_cs_ops;
+		break;
+	default:
+		pr_err("%s: Unsupported TMC config\n", pdata->name);
+		ret = -EINVAL;
+		goto out;
 	}
 
 	drvdata->csdev = coresight_register(&desc);
-- 
2.7.5
