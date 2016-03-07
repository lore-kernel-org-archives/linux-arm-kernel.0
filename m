From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:21:29 +0100
Subject: [PATCH 10/16] mtd: nand: sunxi: fix the NFC_ECC_ERR_CNT() macro
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NFC_ECC_ERR_CNT() is not taking into account the case when the NAND chip
contains more than 4 ECC blocks (NANDs with 4kB+ pages).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 25a167f..c1ab33a 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -155,7 +155,7 @@
 /* define bit use in NFC_ECC_ST */
 #define NFC_ECC_ERR(x)		BIT(x)
 #define NFC_ECC_PAT_FOUND(x)	BIT(x + 16)
-#define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
+#define NFC_ECC_ERR_CNT(b, x)	(((x) >> (((b) % 4) * 8)) & 0xff)
 
 #define NFC_DEFAULT_TIMEOUT_MS	1000
 
-- 
2.1.4
