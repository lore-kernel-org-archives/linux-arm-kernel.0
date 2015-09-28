From: yitian.bu@tangramtek.com (yitian)
Date: Mon, 28 Sep 2015 10:55:58 +0800
Subject: [PATCH 1/1] dmaengine: dw: fix nollp issue
Message-ID: <032901d0f999$363fae80$a2bf0b80$@tangramtek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when channel number is less than maximum number, the register
address of all channels is wrong, which causes the "nollp" flag
is set for all channels even if HW supports llp.

Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
---
 drivers/dma/dw/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index cf1c87f..c2e9ac8 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1591,7 +1591,7 @@ int dw_dma_probe(struct dw_dma_chip *chip, struct
dw_dma_platform_data *pdata)
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < nr_channels; i++) {
 		struct dw_dma_chan	*dwc = &dw->chan[i];
-		int			r = nr_channels - i - 1;
+		int			r = DW_DMA_MAX_NR_CHANNELS - i - 1;
 
 		dwc->chan.device = &dw->dma;
 		dma_cookie_init(&dwc->chan);
-- 
1.7.12.4
