From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 22 Jun 2012 19:18:07 +0530
Subject: [PATCH 08/11] crypto: omap: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Message-ID: <1340372890-10091-9-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the omap crypto clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/omap-aes.c  |    2 ++
 drivers/crypto/omap-sham.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 63e57b5..70da28c 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -848,6 +848,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 		err = PTR_ERR(dd->iclk);
 		goto err_res;
 	}
+	clk_prepare(dd->iclk);
 
 	dd->io_base = ioremap(dd->phys_base, SZ_4K);
 	if (!dd->io_base) {
@@ -894,6 +895,7 @@ err_dma:
 	tasklet_kill(&dd->queue_task);
 	iounmap(dd->io_base);
 err_io:
+	clk_unprepare(dd->iclk);
 	clk_put(dd->iclk);
 err_res:
 	kfree(dd);
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index a3fd6fc..ac5e58d 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1205,6 +1205,7 @@ static int __devinit omap_sham_probe(struct platform_device *pdev)
 		err = PTR_ERR(dd->iclk);
 		goto clk_err;
 	}
+	clk_prepare(dd->iclk);
 
 	dd->io_base = ioremap(dd->phys_base, SZ_4K);
 	if (!dd->io_base) {
@@ -1236,6 +1237,7 @@ err_algs:
 		crypto_unregister_ahash(&algs[j]);
 	iounmap(dd->io_base);
 io_err:
+	clk_unprepare(dd->iclk);
 	clk_put(dd->iclk);
 clk_err:
 	omap_sham_dma_cleanup(dd);
-- 
1.7.1
