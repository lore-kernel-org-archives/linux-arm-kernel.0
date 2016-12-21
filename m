From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Wed, 21 Dec 2016 22:13:58 +0100
Subject: [PATCH] dmaengine: ipu: Make sure the interrupt routine checks all
 interrupts.
Message-ID: <1482354838-22615-1-git-send-email-lilja.magnus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3d8cc00073d6 ("dmaengine: ipu: Consolidate duplicated irq handlers")
consolidated the two interrupts routines into one, but the remaining
interrupt routine only checks the status of the error interrupts, not the
normal interrupts.

This patch fixes that problem (tested on i.MX31 PDK board).

Fixes: 3d8cc00073d6 ("dmaengine: ipu: Consolidate duplicated irq handlers")
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: <stable@vger.kernel.org> # 4.1.x
Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
---
 drivers/dma/ipu/ipu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index dd184b5..2846278 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -272,7 +272,7 @@ static void ipu_irq_handler(struct irq_desc *desc)
 	u32 status;
 	int i, line;
 
-	for (i = IPU_IRQ_NR_FN_BANKS; i < IPU_IRQ_NR_BANKS; i++) {
+	for (i = 0; i < IPU_IRQ_NR_BANKS; i++) {
 		struct ipu_irq_bank *bank = irq_bank + i;
 
 		raw_spin_lock(&bank_lock);
-- 
2.7.4
