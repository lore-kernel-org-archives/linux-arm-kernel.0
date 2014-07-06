From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  6 Jul 2014 01:05:07 -0300
Subject: [PATCH v2 0/8] DMAEngine support for sun4i, sun5i & sun7i
Message-ID: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As part of Google Summer of Code, I've tasked myself with implementing
DMA support for the earlier Allwinner platforms. This second round of
patches is the result of said effort.

The first patch is the actual driver to support these platforms. Patches
three, four and five add the corresponding DMA node to the sun4i,
sun5i and sun7i device trees.

The second patch, involving the sunxi SPI driver, lets users do SPI
transfers of >=64 bytes by using DMA. The first round of patches also
had a patch for 8250_dw letting it use DMA as well, but there were some
issues causing underruns and "too much work for IRQ", so I have dropped
them. It's worth noting that Allwinner themselves don't use DMA
transfers on their 8250 driver on the SDK.

Patches six, seven and eight add the DMA properties to SPI so the first
two patches can be used. Patches nine, ten and eleven are *only intended
for testing*, and add a dummy SPIdev device to cubieboard, cubietruck
and A10S-OLinuXino to facilitate testing with spidev_test.

My main testing procedure for SPI has been modified versions of
spidev_test from the kernel tree, with and without shorting MISO and
MOSI. For memory to memory transfers, I have used dmatest.ko with
various configurations. I have done testing on a cubieboard (A10, sun4i)
and cubietruck (A20, sun7i) as well as an A10S-OLinuXino.

You will find some extra remarks on individual patches after their
descriptions. All comments are welcome.

Thanks!

Emilio L?pez (8):
  dma: sun4i: Add support for the DMA engine on sun[457]i SoCs
  spi: sun4i: add DMA support
  ARM: sun4i: Add node to represent the DMA controller
  ARM: sun5i: Add nodes to represent the DMA controllers
  ARM: sun7i: Add node to represent the DMA controller
  ARM: sun4i: enable DMA on SPI
  ARM: sun5i: enable DMA on SPI
  ARM: sun7i: enable DMA on SPI

 .../devicetree/bindings/dma/sun4i-dma.txt          |   45 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   16 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   14 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   14 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   16 +
 drivers/dma/Kconfig                                |   10 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/sun4i-dma.c                            | 1025 ++++++++++++++++++++
 drivers/spi/spi-sun4i.c                            |  155 ++-
 9 files changed, 1285 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
 create mode 100644 drivers/dma/sun4i-dma.c

-- 
2.0.1
