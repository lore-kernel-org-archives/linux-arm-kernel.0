From: chunfeng.yun@mediatek.com (chunfeng.yun at mediatek.com)
Date: Wed, 27 May 2015 19:47:57 +0800
Subject: [PATCH 0/6] Mediatek xHCI support
Message-ID: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch supports MediaTek's xHCI controller.

There are some differences from xHCI spec:
1. The interval is specified in 250 * 8ns increments for Interrupt Moderation
Interval(IMODI) of the Interrupter Moderation(IMOD) register, it is 8 times as
much as that defined in xHCI spec.

2. For the value of TD Size in Normal TRB, MTK's xHCI controller defines a
number of packets that remain to be transferred for a TD after processing all
Max packets in all previous TRBs,that means don't include the current TRB's,
but in xHCI spec it includes the current ones.

3. To minimize the scheduling effort for synchronous endpoints in xHC, the MTK
architecture defines some extra SW scheduling parameters for HW. According to
these parameters provided by SW, the xHC can easily decide whether a
synchronous endpoint should be scheduled in a specific uFrame. The extra SW
scheduling parameters are put into reserved DWs in Slot and Endpoint Context.
And a bandwidth scheduler algorithm is added to support such feature.

A usb3.0 phy driver is also added which used by mt65xx SoCs platform, it
supports two usb2.0 ports and one usb3.0 port.

Chunfeng Yun (6):
  dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
  dt-bindings: Add a binding for Mediatek xHCI host controller
  xhci: probe phy before add usb_hcd
  usb: phy: add usb3.0 phy driver for mt65xx SoCs
  xhci: mediatek: support MTK xHCI host controller
  arm64: dts: mediatek: add xHCI & usb phy for mt8173

 .../devicetree/bindings/usb/mt65xx-u3phy.txt       |  37 ++
 .../devicetree/bindings/usb/mt8173-xhci.txt        |  19 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  14 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  24 +
 drivers/usb/host/Kconfig                           |   9 +
 drivers/usb/host/Makefile                          |   3 +
 drivers/usb/host/xhci-mtk.c                        | 470 +++++++++++++
 drivers/usb/host/xhci-mtk.h                        | 119 ++++
 drivers/usb/host/xhci-plat.c                       |  56 +-
 drivers/usb/host/xhci-ring.c                       |  35 +-
 drivers/usb/host/xhci.c                            |  16 +-
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/phy/Kconfig                            |  10 +
 drivers/usb/phy/Makefile                           |   1 +
 drivers/usb/phy/phy-mt65xx-usb3.c                  | 724 +++++++++++++++++++++
 15 files changed, 1513 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
 create mode 100644 drivers/usb/host/xhci-mtk.c
 create mode 100644 drivers/usb/host/xhci-mtk.h
 create mode 100644 drivers/usb/phy/phy-mt65xx-usb3.c

--
1.8.1.1.dirty
