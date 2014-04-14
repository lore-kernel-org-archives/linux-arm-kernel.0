From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 Apr 2014 14:29:59 +0800
Subject: [PATCH 3/5] spi: sirf: make GPIO chipselect function work well
In-Reply-To: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397457001-5266-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

orignal GPIO chipslect is not standard because it don't take care to the
chipselect signal: BITBANG_CS_ACTIVE and BITBANG_CS_INACTIVE.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 9b30743..67d8909 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -470,7 +470,16 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 		writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
 	} else {
 		int gpio = sspi->chipselect[spi->chip_select];
-		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
+		switch (value) {
+		case BITBANG_CS_ACTIVE:
+			gpio_direction_output(gpio,
+					spi->mode & SPI_CS_HIGH ? 1 : 0);
+			break;
+		case BITBANG_CS_INACTIVE:
+			gpio_direction_output(gpio,
+					spi->mode & SPI_CS_HIGH ? 0 : 1);
+			break;
+		}
 	}
 }
 
-- 
1.7.5.4
