From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 5 Nov 2013 17:59:07 +0800
Subject: [PATCH] mtd: atmel_nand: fix bug driver will in a dead lock if no
 nand detected
Message-ID: <1383645547-21813-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the atmel driver probe function, the code shows like following:
  atmel_nand_probe(...) {
        ...

  err_nand_ioremap:
        platform_driver_unregister(&atmel_nand_nfc_driver);
        return res;
  }

If no nand flash detected, the driver probe function will goto
err_nand_ioremap label.
Then platform_driver_unregister() will be called. It will get the
lock of atmel_nand device since it is parent of nfc_device. The
problem is the lock is already hold by atmel_nand_probe itself.
So system will be in a dead lock.

This patch just simply removed to platform_driver_unregister() call.
When atmel_nand driver is quit the platform_driver_unregister() will
be called in atmel_nand_remove().

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index ef9c9f5..469d4e2 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -2142,7 +2142,6 @@ err_no_card:
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
 err_nand_ioremap:
-	platform_driver_unregister(&atmel_nand_nfc_driver);
 	return res;
 }
 
-- 
1.7.9.5
