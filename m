From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 28 Sep 2011 14:55:24 +0530
Subject: [PATCH v5 5/6] ARM: SAMSUNG: Add device tree support for pl330 dma
	engine wrappers
In-Reply-To: <1317201925-25148-1-git-send-email-thomas.abraham@linaro.org>
References: <1317201925-25148-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1317201925-25148-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new dma request id 'DMACH_DT_PROP' is introduced for client drivers
requesting a dma channel. This request indicates that a device tree
node property represting the dma channel is available in
'struct samsung_dma_info'. The dma channel request wrapper uses the
node property value as the value for the filter parameter.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/plat-samsung/dma-ops.c                |    9 ++++++++-
 arch/arm/plat-samsung/include/plat/dma-ops.h   |    1 +
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index 8d18425..b1135dd 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -23,11 +23,18 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
 	struct dma_slave_config slave_config;
+	void *filter_param;
 
 	dma_cap_zero(mask);
 	dma_cap_set(info->cap, mask);
 
-	chan = dma_request_channel(mask, pl330_filter, (void *)dma_ch);
+	/*
+	 * If a dma channel property of a device node from device tree is
+	 * specified, use that as the fliter parameter.
+	 */
+	filter_param = (dma_ch == DMACH_DT_PROP) ? (void *)info->dt_dmach_prop :
+				(void *)dma_ch;
+	chan = dma_request_channel(mask, pl330_filter, filter_param);
 
 	if (info->direction == DMA_FROM_DEVICE) {
 		memset(&slave_config, 0, sizeof(struct dma_slave_config));
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
index 4c1a363..22eafc3 100644
--- a/arch/arm/plat-samsung/include/plat/dma-ops.h
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -31,6 +31,7 @@ struct samsung_dma_info {
 	enum dma_slave_buswidth width;
 	dma_addr_t fifo;
 	struct s3c2410_dma_client *client;
+	struct property *dt_dmach_prop;
 };
 
 struct samsung_dma_ops {
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index 2e55e59..c5eaad5 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -21,7 +21,8 @@
  * use these just as IDs.
  */
 enum dma_ch {
-	DMACH_UART0_RX,
+	DMACH_DT_PROP = -1,
+	DMACH_UART0_RX = 0,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
 	DMACH_UART1_TX,
-- 
1.6.6.rc2
