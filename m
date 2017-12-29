From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 29 Dec 2017 15:52:42 +0800
Subject: [PATCH v5 00/16] Rockchip ISP1 Driver
Message-ID: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes in V5: Sync with local changes,
  - fix the SP height limit
  - speed up the second stream capture
  - the second stream can't force sync for rsz when start/stop streaming
  - add frame id to param vb2 buf
  - enable luminance maximum threshold

changes in V4:
  - fix some bugs during development
  - move quantization settings to rkisp1 subdev
  - correct some spelling problems
  - describe ports in dt-binding documents

changes in V3:
  - add some comments
  - fix wrong use of v4l2_async_subdev_notifier_register
  - optimize two paths capture at a time
  - remove compose
  - re-struct headers
  - add a tmp wiki page: http://opensource.rock-chips.com/wiki_Rockchip-isp1

changes in V2:
  mipi-phy:
    - use async probing
    - make it be a child device of the GRF
  isp:
    - add dummy buffer
    - change the way to get bus configuration, which make it possible to
            add parallel sensor support in the future(without mipi-phy driver).

This patch series add a ISP(Camera) v4l2 driver for rockchip rk3288/rk3399 SoC.

Wiki Pages:
http://opensource.rock-chips.com/wiki_Rockchip-isp1

Jacob Chen (12):
  media: doc: add document for rkisp1 meta buffer format
  media: rkisp1: add Rockchip MIPI Synopsys DPHY driver
  media: rkisp1: add Rockchip ISP1 subdev driver
  media: rkisp1: add ISP1 statistics driver
  media: rkisp1: add ISP1 params driver
  media: rkisp1: add capture device driver
  media: rkisp1: add rockchip isp1 core driver
  dt-bindings: Document the Rockchip ISP1 bindings
  dt-bindings: Document the Rockchip MIPI RX D-PHY bindings
  ARM: dts: rockchip: add isp node for rk3288
  ARM: dts: rockchip: add rx0 mipi-phy for rk3288
  MAINTAINERS: add entry for Rockchip ISP1 driver

Jeffy Chen (1):
  media: rkisp1: Add user space ABI definitions

Shunqian Zheng (3):
  media: videodev2.h, v4l2-ioctl: add rkisp1 meta buffer format
  arm64: dts: rockchip: add isp0 node for rk3399
  arm64: dts: rockchip: add rx0 mipi-phy for rk3399

 .../devicetree/bindings/media/rockchip-isp1.txt    |   69 +
 .../bindings/media/rockchip-mipi-dphy.txt          |   88 +
 Documentation/media/uapi/v4l/meta-formats.rst      |    2 +
 .../media/uapi/v4l/pixfmt-meta-rkisp1-params.rst   |   17 +
 .../media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst     |   18 +
 MAINTAINERS                                        |   10 +
 arch/arm/boot/dts/rk3288.dtsi                      |   24 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   25 +
 drivers/media/platform/Kconfig                     |   10 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/rockchip/isp1/Makefile      |    8 +
 drivers/media/platform/rockchip/isp1/capture.c     | 1728 ++++++++++++++++++++
 drivers/media/platform/rockchip/isp1/capture.h     |  194 +++
 drivers/media/platform/rockchip/isp1/common.h      |  137 ++
 drivers/media/platform/rockchip/isp1/dev.c         |  653 ++++++++
 drivers/media/platform/rockchip/isp1/dev.h         |  120 ++
 drivers/media/platform/rockchip/isp1/isp_params.c  | 1553 ++++++++++++++++++
 drivers/media/platform/rockchip/isp1/isp_params.h  |   76 +
 drivers/media/platform/rockchip/isp1/isp_stats.c   |  522 ++++++
 drivers/media/platform/rockchip/isp1/isp_stats.h   |   85 +
 .../media/platform/rockchip/isp1/mipi_dphy_sy.c    |  787 +++++++++
 drivers/media/platform/rockchip/isp1/regs.c        |  266 +++
 drivers/media/platform/rockchip/isp1/regs.h        | 1577 ++++++++++++++++++
 drivers/media/platform/rockchip/isp1/rkisp1.c      | 1205 ++++++++++++++
 drivers/media/platform/rockchip/isp1/rkisp1.h      |  132 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +
 include/uapi/linux/rkisp1-config.h                 |  757 +++++++++
 include/uapi/linux/videodev2.h                     |    4 +
 28 files changed, 10070 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-isp1.txt
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
 create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
 create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
 create mode 100644 drivers/media/platform/rockchip/isp1/Makefile
 create mode 100644 drivers/media/platform/rockchip/isp1/capture.c
 create mode 100644 drivers/media/platform/rockchip/isp1/capture.h
 create mode 100644 drivers/media/platform/rockchip/isp1/common.h
 create mode 100644 drivers/media/platform/rockchip/isp1/dev.c
 create mode 100644 drivers/media/platform/rockchip/isp1/dev.h
 create mode 100644 drivers/media/platform/rockchip/isp1/isp_params.c
 create mode 100644 drivers/media/platform/rockchip/isp1/isp_params.h
 create mode 100644 drivers/media/platform/rockchip/isp1/isp_stats.c
 create mode 100644 drivers/media/platform/rockchip/isp1/isp_stats.h
 create mode 100644 drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c
 create mode 100644 drivers/media/platform/rockchip/isp1/regs.c
 create mode 100644 drivers/media/platform/rockchip/isp1/regs.h
 create mode 100644 drivers/media/platform/rockchip/isp1/rkisp1.c
 create mode 100644 drivers/media/platform/rockchip/isp1/rkisp1.h
 create mode 100644 include/uapi/linux/rkisp1-config.h

-- 
1.9.1
