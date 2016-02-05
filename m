From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 5 Feb 2016 13:45:12 +0100
Subject: [PATCH 1/2] crypto: atmel-sha: fix atmel_sha_remove()
In-Reply-To: <cover.1454675769.git.cyrille.pitchen@atmel.com>
References: <cover.1454675769.git.cyrille.pitchen@atmel.com>
Message-ID: <0ded195da1a7c7e84f959eff0cdd65ddc39c8d51.1454675769.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since atmel_sha_probe() uses devm_xxx functions to allocate resources,
atmel_sha_remove() should no longer explicitly release them.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Fixes: b0e8b3417a62 ("crypto: atmel - use devm_xxx() managed function")
---
 drivers/crypto/atmel-sha.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 63b09e01075c..b827c99b17c1 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1611,13 +1611,6 @@ static int atmel_sha_remove(struct platform_device *pdev)
 	if (sha_dd->caps.has_dma)
 		atmel_sha_dma_cleanup(sha_dd);
 
-	iounmap(sha_dd->io_base);
-
-	clk_put(sha_dd->iclk);
-
-	if (sha_dd->irq >= 0)
-		free_irq(sha_dd->irq, sha_dd);
-
 	return 0;
 }
 
-- 
1.8.2.2
