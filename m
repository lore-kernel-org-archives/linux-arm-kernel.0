From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Thu, 17 Dec 2015 12:40:25 +0100
Subject: [PATCH v5 0/2] spi: dts: sun4i: Add support for wait time between
 word transmissions
Message-ID: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch set adds a new property "spi-word-wait-ns" to the spi-bus
binding that allows SPI slave devices to set a wait time between the
transmission of words. Modifies the spi_device struct and slave device
probing to read and store the new property.

Also modifies the sun4i SPI master driver to make use of the new property.
This specific SPI controller needs 3 clock cycles to set up the delay,
which makes the minimum non-zero wait time on this hardware 4 clock cycles.

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


Marcus Weseloh (2):
  spi: dts: Add new device property to specifcy a wait time between word
    transmissions
  spi: sun4i: Add support for wait time between word transmissions

 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
 drivers/spi/spi-sun4i.c                           | 22 ++++++++++++++++++++++
 drivers/spi/spi.c                                 |  2 ++
 include/linux/spi/spi.h                           |  2 ++
 4 files changed, 28 insertions(+)

-- 
1.9.1
