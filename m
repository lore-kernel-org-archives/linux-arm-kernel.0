From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 May 2016 17:06:33 +0100
Subject: [PATCH 00/18] Add support for FDMA DMA controller and xp70 rproc
 found on STi chipsets
Message-ID: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod / Maxime / Bjorn,

This patchset adds support for the Flexible Direct Memory Access (FDMA) core
found on STi chipsets from STMicroelectronics. The FDMA is a slim (xp70) core CPU
with a dedicated firmware. It is a general purpose DMA controller supporting
16 independent channels and data can be moved from memory to memory or between
memory and paced latency critical real time targets.

After some discussion with the DT maintainers I've removed the firmware
name from DT, and now generate the name based on the compatible string.
This is in keeping with how most other kernel drivers request firmware, and avoids
a new DT firmware name or fdma id binding.

I've also dropped the xbar support for the moment, as I believe it should be
re-worked based on some of the xbar API's that TI recently added. As requested
I've also split it into smaller patches to help with a faster review.

V3 also included some updates to the ASoC DT documentation, and extra DT patches
for Maximes STi DT tree to enable ASoC on STi407 based platforms using the fdma
driver.

v4 includes a new xp70 rproc driver for loading the XP70 elf firmware. This
enables us to use the generic rproc elf loading code. This has deliberately not
been implemented as a platform_driver, to avoid having to have double mappings of
I/O memory from two device drivers, and also to ensure that the DT node reflects
the actual hardware rather than Linux subsystems. The xp70 slimcore is the basis
for various pieces of IP in STi chipsets and the intention is that other drivers
(demux, display) can also be migrated over to using the xp70 rproc for their
elf firmware loading and start/stop control.

regards,

Peter.

Changes since v3:
 - Remove elf loading code from fdma driver (Vinod)
 - Remove fdma_ prefix for clock names (Arnd)
 - Make _xlate use dma_get_any_channel rather than request_channel (Arnd)
 - Make a common function for _prep_ routines (Vinod)
 - Make driver depend on COMPILE_TEST (Arnd)
 - Remove unnecessary st_fdma_filter_fn (Arnd)
 - Enable FDMA as a module (Arnd)
 - Drop fdma_ clock prefix (Arnd)
 - Fix description as well as example for st, prefix (Arnd)
 - Remove string concatenation from fdma register macros to ease grep'ability (Arnd)
 - Add a XP70 rproc driver for ELF firmware loading and start/stop control (Peter)
 - Add myself as a author of the driver (Peter)

Changes since v2:
 - Change to dma-controller (Arnd)
 - Remove platform data header file and simplifiy code (Arnd)
 - Remove FW_LOADER_USER_HELPER_FALLBACK and rework firmware loading to device config (Vinod)
 - Use SET_RUNTIME_PM_OPS helpers (Vinod)
 - Remove fdma-id dt prop and use compatibles to generate different fdma firmware names (Arnd / Lee)
 - Add sti-asoc-card DT nodes and pinmux config for uniperif player & reader (Peter)
 - Update sti-asoc-card DT binding documentation (Peter)
 - Enable STi audio drivers in multi_v7_defconfig (Peter)

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

Peter Griffin (18):
  dmaengine: st_fdma: Add STMicroelectronics FDMA DT binding
    documentation
  dmaengine: st_fdma:  Add STMicroelectronics FDMA driver header file
  dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support
  dmaengine: st_fdma: Add xp70 firmware loading mechanism.
  dmaengine: st_fdma: Add fdma suspend and resume callbacks.
  ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
  MAINTAINERS: Add FDMA driver files to STi section.
  ARM: multi_v7_defconfig: Enable STi FDMA driver
  ASoC: sti: Update DT example to match the driver code
  ASoC: sti: Update example to include assigned-clocks and mclk-fs
  ARM: multi_v7_defconfig: Enable STi and simple-card drivers.
  ARM: DT: STiH407: Add i2s_out pinctrl configuration
  ARM: DT: STiH407: Add i2s_in pinctrl configuration
  ARM: DT: STiH407: Add spdif_out pinctrl config
  ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
  ARM: STi: DT: STiH407: Add uniperif player dt nodes
  ARM: STi: DT: STiH407: Add uniperif reader dt nodes
  ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio card

 Documentation/devicetree/bindings/dma/st_fdma.txt  |   87 ++
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |   22 +-
 MAINTAINERS                                        |    1 +
 arch/arm/boot/dts/stih407-family.dtsi              |  164 +++
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |   55 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |   40 +
 arch/arm/configs/multi_v7_defconfig                |    4 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/st_fdma.c                              | 1203 ++++++++++++++++++++
 drivers/dma/st_fdma.h                              |  281 +++++
 11 files changed, 1863 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt
 create mode 100644 drivers/dma/st_fdma.c
 create mode 100644 drivers/dma/st_fdma.h

-- 
1.9.1
