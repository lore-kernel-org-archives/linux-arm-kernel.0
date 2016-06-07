From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  7 Jun 2016 17:18:54 +0100
Subject: [PATCH v5 00/18] Add support for FDMA DMA controller and slim core
 rproc found on STi chipsets
Message-ID: <1465316352-20691-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod, Bjorn, Maxime, Patrice,

This patchset adds support for the Flexible Direct Memory Access (FDMA) core
found on STi chipsets from STMicroelectronics. The FDMA is a slim core CPU
with a dedicated firmware. It is a general purpose DMA controller supporting
16 independent channels and data can be moved from memory to memory or between
memory and paced latency critical real time targets.

After some discussion with the DT maintainers I've removed the firmware
name from DT, and now generate the name based on the compatible string.
This is in keeping with how most other kernel drivers request firmware, and avoids
a new DT firmware name or fdma id binding.

I've also dropped the dma xbar support for the moment, as I believe it should be
re-worked based on some of the xbar API's that TI recently added. As requested
I've also split it into smaller patches to help with a faster review.

V3 also included some updates to the ASoC st,sti-asoc-card.txt DT documentation
to make the doc align with the driver code. This is kept as part of this series
for completeness and so any further changes to the ASoC dt nodes in this series
move in lockstep with the documentation. However these is no strict dependency
on this update with the rest of the series. It also includes DT patches for
Maximes/ Patrices STi DT tree to enable ASoC on STiH407/10 based platforms using
the fdma driver.

v4 includes a new slim core rproc driver for loading the slim elf firmware. This
enables us to use the generic rproc elf loading code. This has deliberately not
been implemented as a platform_driver, to avoid having to have double mappings of
I/O memory from two device drivers, and also to ensure that the DT node reflects
the actual hardware rather than Linux subsystems. The slim core is the basis
for various pieces of IP in STi chipsets and the intention is that other drivers
(e.g. demux) can also be migrated over to using the slim rproc for their
elf firmware loading and start/stop control.

v5 includes various updates from Bjorn related to the slim rproc implementation.
It also includes a patch to make rsc_table optional in remoteproc_core and various
other cleanups and review feedback from Vinod to do with the actual fdma
implementation. It also fixes a regression introduced in v4 when all drivers are
built-in spotted by Aranud.

regards,

Peter.

Changes since v4:
 - Make rsc table optional in remoteproc (Peter)
 - Various fixups to STi audio DT nodes (Arnaud)
 - Bulk rename of xp70 to slim (Peter)
 - Update my email to @linaro.org (Lee)
 - rebase on v4.7-rc2 (Peter)
 - Don't make ST_SLIM_REMOTEPROC user selectable (Bjorn)
 - -EPROBE_DEFER if rproc_boot fails when allocating DMA channel (Arnaud / Peter)
 - Drop some unnecessary headers (Vinod / Bjorn)
 - Change to writel now we have several mappings (Bjorn)
 - Remove io_res, rproc, and some unused structure fields / #define (Bjorn)
 - put clks in error path, also put clks before rproc_put() (Bjorn)
 - Make enum less generic (Bjorn)
 - Make slim_rproc_alloc() return a st_slim_rproc reference (Bjorn)
 - Alphabetical naming in Kconfig & Makefile (Vinod)
 - Add FDMA prefix to REQ_CTRL* (Vinod)
 - Print ret on some error paths (Vinod)
 - Add some acked-by (Peter)

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
  remoteproc: make rsc table support optional
  remoteproc: st_slim_rproc: add a slimcore rproc driver
  MAINTAINERS: Add st slim core rproc driver to STi section.
  dmaengine: st_fdma: Add STMicroelectronics FDMA DT binding
    documentation
  dmaengine: st_fdma: Add STMicroelectronics FDMA driver header file
  dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support
  ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
  MAINTAINERS: Add FDMA driver files to STi section.
  ARM: multi_v7_defconfig: Enable STi FDMA driver
  ASoC: sti: Update DT example to match the driver code
  ARM: multi_v7_defconfig: Enable STi and simple-card drivers.
  ARM: DT: STiH407: Add i2s_out pinctrl configuration
  ARM: DT: STiH407: Add i2s_in pinctrl configuration
  ARM: DT: STiH407: Add spdif_out pinctrl config
  ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
  ARM: STi: DT: STiH407: Add uniperif player dt nodes
  ARM: STi: DT: STiH407: Add uniperif reader dt nodes
  ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio card

 Documentation/devicetree/bindings/dma/st_fdma.txt  |  87 ++
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  20 +-
 MAINTAINERS                                        |   3 +
 arch/arm/boot/dts/stih407-family.dtsi              | 161 ++++
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |  55 ++
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |  45 ++
 arch/arm/configs/multi_v7_defconfig                |   4 +
 drivers/dma/Kconfig                                |  14 +-
 drivers/dma/Makefile                               |   1 +
 drivers/dma/st_fdma.c                              | 880 +++++++++++++++++++++
 drivers/dma/st_fdma.h                              | 244 ++++++
 drivers/remoteproc/Kconfig                         |   8 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/da8xx_remoteproc.c              |   1 +
 drivers/remoteproc/remoteproc_core.c               |  87 +-
 drivers/remoteproc/st_remoteproc.c                 |   2 +
 drivers/remoteproc/st_slim_rproc.c                 | 338 ++++++++
 drivers/remoteproc/ste_modem_rproc.c               |   2 +
 drivers/remoteproc/wkup_m3_rproc.c                 |   1 +
 include/linux/remoteproc.h                         |   1 +
 include/linux/remoteproc/st_slim_rproc.h           |  53 ++
 21 files changed, 1964 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt
 create mode 100644 drivers/dma/st_fdma.c
 create mode 100644 drivers/dma/st_fdma.h
 create mode 100644 drivers/remoteproc/st_slim_rproc.c
 create mode 100644 include/linux/remoteproc/st_slim_rproc.h

-- 
1.9.1
