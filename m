From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 30 Jul 2010 17:42:09 +0200
Subject: [PATCH] MTD: pxa2xx: move pxa2xx_flash_probe to .devinit.text
Message-ID: <1280504530-31737-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following warning by modpost:

	WARNING: vmlinux.o(.data+0x15018): Section mismatch in reference from the variable pxa2xx_flash_driver to the function .init.text:pxa2xx_flash_probe()
	The variable pxa2xx_flash_driver references
	the function __init pxa2xx_flash_probe()
	If the reference is valid then annotate the
	variable with __init* or __refdata (see linux/init.h) or name the variable:
	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

I choosed to do this instead of using platform_driver_probe as the remove
function uses __devexit.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/maps/pxa2xx-flash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index dd90880..d8ae634 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -51,7 +51,7 @@ struct pxa2xx_flash_info {
 static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
 
 
-static int __init pxa2xx_flash_probe(struct platform_device *pdev)
+static int __devinit pxa2xx_flash_probe(struct platform_device *pdev)
 {
 	struct flash_platform_data *flash = pdev->dev.platform_data;
 	struct pxa2xx_flash_info *info;
-- 
1.7.1
