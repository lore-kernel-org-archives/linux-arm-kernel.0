From: colin.king@canonical.com (Colin King)
Date: Mon,  6 Aug 2018 17:50:45 +0100
Subject: [PATCH] net: thunderx: check for failed allocation lmac->dmacs
Message-ID: <20180806165045.15707-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The allocation of lmac->dmacs is not being checked for allocation
failure. Add the check.

Fixes: 3a34ecfd9d3f ("net: thunderx: add MAC address filter tracking for LMAC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 5d08d2aeb172..e337da6ba2a4 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1083,6 +1083,8 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 	lmac->dmacs_count = (RX_DMAC_COUNT / bgx->lmac_count);
 	lmac->dmacs = kcalloc(lmac->dmacs_count, sizeof(*lmac->dmacs),
 			      GFP_KERNEL);
+	if (!lmac->dmacs)
+		return -ENOMEM;
 
 	/* Enable lmac */
 	bgx_reg_modify(bgx, lmacid, BGX_CMRX_CFG, CMR_EN);
-- 
2.17.1
