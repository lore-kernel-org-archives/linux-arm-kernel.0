From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 20 Jul 2017 11:17:24 +0100
Subject: [PATCH v5 14/19] coresight tmc etr: Detect address width at runtime
In-Reply-To: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500545849-23724-15-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TMC in Coresight SoC-600 advertises the AXI address width
in the device configuration register.

Bit 16 - AXIAW_VALID
 0 - AXI Address Width not valid
 1 - Valid AXI Address width in Bits[23-17]

Bits [23-17] - AXIAW. If AXIAW_VALID = b01 then
 0x20 - 32bit AXI address bus
 0x28 - 40bit AXI address bus
 0x2c - 44bit AXI address bus
 0x30 - 48bit AXI address bus
 0x34 - 52bit AXI address bus

Use the address bits from the device configuration register, if
available. Otherwise, default to 40bit.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 26 +++++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.h |  4 ++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 6d9b8e3..c4a5dea 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -303,16 +303,36 @@ const struct attribute_group *coresight_tmc_groups[] = {
 static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 			     u32 devid, void *dev_caps)
 {
+	u32 dma_mask = 0;
+
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
 	if (!(devid & TMC_DEVID_NOSCAT))
 		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
+
+	/* Check if the AXI address width is available */
+	if (devid & TMC_DEVID_AXIAW_VALID)
+		dma_mask = ((devid >> TMC_DEVID_AXIAW_SHIFT) &
+				TMC_DEVID_AXIAW_MASK);
+
 	/*
-	 * ETR configuration uses a 40-bit AXI master in place of
-	 * the embedded SRAM of ETB/ETF.
+	 * Unless specified in the device configuration, ETR uses a 40-bit
+	 * AXI master in place of the embedded SRAM of ETB/ETF.
 	 */
-	return dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(40));
+	switch (dma_mask) {
+	case 32:
+	case 40:
+	case 44:
+	case 48:
+	case 52:
+		dev_info(drvdata->dev, "Detected dma mask %dbits\n", dma_mask);
+		break;
+	default:
+		dma_mask = 40;
+	}
+
+	return dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(dma_mask));
 }
 
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 23dfbf3..3e94b4b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -72,6 +72,10 @@
 
 #define TMC_DEVID_NOSCAT	BIT(24)
 
+#define TMC_DEVID_AXIAW_VALID	BIT(16)
+#define TMC_DEVID_AXIAW_SHIFT	17
+#define TMC_DEVID_AXIAW_MASK	0x7f
+
 enum tmc_config_type {
 	TMC_CONFIG_TYPE_ETB,
 	TMC_CONFIG_TYPE_ETR,
-- 
2.7.5
