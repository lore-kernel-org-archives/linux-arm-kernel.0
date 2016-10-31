From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 31 Oct 2016 14:02:03 -0700
Subject: [PATCH v2] staging: vc04_services: setup DMA and coherent mask
Message-ID: <20161031210203.2089-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VCHI messages between the CPU and firmware use 32-bit
bus addresses. Explicitly set the DMA mask and coherent
on all platforms.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index a5afcc5..ba77fd8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -97,6 +97,15 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	int slot_mem_size, frag_mem_size;
 	int err, irq, i;
 
+	/*
+	 * VCHI messages between the CPU and firmware use
+	 * 32-bit bus addresses.
+	 */
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+
+	if (err < 0)
+		return err;
+
 	(void)of_property_read_u32(dev->of_node, "cache-line-size",
 				   &g_cache_line_size);
 	g_fragments_size = 2 * g_cache_line_size;
-- 
2.10.1
