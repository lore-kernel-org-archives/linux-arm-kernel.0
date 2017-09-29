From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Fri, 29 Sep 2017 15:09:02 +0200
Subject: [RFC 00/11] Acer Chromebook R13 support
Message-ID: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This is a very rough cut of support for the MT8173-based Acer Chromebook R13
("Elm") platform. It mostly consists of drivers ported from the chromeos-3.18
vendor kernel, a little device tree, and a number of hacks.

This is the first iteration that worked well enough to light up the display
and provide a framebuffer console, and I haven't looked much into why most
of these hacks are necessary yet. The exception is the mmsys device, see
"hack: mediatek: get mmsys to register as both DRM and clock device" for
details on that.

You can find this series at https://github.com/uli/kernel/tree/elm-working,
which also contains a config file and several ancillary bits that are
required to build a kernel partition for the Chromebook. Instructions on
how to do so (and various other things that have to be done to get it
running on your device) are available at
https://www.elinux.org/User:Uli/Acer_Chromebook_R13_GPU_test_system
(These instructions have been written for the vendor kernel, but apply to
mainline as well, except that you won't need any extra patches.)

Testing has so far been limited to what I needed to copy new kernel images
to the device: keyboard, LCD, backlight, SD card and USB port work.

CU
Uli


Ulrich Hecht (11):
  soc: mediatek: MediaTek Command Queue (CMDQ) driver
  drm/bridge: GPIO-controlled display multiplexer driver
  platform/chrome: ChromeOS firmware interface driver
  drm/bridge: Parade PS8640 MIPI DSI -> eDP converter driver
  drm/bridge: Analogix ANX7688 HDMI -> DP bridge driver
  arm64: dts: mediatek: Add Elm Rev. 3 device tree
  hack: mediatek: get mmsys to register as both DRM and clock device
  hack: drm/mediatek: roll back drm_of_find_panel_or_bridge() use
  drm/mediatek: add fbdev support
  hack: mtk-sd: use old driver from vendor kernel
  hack: Revert "iommu/io-pgtable: Sanitise map/unmap addresses"

 arch/arm64/boot/dts/mediatek/Makefile            |    1 +
 arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts |   21 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi     |  210 ++
 arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi     | 1014 ++++++++
 drivers/clk/mediatek/clk-mt8173.c                |    4 +-
 drivers/gpu/drm/bridge/Kconfig                   |   32 +
 drivers/gpu/drm/bridge/Makefile                  |    5 +
 drivers/gpu/drm/bridge/analogix-anx7688.c        |  233 ++
 drivers/gpu/drm/bridge/generic-gpio-mux.c        |  316 +++
 drivers/gpu/drm/bridge/parade-ps8640.c           | 1104 +++++++++
 drivers/gpu/drm/mediatek/Makefile                |    2 +
 drivers/gpu/drm/mediatek/mtk_dpi.c               |    5 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c           |    5 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c           |   16 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h           |    4 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c            |   13 +
 drivers/gpu/drm/mediatek/mtk_drm_fb.h            |    3 +
 drivers/gpu/drm/mediatek/mtk_drm_fbdev.c         |  184 ++
 drivers/gpu/drm/mediatek/mtk_drm_fbdev.h         |   32 +
 drivers/gpu/drm/mediatek/mtk_dsi.c               |   21 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c              |    5 +-
 drivers/iommu/io-pgtable-arm-v7s.c               |    6 -
 drivers/iommu/io-pgtable-arm.c                   |    7 -
 drivers/mmc/host/mtk-sd.c                        |  465 ++--
 drivers/platform/chrome/Kconfig                  |   18 +
 drivers/platform/chrome/Makefile                 |    2 +
 drivers/platform/chrome/chromeos.c               |  120 +
 drivers/platform/chrome/chromeos.h               |   61 +
 drivers/platform/chrome/chromeos_arm.c           |  264 ++
 drivers/platform/chrome/elog.h                   |  186 ++
 drivers/soc/mediatek/Kconfig                     |   10 +
 drivers/soc/mediatek/Makefile                    |    1 +
 drivers/soc/mediatek/mtk-cmdq.c                  | 2814 ++++++++++++++++++++++
 include/linux/chromeos_platform.h                |   27 +
 include/soc/mediatek/cmdq.h                      |  211 ++
 35 files changed, 7161 insertions(+), 261 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi
 create mode 100644 drivers/gpu/drm/bridge/analogix-anx7688.c
 create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c
 create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
 create mode 100644 drivers/platform/chrome/chromeos.c
 create mode 100644 drivers/platform/chrome/chromeos.h
 create mode 100644 drivers/platform/chrome/chromeos_arm.c
 create mode 100644 drivers/platform/chrome/elog.h
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/linux/chromeos_platform.h
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
2.7.4
