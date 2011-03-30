From: hong.xu@atmel.com (Hong Xu)
Date: Wed, 30 Mar 2011 16:26:41 +0800
Subject: [PATCH 3/3] MTD/atmel_nand: Fix support for CPUs that do not support
	DMA access
In-Reply-To: <1301473601-29570-1-git-send-email-hong.xu@atmel.com>
References: <1301473601-29570-1-git-send-email-hong.xu@atmel.com>
Message-ID: <1301473601-29570-3-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use_dma was always "1" even if the CPU does not support DMA

Tested on AT91SAM9261EK by Jean-Christophe PLAGNIOL-VILLARD

Reported-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index c36ea50..1b43654 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -599,7 +599,10 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		nand_chip->options |= NAND_USE_FLASH_BBT;
 	}
 
-	if (cpu_has_dma() && use_dma) {
+	if (!cpu_has_dma())
+		use_dma = 0;
+
+	if (use_dma) {
 		dma_cap_mask_t mask;
 
 		dma_cap_zero(mask);
-- 
1.7.3.3
