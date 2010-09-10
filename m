From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 10 Sep 2010 09:19:34 -0700
Subject: amba_pl022 spi->mode fix/cleanup patches
Message-ID: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series updates drivers and platforms that depend on the
amba_pl022 driver and use the pl022_config_chip structure for
setting up the SPI mode and data transfer width.

The SPI configuration (CPOL/CPHA mode, bit send order, data bits per
word, and loopback mode) were previously setup as part of board
specific data in the pl022_config_chip structure. This has been
changed to now use the .mode field in spi_board_info structure (or
drivers that setup the mode). The SPI transfer's data width is now
configured from spi->bits_per_word.

The SPI driver changes have been previously submitted to the SPI ML.
This patch series need to be layered on that patch series.

These changes add or fix the .mode field in the plats/boards that use the
driver (u300, ux500, lpc32xx). The patches also move the data width
from the board specific area to the driver for mfd/ab8500. As the
fields in the pl022_config_chip structure are no longer needed, they
are removed in the last patch.

These changes have been tested on the phy3250 platform (lpc32xx). I
was able to test the ab8500 driver to some degree, but I only have a
standard pl022. I am unable to test u300 and ux500 changes, but the
u300 changes compiled fine.

[PATCH 1/5] mfd/ab8500: Setup SPI transfer for 24 bits
[PATCH 2/5] ARM: LPC32XX: Add missing SPI mode and remove unused fields
[PATCH 3/5] ARM: U300: spi->mode and spi_bits_per_words updates
[PATCH 4/5] ARM: Ux500: Change SPI mode and remove unused fields
[PATCH 5/5] spi: amba_pl022: Remove unused fields from pl022_config_chip
