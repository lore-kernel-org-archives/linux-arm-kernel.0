From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:46 +0100
Subject: [PATCH 10/17] coresight: etr: Track if the device is coherent
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-11-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Track if the ETR is dma-coherent or not. This will be useful
in deciding if we should use software buffering for perf.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 5 ++++-
 drivers/hwtracing/coresight/coresight-tmc.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 4939333cc6c7..5a8c41130f96 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -347,6 +347,9 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 	if (!(devid & TMC_DEVID_NOSCAT))
 		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
 
+	if (device_get_dma_attr(drvdata->dev) == DEV_DMA_COHERENT)
+		tmc_etr_set_cap(drvdata, TMC_ETR_COHERENT);
+
 	/* Check if the AXI address width is available */
 	if (devid & TMC_DEVID_AXIAW_VALID)
 		dma_mask = ((devid >> TMC_DEVID_AXIAW_SHIFT) &
@@ -397,7 +400,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		goto out;
 
-	drvdata->dev = &adev->dev;
+	drvdata->dev = dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 50ebc17c4645..69da0b584a6b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -131,6 +131,7 @@ enum tmc_mem_intf_width {
  * so we have to rely on PID of the IP to detect the functionality.
  */
 #define TMC_ETR_SAVE_RESTORE		(0x1U << 2)
+#define TMC_ETR_COHERENT		(0x1U << 3)
 
 /* Coresight SoC-600 TMC-ETR unadvertised capabilities */
 #define CORESIGHT_SOC_600_ETR_CAPS	\
-- 
2.13.6
