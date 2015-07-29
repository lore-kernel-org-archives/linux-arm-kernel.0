From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Wed, 29 Jul 2015 16:49:46 +0300
Subject: [PATCH net 11/11] net: thunderx: Fix for crash while BGX teardown
In-Reply-To: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1438177787-20940-12-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thanneeru Srinivasulu <tsrinivasulu@caviumnetworks.com>

Cortina phy does not have kernel driver and we don't attach
device with phy layer for intefaces like XFI, XLAUI etc,
Hence check for interface type before calling disconnect.

Signed-off-by: Thanneeru Srinivasulu <tsrinivasulu@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 633ec05..b961a89 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -673,7 +673,10 @@ static void bgx_lmac_disable(struct bgx *bgx, u8 lmacid)
 	bgx_reg_write(bgx, lmacid, BGX_CMRX_CFG, cmrx_cfg);
 	bgx_flush_dmac_addrs(bgx, lmacid);
 
-	if (lmac->phydev)
+	if ((bgx->lmac_type != BGX_MODE_XFI) &&
+	    (bgx->lmac_type != BGX_MODE_XLAUI) &&
+	    (bgx->lmac_type != BGX_MODE_40G_KR) &&
+	    (bgx->lmac_type != BGX_MODE_10G_KR) && lmac->phydev)
 		phy_disconnect(lmac->phydev);
 
 	lmac->phydev = NULL;
-- 
2.4.6
