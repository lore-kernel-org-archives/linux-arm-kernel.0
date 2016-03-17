From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 17 Mar 2016 10:47:11 +0100
Subject: [PATCH] crypto: marvell/cesa - forward devm_ioremap_resource() error
 code
In-Reply-To: <1458208031-13463-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458208031-13463-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458208031-13463-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward devm_ioremap_resource() error code instead of returning
-ENOMEM.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Fixes: f63601fd616a ("crypto: marvell/cesa - add a new driver for Marvell's CESA")
Cc: <stable@vger.kernel.org> # 4.2+
---
 drivers/crypto/marvell/cesa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index c0656e7..80239ae 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -420,7 +420,7 @@ static int mv_cesa_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	cesa->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cesa->regs))
-		return -ENOMEM;
+		return PTR_ERR(cesa->regs);
 
 	ret = mv_cesa_dev_dma_init(cesa);
 	if (ret)
-- 
2.5.0
