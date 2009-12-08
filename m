From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 Dec 2009 22:14:07 +0100
Subject: [PATCH 2/5] spi-imx: correct check for platform_get_irq failing
In-Reply-To: <1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
	<1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq returns -ENXIO if there is no entry.  So don't check
return value being nonzero but greater or equal to zero.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi_imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index c83ca05..d8d9a35 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -554,7 +554,7 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 	}
 
 	spi_imx->irq = platform_get_irq(pdev, 0);
-	if (!spi_imx->irq) {
+	if (spi_imx->irq < 0) {
 		ret = -EINVAL;
 		goto out_iounmap;
 	}
-- 
1.6.5.2
