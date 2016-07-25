From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Mon, 25 Jul 2016 12:16:48 -0700
Subject: [PATCH v4 5/6] dmaengine: pl330: Make sure microcode is privileged
In-Reply-To: <20160725191649.13414-1-mitchelh@codeaurora.org>
References: <20160725191649.13414-1-mitchelh@codeaurora.org>
Message-ID: <20160725191649.13414-6-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL330 performs privileged instruction fetches.  This can result in
SMMU permission faults on SMMUs that implement the ARMv8 VMSA, which
specifies that mappings that are writeable at one execution level shall
not be executable at any higher-privileged level.  Fix this by using the
DMA_ATTR_PRIVILEGED attribute, which will ensure that the microcode
IOMMU mapping is only accessible to the privileged level.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---

Notes:
    v3..v4
    
      - Reworked against the new dma attrs format.

 drivers/dma/pl330.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 4fc3ffbd5ca0..8cd624fc3760 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1854,14 +1854,16 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
 {
 	int chans = pl330->pcfg.num_chan;
 	int ret;
+	unsigned long dma_attrs = DMA_ATTR_PRIVILEGED;
 
 	/*
 	 * Alloc MicroCode buffer for 'chans' Channel threads.
 	 * A channel's buffer offset is (Channel_Id * MCODE_BUFF_PERCHAN)
 	 */
-	pl330->mcode_cpu = dma_alloc_coherent(pl330->ddma.dev,
+	pl330->mcode_cpu = dma_alloc_attrs(pl330->ddma.dev,
 				chans * pl330->mcbufsz,
-				&pl330->mcode_bus, GFP_KERNEL);
+				&pl330->mcode_bus, GFP_KERNEL,
+				dma_attrs);
 	if (!pl330->mcode_cpu) {
 		dev_err(pl330->ddma.dev, "%s:%d Can't allocate memory!\n",
 			__func__, __LINE__);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
