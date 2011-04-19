From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 19 Apr 2011 14:02:11 +0530
Subject: [PATCH V2 6/7] dmaengine/dw_dmac: Divide one sg to many desc,
	if sg len is greater than DWC_MAX_COUNT
In-Reply-To: <cover.1303194835.git.viresh.kumar@st.com>
References: <cover.1303194835.git.viresh.kumar@st.com>
Message-ID: <16fcd2b821f4785ac9ed8afdec4ce54afecd6f2f.1303194836.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If len passed in sg for slave_sg transfers is greater than DWC_MAX_COUNT, then
driver programmes controller incorrectly.  This patch adds code to handle this
situation by allocation more than one desc for same sg.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |   65 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index f4779e2..c30f0ba 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -697,9 +697,15 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		reg = dws->tx_reg;
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct dw_desc	*desc;
-			u32		len;
-			u32		mem;
+			u32		len, dlen, mem;
 
+			mem = sg_phys(sg);
+			len = sg_dma_len(sg);
+			mem_width = 2;
+			if (unlikely(mem & 3 || len & 3))
+				mem_width = 0;
+
+slave_sg_todev_fill_desc:
 			desc = dwc_desc_get(dwc);
 			if (!desc) {
 				dev_err(chan2dev(chan),
@@ -707,16 +713,19 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 				goto err_desc_get;
 			}
 
-			mem = sg_phys(sg);
-			len = sg_dma_len(sg);
-			mem_width = 2;
-			if (unlikely(mem & 3 || len & 3))
-				mem_width = 0;
-
 			desc->lli.sar = mem;
 			desc->lli.dar = reg;
 			desc->lli.ctllo = ctllo | DWC_CTLL_SRC_WIDTH(mem_width);
-			desc->lli.ctlhi = len >> mem_width;
+			if ((len >> mem_width) > DWC_MAX_COUNT) {
+				dlen = DWC_MAX_COUNT << mem_width;
+				mem += dlen;
+				len -= dlen;
+			} else {
+				dlen = len;
+				len = 0;
+			}
+
+			desc->lli.ctlhi = dlen >> mem_width;
 
 			if (!first) {
 				first = desc;
@@ -730,7 +739,10 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 						&first->tx_list);
 			}
 			prev = desc;
-			total_len += len;
+			total_len += dlen;
+
+			if (len)
+				goto slave_sg_todev_fill_desc;
 		}
 		break;
 	case DMA_FROM_DEVICE:
@@ -743,15 +755,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		reg = dws->rx_reg;
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct dw_desc	*desc;
-			u32		len;
-			u32		mem;
-
-			desc = dwc_desc_get(dwc);
-			if (!desc) {
-				dev_err(chan2dev(chan),
-					"not enough descriptors available\n");
-				goto err_desc_get;
-			}
+			u32		len, dlen, mem;
 
 			mem = sg_phys(sg);
 			len = sg_dma_len(sg);
@@ -759,10 +763,26 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (unlikely(mem & 3 || len & 3))
 				mem_width = 0;
 
+slave_sg_fromdev_fill_desc:
+			desc = dwc_desc_get(dwc);
+			if (!desc) {
+				dev_err(chan2dev(chan),
+						"not enough descriptors available\n");
+				goto err_desc_get;
+			}
+
 			desc->lli.sar = reg;
 			desc->lli.dar = mem;
 			desc->lli.ctllo = ctllo | DWC_CTLL_DST_WIDTH(mem_width);
-			desc->lli.ctlhi = len >> reg_width;
+			if ((len >> reg_width) > DWC_MAX_COUNT) {
+				dlen = DWC_MAX_COUNT << reg_width;
+				mem += dlen;
+				len -= dlen;
+			} else {
+				dlen = len;
+				len = 0;
+			}
+			desc->lli.ctlhi = dlen >> reg_width;
 
 			if (!first) {
 				first = desc;
@@ -776,7 +796,10 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 						&first->tx_list);
 			}
 			prev = desc;
-			total_len += len;
+			total_len += dlen;
+
+			if (len)
+				goto slave_sg_fromdev_fill_desc;
 		}
 		break;
 	default:
-- 
1.7.2.2
