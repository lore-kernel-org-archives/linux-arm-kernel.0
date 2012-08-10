From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:02:11 +0200
Subject: [PATCH 14/14] MTD: atmel_nand: add pinctrl consumer support
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1344603731-32667-14-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-mtd at lists.infradead.org
---
Hi David,

	if you don't mind I would like to apply with the rest of the pinctrl
	patch series

Best Regards,
J.
 drivers/mtd/nand/atmel_nand.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index eef9f80..3f740fd 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -39,6 +39,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/platform_data/atmel.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <mach/cpu.h>
 
@@ -539,6 +540,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct mtd_part_parser_data ppdata = {};
 	int res;
+	struct pinctrl *pinctrl;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -583,6 +585,13 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_W = host->io_base;
 	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(host->dev, "Failed to request pinctrl\n");
+		res = PTR_ERR(pinctrl);
+		goto err_ecc_ioremap;
+	}
+
 	if (gpio_is_valid(host->board.rdy_pin)) {
 		res = gpio_request(host->board.rdy_pin, "nand_rdy");
 		if (res < 0) {
-- 
1.7.10.4
