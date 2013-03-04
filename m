From: mporter@ti.com (Matt Porter)
Date: Mon,  4 Mar 2013 11:52:57 -0500
Subject: [PATCH] arm: davinci: fix edma dmaengine induced null pointer
 dereference on da830
Message-ID: <1362415977-12829-1-git-send-email-mporter@ti.com>
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
Cc: stable at kernel.org
---
 arch/arm/mach-davinci/dma.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index a685e97..f9eb836 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -747,6 +747,8 @@ int edma_alloc_slot(unsigned ctlr, int slot)
 		slot = EDMA_CHAN_SLOT(slot);
 
 	if (slot < 0) {
+		if (!edma_cc[ctlr])
+			return -EINVAL;
 		slot = edma_cc[ctlr]->num_channels;
 		for (;;) {
 			slot = find_next_zero_bit(edma_cc[ctlr]->edma_inuse,
-- 
1.7.9.5
