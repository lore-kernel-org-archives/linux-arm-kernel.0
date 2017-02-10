From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 10 Feb 2017 16:29:42 +0100
Subject: [PATCH 6/8] spi: loopback-test: set HW loopback mode if loopback set
In-Reply-To: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1486740584-17875-7-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the internal HW loopback mode if the loopback option
is set.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-loopback-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 50e620f..ce552af 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -285,6 +285,11 @@ static int spi_loopback_test_probe(struct spi_device *spi)
 
 	dev_info(&spi->dev, "Executing spi-loopback-tests\n");
 
+	if (loopback) {
+		spi->mode |= SPI_LOOP;
+		ret = spi_setup(spi);
+		dev_info(&spi->dev, "configure loopback return: %i\n", ret);
+	}
 	ret = spi_test_run_tests(spi, spi_tests);
 
 	dev_info(&spi->dev, "Finished spi-loopback-tests with return: %i\n",
-- 
2.7.4
