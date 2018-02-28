From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Feb 2018 11:06:46 +0000
Subject: Applied "spi: atmel: init FIFOs before spi enable" to the spi tree
In-Reply-To: <1519727107-5821-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <E1eqzZO-0005Jw-Kt@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: atmel: init FIFOs before spi enable

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9581329eff9db72ab4fbb46a594fd7fdda3c51b0 Mon Sep 17 00:00:00 2001
From: Eugen Hristev <eugen.hristev@microchip.com>
Date: Tue, 27 Feb 2018 12:25:07 +0200
Subject: [PATCH] spi: atmel: init FIFOs before spi enable

The datasheet recommends initializing FIFOs before
SPI enable. If we do not do it like this, there may be
a strange behavior. We noticed that DMA does not work properly
with FIFOs if we do not clear them beforehand or enable them
before SPIEN.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 drivers/spi/spi-atmel.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 4a11fc0d4136..b7936f815373 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1512,6 +1512,11 @@ static void atmel_spi_init(struct atmel_spi *as)
 {
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
+
+	/* It is recommended to enable FIFOs first thing after reset */
+	if (as->fifo_size)
+		spi_writel(as, CR, SPI_BIT(FIFOEN));
+
 	if (as->caps.has_wdrbt) {
 		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
 				| SPI_BIT(MSTR));
@@ -1522,9 +1527,6 @@ static void atmel_spi_init(struct atmel_spi *as)
 	if (as->use_pdc)
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
-
-	if (as->fifo_size)
-		spi_writel(as, CR, SPI_BIT(FIFOEN));
 }
 
 static int atmel_spi_probe(struct platform_device *pdev)
-- 
2.16.1
