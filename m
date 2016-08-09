From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue,  9 Aug 2016 11:03:14 +0200
Subject: [PATCH 1/7] crypto: marvell: be explicit about destination in
 mv_cesa_dma_add_op()
In-Reply-To: <1470733400-23621-1-git-send-email-romain.perier@free-electrons.com>
References: <1470733400-23621-1-git-send-email-romain.perier@free-electrons.com>
Message-ID: <1470733400-23621-2-git-send-email-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The mv_cesa_dma_add_op() function builds a mv_cesa_tdma_desc structure
to copy the operation description to the SRAM, but doesn't explicitly
initialize the destination of the copy. It works fine because the
operatin description must be copied at the beginning of the SRAM, and
the mv_cesa_tdma_desc structure is initialized to zero when
allocated. However, it is somewhat confusing to not have a destination
defined.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/crypto/marvell/tdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/marvell/tdma.c b/drivers/crypto/marvell/tdma.c
index 86a065b..9fd7a5f 100644
--- a/drivers/crypto/marvell/tdma.c
+++ b/drivers/crypto/marvell/tdma.c
@@ -261,6 +261,7 @@ struct mv_cesa_op_ctx *mv_cesa_dma_add_op(struct mv_cesa_tdma_chain *chain,
 	tdma->op = op;
 	tdma->byte_cnt = cpu_to_le32(size | BIT(31));
 	tdma->src = cpu_to_le32(dma_handle);
+	tdma->dst = CESA_SA_CFG_SRAM_OFFSET;
 	tdma->flags = CESA_TDMA_DST_IN_SRAM | CESA_TDMA_OP;
 
 	return op;
-- 
2.8.1
