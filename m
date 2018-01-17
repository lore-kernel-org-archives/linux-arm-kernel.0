From: maxime.chevallier@smile.fr (Maxime Chevallier)
Date: Wed, 17 Jan 2018 17:15:24 +0100
Subject: [PATCH 0/4] spi: a3700: Add improvements and full-duplex transfers
Message-ID: <1516205728-3256-1-git-send-email-maxime.chevallier@smile.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds some improvements on the existing Armada 3700 SPI
driver, the biggest being adding support for full-duplex transfers.

The first patch fixes an undocumented (to my knowledge, I might have
missed something) behaviour where some of the content of the last
write transfer is shifted out during a read half-duplex operation.

The second one sets the correct limits on the SPI max and min
frequencies, based on the source clock rate.

The last 2 patches enable full-duplex transfers. On this controller,
full-duplex transfers cannot use the hardware FIFOs and have to be
performed either 1 or 4 bytes at a time. Because this is more
CPU intensive, and a bit slower than FIFO mode, we only use the
full-duplex way of transferring data when necessary.

Maxime Chevallier (4):
  spi: a3700: Clear DATA_OUT when performing a read
  spi: a3700: Set frequency limits at startup
  spi: a3700: Allow to enable or disable FIFO mode
  spi: a3700: Add full-duplex support

 drivers/spi/spi-armada-3700.c | 106 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 15 deletions(-)

-- 
2.1.4
