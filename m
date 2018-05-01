From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  1 May 2018 10:10:52 +0100
Subject: [PATCH v2 22/27] coresight: tmc-etr: Track if the device is coherent
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1525165857-11096-23-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Track if the ETR is dma-coherent or not. This will be useful
in deciding if we should use software buffering for perf.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 3 +++
 drivers/hwtracing/coresight/coresight-tmc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 7adcde3..91a8f7b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -359,6 +359,9 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 	if (!(devid & TMC_DEVID_NOSCAT) && tmc_etr_can_use_sg(drvdata))
 		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
 
+	if (device_get_dma_attr(drvdata->dev) == DEV_DMA_COHERENT)
+		tmc_etr_set_cap(drvdata, TMC_ETR_COHERENT);
+
 	/* Check if the AXI address width is available */
 	if (devid & TMC_DEVID_AXIAW_VALID)
 		dma_mask = ((devid >> TMC_DEVID_AXIAW_SHIFT) &
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 1f6aa49..76a89a6 100644
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
2.7.4
