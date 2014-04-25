From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 12:29:51 +0100
Subject: [PATCH 000/222] The *Full* Cubox-i series
Message-ID: <20140425112951.GK26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that people can see what kind of a patch nightmare I'm in, and
hopefully start being more co-operative towards getting patches into
mainline, here is the *full* patch set for CuBox-i support that I'm
presently sitting on.

Anything that can be done to make this easier would be very helpful,
so I'm not spending lots of time tweaking some random patch and then
having to remerge all these different sub-series.

 .../DocBook/media/v4l/pixfmt-packed-rgb.xml        |   39 +
 .../devicetree/bindings/leds/leds-pwm.txt          |    2 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |   11 +
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 +-
 arch/arm/Kconfig                                   |   51 -
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |   28 +
 arch/arm/boot/dts/imx6q-cubox-i.dts                |    4 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |   79 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |   22 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |   98 ++
 arch/arm/boot/dts/imx6qdl.dtsi                     |    2 +
 arch/arm/boot/dts/imx6sl.dtsi                      |    2 +
 arch/arm/boot/dts/marco.dtsi                       |    2 +-
 arch/arm/boot/dts/prima2.dtsi                      |    2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |    1 +
 arch/arm/include/asm/hardware/cache-l2x0.h         |  104 +-
 arch/arm/include/asm/outercache.h                  |   67 +-
 arch/arm/mach-berlin/berlin.c                      |    2 +-
 arch/arm/mach-cns3xxx/core.c                       |   10 +-
 arch/arm/mach-exynos/common.h                      |    1 -
 arch/arm/mach-exynos/exynos.c                      |   15 +-
 arch/arm/mach-exynos/sleep.S                       |   30 +-
 arch/arm/mach-highbank/highbank.c                  |   18 +-
 arch/arm/mach-imx/clk-imx6q.c                      |   29 +-
 arch/arm/mach-imx/clk-pllv3.c                      |   27 +-
 arch/arm/mach-imx/mach-vf610.c                     |    2 +-
 arch/arm/mach-imx/suspend-imx6.S                   |   24 +-
 arch/arm/mach-imx/system.c                         |    8 +-
 arch/arm/mach-mvebu/board-v7.c                     |    2 +-
 arch/arm/mach-nomadik/cpu-8815.c                   |    2 +-
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/io.c                           |    2 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |   16 +-
 arch/arm/mach-omap2/omap4-common.c                 |   86 +-
 arch/arm/mach-prima2/l2x0.c                        |   34 +-
 arch/arm/mach-prima2/pm.c                          |    1 -
 arch/arm/mach-realview/realview_eb.c               |    9 +-
 arch/arm/mach-realview/realview_pb1176.c           |    8 +-
 arch/arm/mach-realview/realview_pb11mp.c           |    9 +-
 arch/arm/mach-realview/realview_pbx.c              |    4 +-
 arch/arm/mach-rockchip/rockchip.c                  |    2 +-
 .../board-armadillo800eva-reference.c              |    4 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |    4 +-
 arch/arm/mach-shmobile/setup-r8a7778.c             |    4 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |    4 +-
 arch/arm/mach-socfpga/socfpga.c                    |    2 +-
 arch/arm/mach-spear/platsmp.c                      |   19 +-
 arch/arm/mach-spear/spear13xx.c                    |    8 +-
 arch/arm/mach-sti/board-dt.c                       |   12 +-
 arch/arm/mach-tegra/pm.h                           |    2 -
 arch/arm/mach-tegra/reset-handler.S                |   11 +-
 arch/arm/mach-tegra/sleep.h                        |   31 -
 arch/arm/mach-tegra/tegra.c                        |   22 +-
 arch/arm/mach-ux500/cache-l2x0.c                   |   32 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   28 +-
 arch/arm/mach-zynq/common.c                        |    2 +-
 arch/arm/mm/Kconfig                                |   51 +
 arch/arm/mm/Makefile                               |    3 +-
 arch/arm/mm/cache-feroceon-l2.c                    |    1 -
 arch/arm/mm/cache-l2x0.c                           | 1564 +++++++++++++-------
 arch/arm/mm/l2c-common.c                           |   20 +
 arch/arm/mm/l2c-l2x0-resume.S                      |   58 +
 arch/arm/plat-samsung/s5p-sleep.S                  |    1 -
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/ata/ahci_imx.c                             |  184 ++-
 drivers/cec/Kconfig                                |   14 +
 drivers/cec/Makefile                               |    1 +
 drivers/cec/cec-dev.c                              |  384 +++++
 drivers/gpu/drm/drm_crtc_helper.c                  |    6 -
 drivers/leds/leds-pwm.c                            |  144 +-
 drivers/mmc/core/core.c                            |   42 +
 drivers/mmc/core/host.c                            |   68 +
 drivers/mmc/core/sdio_irq.c                        |   41 +-
 drivers/mmc/host/Kconfig                           |   63 +-
 drivers/mmc/host/dw_mmc.c                          |    2 +
 drivers/mmc/host/sdhci-acpi.c                      |    8 +
 drivers/mmc/host/sdhci-bcm-kona.c                  |    4 +
 drivers/mmc/host/sdhci-bcm2835.c                   |    4 +
 drivers/mmc/host/sdhci-cns3xxx.c                   |   13 +-
 drivers/mmc/host/sdhci-dove.c                      |    4 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   82 +-
 drivers/mmc/host/sdhci-esdhc.h                     |    4 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |    4 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |   70 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |    4 +
 drivers/mmc/host/sdhci-pci.c                       |    9 +-
 drivers/mmc/host/sdhci-pltfm.c                     |    4 +
 drivers/mmc/host/sdhci-pxav2.c                     |   14 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   13 +-
 drivers/mmc/host/sdhci-s3c.c                       |   36 +-
 drivers/mmc/host/sdhci-sirf.c                      |    4 +
 drivers/mmc/host/sdhci-spear.c                     |    5 +-
 drivers/mmc/host/sdhci-tegra.c                     |   27 +-
 drivers/mmc/host/sdhci.c                           |  728 +++++----
 drivers/mmc/host/sdhci.h                           |   20 +-
 drivers/net/ethernet/freescale/fec.h               |   62 +-
 drivers/net/ethernet/freescale/fec_main.c          | 1414 +++++++++++-------
 drivers/regulator/anatop-regulator.c               |    1 +
 drivers/regulator/core.c                           |    2 +-
 drivers/regulator/dummy.c                          |    1 +
 drivers/regulator/fixed.c                          |    4 +-
 drivers/staging/imx-drm/Kconfig                    |   18 +
 drivers/staging/imx-drm/Makefile                   |    3 +
 drivers/staging/imx-drm/drm-ddc-connector.c        |   92 ++
 drivers/staging/imx-drm/drm-ddc-connector.h        |   26 +
 drivers/staging/imx-drm/dw-hdmi-audio.c            |  654 ++++++++
 drivers/staging/imx-drm/dw-hdmi-audio.h            |   15 +
 drivers/staging/imx-drm/dw-hdmi-cec.c              |  205 +++
 drivers/staging/imx-drm/dw-hdmi-cec.h              |   16 +
 drivers/staging/imx-drm/imx-drm-core.c             |    7 +-
 drivers/staging/imx-drm/imx-hdmi.c                 |  178 ++-
 drivers/staging/imx-drm/imx-ldb.c                  |   21 +
 drivers/staging/imx-drm/imx-tve.c                  |   63 +-
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h        |    5 +
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |   41 +-
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c            |   94 +-
 drivers/staging/imx-drm/ipu-v3/ipu-di.c            |    2 +-
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c          |   25 +-
 drivers/staging/imx-drm/ipu-v3/ipu-dp.c            |   71 +-
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h           |    3 +
 drivers/staging/imx-drm/ipuv3-crtc.c               |   16 +-
 drivers/staging/imx-drm/ipuv3-plane.c              |    4 +
 drivers/staging/imx-drm/parallel-display.c         |    2 +
 include/linux/cec-dev.h                            |   69 +
 include/linux/mmc/host.h                           |    8 +
 include/linux/mmc/sdhci.h                          |   15 +-
 include/uapi/linux/cec-dev.h                       |   34 +
 include/uapi/linux/videodev2.h                     |    1 +
 sound/soc/fsl/imx-pcm-dma.c                        |    2 +-
 133 files changed, 5598 insertions(+), 2336 deletions(-)


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
