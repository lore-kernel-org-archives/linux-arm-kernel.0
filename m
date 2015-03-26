From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 13:06:30 +0000
Subject: [PATCH 2/3] dmaengine: at_hdmac: use __le32 for descriptor writes
In-Reply-To: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427375191-1467-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure the at_hdmac driver writes descriptors out in the
peripheral's little endian format when the cpu is running
in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Vinod Koul <vinod.koul@intel.com>
CC: linux-arm-kernel at lists.infradead.org
CC: dmaengine at vger.kernel.org
---
 drivers/dma/at_hdmac.c      | 74 ++++++++++++++++++++++-----------------------
 drivers/dma/at_hdmac_regs.h | 13 ++++----
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 1e1a4c5..174858b 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -190,7 +190,7 @@ static void atc_desc_chain(struct at_desc **first, struct at_desc **prev,
 		*first = desc;
 	} else {
 		/* inform the HW lli about chaining */
-		(*prev)->lli.dscr = desc->txd.phys;
+		(*prev)->lli.dscr = cpu_to_le32(desc->txd.phys);
 		/* insert the link descriptor to the LD ring */
 		list_add_tail(&desc->desc_node,
 				&(*first)->tx_list);
@@ -249,13 +249,13 @@ static struct at_desc *atc_get_current_descriptors(struct at_dma_chan *atchan,
 	struct at_desc  *desc, *_desc, *child, *desc_cur = NULL;
 
 	list_for_each_entry_safe(desc, _desc, &atchan->active_list, desc_node) {
-		if (desc->lli.dscr == dscr_addr) {
+		if (le32_to_cpu(desc->lli.dscr) == dscr_addr) {
 			desc_cur = desc;
 			break;
 		}
 
 		list_for_each_entry(child, &desc->tx_list, desc_node) {
-			if (child->lli.dscr == dscr_addr) {
+			if (le32_to_cpu(child->lli.dscr) == dscr_addr) {
 				desc_cur = child;
 				break;
 			}
@@ -300,7 +300,7 @@ static int atc_get_bytes_left(struct dma_chan *chan)
 			goto out;
 		}
 
-		count = (desc_cur->lli.ctrla & ATC_BTSIZE_MAX)
+		count = (le32_to_cpu(desc_cur->lli.ctrla) & ATC_BTSIZE_MAX)
 			<< desc_first->tx_width;
 		if (atchan->remain_desc < count) {
 			ret = -EINVAL;
@@ -647,10 +647,10 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!desc)
 			goto err_desc_get;
 
-		desc->lli.saddr = src + offset;
-		desc->lli.daddr = dest + offset;
-		desc->lli.ctrla = ctrla | xfer_count;
-		desc->lli.ctrlb = ctrlb;
+		desc->lli.saddr = cpu_to_le32(src + offset);
+		desc->lli.daddr = cpu_to_le32(dest + offset);
+		desc->lli.ctrla = cpu_to_le32(ctrla | xfer_count);
+		desc->lli.ctrlb = cpu_to_le32(ctrlb);
 
 		desc->txd.cookie = 0;
 
@@ -746,12 +746,12 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (unlikely(mem & 3 || len & 3))
 				mem_width = 0;
 
-			desc->lli.saddr = mem;
-			desc->lli.daddr = reg;
-			desc->lli.ctrla = ctrla
-					| ATC_SRC_WIDTH(mem_width)
-					| len >> mem_width;
-			desc->lli.ctrlb = ctrlb;
+			desc->lli.saddr = cpu_to_le32(mem);
+			desc->lli.daddr = cpu_to_le32(reg);
+			desc->lli.ctrla = cpu_to_le32(ctrla
+						      | ATC_SRC_WIDTH(mem_width)
+						      | len >> mem_width);
+			desc->lli.ctrlb = cpu_to_le32(ctrlb);
 
 			atc_desc_chain(&first, &prev, desc);
 			total_len += len;
@@ -786,12 +786,12 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (unlikely(mem & 3 || len & 3))
 				mem_width = 0;
 
-			desc->lli.saddr = reg;
-			desc->lli.daddr = mem;
-			desc->lli.ctrla = ctrla
-					| ATC_DST_WIDTH(mem_width)
-					| len >> reg_width;
-			desc->lli.ctrlb = ctrlb;
+			desc->lli.saddr = cpu_to_le32(reg);
+			desc->lli.daddr = cpu_to_le32(mem);
+			desc->lli.ctrla = cpu_to_le32(ctrla
+						      | ATC_DST_WIDTH(mem_width)
+						      | len >> reg_width);
+			desc->lli.ctrlb = cpu_to_le32(ctrlb);
 
 			atc_desc_chain(&first, &prev, desc);
 			total_len += len;
@@ -864,25 +864,25 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
-		desc->lli.saddr = buf_addr + (period_len * period_index);
-		desc->lli.daddr = sconfig->dst_addr;
-		desc->lli.ctrla = ctrla;
-		desc->lli.ctrlb = ATC_DST_ADDR_MODE_FIXED
-				| ATC_SRC_ADDR_MODE_INCR
-				| ATC_FC_MEM2PER
-				| ATC_SIF(atchan->mem_if)
-				| ATC_DIF(atchan->per_if);
+		desc->lli.saddr = cpu_to_le32(buf_addr + (period_len * period_index));
+		desc->lli.daddr = cpu_to_le32(sconfig->dst_addr);
+		desc->lli.ctrla = cpu_to_le32(ctrla);
+		desc->lli.ctrlb = cpu_to_le32(ATC_DST_ADDR_MODE_FIXED
+					      | ATC_SRC_ADDR_MODE_INCR
+					      | ATC_FC_MEM2PER
+					      | ATC_SIF(atchan->mem_if)
+					      | ATC_DIF(atchan->per_if));
 		break;
 
 	case DMA_DEV_TO_MEM:
-		desc->lli.saddr = sconfig->src_addr;
-		desc->lli.daddr = buf_addr + (period_len * period_index);
-		desc->lli.ctrla = ctrla;
-		desc->lli.ctrlb = ATC_DST_ADDR_MODE_INCR
-				| ATC_SRC_ADDR_MODE_FIXED
-				| ATC_FC_PER2MEM
-				| ATC_SIF(atchan->per_if)
-				| ATC_DIF(atchan->mem_if);
+		desc->lli.saddr = cpu_to_le32(sconfig->src_addr);
+		desc->lli.daddr = cpu_to_le32(buf_addr + (period_len * period_index));
+		desc->lli.ctrla = cpu_to_le32(ctrla);
+		desc->lli.ctrlb = cpu_to_le32(ATC_DST_ADDR_MODE_INCR
+					      | ATC_SRC_ADDR_MODE_FIXED
+					      | ATC_FC_PER2MEM
+					      | ATC_SIF(atchan->per_if)
+					      | ATC_DIF(atchan->mem_if));
 		break;
 
 	default:
@@ -960,7 +960,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	}
 
 	/* lets make a cyclic list */
-	prev->lli.dscr = first->txd.phys;
+	prev->lli.dscr = cpu_to_le32(first->txd.phys);
 
 	/* First descriptor of the chain embedds additional information */
 	first->txd.cookie = -EBUSY;
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index b4d0a54..a79c4b4 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -170,9 +170,9 @@ struct at_lli {
 	dma_addr_t	saddr;
 	dma_addr_t	daddr;
 	/* value that may get written back: */
-	u32		ctrla;
+	__le32		ctrla;
 	/* more values that are not changed by hardware */
-	u32		ctrlb;
+	__le32		ctrlb;
 	dma_addr_t	dscr;	/* chain to next lli */
 };
 
@@ -377,8 +377,9 @@ static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
 {
 	dev_crit(chan2dev(&atchan->chan_common),
 		 "  desc: s0x%x d0x%x ctrl0x%x:0x%x l0x%x\n",
-		 lli->saddr, lli->daddr,
-		 lli->ctrla, lli->ctrlb, lli->dscr);
+		 le32_to_cpu(lli->saddr), le32_to_cpu(lli->daddr),
+		 le32_to_cpu(lli->ctrla), le32_to_cpu(lli->ctrlb),
+		 le32_to_cpu(lli->dscr));
 }
 
 
@@ -443,8 +444,8 @@ static void set_desc_eol(struct at_desc *desc)
 {
 	u32 ctrlb = desc->lli.ctrlb;
 
-	ctrlb &= ~ATC_IEN;
-	ctrlb |= ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS;
+	ctrlb &= cpu_to_le32(~ATC_IEN);
+	ctrlb |= cpu_to_le32(ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS);
 
 	desc->lli.ctrlb = ctrlb;
 	desc->lli.dscr = 0;
-- 
2.1.4
