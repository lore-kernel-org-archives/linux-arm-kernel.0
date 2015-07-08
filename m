From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 8 Jul 2015 17:41:02 +0800
Subject: [PATCH v2 0/5] Mediatek xHCI support
Message-ID: <1436348468-4126-1-git-send-email-chunfeng.yun@mediatek.com>
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

Change in v2:
1. Rebase to 4.2-rc1
2. Remove probe phy before add usb_hcd patch from this series due to 4.2-rc1
   already fix this issue
3. add xhci mac clocks
4. add suspend/resume
5. support remote wakeup

Chunfeng Yun (5):
  dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
  dt-bindings: Add a binding for Mediatek xHCI host controller
  usb: phy: add usb3.0 phy driver for mt65xx SoCs
  xhci: mediatek: support MTK xHCI host controller
  arm64: dts: mediatek: add xHCI & usb phy for mt8173

 .../devicetree/bindings/usb/mt65xx-u3phy.txt       |  34 +
 .../devicetree/bindings/usb/mt8173-xhci.txt        |  27 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  15 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  27 +
 drivers/usb/host/Kconfig                           |   9 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/xhci-mtk.c                        | 814 ++++++++++++++++++++
 drivers/usb/host/xhci-mtk.h                        | 108 +++
 drivers/usb/host/xhci-ring.c                       |  35 +-
 drivers/usb/host/xhci.c                            |  19 +-
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/phy/Kconfig                            |  10 +
 drivers/usb/phy/Makefile                           |   1 +
 drivers/usb/phy/phy-mt65xx-usb3.c                  | 856 +++++++++++++++++++++
 14 files changed, 1950 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
 create mode 100644 drivers/usb/host/xhci-mtk.c
 create mode 100644 drivers/usb/host/xhci-mtk.h
 create mode 100644 drivers/usb/phy/phy-mt65xx-usb3.c

--
1.8.1.1.dirty
