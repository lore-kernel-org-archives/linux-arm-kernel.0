From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sat, 26 Dec 2015 16:53:03 +0100
Subject: [PATCH v6 0/3] spi: dts: sun4i: Add support for wait time between
 word transmissions
Message-ID: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the sixth version of the patch set that adds a new property
"spi-word-wait-ns" to the spi-bus binding to allow SPI slave devices to set
a wait time between the transmission of words. It modifies the spi_device
struct and slave device probing to read and store the new property.

Also modifies the sun4i SPI master driver to make use of the new property.
This specific SPI controller needs 3 clock cycles to set up the delay, which
makes the minimum non-zero wait time on this hardware 4 clock cycles.

It now also fixes multiple problems in the sun4i clock calculation: 
 - The A10/A20 datasheet contains the formula AHB_CLK / (2^(n+1)) to calculate
   SPI_CLK from CDR1, but this formula is wrong. The actual formula -
   determined by analyzing the actual waveforms on a A20 SoC - is AHB_CLK /
   (2^n).

 - The divisor calculations for CDR1 and CDR2 both rounded to the nearest
   integer. This could lead to a transfer speed that is higher than the
   requested speed. This patch changes both calculations to always round down.

 - The mclk frequency was only ever increased, never decreased. This could
   lead to unpredictable transfer speeds, depending on the order in which
   transfers with different speeds where serviced by the SPI driver.


Changes from v1:
 * renamed the property for more clarity
 * wait time is set in nanoseconds instead of number of clock cycles
 * transparently handle the 3 setup clock cycles

Changes from v2:
 * fixed typo in comment
 * moved parameter to spi-bus binding, dropping the vendor prefix
 * changed commit summary and description to reflect the changes

Changes from v3:
 * remove reference to "hardware" in comments and description, as the wait
   time could also be implemented in software
 * read and set property value in spi core

Changes from v4:
 * log with dev_dbg instead of dev_info
 * split patch into two separate ones for SPI-core and sun4i parts

Changes from v5:
 * Add Maxime's Reviewed-by and Rob's Acked-by to the SPI core patch
 * Add patch to fix clock calculation
 * Use actual SPI speed instead of tfr->speed_hz for wait time calculation


Marcus Weseloh (3):
  spi: dts: Add new device property to specifcy a wait time between word
    transmissions
  spi: sun4i: Fix clock calculations to be predictable and never exceed
    the requested rate
  spi: sun4i: Add support for wait time between word transmissions

 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 +
 drivers/spi/spi-sun4i.c                           | 51 ++++++++++++++++++-----
 drivers/spi/spi.c                                 |  2 +
 include/linux/spi/spi.h                           |  2 +
 4 files changed, 46 insertions(+), 11 deletions(-)

-- 
1.9.1
