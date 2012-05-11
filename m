From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 11 May 2012 14:19:51 +0200
Subject: [PATCH] RFC: ARM: msm: re-read DMA IRQ status on each iteration
Message-ID: <1336738791-15037-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We have recently found a number or erroneous IRQ handlers in
the kernel where the flag iterator loop miss IRQs that get
raised when the loop is executing. This was spotted in the
MSM DMA driver by Julia Lawall using this cocinelle
snippet:

@@
expression pending,gedr,e1;
statement S;
@@

*pending = readl(gedr);
... when != pending = e1
while (pending) S

Cc: arve at android.com
Cc: Brian Swetland <swetland@google.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
David et al: I'm uncertain about this one since the comment
says that the read clears the IRQ, such as if the read operation
itself will latch out the flag register and clear it. (I encountered
this behaviour in the MOS6569 VIC raster IRQ register $D019 in the
1980s if I'm not mistaken.)
---
 arch/arm/mach-msm/dma.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
index 02cae5e..ee11afe 100644
--- a/arch/arm/mach-msm/dma.c
+++ b/arch/arm/mach-msm/dma.c
@@ -147,10 +147,8 @@ static irqreturn_t msm_datamover_irq_handler(int irq, void *dev_id)
 
 	spin_lock_irqsave(&msm_dmov_lock, irq_flags);
 
-	int_status = readl(DMOV_ISR); /* read and clear interrupt */
-	PRINT_FLOW("msm_datamover_irq_handler: DMOV_ISR %x\n", int_status);
-
-	while (int_status) {
+	while (int_status = readl(DMOV_ISR)) {
+		PRINT_FLOW("msm_datamover_irq_handler: DMOV_ISR %x\n", int_status);
 		mask = int_status & -int_status;
 		id = fls(mask) - 1;
 		PRINT_FLOW("msm_datamover_irq_handler %08x %08x id %d\n", int_status, mask, id);
-- 
1.7.9.2
