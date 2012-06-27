From: stigge@antcom.de (Roland Stigge)
Date: Wed, 27 Jun 2012 17:51:13 +0200
Subject: [PATCH 2/4] mtd: lpc32xx_slc: Make wp gpio optional
In-Reply-To: <1340812275-1197-1-git-send-email-stigge@antcom.de>
References: <1340812275-1197-1-git-send-email-stigge@antcom.de>
Message-ID: <1340812275-1197-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

This patch supports missing wp gpio.

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 drivers/mtd/nand/lpc32xx_slc.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index b27b3b3..ab72aca 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -192,7 +192,7 @@ struct lpc32xx_nand_cfg_slc {
 	u32     rhold;
 	u32     rsetup;
 	bool    use_bbt;
-	unsigned wp_gpio;
+	int     wp_gpio;
 	struct mtd_partition *parts;
 	unsigned num_parts;
 };
@@ -295,7 +295,8 @@ static int lpc32xx_nand_device_ready(struct mtd_info *mtd)
  */
 static void lpc32xx_wp_enable(struct lpc32xx_nand_host *host)
 {
-	gpio_set_value(host->ncfg->wp_gpio, 0);
+	if (gpio_is_valid(host->ncfg->wp_gpio))
+		gpio_set_value(host->ncfg->wp_gpio, 0);
 }
 
 /*
@@ -303,7 +304,8 @@ static void lpc32xx_wp_enable(struct lpc32xx_nand_host *host)
  */
 static void lpc32xx_wp_disable(struct lpc32xx_nand_host *host)
 {
-	gpio_set_value(host->ncfg->wp_gpio, 1);
+	if (gpio_is_valid(host->ncfg->wp_gpio))
+		gpio_set_value(host->ncfg->wp_gpio, 1);
 }
 
 /*
@@ -819,7 +821,8 @@ static int __devinit lpc32xx_nand_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Missing platform data\n");
 		return -ENOENT;
 	}
-	if (gpio_request(host->ncfg->wp_gpio, "NAND WP")) {
+	if (gpio_is_valid(host->ncfg->wp_gpio) &&
+			gpio_request(host->ncfg->wp_gpio, "NAND WP")) {
 		dev_err(&pdev->dev, "GPIO not available\n");
 		return -EBUSY;
 	}
-- 
1.7.10.4
