From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue,  7 Mar 2017 18:09:09 +0530
Subject: [PATCH v2 2/4] net: thunderx: Fix LMAC mode debug prints for QSGMII
 mode
In-Reply-To: <1488890351-18493-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1488890351-18493-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1488890351-18493-3-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

When BGX/LMACs are in QSGMII mode, for some LMACs, mode info is
not being printed. This patch will fix that. With changes already
done to not do any sort of serdes 2 lane mapping config calculation
in kernel driver, we can get rid of this logic.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 4c8e8cf..9b8a53e 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1011,12 +1011,6 @@ static void bgx_print_qlm_mode(struct bgx *bgx, u8 lmacid)
 			dev_info(dev, "%s: 40G_KR4\n", (char *)str);
 		break;
 	case BGX_MODE_QSGMII:
-		if ((lmacid == 0) &&
-		    (bgx_get_lane2sds_cfg(bgx, lmac) != lmacid))
-			return;
-		if ((lmacid == 2) &&
-		    (bgx_get_lane2sds_cfg(bgx, lmac) == lmacid))
-			return;
 		dev_info(dev, "%s: QSGMII\n", (char *)str);
 		break;
 	case BGX_MODE_RGMII:
-- 
2.7.4
