From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sat, 9 Dec 2017 16:45:29 +0800
Subject: [PATCH 0/7] Add USB remote wakeup driver
Message-ID: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    These patches introduce the SSUSB and SPM glue layer driver which is
used to support usb remote wakeup. Usually the glue layer is put into
a system controller, such as PERICFG module.
    The old way to support usb wakeup is put into SSUSB controller drivers,
including xhci-mtk driver and mtu3 driver, but there are some problems:
    1. can't disdinguish the relation between glue layer and SSUSB IP
       when SoCs supports multi SSUSB IPs;
    2. duplicated code for wakeup are put into both xhci-mtk and mtu3
       drivers;
    3. the glue layer may vary on different SoCs with SSUSB IP, and will
       make SSUSB controller drivers complicated;
    In order to resolve these problems, it's useful to make the glue layer
transparent by extracting a seperated driver, meanwhile to reduce the
duplicated code and simplify SSUSB controller drivers.

Changes from v1:
 * Introduce USB remote wakeup driver
 * Use the new way to support remote wakeup for SSUSB controller drivers
 * Add binding document for USB remote wakeup driver
 * Update binding documents of SSUSB controller drivers
 * Update DTS of MT8173 platform

Chunfeng Yun (7):
  soc: mediatek: Add USB wakeup driver
  dt-bindings: soc: mediatek: add bindings document for USB wakeup
  usb: xhci-mtk: use APIs of mtu_wakeup to support remote wakeup
  usb: mtu3: use APIs of mtu_wakeup to support remote wakeup
  dt-bindings: usb: mtk-xhci: add USB wakeup properties
  dt-bindings: usb: mtu3: add USB wakeup properties
  arm64: dts: mt8173: add uwk node and remove unused usb property

 .../bindings/soc/mediatek/usb-wakeup.txt           |  77 +++
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |  15 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |  14 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  28 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  16 +-
 drivers/soc/mediatek/Kconfig                       |   8 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-usb-wakeup.c              | 519 +++++++++++++++++++++
 drivers/usb/host/xhci-mtk.c                        |  39 +-
 drivers/usb/host/xhci-mtk.h                        |   2 +
 drivers/usb/mtu3/mtu3.h                            |   2 +
 drivers/usb/mtu3/mtu3_host.c                       |  39 +-
 include/dt-bindings/soc/mediatek,usb-wakeup.h      |  15 +
 include/linux/soc/mediatek/usb-wakeup.h            |  88 ++++
 14 files changed, 803 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/usb-wakeup.txt
 create mode 100644 drivers/soc/mediatek/mtk-usb-wakeup.c
 create mode 100644 include/dt-bindings/soc/mediatek,usb-wakeup.h
 create mode 100644 include/linux/soc/mediatek/usb-wakeup.h

-- 
1.9.1
