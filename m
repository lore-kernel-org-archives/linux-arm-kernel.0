From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 12 Jul 2012 07:30:36 +0200
Subject: [PATCH 1/1] MTD: atmel nand: fix gpio missing request
Message-ID: <1342071036-15905-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without this the gpio will not be muxed as a gpio by the current custom pinmux
or later by the pinctrl

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 97ac671..fce649a 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -583,8 +583,24 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_W = host->io_base;
 	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
 
-	if (gpio_is_valid(host->board.rdy_pin))
+	if (gpio_is_valid(host->board.rdy_pin)) {
+		res = gpio_request(host->board.rdy_pin, "nand_rdy");
+		if (res) {
+			dev_err(&pdev->dev,
+				"can't request rdy gpio %d\n", host->board.rdy_pin);
+			goto err_ecc_ioremap;
+		}
 		nand_chip->dev_ready = atmel_nand_device_ready;
+	}
+
+	if (gpio_is_valid(host->board.enable_pin)) {
+		res = gpio_request(host->board.enable_pin, "nand_enable");
+		if (res) {
+			dev_err(&pdev->dev,
+				"can't request enable gpio %d\n", host->board.enable_pin);
+			goto err_ecc_ioremap;
+		}
+	}
 
 	nand_chip->ecc.mode = host->board.ecc_mode;
 
@@ -622,6 +638,13 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	atmel_nand_enable(host);
 
 	if (gpio_is_valid(host->board.det_pin)) {
+		res = gpio_request(host->board.det_pin, "nand_det");
+		if (res) {
+			dev_err(&pdev->dev,
+				"can't request det gpio %d\n", host->board.det_pin);
+			goto err_no_card;
+		}
+
 		if (gpio_get_value(host->board.det_pin)) {
 			printk(KERN_INFO "No SmartMedia card inserted.\n");
 			res = -ENXIO;
-- 
1.7.10
