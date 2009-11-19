From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 19 Nov 2009 11:39:45 +0100
Subject: [PATCH] SPI: drain MXC SPI transfer buffer when probing device
Message-ID: <mailman.48.1258657314.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the MX31litekit, the bootloader seems to communicate with the MC13783
PMIC chip before booting Linux. However, it does not flush all the
buffers properly after that, which makes the imx-spi driver read
bogus data when probing the MC13783.

Fix that by draining the SPI receive buffer on startup.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi_imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 89c22ef..1b17f44 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -44,6 +44,9 @@
 #define MXC_CSPIINT		0x0c
 #define MXC_RESET		0x1c
 
+#define MX3_CSPISTAT		0x14
+#define MX3_CSPISTAT_RR		(1 << 3)
+
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
@@ -593,6 +596,11 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 	if (!cpu_is_mx31() || !cpu_is_mx35())
 		writel(1, spi_imx->base + MXC_RESET);
 
+	/* drain receive buffer */
+	if (cpu_is_mx31() || cpu_is_mx35())
+		while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
+			readl(spi_imx->base + MXC_CSPIRXDATA);
+
 	spi_imx->intctrl(spi_imx, 0);
 
 	ret = spi_bitbang_start(&spi_imx->bitbang);
-- 
1.6.5.2
