From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Oct 2010 11:24:01 +0200
Subject: [PATCH 7/6] spi/imx: Support different fifo sizes
In-Reply-To: <20100902143908.GK14214@pengutronix.de>
References: <20100902143908.GK14214@pengutronix.de>
Message-ID: <1286529841-20800-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Jander <david@protonic.nl>

The i.MX51 ECSPI has a fifo size of 64 entries instead of 8 entries as
found on the other cspi bus devices.

Cc: Jason Wang <jason77.wang@gmail.com>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch depends on patches already acked by Grant Likely and sitting
in Sascha Hauer's imx-for-2.6.37 branch.

Best regards
Uwe

 drivers/spi/spi_imx.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 6bab2cf..55a38e2 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -77,6 +77,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	unsigned int fifosize;
 };
 
 struct spi_imx_data {
@@ -541,6 +542,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.trigger = mx1_trigger,
 		.rx_available = mx1_rx_available,
 		.reset = mx1_reset,
+		.fifosize = 8,
 	},
 #endif
 #ifdef CONFIG_SPI_IMX_VER_0_0
@@ -550,6 +552,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.trigger = mx27_trigger,
 		.rx_available = mx27_rx_available,
 		.reset = spi_imx0_0_reset,
+		.fifosize = 8,
 	},
 #endif
 #ifdef CONFIG_SPI_IMX_VER_0_4
@@ -559,6 +562,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.trigger = mx31_trigger,
 		.rx_available = mx31_rx_available,
 		.reset = spi_imx0_4_reset,
+		.fifosize = 8,
 	},
 #endif
 #ifdef CONFIG_SPI_IMX_VER_0_7
@@ -568,6 +572,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.trigger = mx31_trigger,
 		.rx_available = mx31_rx_available,
 		.reset = spi_imx0_4_reset,
+		.fifosize = 8,
 	},
 #endif
 #ifdef CONFIG_SPI_IMX_VER_2_3
@@ -577,6 +582,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.trigger = spi_imx2_3_trigger,
 		.rx_available = spi_imx2_3_rx_available,
 		.reset = spi_imx2_3_reset,
+		.fifosize = 64,
 	},
 #endif
 };
@@ -596,7 +602,7 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
-	while (spi_imx->txfifo < 8) {
+	while (spi_imx->txfifo < spi_imx->devtype_data.fifosize) {
 		if (!spi_imx->count)
 			break;
 		spi_imx->tx(spi_imx);
-- 
1.7.2.3
