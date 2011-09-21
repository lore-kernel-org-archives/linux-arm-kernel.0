From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Sep 2011 13:30:41 +0200
Subject: [PATCH 07/11 v2] ARM: at92/nand: use gpio_is_valid to check the gpio
In-Reply-To: <20110921112830.GP24966@game.jcrosoft.org>
References: <20110921112830.GP24966@game.jcrosoft.org>
Message-ID: <1316604645-22599-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
V2 update commit log

Best Regards,
J. drivers/mtd/nand/atmel_nand.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 55da20c..e20ac1f 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -113,7 +113,7 @@ static int cpu_has_dma(void)
  */
 static void atmel_nand_enable(struct atmel_nand_host *host)
 {
-	if (host->board->enable_pin)
+	if (gpio_is_valid(host->board->enable_pin))
 		gpio_set_value(host->board->enable_pin, 0);
 }
 
@@ -122,7 +122,7 @@ static void atmel_nand_enable(struct atmel_nand_host *host)
  */
 static void atmel_nand_disable(struct atmel_nand_host *host)
 {
-	if (host->board->enable_pin)
+	if (gpio_is_valid(host->board->enable_pin))
 		gpio_set_value(host->board->enable_pin, 1);
 }
 
@@ -535,7 +535,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_W = host->io_base;
 	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
 
-	if (host->board->rdy_pin)
+	if (gpio_is_valid(host->board->rdy_pin))
 		nand_chip->dev_ready = atmel_nand_device_ready;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -573,7 +573,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	atmel_nand_enable(host);
 
-	if (host->board->det_pin) {
+	if (gpio_is_valid(host->board->det_pin)) {
 		if (gpio_get_value(host->board->det_pin)) {
 			printk(KERN_INFO "No SmartMedia card inserted.\n");
 			res = -ENXIO;
-- 
1.7.6.3
