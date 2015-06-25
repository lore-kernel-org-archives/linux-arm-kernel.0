From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 25 Jun 2015 10:37:50 +0200
Subject: [PATCH] crypto: mv_cesa - fix up for of_get_named_gen_pool() rename
In-Reply-To: <CABxcv=m4juAMHaMYSB+8O8cEX+YZCJ0cArS2wN-YGpTBgWe-CA@mail.gmail.com>
References: <CABxcv=m4juAMHaMYSB+8O8cEX+YZCJ0cArS2wN-YGpTBgWe-CA@mail.gmail.com>
Message-ID: <1435221470-5382-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following build error:

drivers/crypto/mv_cesa.c: In function 'mv_cesa_get_sram':
drivers/crypto/mv_cesa.c:1037: error: implicit declaration of function 'of_get_named_gen_pool'
drivers/crypto/mv_cesa.c:1038: warning: assignment makes pointer from integer without a cast
scripts/Makefile.build:258: recipe for target 'drivers/crypto/mv_cesa.o' failed

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/crypto/mv_cesa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/mv_cesa.c b/drivers/crypto/mv_cesa.c
index 5bcd575fa96f..e6b658faef63 100644
--- a/drivers/crypto/mv_cesa.c
+++ b/drivers/crypto/mv_cesa.c
@@ -1034,8 +1034,8 @@ static int mv_cesa_get_sram(struct platform_device *pdev,
 			     &sram_size);
 
 	cp->sram_size = sram_size;
-	cp->sram_pool = of_get_named_gen_pool(pdev->dev.of_node,
-					      "marvell,crypto-srams", 0);
+	cp->sram_pool = of_gen_pool_get(pdev->dev.of_node,
+					"marvell,crypto-srams", 0);
 	if (cp->sram_pool) {
 		cp->sram = gen_pool_dma_alloc(cp->sram_pool, sram_size,
 					      &cp->sram_dma);
-- 
2.1.4
