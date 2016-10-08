From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat,  8 Oct 2016 13:52:22 +0100
Subject: [PATCH v10 00/11] Add support for FDMA DMA controller and slim core
 rproc found on STi chipsets
Message-ID: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod and Bjorn,

This patchset adds support for the Flexible Direct Memory Access (FDMA) core
found on STi chipsets from STMicroelectronics. The FDMA is a slim core CPU
with a dedicated firmware. It is a general purpose DMA controller supporting
16 independent channels and data can be moved from memory to memory or between
memory and paced latency critical real time targets.

[..]

V10 series updates remoteproc kconfig subsystem to use 'depends on' rather
than select for the remoteproc core. Remoteproc client drivers now need to
'depends on' for the core part.

This avoids the Kconfig recursive dependency errors and reliance on the DRM
patch included with the v9 series. Patches are also included for enabling the
remoteproc core in the multi_v7 defconfig. All patches for DRM subsystem have
been removed.

Note there is no longer a depedency with the DRM_VIRTIO_GPU driver in this series,
only remoteproc and dmaengine subsystems.

regards,

Peter.

Changes since v9:
 - Update remoteproc Kconfig to 'depends on'
 - Add remoteproc core to multi_v7 defconfig
 - Remove drm patches
 - rebase v4.8

Changes since v8:
 - Add MODULE_ALIAS (Vinod)
 - devm_kzalloc to devm_kcalloc (Vinod)
 - quisce tasklet initialised by vchan_init() (Vinod)
 - Don't make SLIM rproc user selectable (Bjorn)
 - slim_rproc: Ensure clocks enabled before firmware load (Peter)
 - Various code style nits / commit message change (Lee)
 - Separate patch for '\n' kconfig removal (Vinod)
 - Fix clock bug when booting without clk_ignore_unused param

Changes since v7:
 - Rebase on v4.8-rc3 (Peter)
 - Double check that len is <= mem[i].size (Bjorn)
 - Remove if (!fw) checks (Bjorn)
 - Omit reference from fw_ops struct (Bjorn)
 - Call rproc_del() before rproc_put() (Bjorn)
 - Fix some odd line breaks (Bjorn)
 - Rename SLIM_* and slim_* with st prefix (Bjorn)

Changes since v6:
 - Fix recursive Kconfig warning (Patrice)
 - Fix various Intel zero day compiler warnings
 - Remove all changes related to late firmware load (now relies on initramfs) (Peter)

Changes since v5:
 - Remove optional rsc table and go back to dummy resource table (Bjorn)
 - Retry rproc_fw_config_virtio() from rproc_boot() if previously failed (Peter)
 - Fixup some kbuild warnings
 - rebase on v4.7-rc5
 - Remove some patches which were merged via ASoC tree

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

Peter Griffin (11):
  remoteproc: st_slim_rproc: add a slimcore rproc driver
  MAINTAINERS: Add st slim core rproc driver to STi section.
  remoteproc: Update Kconfig setup to 'depends on REMOTEPROC'
  dmaengine: st_fdma: Add STMicroelectronics FDMA DT binding
    documentation
  dmaengine: st_fdma: Add STMicroelectronics FDMA driver header file
  dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support
  MAINTAINERS: Add FDMA driver files to STi section.
  ARM: multi_v7_defconfig: Enable remoteproc core
  ARM: multi_v7_defconfig: Enable st_remoteproc driver.
  ARM: multi_v7_defconfig: Enable STi FDMA driver
  ARM: multi_v7_defconfig: Enable STi and simple-card drivers.

 Documentation/devicetree/bindings/dma/st_fdma.txt |  87 +++
 MAINTAINERS                                       |   3 +
 arch/arm/configs/multi_v7_defconfig               |   6 +
 drivers/dma/Kconfig                               |  13 +
 drivers/dma/Makefile                              |   1 +
 drivers/dma/st_fdma.c                             | 899 ++++++++++++++++++++++
 drivers/dma/st_fdma.h                             | 249 ++++++
 drivers/remoteproc/Kconfig                        |  23 +-
 drivers/remoteproc/Makefile                       |   1 +
 drivers/remoteproc/st_slim_rproc.c                | 364 +++++++++
 include/linux/remoteproc/st_slim_rproc.h          |  58 ++
 11 files changed, 1696 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt
 create mode 100644 drivers/dma/st_fdma.c
 create mode 100644 drivers/dma/st_fdma.h
 create mode 100644 drivers/remoteproc/st_slim_rproc.c
 create mode 100644 include/linux/remoteproc/st_slim_rproc.h

-- 
1.9.1
