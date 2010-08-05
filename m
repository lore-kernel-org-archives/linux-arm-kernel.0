From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:49 +0200
Subject: [PATCH 15/19] SPI: amba-pl022: move probe and remove to .devinit and
	.devexit resp.
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver can be bound via sysfs after the .init sections are already
discarded, so pl022_probe must not be in .init.text.  If there is no remove
function the driver can still be unbound without any callback being run.
So pl022_remove must not be in .exit.text.

This fixes a section mismatch reported by modpost.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/amba-pl022.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index f0a1418..acd35d1 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1723,7 +1723,7 @@ static void pl022_cleanup(struct spi_device *spi)
 }
 
 
-static int __init
+static int __devinit
 pl022_probe(struct amba_device *adev, struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -1838,7 +1838,7 @@ pl022_probe(struct amba_device *adev, struct amba_id *id)
 	return status;
 }
 
-static int __exit
+static int __devexit
 pl022_remove(struct amba_device *adev)
 {
 	struct pl022 *pl022 = amba_get_drvdata(adev);
@@ -1970,7 +1970,7 @@ static struct amba_driver pl022_driver = {
 	},
 	.id_table	= pl022_ids,
 	.probe		= pl022_probe,
-	.remove		= __exit_p(pl022_remove),
+	.remove		= __devexit_p(pl022_remove),
 	.suspend        = pl022_suspend,
 	.resume         = pl022_resume,
 };
-- 
1.7.1
