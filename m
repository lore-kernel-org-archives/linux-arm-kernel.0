From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jul 2017 14:07:03 +0200
Subject: [PATCH 11/22] net: thunder_bgx: avoid format string overflow warning
In-Reply-To: <20170714120720.906842-1-arnd@arndb.de>
References: <20170714120720.906842-1-arnd@arndb.de>
Message-ID: <20170714120720.906842-12-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc warns that the temporary buffer might be too small here:

drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function 'bgx_probe':
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1020:16: error: '%d' directive writing between 1 and 10 bytes into a region of size between 9 and 11 [-Werror=format-overflow=]
sprintf(str, "BGX%d LMAC%d mode", bgx->bgx_id, lmacid);
             ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1020:16: note: directive argument in the range [0, 2147483647]
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1020:3: note: 'sprintf' output between 16 and 27 bytes into a destination of size 20

This probably can't happen, but it can't hurt to make it long
enough for the theoretical limit.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a0ca68ce3fbb..79112563a25a 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1008,7 +1008,7 @@ static void bgx_print_qlm_mode(struct bgx *bgx, u8 lmacid)
 {
 	struct device *dev = &bgx->pdev->dev;
 	struct lmac *lmac;
-	char str[20];
+	char str[27];
 
 	if (!bgx->is_dlm && lmacid)
 		return;
-- 
2.9.0
