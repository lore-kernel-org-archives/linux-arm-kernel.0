From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Dec 2016 22:03:37 +0800
Subject: [PATCH 3/3] dma: zx: fix residue calculation
In-Reply-To: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
References: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1481810617-7650-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The dma residue is defined as the free space to end of transfer buffer,
which could be multiple segments chained together.  So the residue
calculation in zx_dma_tx_status() works for both slave_sg and cyclic
case.  But unfortunately, the 'index' is wrong.  It should plus one,
because the current segment is already occupied and shouldn't be counted
into free space.

This fixes the HDMI audio noise issue we see on ZX296718 with SPDIF
interface.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/zx_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 33155c6816cc..42ff3e66c1e1 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -365,7 +365,8 @@ static enum dma_status zx_dma_tx_status(struct dma_chan *chan,
 
 		bytes = 0;
 		clli = zx_dma_get_curr_lli(p);
-		index = (clli - ds->desc_hw_lli) / sizeof(struct zx_desc_hw);
+		index = (clli - ds->desc_hw_lli) /
+				sizeof(struct zx_desc_hw) + 1;
 		for (; index < ds->desc_num; index++) {
 			bytes += ds->desc_hw[index].src_x;
 			/* end of lli */
-- 
1.9.1
