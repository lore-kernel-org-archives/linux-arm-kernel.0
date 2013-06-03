From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 15:24:53 +0200
Subject: [PATCH] spi: sirf: avoid uninitialized-use warning
Message-ID: <2423840.pM7qIRtGlE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

24778be20 "spi: convert drivers to use bits_per_word_mask"
removed the "default" statement in the spi_sirfsoc_setup_transfer
switch, causing a new warning:

drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_setup_transfer':
arch/arm/include/asm/io.h:90:2: warning: 'rxfifo_ctrl' may be used uninitialized in this function [-Wmaybe-uninitialized]
  asm volatile("str %1, %0"
  ^
drivers/spi/spi-sirf.c:364:19: note: 'rxfifo_ctrl' was declared here
  u32 txfifo_ctrl, rxfifo_ctrl;
                   ^

The compiler has correctly identified that this case may happen,
but since we know that things are horribly broken if bits_per_word
is ever something other than the values we tested, calling BUG()
is an appropriate action and tells the compiler that execution
will not continue afterwards.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Brown <broonie@kernel.org>
---
I keep using the wrong address for Mark even though I know it doesn't work
any more. Sorry for the duplicate mail.

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 265a5c6..fc20bcf 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -409,6 +409,8 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
 					SIRFSOC_SPI_FIFO_WIDTH_DWORD;
 		break;
+	default:
+		BUG();
 	}
 
 	if (!(spi->mode & SPI_CS_HIGH))
