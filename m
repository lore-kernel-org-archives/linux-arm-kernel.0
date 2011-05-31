From: chris@techworks.ie (Christian Gagneraud)
Date: Tue, 31 May 2011 17:04:20 +0100
Subject: [PATCH RFC 0/3] AT91: SPI: Add peripheral chip select decoding
Message-ID: <1306857863-13424-1-git-send-email-chris@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a RFC on adding support for CS decode on AT91 platforms.
CS decode allow to control many SPI devices with few CS lines by simply coding
the CS# on the lines, that is with 4 CS lines you can adress up to 15 SPI 
devices. Of course this require a decoder on the slave side.

First of all, an atmel_spi_data structure have been added to describe which 
GPIO they use as CS line and as well to enable or not the use of the CS decode 
feature.
Then the at91_add_device_spi() has been revamped, it is now used to add a SPI 
*controller* device only. The boards need to register their SPI devices with 
spi_register_board_info().

All of this has been tested on a PortuxG20 board, as an example the last patch 
show how to use it.

As it is only an RFC for now, I didn't bother with other AT91 SoC than the 9G20.

Christian Gagneraud (3):
  AT91: SPI: Add CS decode support
  AT91: SPI: Split SPI controller device and SPI device
  AT91: SPI: Add example of platform specific CS/GPIO usage

 arch/arm/mach-at91/at91sam9260_devices.c |   60 ++++++-------
 arch/arm/mach-at91/board-stamp9g20.c     |   62 +++++++++++++-
 arch/arm/mach-at91/include/mach/board.h  |   11 ++-
 drivers/spi/atmel_spi.c                  |  137 ++++++++++++++++++++----------
 4 files changed, 189 insertions(+), 81 deletions(-)

-- 
1.7.4.1
