From: joelf@ti.com (Joel Fernandes)
Date: Mon, 5 Aug 2013 11:14:47 -0500
Subject: [PATCH v3 02/12] ARM: edma: Don't clear EMR of channel in edma_stop
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Message-ID: <1375719297-12871-3-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We certainly don't want error conditions to be cleared any other
place but the EDMA error handler, as this will make us 'forget'
about missed events we might need to know errors have occurred.

This fixes a race condition where the EMR was being cleared
by the transfer completion interrupt handler.

Basically, what was happening was:

            Missed event
             |
             |
             V
SG1-SG2-SG3-Null
         \
          \__TC Interrupt (Almost same time as ARM is executing
TC interrupt handler, an event got missed and also forgotten
by clearing the EMR).

This causes the following  problems:

1.
If error interrupt is also pending and TC interrupt clears the EMR
by calling edma_stop as has been observed in the edma_callback function,
the ARM will execute the error interrupt even though the EMR is clear.
As a result, the  dma_ccerr_handler returns IRQ_NONE. If this happens
enough number of times, IRQ subsystem disables the interrupt thinking
its spurious which makes error handler never execute again.

2.
Also even if error handler doesn't return IRQ_NONE, the removing of EMR
removes the knowledge about which channel had a missed event, and thus
a manual trigger on such channels cannot be performed.

The EMR is ultimately being cleared by the Error interrupt handler
once it is handled so we remove code that does it in edma_stop and
allow it to happen there.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/common/edma.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 3567ba1..6433b6c 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1307,7 +1307,6 @@ void edma_stop(unsigned channel)
 		edma_shadow0_write_array(ctlr, SH_EECR, j, mask);
 		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
 		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
-		edma_write_array(ctlr, EDMA_EMCR, j, mask);
 
 		pr_debug("EDMA: EER%d %08x\n", j,
 				edma_shadow0_read_array(ctlr, SH_EER, j));
-- 
1.7.9.5
