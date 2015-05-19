From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 19 May 2015 15:34:11 +0200
Subject: [RFC PATCH 1/4] spi: spidev: Add Google SPI flash compatible string
In-Reply-To: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Google Chromebooks have a SPI flash that is used to store firmware and
different system parameters and data (i.e: Google Binary Block flags).

Since there isn't a driver for it yet, the spidev interface is used to
access the flash from user-space (i.e: using the flashrom tool).

Add a "google,spi-flash" compatible string so the Device Tree sources
use it instead of the "spidev" compatible which does not describe the
real HW and is just a Linux implementation detail.

A generic "google,spi-flash" OF device ID is used instead of the actual
vendor/model because these chips are commodity parts that are sourced
from multiple vendors. So specifying the exact vendor and model in the
DTS will add a maintenance burden with no real gain (the parts are 100%
compatible anyways) and will likely result in it simply being wrong for
a sizeable fraction of the machines.

Also, it would require to duplicate a DTS since the machine is the same
besides using a different SPI flash part.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index dd616ff0ffc5..b18cf7bdc385 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -693,6 +693,7 @@ static struct class *spidev_class;
 #ifdef CONFIG_OF
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
+	{ .compatible = "google,spi-flash" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.1.4
