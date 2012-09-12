From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 12 Sep 2012 14:14:02 -0400
Subject: [PATCH] davinci: check for presence of channel controller on slot
 alloc
Message-ID: <1347473642-9948-1-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a check for the presence of the channel controller when
trying to allocate a slot.  Without this fix, the kernel panics with a NULL
pointer dereference when the dma-engine drivers are probed.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/dma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index a685e97..2fee31e 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -743,6 +743,9 @@ EXPORT_SYMBOL(edma_free_channel);
  */
 int edma_alloc_slot(unsigned ctlr, int slot)
 {
+	if (!edma_cc[ctlr])
+		return -ENODEV;
+
 	if (slot >= 0)
 		slot = EDMA_CHAN_SLOT(slot);
 
-- 
1.7.9.5
