From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 28 Nov 2015 18:38:55 +0800
Subject: [PATCH v2 00/10] Add New DRM Driver for HiSilicon hi6220 SoC
Message-ID: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This patch set adds a new drm driver for HiSilicon hi6220 SoC.
Current testing and support board is Hikey board which is one of Linaro
96boards. It is an arm64 open source board. For more information about
this board, please access https://www.96boards.org.

Hardware Detail
---------------
  The display subsystem of Hi6220 SoC is shown as bellow:
 +-----+       +----------+     +-----+     +---------+
 |     |       |          |     |     |     |         |             	
 | FB  |------>|   ADE    |---->| DSI |---->| External|
 |     |       |          |     |     |     |  HDMI   |
 +-----+       +----------+     +-----+     +---------+

- ADE(Advanced Display Engine) is the display controller. It contains 7
channels, 3 overlay compositors and a LDI.
  - A channel looks like: DMA-->clip-->scale-->ctrans(or called csc).
  - Overlay compositor is response to compose planes which come from 7
  channels and pass composed image to LDI.
  - LDI is response to generate timings and RGB data stream.
- DSI converts the RGB data stream from ADE to DSI packets.
- External HDMI module is connected with DSI bus. Now Hikey use a ADI's
  ADV7533 external HDMI chip.

Change History
-------------
Changes in v2:
- Remove abtraction layer of plane/crtc/encoder/connector.
- Refactor atomic implementation according to Daniel Vetter's guides:
http://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
http://blog.ffwll.ch/2015/09/xdc-2015-atomic-modesetting-for-drivers.html
http://blog.ffwll.ch/2015/08/atomic-modesetting-design-overview.html
- Use bridge instead of slave encoder to connect external HDMI.
- Move dt binding docs to bindings/display/hisilicon directory. 


Xinliang Liu (10):
  arm64: dts: hisilicon: Add display subsystem DT nodes for hi6220.
  drm/hisilicon: Add device tree binding for hi6220 display subsystem
  drm/hisilicon: Add hisilicon DRM master driver
  drm/hisilicon: Add crtc funcs for ADE
  drm/hisilicon: Add plane funcs for ADE
  drm/hisilicon: Add vblank feature
  drm/hisilicon: Add cma fbdev and hotplug
  drm/hisilicon: Add dsi encoder driver
  drm/hisilicon: Add dsi host driver
  drm/hisilicon: Add support for external bridge

 .../bindings/display/hisilicon/hisi-ade.txt        |   42 +
 .../bindings/display/hisilicon/hisi-drm.txt        |   66 ++
 .../bindings/display/hisilicon/hisi-dsi.txt        |   53 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   21 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   44 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/hisilicon/Kconfig                  |   10 +
 drivers/gpu/drm/hisilicon/Makefile                 |    5 +
 drivers/gpu/drm/hisilicon/hisi_ade_reg.h           |  490 +++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_ade.c           | 1068 ++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_ade.h           |   16 +
 drivers/gpu/drm/hisilicon/hisi_drm_drv.c           |  280 +++++
 drivers/gpu/drm/hisilicon/hisi_drm_drv.h           |   19 +
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c           |  829 +++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_dsi_reg.h           |   89 ++
 16 files changed, 3035 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-drm.txt
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-dsi.txt
 create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_ade_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_ade.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_ade.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_dsi_reg.h

-- 
1.9.1
