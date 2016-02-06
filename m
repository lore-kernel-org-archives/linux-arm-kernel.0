From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat,  6 Feb 2016 11:24:47 +0800
Subject: [PATCH v4 00/11] Add DRM Driver for HiSilicon Kirin hi6220 SoC
Message-ID: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a new drm driver for HiSilicon Kirin hi6220 SoC.
Current testing and support board is Hikey board which is one of Linaro
96boards. It is an arm64 open source board. For more information about
this board, please access https://www.96boards.org.

Hardware Detail
---------------
  The display subsystem of Hi6220 SoC is shown as bellow:
 +-----+       +----------+     +-----+     +-------------+
 |     |       |          |     |     |     |             |             	
 | FB  |------>|   ADE    |---->| DSI |---->|   External  |
 |     |       |          |     |     |     |  HDMI/panel |
 +-----+       +----------+     +-----+     +-------------+

- ADE(Advanced Display Engine) is the display controller. It contains 7
channels, 3 overlay compositors and a LDI.
  - A channel looks like: DMA-->clip-->scale-->ctrans(or called csc).
  - Overlay compositor is response to compose planes which come from 7
  channels and pass composed image to LDI.
  - LDI is response to generate timings and RGB data stream.
- DSI converts the RGB data stream from ADE to DSI packets.
- External HDMI/panel module is connected with DSI bus. Now Hikey use a
  ADI's ADV7533 external HDMI chip.

Change History
-------------
Changes in v4:
- Describe more specific of clocks and ports of binding docs.
- Fix indentation of binding docs.

Changes in v3:
- Move and rename all the files to kirin sub-directory.
  So that we could separate different seires SoCs' driver.
- Make ade as the drm master node.
- Replace drm_platform_init, load, unload implementation.
- Use assigned-clocks to set clock rate.
- Use ports to connect display relavant nodes.
- Rename hisi_drm_dsi.c to dw_drm_dsi.c
- Make encoder type as DRM_MODE_ENCODER_DSI.
- A few cleanup on regs and code.

Changes in v2:
- Remove abtraction layer of plane/crtc/encoder/connector.
- Refactor atomic implementation according to Daniel Vetter's guides:
http://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
http://blog.ffwll.ch/2015/09/xdc-2015-atomic-modesetting-for-drivers.html
http://blog.ffwll.ch/2015/08/atomic-modesetting-design-overview.html
- Use bridge instead of slave encoder to connect external HDMI.
- Move dt binding docs to bindings/display/hisilicon directory. 

Xinliang Liu (11):
  drm/hisilicon: Add device tree binding for hi6220 display subsystem
  drm/hisilicon: Add hisilicon kirin drm master driver
  drm/hisilicon: Add crtc driver for ADE
  drm/hisilicon: Add plane driver for ADE
  drm/hisilicon: Add vblank driver for ADE
  drm/hisilicon: Add cma fbdev and hotplug
  drm/hisilicon: Add designware dsi encoder driver
  drm/hisilicon: Add designware dsi host driver
  drm/hisilicon: Add support for external bridge
  MAINTAINERS: Add maintainer for hisilicon DRM driver
  arm64: dts: hisilicon: Add display subsystem DT nodes for hi6220

 .../bindings/display/hisilicon/dw-dsi.txt          |   77 ++
 .../bindings/display/hisilicon/hisi-ade.txt        |   69 ++
 MAINTAINERS                                        |   10 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   44 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   53 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/hisilicon/Kconfig                  |    5 +
 drivers/gpu/drm/hisilicon/Makefile                 |    5 +
 drivers/gpu/drm/hisilicon/kirin/Kconfig            |   10 +
 drivers/gpu/drm/hisilicon/kirin/Makefile           |    5 +
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |  845 ++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h       |   83 ++
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h    |  280 ++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    | 1053 ++++++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |  382 +++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h    |   31 +
 17 files changed, 2955 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
 create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h

-- 
1.9.1
