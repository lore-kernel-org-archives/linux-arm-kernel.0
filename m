From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 13 Dec 2016 00:08:45 +0530
Subject: [PATCH V7 6/8] dmaengine: pl330: Make sure microcode is privileged
In-Reply-To: <1481567927-14791-1-git-send-email-sricharan@codeaurora.org>
References: <1481567927-14791-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1481567927-14791-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mitchel Humpherys <mitchelh@codeaurora.org>

The PL330 is hard-wired such that instruction fetches on both the
manager and channel threads go out onto the bus with the "privileged"
bit set. This can become troublesome once there is an IOMMU or other
form of memory protection downstream, since those will typically be
programmed by the DMA mapping subsystem in the expectation of normal
unprivileged transactions (such as the PL330 channel threads' own data
accesses as currently configured by this driver).

To avoid the case of, say, an IOMMU blocking an unexpected privileged
transaction with a permission fault, use the newly-introduced
DMA_ATTR_PRIVILEGED attribute for the mapping of our microcode buffer.
That way the DMA layer can do whatever it needs to do to make things
continue to work as expected on more complex systems.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
[rm: remove now-redundant local variable, clarify commit message]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/dma/pl330.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 030fe05..1e5ae0c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1859,9 +1859,10 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
 	 * Alloc MicroCode buffer for 'chans' Channel threads.
 	 * A channel's buffer offset is (Channel_Id * MCODE_BUFF_PERCHAN)
 	 */
-	pl330->mcode_cpu = dma_alloc_coherent(pl330->ddma.dev,
+	pl330->mcode_cpu = dma_alloc_attrs(pl330->ddma.dev,
 				chans * pl330->mcbufsz,
-				&pl330->mcode_bus, GFP_KERNEL);
+				&pl330->mcode_bus, GFP_KERNEL,
+				DMA_ATTR_PRIVILEGED);
 	if (!pl330->mcode_cpu) {
 		dev_err(pl330->ddma.dev, "%s:%d Can't allocate memory!\n",
 			__func__, __LINE__);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
