From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 28 Oct 2014 14:23:01 +0100
Subject: [PATCHv3 6/9] net: fec: use swab32s() instead of cpu_to_be32()
In-Reply-To: <1414502584-10583-1-git-send-email-LW@KARO-electronics.de>
References: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
 <1414502584-10583-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1414502584-10583-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when swap_buffer() is being called, we know for sure, that we need to
byte swap the data. Also this function is called for swapping data in
both directions. Thus cpu_to_be32() is semantically not correct for
all use cases. Use swab32s() to reflect this.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5c1d517..5b76cdc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -293,7 +293,7 @@ static void *swap_buffer(void *bufaddr, int len)
 	unsigned int *buf = bufaddr;
 
 	for (i = 0; i < DIV_ROUND_UP(len, 4); i++, buf++)
-		*buf = cpu_to_be32(*buf);
+		swab32s(buf);
 
 	return bufaddr;
 }
-- 
1.7.10.4
