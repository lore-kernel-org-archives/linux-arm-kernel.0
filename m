From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 11 Dec 2015 15:02:34 +0100
Subject: [PATCH v5 01/58] mtd: nand: denali: add missing nand_release() call
 in denali_remove()
In-Reply-To: <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449842554-29898-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unregister the NAND device from the NAND subsystem when removing a denali
NAND controller, otherwise the MTD attached to the NAND device is still
exposed by the MTD layer, and accesses to this device will likely crash
the system.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes since v4:
- remove Cc stable and fixes tags
- calculate the dma buffer size before calling nand_release()

 drivers/mtd/nand/denali.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 67eb2be..fdfea05 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1622,9 +1622,11 @@ EXPORT_SYMBOL(denali_init);
 /* driver exit point */
 void denali_remove(struct denali_nand_info *denali)
 {
+	int bufsize = denali->mtd.writesize + denali->mtd.oobsize;
+
+	nand_release(&denali->mtd);
 	denali_irq_cleanup(denali->irq, denali);
-	dma_unmap_single(denali->dev, denali->buf.dma_buf,
-			 denali->mtd.writesize + denali->mtd.oobsize,
+	dma_unmap_single(denali->dev, denali->buf.dma_buf, bufsize,
 			 DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(denali_remove);
-- 
2.1.4
