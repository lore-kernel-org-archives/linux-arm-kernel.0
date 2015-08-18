From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Tue, 18 Aug 2015 22:21:51 +0200
Subject: [PATCH v3 0/2] spi: dw: Reintroduce optional 16 bit data register I/O
Message-ID: <1439929313-4948-1-git-send-email-michael@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 32bit
accesses") globally changed all register access in the dw_apb_ssi driver
to 32 bit access, which breaks data register (FIFO) access on picoXcell
platforms.

This series introduces a variable to the core spi-dw driver to indicate
to the core that either 16 or 32 bit data register access is appropriate,
with the code defaulting to the current 32 bit behaviour.

The dw-spi-mmio driver is updated to support optionally setting this
variable from the device tree and the binding documentation is updated.

Prior to applying this change the following error presents on
a picoXcell pc3x3 platform:
  spi_master spi32766: interrupt_transfer: fifo overrun/underrun
  m25p80 spi32766.0: error -5 reading 9f
  m25p80: probe of spi32766.0 failed with error -5

With this series applied:
  m25p80 spi32766.0: m25p40 (512 Kbytes)

Changes in v3:
  - Rename the DT property as requested by Rob Herring.

Changes in v2:
  - Incorporate review feedback from Andy Shevchenko, reworking the
    bindings to reflect common practice and adjusting the driver
    to suit.
  - Add a wrapper inline function for accessing the data register
    using the configured with.

Michael van der Westhuizen (2):
  dt: snps,dw-apb-ssi: Document new I/O data register width property
  spi: dw: Allow interface drivers to limit data I/O to word sizes

 drivers/spi/spi-dw-mmio.c |  3 +++
 drivers/spi/spi-dw.c      |  4 ++--
 drivers/spi/spi-dw.h      | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.1.4
