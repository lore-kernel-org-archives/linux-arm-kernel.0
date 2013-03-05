From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Mar 2013 20:23:52 +0800
Subject: [PATCH v2 00/12] ARM: mxs: move to generic DMA device tree binding
Message-ID: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series converts mxs-dma and its clients to generic DMA device tree
binding/helper.

I published a branch below to ease people who is willing to help
testing the series.

 git://git.linaro.org/people/shawnguo/linux-2.6.git devel/mxs-dma-dt

Changes since v1:
 - Remove the use of of_dma_filter_info which should not be needed by
   a customized xlate function
 - Correct dma-names to have it mean the channel function in client
   devices
 - Add a new dmaengine_pcm API snd_dmaengine_generic_pcm_open() for
   users that support generic DMA device tree binding
 - Remove the old fsl,<module>-dma-channel properties from device tree

Subsystem maintainers,

I need your ACKs to have the series go via arm-soc as a whole if the
patches look good to you.

Thanks,
Shawn

Shawn Guo (12):
  ARM: dts: add generic DMA device tree binding for mxs-dma
  dma: mxs-dma: use devm_* managed functions
  dma: mxs-dma: move to generic device tree binding
  mmc: mxs-mmc: move to use generic DMA helper
  spi: mxs-spi: move to use generic DMA helper
  i2c: i2c-mxs: move to use generic DMA helper
  mtd: gpmi: move to use generic DMA helper
  serial: mxs-auart: move to use generic DMA helper
  ASoC: dmaengine_pcm: add snd_dmaengine_generic_pcm_open()
  ASoC: mxs: move to use generic DMA helper
  dma: mxs-dma: remove code left from generic DMA binding conversion
  ARM: dts: remove old DMA binding data from client nodes

 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   49 +++++++-
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt  |   12 +-
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |   12 +-
 .../devicetree/bindings/mtd/gpmi-nand.txt          |   17 +--
 .../devicetree/bindings/sound/mxs-saif.txt         |   18 +--
 Documentation/devicetree/bindings/spi/mxs-spi.txt  |   12 +-
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   16 ++-
 arch/arm/boot/dts/imx23.dtsi                       |   57 +++++++--
 arch/arm/boot/dts/imx28.dtsi                       |  104 +++++++++++-----
 arch/arm/boot/dts/imx6qdl.dtsi                     |   12 +-
 drivers/dma/mxs-dma.c                              |  128 +++++++++++---------
 drivers/i2c/busses/i2c-mxs.c                       |   40 +-----
 drivers/mmc/host/mxs-mmc.c                         |   48 +-------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   51 +-------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    3 +-
 drivers/spi/spi-mxs.c                              |   60 ++-------
 drivers/tty/serial/mxs-auart.c                     |   52 +-------
 include/linux/fsl/mxs-dma.h                        |   20 ---
 include/linux/spi/mxs-spi.h                        |    4 +-
 include/sound/dmaengine_pcm.h                      |    2 +
 sound/soc/mxs/mxs-pcm.c                            |   42 +------
 sound/soc/mxs/mxs-pcm.h                            |    5 -
 sound/soc/mxs/mxs-saif.c                           |   28 +----
 sound/soc/mxs/mxs-saif.h                           |    1 -
 sound/soc/soc-dmaengine-pcm.c                      |   39 ++++++
 25 files changed, 368 insertions(+), 464 deletions(-)
 delete mode 100644 include/linux/fsl/mxs-dma.h

-- 
1.7.9.5
