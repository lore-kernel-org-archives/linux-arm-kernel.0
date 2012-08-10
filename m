From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:02:09 +0200
Subject: [PATCH 12/14] MTD: atmel nand: fix gpio missing request
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1344603731-32667-12-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without this the gpio will not be muxed as a gpio by the current custom pinmux
or later by the pinctrl

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   56 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 97ac671..eef9f80 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -583,8 +583,39 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_W = host->io_base;
 	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
 
-	if (gpio_is_valid(host->board.rdy_pin))
+	if (gpio_is_valid(host->board.rdy_pin)) {
+		res = gpio_request(host->board.rdy_pin, "nand_rdy");
+		if (res < 0) {
+			dev_err(&pdev->dev,
+				"can't request rdy gpio %d\n", host->board.rdy_pin);
+			goto err_ecc_ioremap;
+		}
+
+		res = gpio_direction_input(host->board.rdy_pin);
+		if (res < 0) {
+			dev_err(&pdev->dev,
+				"can't request input direction rdy gpio %d\n", host->board.rdy_pin);
+			goto err_ecc_ioremap;
+		}
+
 		nand_chip->dev_ready = atmel_nand_device_ready;
+	}
+
+	if (gpio_is_valid(host->board.enable_pin)) {
+		res = gpio_request(host->board.enable_pin, "nand_enable");
+		if (res < 0) {
+			dev_err(&pdev->dev,
+				"can't request enable gpio %d\n", host->board.enable_pin);
+			goto err_ecc_ioremap;
+		}
+
+		res = gpio_direction_output(host->board.enable_pin, 1);
+		if (res < 0) {
+			dev_err(&pdev->dev,
+				"can't request output direction enable gpio %d\n", host->board.enable_pin);
+			goto err_ecc_ioremap;
+		}
+	}
 
 	nand_chip->ecc.mode = host->board.ecc_mode;
 
@@ -622,6 +653,20 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	atmel_nand_enable(host);
 
 	if (gpio_is_valid(host->board.det_pin)) {
+		res = gpio_request(host->board.det_pin, "nand_det");
+		if (res < 0) {
+			dev_err(&pdev->dev,
+				"can't request det gpio %d\n", host->board.det_pin);
+			goto err_no_card;
+		}
+
+		res = gpio_direction_input(host->board.det_pin);
+		if (res < 0) {
+			dev_err(&pdev->dev,
+				"can't request input direction det gpio %d\n", host->board.det_pin);
+			goto err_no_card;
+		}
+
 		if (gpio_get_value(host->board.det_pin)) {
 			printk(KERN_INFO "No SmartMedia card inserted.\n");
 			res = -ENXIO;
@@ -738,6 +783,15 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
 
 	atmel_nand_disable(host);
 
+	if (gpio_is_valid(host->board.det_pin))
+		gpio_free(host->board.det_pin);
+
+	if (gpio_is_valid(host->board.enable_pin))
+		gpio_free(host->board.enable_pin);
+
+	if (gpio_is_valid(host->board.rdy_pin))
+		gpio_free(host->board.rdy_pin);
+
 	if (host->ecc)
 		iounmap(host->ecc);
 
-- 
1.7.10.4
