From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:30 -0700
Subject: [PATCH 26/46] DaVinci: EDMA: Updating terminlogy in EDMA driver
In-Reply-To: <1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
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
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Paulraj <s-paulraj@ti.com>

The patch itself does not change the functionality of
any existing code. PARAM entries in the present GIT kernel
are referred to as slots. New API's being added to the
EDMA driver were referring to these PARAM entries as
"params". This patch updates the terminolgy used in the
EDMA driver.

Signed-off-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |   65 ++++++++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index b097592..4ff1f93 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -509,21 +509,21 @@ static irqreturn_t dma_tc1err_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int reserve_contiguous_params(int ctlr, unsigned int id,
-				     unsigned int num_params,
-				     unsigned int start_param)
+static int reserve_contiguous_slots(int ctlr, unsigned int id,
+				     unsigned int num_slots,
+				     unsigned int start_slot)
 {
 	int i, j;
-	unsigned int count = num_params;
-	int stop_param = start_param;
+	unsigned int count = num_slots;
+	int stop_slot = start_slot;
 	DECLARE_BITMAP(tmp_inuse, EDMA_MAX_PARAMENTRY);
 
-	for (i = start_param; i < edma_info[ctlr]->num_slots; ++i) {
+	for (i = start_slot; i < edma_info[ctlr]->num_slots; ++i) {
 		j = EDMA_CHAN_SLOT(i);
 		if (!test_and_set_bit(j, edma_info[ctlr]->edma_inuse)) {
 			/* Record our current beginning slot */
-			if (count == num_params)
-				stop_param = i;
+			if (count == num_slots)
+				stop_slot = i;
 
 			count--;
 			set_bit(j, tmp_inuse);
@@ -534,34 +534,34 @@ static int reserve_contiguous_params(int ctlr, unsigned int id,
 			clear_bit(j, tmp_inuse);
 
 			if (id == EDMA_CONT_PARAMS_FIXED_EXACT) {
-				stop_param = i;
+				stop_slot = i;
 				break;
 			} else
-				count = num_params;
+				count = num_slots;
 		}
 	}
 
 	/*
 	 * We have to clear any bits that we set
-	 * if we run out parameter RAMs, i.e we do find a set
-	 * of contiguous parameter RAMs but do not find the exact number
-	 * requested as we may reach the total number of parameter RAMs
+	 * if we run out parameter RAM slots, i.e we do find a set
+	 * of contiguous parameter RAM slots but do not find the exact number
+	 * requested as we may reach the total number of parameter RAM slots
 	 */
 	if (i == edma_info[ctlr]->num_slots)
-		stop_param = i;
+		stop_slot = i;
 
-	for (j = start_param; j < stop_param; j++)
+	for (j = start_slot; j < stop_slot; j++)
 		if (test_bit(j, tmp_inuse))
 			clear_bit(j, edma_info[ctlr]->edma_inuse);
 
 	if (count)
 		return -EBUSY;
 
-	for (j = i - num_params + 1; j <= i; ++j)
+	for (j = i - num_slots + 1; j <= i; ++j)
 		memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(j),
 			&dummy_paramset, PARM_SIZE);
 
-	return EDMA_CTLR_CHAN(ctlr, i - num_params + 1);
+	return EDMA_CTLR_CHAN(ctlr, i - num_slots + 1);
 }
 
 /*-----------------------------------------------------------------------*/
@@ -759,26 +759,27 @@ EXPORT_SYMBOL(edma_free_slot);
 /**
  * edma_alloc_cont_slots- alloc contiguous parameter RAM slots
  * The API will return the starting point of a set of
- * contiguous PARAM's that have been requested
+ * contiguous parameter RAM slots that have been requested
  *
  * @id: can only be EDMA_CONT_PARAMS_ANY or EDMA_CONT_PARAMS_FIXED_EXACT
  * or EDMA_CONT_PARAMS_FIXED_NOT_EXACT
- * @count: number of contiguous Paramter RAM's
- * @param  - the start value of Parameter RAM that should be passed if id
+ * @count: number of contiguous Paramter RAM slots
+ * @slot  - the start value of Parameter RAM slot that should be passed if id
  * is EDMA_CONT_PARAMS_FIXED_EXACT or EDMA_CONT_PARAMS_FIXED_NOT_EXACT
  *
  * If id is EDMA_CONT_PARAMS_ANY then the API starts looking for a set of
- * contiguous Parameter RAMs from parameter RAM 64 in the case of DaVinci SOCs
- * and 32 in the case of Primus
+ * contiguous Parameter RAM slots from parameter RAM 64 in the case of
+ * DaVinci SOCs and 32 in the case of DA8xx SOCs.
  *
  * If id is EDMA_CONT_PARAMS_FIXED_EXACT then the API starts looking for a
- * set of contiguous parameter RAMs from the "param" that is passed as an
+ * set of contiguous parameter RAM slots from the "slot" that is passed as an
  * argument to the API.
  *
  * If id is EDMA_CONT_PARAMS_FIXED_NOT_EXACT then the API initially tries
- * starts looking for a set of contiguous parameter RAMs from the "param"
+ * starts looking for a set of contiguous parameter RAMs from the "slot"
  * that is passed as an argument to the API. On failure the API will try to
- * find a set of contiguous Parameter RAMs in the remaining Parameter RAMs
+ * find a set of contiguous Parameter RAM slots from the remaining Parameter
+ * RAM slots
  */
 int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
 {
@@ -793,7 +794,7 @@ int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
 		return -EINVAL;
 
 	/*
-	 * The number of parameter RAMs requested cannot be less than 1
+	 * The number of parameter RAM slots requested cannot be less than 1
 	 * and cannot be more than the number of slots minus the number of
 	 * channels
 	 */
@@ -803,11 +804,11 @@ int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
 
 	switch (id) {
 	case EDMA_CONT_PARAMS_ANY:
-		return reserve_contiguous_params(ctlr, id, count,
+		return reserve_contiguous_slots(ctlr, id, count,
 						 edma_info[ctlr]->num_channels);
 	case EDMA_CONT_PARAMS_FIXED_EXACT:
 	case EDMA_CONT_PARAMS_FIXED_NOT_EXACT:
-		return reserve_contiguous_params(ctlr, id, count, slot);
+		return reserve_contiguous_slots(ctlr, id, count, slot);
 	default:
 		return -EINVAL;
 	}
@@ -816,14 +817,14 @@ int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
 EXPORT_SYMBOL(edma_alloc_cont_slots);
 
 /**
- * edma_free_cont_slots - deallocate DMA parameter RAMs
- * @slot: first parameter RAM of a set of parameter RAMs to be freed
- * @count: the number of contiguous parameter RAMs to be freed
+ * edma_free_cont_slots - deallocate DMA parameter RAM slots
+ * @slot: first parameter RAM of a set of parameter RAM slots to be freed
+ * @count: the number of contiguous parameter RAM slots to be freed
  *
  * This deallocates the parameter RAM slots allocated by
  * edma_alloc_cont_slots.
  * Callers/applications need to keep track of sets of contiguous
- * parameter RAMs that have been allocated using the edma_alloc_cont_slots
+ * parameter RAM slots that have been allocated using the edma_alloc_cont_slots
  * API.
  * Callers are responsible for ensuring the slots are inactive, and will
  * not be activated.
-- 
1.6.4.3
