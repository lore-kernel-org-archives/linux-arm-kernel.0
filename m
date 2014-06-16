From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:25 -0300
Subject: [PATCH 00/10] DMAEngine support for sun4i, sun5i & sun7i
Message-ID: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As part of Google Summer of Code, I've tasked myself with implementing
DMA support for the earlier Allwinner platforms. This first round of
patches is the result of said effort.

The first patch is the actual driver to support these platforms. Patches
four and five add the corresponding DMA node to the device trees.

Patches two and three are two patches I created to test the driver with
some memory to device / device to memory transfers. The former lets
the 8250_dw driver, used for the sunxi UARTs, use DMA transfers. After
testing for a while, it seems there is an issue with DMA transfers on
the UARTs - for normal user-interactive operation it seems to work okay,
but pasting some chunk of text to it seems to hang the UART and some
messages about "too much work for IRQ" show up with the UART IRQ number.
I was not able to investigate further because I'm interacting with the
device via the UART.
The latter patch for the SPI driver lets me use DMA for SPI transfers
of <=64 bytes. Anything larger than the FIFO size seems to stall; is
this expected behaviour?

Patches six and seven add the DMA properties to SPI so you can test with
the third patch. Patch eight does the same for the UARTs. The last two
patches add a dummy SPIdev device to both cubieboard and cubietruck to
facilitate testing with spidev_test.

My main testing procedure for SPI has been spidev_test from the kernel
tree, with and without shorting MISO and MOSI. For memory to memory
transfers, I have used dmatest.ko with various configurations. I have
done testing on a cubieboard (A10, sun4i) and cubietruck (A20, sun7i)
and while I expect no issues to show up, I will be repeating my tests
on an A10S olinuxino as well.

You will find some extra remarks on individual patches after their
descriptions. All comments are welcome.

Thanks!

Emilio

Emilio L?pez (10):
  dma: sun4i: Add support for the DMA engine on sun[457]i SoCs
  serial: 8250_dw: support DMA on the OF case
  spi: sun4i: add DMA support
  ARM: sun7i: Add node to represent the DMA controller
  ARM: sun4i: Add node to represent the DMA controller
  ARM: sun7i: enable DMA on SPI
  ARM: sun4i: enable DMA on SPI
  ARM: sun7i: add DMA properties to UARTs
  ARM: sun4i: cubieboard: add an SPIdev device for testing
  ARM: sun7i: cubietruck: add an SPIdev device for testing

 .../devicetree/bindings/dma/sun4i-dma.txt          |   45 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |   12 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   23 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   12 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   32 +
 drivers/dma/Kconfig                                |   10 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/sun4i-dma.c                            | 1065 ++++++++++++++++++++
 drivers/spi/spi-sun4i.c                            |  146 ++-
 drivers/tty/serial/8250/8250_dw.c                  |    7 +-
 10 files changed, 1345 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
 create mode 100644 drivers/dma/sun4i-dma.c

-- 
2.0.0
