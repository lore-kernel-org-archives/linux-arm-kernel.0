From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Fri, 19 Jun 2015 10:43:53 +0200
Subject: [PATCH 0/2] spi: dw: Reintroduce optional 16 bit data register I/O
Message-ID: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 32bit
accesses") globally changed all register access in the dw_apb_ssi driver
to 32 bit access, which breaks data register (FIFO) access on picoXcell
platforms.

This series introduces a boolean to the core spi-dw driver to indicate
to the core that 16 bit data register access is appropriate, implements
the code that respects that flag and updates the dw-spi-mmio driver to
allow setting this boolean from the device tree.

A binding documentation fix is included in this series.

Prior to applying this change the following error presents on
a picoCell pc3x3 platform:
  spi_master spi32766: interrupt_transfer: fifo overrun/underrun
  m25p80 spi32766.0: error -5 reading 9f
  m25p80: probe of spi32766.0 failed with error -5

With this series applied:
  m25p80 spi32766.0: m25p40 (512 Kbytes)

Michael van der Westhuizen (2):
  dt: snps,dw-apb-ssi: Describe 16 bit data register usage limitations
  spi: dw: Allow interface drivers to limit data I/O to word sizes

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt |  3 +++
 drivers/spi/spi-dw-mmio.c                                 |  5 +++++
 drivers/spi/spi-dw.c                                      | 13 +++++++++++--
 drivers/spi/spi-dw.h                                      | 11 +++++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.1.4
