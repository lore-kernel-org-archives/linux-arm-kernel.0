From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:06 +0800
Subject: [PATCH RFC 0/8] Add New DRM Driver for Hisilicon's Hi6220 SoC
Message-ID: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  These patch set adds a new drm driver for Hisilicon's Hi6220 SoC.
Current testing and support board is Hikey board which is one of Linaro
96boards. It is an arm64 open source board. For more information about
this board, please access https://www.96boards.org.

1. Hardware Detail
  The display subsystem of Hi6220 SoC is shown as bellow:
 +-----+       +----------+     +-----+     +---------+
 |     |       |          |     |     |     |         |             	
 | FB  |------>|   ADE    |---->| DSI |---->| External|
 |     |       |          |     |     |     |  HDMI   |
 +-----+       +----------+     +-----+     +---------+

- ADE(Advanced Display Engine) is the display controller. It contains 7
channels or pipes, 3 overlay and a LDI.
  - A channel/pipe looks like: DMA-->clip-->scale-->ctrans/csc.
  - Overlay is response to compose planes which come from 7 channels and
  pass composed image to LDI.
  - LDI is response to generate timings and RGB data stream.
- DSI converts the RGB data stream from ADE to DSI packets.
- External HDMI module is connected with DSI bus. Now Hikey use a ADI's
  ADV7533 external HDMI chip.

2. Software Detail
  About the software organization and implementation detail:
We have a main drm platform driver (hisi_drm_drv.c), ade platform driver
(hisi_ade.c) and a dsi platform driver (hisi_drm_dsi.c). Ade driver
implements the plane and crtc driver interfaces and dsi implements the
encoder and connector driver interfaces. We take advantage of component
framework to initialize each driver.
  In order to support multi coming Hisilicon's SoCs, we plan to separate
common driver code and SoC specific implemented code as possiple as we can.
We abstract an ops for each component(crtc, plane, encoder and connector)
to reuse the common interface implementation logic (FIXME: Not sure if we
can achieve this target and if it is good or not). Thus, we put these
common driver code into hisi_drm_drv/crtc/plane/encoder/connector.c files.

Xinwei Kong (8):
  dt-bindings: Document the hi6220 bindings for DRM driver
  drm: hisilicon: Add new DRM driver for hisilicon Soc
  drm: hisilicon: Add the link to DRM/KMS interface
  drm: hisilicon: fill interface function of plane\crtc part
  drm: hisilicon: fill interface function of encoder\connector part
  drm: hisilicon: Add support for fbdev
  drm: hisilicon: Add support for vblank
  dts: hisilicon: Add drm driver device dts config for HiKey board

 .../devicetree/bindings/gpu/hisilicon,hi6220.txt   |   69 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   34 +
 arch/arm64/configs/defconfig                       |    5 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/hisilicon/Kconfig                  |   32 +
 drivers/gpu/drm/hisilicon/Makefile                 |   12 +
 drivers/gpu/drm/hisilicon/hisi_ade.c               | 1360 ++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_ade_reg.h           |  208 +++
 drivers/gpu/drm/hisilicon/hisi_drm_connector.c     |  128 ++
 drivers/gpu/drm/hisilicon/hisi_drm_connector.h     |   33 +
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.c          |  315 +++++
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.h          |   64 +
 drivers/gpu/drm/hisilicon/hisi_drm_drv.c           |  220 ++++
 drivers/gpu/drm/hisilicon/hisi_drm_drv.h           |   36 +
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c           |  829 ++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_encoder.c       |  117 ++
 drivers/gpu/drm/hisilicon/hisi_drm_encoder.h       |   41 +
 drivers/gpu/drm/hisilicon/hisi_drm_fb.c            |  175 +++
 drivers/gpu/drm/hisilicon/hisi_drm_fb.h            |   33 +
 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c         |  395 ++++++
 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h         |   24 +
 drivers/gpu/drm/hisilicon/hisi_drm_plane.c         |  257 ++++
 drivers/gpu/drm/hisilicon/hisi_drm_plane.h         |   55 +
 drivers/gpu/drm/hisilicon/hisi_dsi_reg.h           |   91 ++
 25 files changed, 4536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt
 create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_ade.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_ade_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_connector.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_connector.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_encoder.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fb.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fb.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_plane.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_plane.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_dsi_reg.h

-- 
1.9.1
