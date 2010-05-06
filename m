From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:24 -0700
Subject: [PATCH 33/34] davinci: edma: use a more intuitive name for edma_info
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-34-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

'edma_info' structure inside the edma driver represents
a single instance of edma channel controller. Call it
'edma_cc' instead. This also avoids readers confusing
it with an instance of edma_soc_info structre which
carries the platform data for a single channel controller
instance.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |  158 +++++++++++++++++++++----------------------
 1 files changed, 77 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 0bf290b..b705089 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -243,7 +243,7 @@ struct edma {
 	} intr_data[EDMA_MAX_DMACH];
 };
 
-static struct edma *edma_info[EDMA_MAX_CC];
+static struct edma *edma_cc[EDMA_MAX_CC];
 static int arch_num_cc;
 
 /* dummy param set used to (re)initialize parameter RAM slots */
@@ -261,7 +261,7 @@ static void map_dmach_queue(unsigned ctlr, unsigned ch_no,
 
 	/* default to low priority queue */
 	if (queue_no == EVENTQ_DEFAULT)
-		queue_no = edma_info[ctlr]->default_queue;
+		queue_no = edma_cc[ctlr]->default_queue;
 
 	queue_no &= 7;
 	edma_modify_array(ctlr, EDMA_DMAQNUM, (ch_no >> 3),
@@ -315,8 +315,8 @@ setup_dma_interrupt(unsigned lch,
 				(1 << (lch & 0x1f)));
 	}
 
-	edma_info[ctlr]->intr_data[lch].callback = callback;
-	edma_info[ctlr]->intr_data[lch].data = data;
+	edma_cc[ctlr]->intr_data[lch].callback = callback;
+	edma_cc[ctlr]->intr_data[lch].data = data;
 
 	if (callback) {
 		edma_shadow0_write_array(ctlr, SH_ICR, lch >> 5,
@@ -328,11 +328,10 @@ setup_dma_interrupt(unsigned lch,
 
 static int irq2ctlr(int irq)
 {
-	if (irq >= edma_info[0]->irq_res_start &&
-		irq <= edma_info[0]->irq_res_end)
+	if (irq >= edma_cc[0]->irq_res_start && irq <= edma_cc[0]->irq_res_end)
 		return 0;
-	else if (irq >= edma_info[1]->irq_res_start &&
-		irq <= edma_info[1]->irq_res_end)
+	else if (irq >= edma_cc[1]->irq_res_start &&
+		irq <= edma_cc[1]->irq_res_end)
 		return 1;
 
 	return -1;
@@ -377,10 +376,10 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 				/* Clear the corresponding IPR bits */
 				edma_shadow0_write_array(ctlr, SH_ICR, j,
 							(1 << i));
-				if (edma_info[ctlr]->intr_data[k].callback) {
-					edma_info[ctlr]->intr_data[k].callback(
+				if (edma_cc[ctlr]->intr_data[k].callback) {
+					edma_cc[ctlr]->intr_data[k].callback(
 						k, DMA_COMPLETE,
-						edma_info[ctlr]->intr_data[k].
+						edma_cc[ctlr]->intr_data[k].
 						data);
 				}
 			}
@@ -433,12 +432,12 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 					/* Clear any SER */
 					edma_shadow0_write_array(ctlr, SH_SECR,
 								j, (1 << i));
-					if (edma_info[ctlr]->intr_data[k].
+					if (edma_cc[ctlr]->intr_data[k].
 								callback) {
-						edma_info[ctlr]->intr_data[k].
+						edma_cc[ctlr]->intr_data[k].
 						callback(k,
 						DMA_CC_ERROR,
-						edma_info[ctlr]->intr_data
+						edma_cc[ctlr]->intr_data
 						[k].data);
 					}
 				}
@@ -514,9 +513,9 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
 	int stop_slot = start_slot;
 	DECLARE_BITMAP(tmp_inuse, EDMA_MAX_PARAMENTRY);
 
-	for (i = start_slot; i < edma_info[ctlr]->num_slots; ++i) {
+	for (i = start_slot; i < edma_cc[ctlr]->num_slots; ++i) {
 		j = EDMA_CHAN_SLOT(i);
-		if (!test_and_set_bit(j, edma_info[ctlr]->edma_inuse)) {
+		if (!test_and_set_bit(j, edma_cc[ctlr]->edma_inuse)) {
 			/* Record our current beginning slot */
 			if (count == num_slots)
 				stop_slot = i;
@@ -543,12 +542,12 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
 	 * of contiguous parameter RAM slots but do not find the exact number
 	 * requested as we may reach the total number of parameter RAM slots
 	 */
-	if (i == edma_info[ctlr]->num_slots)
+	if (i == edma_cc[ctlr]->num_slots)
 		stop_slot = i;
 
 	for (j = start_slot; j < stop_slot; j++)
 		if (test_bit(j, tmp_inuse))
-			clear_bit(j, edma_info[ctlr]->edma_inuse);
+			clear_bit(j, edma_cc[ctlr]->edma_inuse);
 
 	if (count)
 		return -EBUSY;
@@ -570,7 +569,7 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 				(int)pdev->resource[i].start >= 0) {
 			ctlr = EDMA_CTLR(pdev->resource[i].start);
 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-					edma_info[ctlr]->edma_unused);
+					edma_cc[ctlr]->edma_unused);
 		}
 	}
 
@@ -644,14 +643,13 @@ int edma_alloc_channel(int channel,
 		for (i = 0; i < arch_num_cc; i++) {
 			channel = 0;
 			for (;;) {
-				channel = find_next_bit(edma_info[i]->
-						edma_unused,
-						edma_info[i]->num_channels,
+				channel = find_next_bit(edma_cc[i]->edma_unused,
+						edma_cc[i]->num_channels,
 						channel);
-				if (channel == edma_info[i]->num_channels)
+				if (channel == edma_cc[i]->num_channels)
 					break;
 				if (!test_and_set_bit(channel,
-						edma_info[i]->edma_inuse)) {
+						edma_cc[i]->edma_inuse)) {
 					done = 1;
 					ctlr = i;
 					break;
@@ -663,9 +661,9 @@ int edma_alloc_channel(int channel,
 		}
 		if (!done)
 			return -ENOMEM;
-	} else if (channel >= edma_info[ctlr]->num_channels) {
+	} else if (channel >= edma_cc[ctlr]->num_channels) {
 		return -EINVAL;
-	} else if (test_and_set_bit(channel, edma_info[ctlr]->edma_inuse)) {
+	} else if (test_and_set_bit(channel, edma_cc[ctlr]->edma_inuse)) {
 		return -EBUSY;
 	}
 
@@ -706,7 +704,7 @@ void edma_free_channel(unsigned channel)
 	ctlr = EDMA_CTLR(channel);
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel >= edma_info[ctlr]->num_channels)
+	if (channel >= edma_cc[ctlr]->num_channels)
 		return;
 
 	setup_dma_interrupt(channel, NULL, NULL);
@@ -714,7 +712,7 @@ void edma_free_channel(unsigned channel)
 
 	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(channel),
 			&dummy_paramset, PARM_SIZE);
-	clear_bit(channel, edma_info[ctlr]->edma_inuse);
+	clear_bit(channel, edma_cc[ctlr]->edma_inuse);
 }
 EXPORT_SYMBOL(edma_free_channel);
 
@@ -738,20 +736,19 @@ int edma_alloc_slot(unsigned ctlr, int slot)
 		slot = EDMA_CHAN_SLOT(slot);
 
 	if (slot < 0) {
-		slot = edma_info[ctlr]->num_channels;
+		slot = edma_cc[ctlr]->num_channels;
 		for (;;) {
-			slot = find_next_zero_bit(edma_info[ctlr]->edma_inuse,
-					edma_info[ctlr]->num_slots, slot);
-			if (slot == edma_info[ctlr]->num_slots)
+			slot = find_next_zero_bit(edma_cc[ctlr]->edma_inuse,
+					edma_cc[ctlr]->num_slots, slot);
+			if (slot == edma_cc[ctlr]->num_slots)
 				return -ENOMEM;
-			if (!test_and_set_bit(slot,
-						edma_info[ctlr]->edma_inuse))
+			if (!test_and_set_bit(slot, edma_cc[ctlr]->edma_inuse))
 				break;
 		}
-	} else if (slot < edma_info[ctlr]->num_channels ||
-			slot >= edma_info[ctlr]->num_slots) {
+	} else if (slot < edma_cc[ctlr]->num_channels ||
+			slot >= edma_cc[ctlr]->num_slots) {
 		return -EINVAL;
-	} else if (test_and_set_bit(slot, edma_info[ctlr]->edma_inuse)) {
+	} else if (test_and_set_bit(slot, edma_cc[ctlr]->edma_inuse)) {
 		return -EBUSY;
 	}
 
@@ -777,13 +774,13 @@ void edma_free_slot(unsigned slot)
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot < edma_info[ctlr]->num_channels ||
-		slot >= edma_info[ctlr]->num_slots)
+	if (slot < edma_cc[ctlr]->num_channels ||
+		slot >= edma_cc[ctlr]->num_slots)
 		return;
 
 	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot),
 			&dummy_paramset, PARM_SIZE);
-	clear_bit(slot, edma_info[ctlr]->edma_inuse);
+	clear_bit(slot, edma_cc[ctlr]->edma_inuse);
 }
 EXPORT_SYMBOL(edma_free_slot);
 
@@ -821,8 +818,8 @@ int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
 	 * of slots
 	 */
 	if ((id != EDMA_CONT_PARAMS_ANY) &&
-		(slot < edma_info[ctlr]->num_channels ||
-		slot >= edma_info[ctlr]->num_slots))
+		(slot < edma_cc[ctlr]->num_channels ||
+		slot >= edma_cc[ctlr]->num_slots))
 		return -EINVAL;
 
 	/*
@@ -831,13 +828,13 @@ int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
 	 * channels
 	 */
 	if (count < 1 || count >
-		(edma_info[ctlr]->num_slots - edma_info[ctlr]->num_channels))
+		(edma_cc[ctlr]->num_slots - edma_cc[ctlr]->num_channels))
 		return -EINVAL;
 
 	switch (id) {
 	case EDMA_CONT_PARAMS_ANY:
 		return reserve_contiguous_slots(ctlr, id, count,
-						 edma_info[ctlr]->num_channels);
+						 edma_cc[ctlr]->num_channels);
 	case EDMA_CONT_PARAMS_FIXED_EXACT:
 	case EDMA_CONT_PARAMS_FIXED_NOT_EXACT:
 		return reserve_contiguous_slots(ctlr, id, count, slot);
@@ -869,8 +866,8 @@ int edma_free_cont_slots(unsigned slot, int count)
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot < edma_info[ctlr]->num_channels ||
-		slot >= edma_info[ctlr]->num_slots ||
+	if (slot < edma_cc[ctlr]->num_channels ||
+		slot >= edma_cc[ctlr]->num_slots ||
 		count < 1)
 		return -EINVAL;
 
@@ -880,7 +877,7 @@ int edma_free_cont_slots(unsigned slot, int count)
 
 		memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot_to_free),
 			&dummy_paramset, PARM_SIZE);
-		clear_bit(slot_to_free, edma_info[ctlr]->edma_inuse);
+		clear_bit(slot_to_free, edma_cc[ctlr]->edma_inuse);
 	}
 
 	return 0;
@@ -910,7 +907,7 @@ void edma_set_src(unsigned slot, dma_addr_t src_port,
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot < edma_info[ctlr]->num_slots) {
+	if (slot < edma_cc[ctlr]->num_slots) {
 		unsigned int i = edma_parm_read(ctlr, PARM_OPT, slot);
 
 		if (mode) {
@@ -948,7 +945,7 @@ void edma_set_dest(unsigned slot, dma_addr_t dest_port,
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot < edma_info[ctlr]->num_slots) {
+	if (slot < edma_cc[ctlr]->num_slots) {
 		unsigned int i = edma_parm_read(ctlr, PARM_OPT, slot);
 
 		if (mode) {
@@ -1008,7 +1005,7 @@ void edma_set_src_index(unsigned slot, s16 src_bidx, s16 src_cidx)
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot < edma_info[ctlr]->num_slots) {
+	if (slot < edma_cc[ctlr]->num_slots) {
 		edma_parm_modify(ctlr, PARM_SRC_DST_BIDX, slot,
 				0xffff0000, src_bidx);
 		edma_parm_modify(ctlr, PARM_SRC_DST_CIDX, slot,
@@ -1034,7 +1031,7 @@ void edma_set_dest_index(unsigned slot, s16 dest_bidx, s16 dest_cidx)
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot < edma_info[ctlr]->num_slots) {
+	if (slot < edma_cc[ctlr]->num_slots) {
 		edma_parm_modify(ctlr, PARM_SRC_DST_BIDX, slot,
 				0x0000ffff, dest_bidx << 16);
 		edma_parm_modify(ctlr, PARM_SRC_DST_CIDX, slot,
@@ -1081,7 +1078,7 @@ void edma_set_transfer_params(unsigned slot,
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot < edma_info[ctlr]->num_slots) {
+	if (slot < edma_cc[ctlr]->num_slots) {
 		edma_parm_modify(ctlr, PARM_LINK_BCNTRLD, slot,
 				0x0000ffff, bcnt_rld << 16);
 		if (sync_mode == ASYNC)
@@ -1111,9 +1108,9 @@ void edma_link(unsigned from, unsigned to)
 	ctlr_to = EDMA_CTLR(to);
 	to = EDMA_CHAN_SLOT(to);
 
-	if (from >= edma_info[ctlr_from]->num_slots)
+	if (from >= edma_cc[ctlr_from]->num_slots)
 		return;
-	if (to >= edma_info[ctlr_to]->num_slots)
+	if (to >= edma_cc[ctlr_to]->num_slots)
 		return;
 	edma_parm_modify(ctlr_from, PARM_LINK_BCNTRLD, from, 0xffff0000,
 				PARM_OFFSET(to));
@@ -1134,7 +1131,7 @@ void edma_unlink(unsigned from)
 	ctlr = EDMA_CTLR(from);
 	from = EDMA_CHAN_SLOT(from);
 
-	if (from >= edma_info[ctlr]->num_slots)
+	if (from >= edma_cc[ctlr]->num_slots)
 		return;
 	edma_parm_or(ctlr, PARM_LINK_BCNTRLD, from, 0xffff);
 }
@@ -1161,7 +1158,7 @@ void edma_write_slot(unsigned slot, const struct edmacc_param *param)
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot >= edma_info[ctlr]->num_slots)
+	if (slot >= edma_cc[ctlr]->num_slots)
 		return;
 	memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot), param,
 			PARM_SIZE);
@@ -1183,7 +1180,7 @@ void edma_read_slot(unsigned slot, struct edmacc_param *param)
 	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
 
-	if (slot >= edma_info[ctlr]->num_slots)
+	if (slot >= edma_cc[ctlr]->num_slots)
 		return;
 	memcpy_fromio(param, edmacc_regs_base[ctlr] + PARM_OFFSET(slot),
 			PARM_SIZE);
@@ -1208,7 +1205,7 @@ void edma_pause(unsigned channel)
 	ctlr = EDMA_CTLR(channel);
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_info[ctlr]->num_channels) {
+	if (channel < edma_cc[ctlr]->num_channels) {
 		unsigned int mask = (1 << (channel & 0x1f));
 
 		edma_shadow0_write_array(ctlr, SH_EECR, channel >> 5, mask);
@@ -1229,7 +1226,7 @@ void edma_resume(unsigned channel)
 	ctlr = EDMA_CTLR(channel);
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_info[ctlr]->num_channels) {
+	if (channel < edma_cc[ctlr]->num_channels) {
 		unsigned int mask = (1 << (channel & 0x1f));
 
 		edma_shadow0_write_array(ctlr, SH_EESR, channel >> 5, mask);
@@ -1255,12 +1252,12 @@ int edma_start(unsigned channel)
 	ctlr = EDMA_CTLR(channel);
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_info[ctlr]->num_channels) {
+	if (channel < edma_cc[ctlr]->num_channels) {
 		int j = channel >> 5;
 		unsigned int mask = (1 << (channel & 0x1f));
 
 		/* EDMA channels without event association */
-		if (test_bit(channel, edma_info[ctlr]->edma_unused)) {
+		if (test_bit(channel, edma_cc[ctlr]->edma_unused)) {
 			pr_debug("EDMA: ESR%d %08x\n", j,
 				edma_shadow0_read_array(ctlr, SH_ESR, j));
 			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
@@ -1301,7 +1298,7 @@ void edma_stop(unsigned channel)
 	ctlr = EDMA_CTLR(channel);
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_info[ctlr]->num_channels) {
+	if (channel < edma_cc[ctlr]->num_channels) {
 		int j = channel >> 5;
 		unsigned int mask = (1 << (channel & 0x1f));
 
@@ -1340,7 +1337,7 @@ void edma_clean_channel(unsigned channel)
 	ctlr = EDMA_CTLR(channel);
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_info[ctlr]->num_channels) {
+	if (channel < edma_cc[ctlr]->num_channels) {
 		int j = (channel >> 5);
 		unsigned int mask = 1 << (channel & 0x1f);
 
@@ -1368,7 +1365,7 @@ void edma_clear_event(unsigned channel)
 	ctlr = EDMA_CTLR(channel);
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel >= edma_info[ctlr]->num_channels)
+	if (channel >= edma_cc[ctlr]->num_channels)
 		return;
 	if (channel < 32)
 		edma_write(ctlr, EDMA_ECR, 1 << channel);
@@ -1423,38 +1420,37 @@ static int __init edma_probe(struct platform_device *pdev)
 			goto fail1;
 		}
 
-		edma_info[j] = kmalloc(sizeof(struct edma), GFP_KERNEL);
-		if (!edma_info[j]) {
+		edma_cc[j] = kmalloc(sizeof(struct edma), GFP_KERNEL);
+		if (!edma_cc[j]) {
 			status = -ENOMEM;
 			goto fail1;
 		}
-		memset(edma_info[j], 0, sizeof(struct edma));
+		memset(edma_cc[j], 0, sizeof(struct edma));
 
-		edma_info[j]->num_channels = min_t(unsigned, info[j].n_channel,
+		edma_cc[j]->num_channels = min_t(unsigned, info[j].n_channel,
 							EDMA_MAX_DMACH);
-		edma_info[j]->num_slots = min_t(unsigned, info[j].n_slot,
+		edma_cc[j]->num_slots = min_t(unsigned, info[j].n_slot,
 							EDMA_MAX_PARAMENTRY);
-		edma_info[j]->num_cc = min_t(unsigned, info[j].n_cc,
-							EDMA_MAX_CC);
+		edma_cc[j]->num_cc = min_t(unsigned, info[j].n_cc, EDMA_MAX_CC);
 
-		edma_info[j]->default_queue = info[j].default_queue;
-		if (!edma_info[j]->default_queue)
-			edma_info[j]->default_queue = EVENTQ_1;
+		edma_cc[j]->default_queue = info[j].default_queue;
+		if (!edma_cc[j]->default_queue)
+			edma_cc[j]->default_queue = EVENTQ_1;
 
 		dev_dbg(&pdev->dev, "DMA REG BASE ADDR=%p\n",
 			edmacc_regs_base[j]);
 
-		for (i = 0; i < edma_info[j]->num_slots; i++)
+		for (i = 0; i < edma_cc[j]->num_slots; i++)
 			memcpy_toio(edmacc_regs_base[j] + PARM_OFFSET(i),
 					&dummy_paramset, PARM_SIZE);
 
 		/* Mark all channels as unused */
-		memset(edma_info[j]->edma_unused, 0xff,
-			sizeof(edma_info[j]->edma_unused));
+		memset(edma_cc[j]->edma_unused, 0xff,
+			sizeof(edma_cc[j]->edma_unused));
 
 		sprintf(irq_name, "edma%d", j);
 		irq[j] = platform_get_irq_byname(pdev, irq_name);
-		edma_info[j]->irq_res_start = irq[j];
+		edma_cc[j]->irq_res_start = irq[j];
 		status = request_irq(irq[j], dma_irq_handler, 0, "edma",
 					&pdev->dev);
 		if (status < 0) {
@@ -1465,7 +1461,7 @@ static int __init edma_probe(struct platform_device *pdev)
 
 		sprintf(irq_name, "edma%d_err", j);
 		err_irq[j] = platform_get_irq_byname(pdev, irq_name);
-		edma_info[j]->irq_res_end = err_irq[j];
+		edma_cc[j]->irq_res_end = err_irq[j];
 		status = request_irq(err_irq[j], dma_ccerr_handler, 0,
 					"edma_error", &pdev->dev);
 		if (status < 0) {
@@ -1478,7 +1474,7 @@ static int __init edma_probe(struct platform_device *pdev)
 		 * specified. This way, long transfers on the low priority queue
 		 * started by the codec engine will not cause audio defects.
 		 */
-		for (i = 0; i < edma_info[j]->num_channels; i++)
+		for (i = 0; i < edma_cc[j]->num_channels; i++)
 			map_dmach_queue(j, i, EVENTQ_1);
 
 		queue_tc_mapping = info[j].queue_tc_mapping;
@@ -1541,7 +1537,7 @@ fail1:
 			release_mem_region(r[i]->start, len[i]);
 		if (edmacc_regs_base[i])
 			iounmap(edmacc_regs_base[i]);
-		kfree(edma_info[i]);
+		kfree(edma_cc[i]);
 	}
 	return status;
 }
-- 
1.7.0.2
