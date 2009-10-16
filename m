From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:25 -0700
Subject: [PATCH 21/46] DaVinci: EDMA: Fix bug in edma_free_cont_slots API
In-Reply-To: <1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Paulraj <s-paulraj@ti.com>

In the edma_free_cont_slots API, the variable slot was being modified
and then used in the for loop.
This results in incorrect behaviour when the API is used.

Signed-off-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index f2e57d2..89ce3e1 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -813,7 +813,7 @@ EXPORT_SYMBOL(edma_alloc_cont_slots);
  */
 int edma_free_cont_slots(unsigned slot, int count)
 {
-	unsigned ctlr;
+	unsigned ctlr, slot_to_free;
 	int i;
 
 	ctlr = EDMA_CTLR(slot);
@@ -826,11 +826,11 @@ int edma_free_cont_slots(unsigned slot, int count)
 
 	for (i = slot; i < slot + count; ++i) {
 		ctlr = EDMA_CTLR(i);
-		slot = EDMA_CHAN_SLOT(i);
+		slot_to_free = EDMA_CHAN_SLOT(i);
 
-		memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot),
+		memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot_to_free),
 			&dummy_paramset, PARM_SIZE);
-		clear_bit(slot, edma_info[ctlr]->edma_inuse);
+		clear_bit(slot_to_free, edma_info[ctlr]->edma_inuse);
 	}
 
 	return 0;
-- 
1.6.4.3
