From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:50 +0200
Subject: [PATCH 16/19] ARM: nomadik: register nmk_gpio_driver using
	platform_driver_probe
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a section mismatch reported by modpost:

	WARNING: arch/arm/plat-nomadik/built-in.o(.data+0x100): Section mismatch in reference from the variable nmk_gpio_driver to the function .init.text:nmk_gpio_probe()
	The variable nmk_gpio_driver references
	the function __init nmk_gpio_probe()
	If the reference is valid then annotate the
	variable with __init* or __refdata (see linux/init.h) or name the variable:
	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-nomadik/gpio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 977c8f9..9bc1646 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -624,14 +624,13 @@ static struct platform_driver nmk_gpio_driver = {
 		.owner = THIS_MODULE,
 		.name = "gpio",
 		},
-	.probe = nmk_gpio_probe,
 	.suspend = NULL, /* to be done */
 	.resume = NULL,
 };
 
 static int __init nmk_gpio_init(void)
 {
-	return platform_driver_register(&nmk_gpio_driver);
+	return platform_driver_probe(&nmk_gpio_driver, nmk_gpio_probe);
 }
 
 core_initcall(nmk_gpio_init);
-- 
1.7.1
