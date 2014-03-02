From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Mar 2014 11:44:34 +0400
Subject: [PATCH 3/4] mfd: mc13xxx: Add missing spi_setup()
In-Reply-To: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
Message-ID: <1393746275-9253-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe routine should call spi_setup() to configure the SPI bus
so it can properly communicate with the device.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/mfd/mc13xxx-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index cd27c32..f35624a 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -139,6 +139,9 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 	mc13xxx->irq = spi->irq;
 
 	spi->max_speed_hz = spi->max_speed_hz ? : 26000000;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
 
 	mc13xxx->regmap = devm_regmap_init(&spi->dev, &regmap_mc13xxx_bus,
 					   &spi->dev,
-- 
1.8.3.2
