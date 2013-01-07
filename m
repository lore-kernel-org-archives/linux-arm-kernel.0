From: marex@denx.de (Marek Vasut)
Date: Mon,  7 Jan 2013 15:28:05 +0100
Subject: [PATCH] mtd: mxc_nand: Make use of supplied pinctrl data
Message-ID: <1357568885-15507-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MXC NAND driver doesn't consider the pinctrl data supplied via DT, which
will result in NAND pins not being properly configured.

Make the driver use pinctrl, but to prevent breakage on various boards, do not
fail if the pinctrl data are not available, only print a warning message.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 45204e4..ed805fb 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -34,6 +34,7 @@
 #include <linux/completion.h>
 #include <linux/of_device.h>
 #include <linux/of_mtd.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/mach/flash.h>
 #include <linux/platform_data/mtd-mxc_nand.h>
@@ -1385,6 +1386,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 	struct mtd_info *mtd;
 	struct mxc_nand_host *host;
 	struct resource *res;
+	struct pinctrl *pinctrl;
 	int err = 0;
 
 	/* Allocate memory for MTD device structure and private data */
@@ -1449,6 +1451,10 @@ static int mxcnd_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "No PINCTRL data for the NAND driver!\n");
+
 	host->base = devm_request_and_ioremap(&pdev->dev, res);
 	if (!host->base)
 		return -ENOMEM;
-- 
1.7.10.4
