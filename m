From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 22 Jul 2015 22:05:40 +0800
Subject: No subject
Message-ID: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From ac1e8724bfa47494223bad0af450c1a63cd2fe0c Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Wed, 22 Jul 2015 21:15:15 +0800
Subject: [PATCH 0/5] *** SUBJECT HERE ***

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

Change in v3:
1. implement generic phy
2. move opperations for IPPC and wakeup from phy driver to xHCI driver
3. seperate quirk functions into a single C file to fix up dependence issue

Chunfeng Yun (5):
  dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
  dt-bindings: Add a binding for Mediatek xHCI host controller
  usb: phy: add usb3.0 phy driver for mt65xx SoCs
  xhci: mediatek: support MTK xHCI host controller
  arm64: dts: mediatek: add xHCI & usb phy for mt8173

 .../devicetree/bindings/phy/phy-mt65xx-u3.txt      |  21 +
 .../devicetree/bindings/usb/mt8173-xhci.txt        |  50 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  15 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  31 +
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-mt65xx-usb3.c                      | 426 +++++++++++
 drivers/usb/host/Kconfig                           |   9 +
 drivers/usb/host/Makefile                          |   4 +
 drivers/usb/host/xhci-mtk-sch.c                    | 436 +++++++++++
 drivers/usb/host/xhci-mtk.c                        | 836 +++++++++++++++++++++
 drivers/usb/host/xhci-mtk.h                        | 135 ++++
 drivers/usb/host/xhci-ring.c                       |  35 +-
 drivers/usb/host/xhci.c                            |  19 +-
 drivers/usb/host/xhci.h                            |   1 +
 15 files changed, 2021 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mt65xx-u3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
 create mode 100644 drivers/phy/phy-mt65xx-usb3.c
 create mode 100644 drivers/usb/host/xhci-mtk-sch.c
 create mode 100644 drivers/usb/host/xhci-mtk.c
 create mode 100644 drivers/usb/host/xhci-mtk.h

--
1.8.1.1.dirty

In-Reply-To: 
