From: mporter@ti.com (Matt Porter)
Date: Tue,  5 Mar 2013 10:58:22 -0500
Subject: [PATCH v2] arm: davinci: fix edma dmaengine induced null pointer
 dereference on da830
Message-ID: <1362499102-16468-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds additional error checking to the private edma api implementation
to catch the case where the edma_alloc_slot() has an invalid controller
parameter. The edma dmaengine wrapper driver relies on this condition
being handled in order to avoid setting up a second edma dmaengine
instance on DA830.

Verfied using a DA850 with the second EDMA controller platform instance
removed to simulate a DA830 which only has a single EDMA controller.

Reported-by: Tomas Novotny <tomas@novotny.cz>
Signed-off-by: Matt Porter <mporter@ti.com>
Cc: stable at vger.kernel.org # v3.7.x+
---
v2: Move error check out of conditional to catch all cases

 arch/arm/mach-davinci/dma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index a685e97..45b7c71 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -743,6 +743,9 @@ EXPORT_SYMBOL(edma_free_channel);
  */
 int edma_alloc_slot(unsigned ctlr, int slot)
 {
+	if (!edma_cc[ctlr])
+		return -EINVAL;
+
 	if (slot >= 0)
 		slot = EDMA_CHAN_SLOT(slot);
 
-- 
1.7.9.5
