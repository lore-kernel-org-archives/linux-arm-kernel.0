From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 28 Oct 2014 12:01:43 +0100
Subject: [PATCHv2 5/6] net: fec: simplify loop counter handling in
 swap_buffer()
In-Reply-To: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
References: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1414494104-27943-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminate the DIV_ROUND_UP() and change the loop counter increment to
4 instead. This results in saving 6 instructions in the functions
assembly code.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 3a103e9..404fb9d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -333,7 +333,7 @@ static void *swap_buffer(void *bufaddr, int len)
 	int i;
 	unsigned int *buf = bufaddr;
 
-	for (i = 0; i < DIV_ROUND_UP(len, 4); i++, buf++)
+	for (i = 0; i < len; i += 4, buf++)
 		swab32s(buf);
 
 	return bufaddr;
-- 
1.7.10.4
