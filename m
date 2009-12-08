From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 Dec 2009 22:14:06 +0100
Subject: [PATCH 1/5] spi-imx: use platform_driver_probe as probe lives in
	.init.text
In-Reply-To: <20091208211258.GA13706@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
Message-ID: <1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using platform_driver_register with a probe function defined using
__init is wrong.

This fixes an oops after:

	cd /sys/bus/platform/drivers/spi_imx
	echo -n spi_imx.0 > unbind
	echo -n spi_imx.0 > bind

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi_imx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 1b17f44..c83ca05 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -666,13 +666,12 @@ static struct platform_driver spi_imx_driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
 		   },
-	.probe = spi_imx_probe,
 	.remove = __exit_p(spi_imx_remove),
 };
 
 static int __init spi_imx_init(void)
 {
-	return platform_driver_register(&spi_imx_driver);
+	return platform_driver_probe(&spi_imx_driver, spi_imx_probe);
 }
 
 static void __exit spi_imx_exit(void)
-- 
1.6.5.2
