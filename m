From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 15:14:22 +0100
Subject: [PATCH v2 0/9] Add support for FDMA DMA controller found on STi
 chipsets
Message-ID: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

This patchset adds support for the Flexible Direct Memory Access (FDMA) core
found on STi chipsets from STMicroelectronics. The FDMA is a slim (xp70) core CPU
with a dedicated firmware. It is a general purpose DMA controller supporting
16 independent channels and data can be moved from memory to memory or between
memory and paced latency critical real time targets.

After some discussion with the DT maintainers I've decided not to include the
firmware name in DT, and generate the name based on the compatible string.
This is in keeping with how most other kernel drivers request firmware, and avoids
a new DT firmware name binding.

I've also dropped the xbar support for the moment, as I believe it should be
re-worked based on some of the xbar API's that TI recently added. As requested
I've also split it into smaller patches to help with faster review.

regards,

Peter.

Changes since v1:
 - split into smaller patches for easier / faster review (Vinod)
 - new fill_hw_mode() with common code (Vinod)
 - new config_reqctrl() called from *_prep() instead of device_config cb (Vinod)
 - fdma-xbar support removed (Peter)
 - rework firmware name mechanism so fwname isn't in DT (Peter / Lee)
 - st_fdma_seg_to_mem can be static (Paul)
 - EXPORT_SYMBOL st_fdma_filter_fn not required (Paul)
 - s/channel/channels (vinod)
 - better describe "Must be <3>" (vinod)
 - sizeof(*ehdr) (vinod)
 - print values on error debug (vinod)
 - empty line (Vinod)
 - Update to -EIO (Vinod)
 - Make st_fdma tristate (Paul)
 - Remove __exit tag from .remove (Maxime)
 - Update MAINTAINERS rule to fdma* (Lee)
 - Unit address should match reg property (Lee)

Peter Griffin (9):
  dmaengine: st_fdma: Add STMicroelectronics FDMA DT binding
    documentation
  dmaengine: st_fdma: Add st fdma platform specific header
  dmaengine: st_fdma:  Add STMicroelectronics FDMA driver header file
  dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support
  dmaengine: st_fdma: Add xp70 firmware loading mechanism.
  dmaengine: st_fdma: Add fdma suspend and resume callbacks.
  ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
  MAINTAINERS: Add FDMA driver files to STi section.
  ARM: multi_v7_defconfig: Enable STi FDMA driver

 Documentation/devicetree/bindings/dma/st_fdma.txt |   78 ++
 MAINTAINERS                                       |    1 +
 arch/arm/boot/dts/stih407-family.dtsi             |   51 +
 arch/arm/configs/multi_v7_defconfig               |    1 +
 drivers/dma/Kconfig                               |   14 +
 drivers/dma/Makefile                              |    1 +
 drivers/dma/st_fdma.c                             | 1204 +++++++++++++++++++++
 drivers/dma/st_fdma.h                             |  237 ++++
 include/linux/platform_data/dma-st_fdma.h         |   72 ++
 9 files changed, 1659 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt
 create mode 100644 drivers/dma/st_fdma.c
 create mode 100644 drivers/dma/st_fdma.h
 create mode 100644 include/linux/platform_data/dma-st_fdma.h

-- 
1.9.1
