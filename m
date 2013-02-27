From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 27 Feb 2013 08:39:34 +0800
Subject: [PATCH Resend v5 03/16] spi/spi-atmel: add support transfer on CS1, 2,
 3, not only on CS0
In-Reply-To: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1361925574-12023-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: spi-devel-general at lists.sourceforge.net
Cc: linux-kernel at vger.kernel.org
---
 drivers/spi/spi-atmel.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index a8e091b..9c8f2d5 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -256,11 +256,6 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
  * Master on Chip Select 0.")  No workaround exists for that ... so for
  * nCS0 on that chip, we (a) don't use the GPIO, (b) can't support CS_HIGH,
  * and (c) will trigger that first erratum in some cases.
- *
- * TODO: Test if the atmel_spi_is_v2() branch below works on
- * AT91RM9200 if we use some other register than CSR0. However, don't
- * do this unconditionally since AP7000 has an errata where the BITS
- * field in CSR0 overrides all other CSRs.
  */
 
 static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
@@ -270,18 +265,22 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 	u32 mr;
 
 	if (atmel_spi_is_v2(as)) {
-		/*
-		 * Always use CSR0. This ensures that the clock
-		 * switches to the correct idle polarity before we
-		 * toggle the CS.
+		spi_writel(as, CSR0 + 4 * spi->chip_select, asd->csr);
+		/* For the low SPI version, there is a issue that PDC transfer
+		 * on CS1,2,3 needs SPI_CSR0.BITS config as SPI_CSR1,2,3.BITS
 		 */
 		spi_writel(as, CSR0, asd->csr);
 		if (as->caps.has_wdrbt) {
-			spi_writel(as, MR, SPI_BF(PCS, 0x0e) | SPI_BIT(WDRBT)
-				| SPI_BIT(MODFDIS) | SPI_BIT(MSTR));
+			spi_writel(as, MR,
+					SPI_BF(PCS, ~(0x01 << spi->chip_select))
+					| SPI_BIT(WDRBT)
+					| SPI_BIT(MODFDIS)
+					| SPI_BIT(MSTR));
 		} else {
-			spi_writel(as, MR, SPI_BF(PCS, 0x0e) | SPI_BIT(MODFDIS)
-				| SPI_BIT(MSTR));
+			spi_writel(as, MR,
+					SPI_BF(PCS, ~(0x01 << spi->chip_select))
+					| SPI_BIT(MODFDIS)
+					| SPI_BIT(MSTR));
 		}
 		mr = spi_readl(as, MR);
 		gpio_set_value(asd->npcs_pin, active);
-- 
1.7.9.5
