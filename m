From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sun, 18 Oct 2015 11:51:16 +0800
Subject: [PATCH v10 0/3] Mediatek xHCI support
Message-ID: <1445140279-18121-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 66e467548861c39c52de1d3d899ddc980c6cb925 Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Sun, 18 Oct 2015 11:39:45 +0800
Subject: [PATCH v10 0/3] Mediatek xHCI support

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

depend on the patch for TDS calculation:
https://patchwork.kernel.org/patch/7140041/

Change in v10:
1. simplify clock stability checks
2. put MTK xHCI configuration from xhci_mtk_probe() to xhci_mtk_setup()

Change in v9:
1. fix up issue of FS out-iso when use single-TT hub
2. improve RX sensitivity
3. remove udelay(800) called by phy_instance_power_on/off

Change in v8:
1. use struct overlay for ippc register
2. change usb wakeup as optional feature
3. add TDS quirk into unified TDS calculation function

Change in v7:
1. remove xHCI timing setting which only for FPGA
2. revise xHCI scheduler algorithms
3. replace "usb" by "USB" in xHCI binding file

Change in v6:
1. get register base address of port in probe instead of of_xlate
2. enable clock in phy_init instead of probe

Change in v5:
1. descripte more exactly for each specifiers in xHCI binding
2. make use of new multi-phy feature for phy driver

Change in v4:
1. descripte more exactly for each specifiers in binding file
2. use BIT() to define a bit mask macro

Change in v3:
1. implement generic phy
2. move opperations of IPPC and wakeup from phy driver to xHCI driver
3. seperate quirk functions into a single C file to fix up dependence issue

Change in v2:
1. Rebase to 4.2-rc1
2. Remove probe phy before add usb_hcd patch from this series due to 4.2-rc1
   already fix this issue
3. add xhci mac clocks
4. add suspend/resume
5. support remote wakeup

Chunfeng Yun (3):
  dt-bindings: Add a binding for Mediatek xHCI host controller
  xhci: mediatek: support MTK xHCI host controller
  arm64: dts: mediatek: add xHCI & usb phy for mt8173

 .../devicetree/bindings/usb/mt8173-xhci.txt        |  51 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  16 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  42 ++
 drivers/usb/host/Kconfig                           |   9 +
 drivers/usb/host/Makefile                          |   4 +
 drivers/usb/host/xhci-mtk-sch.c                    | 415 +++++++++++
 drivers/usb/host/xhci-mtk.c                        | 765 +++++++++++++++++++++
 drivers/usb/host/xhci-mtk.h                        | 162 +++++
 drivers/usb/host/xhci-ring.c                       |  16 +-
 drivers/usb/host/xhci.c                            |  19 +-
 drivers/usb/host/xhci.h                            |   1 +
 11 files changed, 1494 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
 create mode 100644 drivers/usb/host/xhci-mtk-sch.c
 create mode 100644 drivers/usb/host/xhci-mtk.c
 create mode 100644 drivers/usb/host/xhci-mtk.h

--
1.8.1.1.dirty
