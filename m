From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 23:36:06 +0200
Subject: [PATCH 01/12] mtd: atmel nand: build regression
In-Reply-To: <1348868177-21205-1-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
Message-ID: <1348868177-21205-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel_nand driver was broken by b654a9a46fc2 "mtd: atmel nand: fix
gpio missing request". This is a rather helpless attempt to fix this,
probably messing up the error handling even further but getting the
build to work again, so please treat it as a bug report rather than
a fix to be applied.

Without this patch, building any at91 configuration results in:

drivers/mtd/nand/atmel_nand.c: In function 'atmel_nand_probe':
drivers/mtd/nand/atmel_nand.c:1451:4: error: label 'err_ecc_ioremap' used but not defined

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/mtd/nand/atmel_nand.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 9144557..eba5b2a 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1420,7 +1420,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"can't request rdy gpio %d\n",
 				host->board.rdy_pin);
-			goto err_ecc_ioremap;
+			goto err_no_card;
 		}
 
 		res = gpio_direction_input(host->board.rdy_pin);
@@ -1428,7 +1428,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"can't request input direction rdy gpio %d\n",
 				host->board.rdy_pin);
-			goto err_ecc_ioremap;
+			goto err_no_card;
 		}
 
 		nand_chip->dev_ready = atmel_nand_device_ready;
@@ -1440,7 +1440,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"can't request enable gpio %d\n",
 				host->board.enable_pin);
-			goto err_ecc_ioremap;
+			goto err_no_card;
 		}
 
 		res = gpio_direction_output(host->board.enable_pin, 1);
@@ -1448,7 +1448,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"can't request output direction enable gpio %d\n",
 				host->board.enable_pin);
-			goto err_ecc_ioremap;
+			goto err_no_card;
 		}
 	}
 
-- 
1.7.10
