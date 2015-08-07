From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 7 Aug 2015 20:30:39 +0800
Subject: Mediatek xHCI support
Message-ID: <1438950644-27290-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 5c00619366ce4e7ff2bad050697dd6b3294f38ec Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Fri, 7 Aug 2015 20:16:42 +0800
Subject: [PATCH v5 0/5]  Mediatek xHCI support

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

Change in v5:
1. descripte more exactly for each specifiers in xHCI binding
2. make use of new multi-phy feature for phy driver


Chunfeng Yun (5):
  dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
  dt-bindings: Add a binding for Mediatek xHCI host controller
  usb: phy: add usb3.0 phy driver for mt65xx SoCs
  xhci: mediatek: support MTK xHCI host controller
  arm64: dts: mediatek: add xHCI & usb phy for mt8173

 .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |  69 ++
 .../devicetree/bindings/usb/mt8173-xhci.txt        |  52 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  16 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  44 ++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-mt65xx-usb3.c                      | 467 ++++++++++++
 drivers/usb/host/Kconfig                           |   9 +
 drivers/usb/host/Makefile                          |   4 +
 drivers/usb/host/xhci-mtk-sch.c                    | 436 +++++++++++
 drivers/usb/host/xhci-mtk.c                        | 837 +++++++++++++++++++++
 drivers/usb/host/xhci-mtk.h                        | 133 ++++
 drivers/usb/host/xhci-ring.c                       |  35 +-
 drivers/usb/host/xhci.c                            |  19 +-
 drivers/usb/host/xhci.h                            |   1 +
 15 files changed, 2125 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
 create mode 100644 drivers/phy/phy-mt65xx-usb3.c
 create mode 100644 drivers/usb/host/xhci-mtk-sch.c
 create mode 100644 drivers/usb/host/xhci-mtk.c
 create mode 100644 drivers/usb/host/xhci-mtk.h

--
1.8.1.1.dirty
