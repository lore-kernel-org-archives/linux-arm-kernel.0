From: Herve.CODINA@celad.com (Herve Codina)
Date: Mon, 3 Mar 2014 12:15:29 +0100
Subject: [PATCH] Disable Subpage nand write when using Atmel PMECC
Message-ID: <1393845329-18175-1-git-send-email-Herve.CODINA@celad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Crash detected on sam5d35 and its pmecc nand ecc controller.

The problem was a call to chip->ecc.hwctl from nand_write_subpage_hwecc
(nand_base.c) when we write a sub page.
chip->ecc.hwctl function is not set when we are using PMECC controller.
As a workaround, set NAND_NO_SUBPAGE_WRITE for PMECC controller in
order to disable sub page access in nand_write_page.


Signed-off-by: Herve Codina <Herve.CODINA@celad.com>
---
 drivers/mtd/nand/atmel_nand.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 1f719e0..4ce181a 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1220,6 +1220,7 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 		goto err;
 	}
 
+	nand_chip->options |= NAND_NO_SUBPAGE_WRITE;
 	nand_chip->ecc.read_page = atmel_nand_pmecc_read_page;
 	nand_chip->ecc.write_page = atmel_nand_pmecc_write_page;
 
-- 
1.7.9.5
