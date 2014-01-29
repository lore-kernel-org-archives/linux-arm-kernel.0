From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jan 2014 12:10:45 +0100
Subject: [PATCH v2 0/5] Add Allwinner A31 SPI controller support
Message-ID: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset brings support for the SPI controller found in the
Allwinner A31 SoC.

Even though the controller supports DMA, the driver only supports PIO
mode for now. This driver will be used to bring up and test DMA on the
SoC, so support for the DMA will come eventually.

It doesn't support transfer larger than the FIFO size (128 bytes) for
now, I expect it to be fixed in the future.

Thanks!
Maxime

Changes from v1:
  - Switched to using the transfer_one and set_cs callbacks
  - Switched to using runtime_pm
  - Report an error when we try to do a transfer larger than the FIFO
    size, instead of silently timeouting.
  - Added a Kconfig symbol
  - Move the clock ratio change at transfer time
  - Fixed the PLL6 cell size in the DTSI
  - A few fixes here and there: typos, etc.

Maxime Ripard (5):
  clk: sunxi: Add support for PLL6 on the A31
  ARM: sun6i: dt: Add PLL6 and SPI module clocks
  spi: sunxi: Add Allwinner A31 SPI controller driver
  ARM: sun6i: dt: Add SPI controllers to the A31 DTSI
  ARM: sunxi: Enable A31 SPI and SID in the defconfig

 Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
 .../devicetree/bindings/spi/spi-sun6i.txt          |  24 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  86 +++-
 arch/arm/configs/sunxi_defconfig                   |   3 +
 drivers/clk/sunxi/clk-sunxi.c                      |  45 ++
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sun6i.c                            | 478 +++++++++++++++++++++
 8 files changed, 636 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
 create mode 100644 drivers/spi/spi-sun6i.c

-- 
1.8.4.2
