From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:45 +0100
Subject: [PATCH v4 01/58] mtd: nand: denali: add missing nand_release() call
 in denali_remove()
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unregister the NAND device from the NAND subsystem when removing a denali
NAND controller, otherwise the MTD attached to the NAND device is still
exposed by the MTD layer, and accesses to this device will likely crash
the system.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: <stable@vger.kernel.org> #3.8+
Fixes: 2a0a288ec258 ("mtd: denali: split the generic driver and PCI layer")
---
 drivers/mtd/nand/denali.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 67eb2be..8feece3 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1622,6 +1622,7 @@ EXPORT_SYMBOL(denali_init);
 /* driver exit point */
 void denali_remove(struct denali_nand_info *denali)
 {
+	nand_release(&denali->mtd);
 	denali_irq_cleanup(denali->irq, denali);
 	dma_unmap_single(denali->dev, denali->buf.dma_buf,
 			 denali->mtd.writesize + denali->mtd.oobsize,
-- 
2.1.4
