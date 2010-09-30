From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 30 Sep 2010 11:40:48 +0200
Subject: [PATCH] spi/pl022: make sure the chip_info dev pointer is set
Message-ID: <1285839648-7368-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We forgot to set the pointer back to the device if the user
supplied all device settings, leading to crashing debug prints
as controller data is verified.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/spi/amba-pl022.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 4c37c4e..90a7e5d 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1574,6 +1574,8 @@ static int pl022_setup(struct spi_device *spi)
 		chip_info->duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX;
 		chip_info->cs_control = null_cs_control;
 	} else {
+		/* Users should not set this field */
+		chip_info->dev = &spi->dev;
 		dev_dbg(&spi->dev,
 			"using user supplied controller_data settings\n");
 	}
-- 
1.6.3.3
