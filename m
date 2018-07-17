From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Tue, 17 Jul 2018 16:31:49 +0200
Subject: [PATCH RESEND 0/5] spi: imx: Improve non 8-bit aligned words and
 dynamic bursts
Message-ID: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resend with i.MX platform maintainers and reviewers in Cc: ]

This series aims to improve PIO transfers on the SPI imx driver for several
use-cases, where bits_per_words isn't a multiple of 8, or when using
dynamic_burst mode.

The first patch is just a cosmetic cleanup of extra variable assignments

The second patch enforces the use of the dynamic_burst mode only when we
can pack words into the 32 bits FIFO entries. This avoid having to mask out the
remaining parts of the words, and avoid shifting extra clock ticks.

The 3rd and 4th patches fixes the way we compute the number of bytes per words,
by using 4 bytes to transfer 24 bits words as expected by the core.

Finally, the 5th patch reworks the way dynamic bursts are emitted, by shifting
out the non 4-bytes aligned parts first as expected by the imx SPI controller.

This avoid splitting out transfer when not necessary.

This was tested on imx6s and imx6q, with and without DMA, in single and full
duplex with a wide range of transfer sizes and bit_per_words values.

I however couldn't test the slave mode with these patches, so some review is
very welcomed, especially on the last patch.

Thanks,

Maxime

Maxime Chevallier (5):
  spi: imx: Remove duplicate variable assignments
  spi: imx: Use dynamic bursts only when bits_per_word is 8, 16 or 32
  spi: imx: Use correct number of bytes per words
  spi: imx: remove unnecessary check in spi_imx_can_dma
  spi: imx: Use the longuest possible burst size when in dynamic_burst

 drivers/spi/spi-imx.c | 162 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 61 deletions(-)

-- 
2.11.0
