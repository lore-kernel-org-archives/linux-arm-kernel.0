From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 19 Oct 2016 10:28:19 +0800
Subject: [PATCH v7, 0/8] Add MediaTek USB3 DRD Driver 
Message-ID: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches introduce the MediaTek USB3 dual-role controller
driver.

The driver can be configured as Dual-Role Device (DRD),
Peripheral Only and Host Only (xHCI) modes. It works well
with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
tested on MT8173 platform which only contains USB2.0 device IP,
and on MT6290 platform which contains USB3.0 device IP.

Change in v7:
1. split dual-role driver into four patchs
2. remove QMU done tasklet
3. add a bool in xhci_hcd_mtk to signal absence of IPPC

Change in v6:
1. handle endianness of GPD and SETUP data
2. remove dummy error log and return suitable error number
3. cancel delay work when deregiseter driver

Change in v5:
1. modify some comments
2. rename some unsuitable variables
3. add reg-names property for host node
4. add USB_MTU3_DEBUG to control debug messages

Change in v4:
1. fix build errors on non-mediatek platforms
2. provide manual dual-role switch via debugfs instead of sysfs

Change in v3:
1. fix some typo error
2. rename mtu3.txt to mt8173-mtu3.txt

Change in v2:
1. modify binding docs according to suggestions
2. modify some comments and remove some dummy blank lines
3. fix memory leakage


Chunfeng Yun (8):
  dt-bindings: mt8173-xhci: support host side of dual-role mode
  dt-bindings: mt8173-mtu3: add devicetree bindings
  usb: xhci-mtk: make IPPC register optional
  usb: Add MediaTek USB3 DRD driver
  usb: mtu3: Super-Speed Peripheral mode support
  usb: mtu3: host only mode support
  usb: mtu3: dual-role mode support
  arm64: dts: mediatek: add USB3 DRD driver

 .../devicetree/bindings/usb/mt8173-mtu3.txt        |   87 ++
 .../devicetree/bindings/usb/mt8173-xhci.txt        |   54 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   63 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   29 +-
 drivers/usb/Kconfig                                |    2 +
 drivers/usb/Makefile                               |    1 +
 drivers/usb/host/xhci-mtk.c                        |   38 +-
 drivers/usb/host/xhci-mtk.h                        |    1 +
 drivers/usb/mtu3/Kconfig                           |   54 ++
 drivers/usb/mtu3/Makefile                          |   18 +
 drivers/usb/mtu3/mtu3.h                            |  417 +++++++++
 drivers/usb/mtu3/mtu3_core.c                       |  859 +++++++++++++++++++
 drivers/usb/mtu3/mtu3_dr.c                         |  379 +++++++++
 drivers/usb/mtu3/mtu3_dr.h                         |  108 +++
 drivers/usb/mtu3/mtu3_gadget.c                     |  730 ++++++++++++++++
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |  881 ++++++++++++++++++++
 drivers/usb/mtu3/mtu3_host.c                       |  294 +++++++
 drivers/usb/mtu3/mtu3_hw_regs.h                    |  473 +++++++++++
 drivers/usb/mtu3/mtu3_plat.c                       |  484 +++++++++++
 drivers/usb/mtu3/mtu3_qmu.c                        |  573 +++++++++++++
 drivers/usb/mtu3/mtu3_qmu.h                        |   43 +
 21 files changed, 5561 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
 create mode 100644 drivers/usb/mtu3/Kconfig
 create mode 100644 drivers/usb/mtu3/Makefile
 create mode 100644 drivers/usb/mtu3/mtu3.h
 create mode 100644 drivers/usb/mtu3/mtu3_core.c
 create mode 100644 drivers/usb/mtu3/mtu3_dr.c
 create mode 100644 drivers/usb/mtu3/mtu3_dr.h
 create mode 100644 drivers/usb/mtu3/mtu3_gadget.c
 create mode 100644 drivers/usb/mtu3/mtu3_gadget_ep0.c
 create mode 100644 drivers/usb/mtu3/mtu3_host.c
 create mode 100644 drivers/usb/mtu3/mtu3_hw_regs.h
 create mode 100644 drivers/usb/mtu3/mtu3_plat.c
 create mode 100644 drivers/usb/mtu3/mtu3_qmu.c
 create mode 100644 drivers/usb/mtu3/mtu3_qmu.h

-- 
1.7.9.5
