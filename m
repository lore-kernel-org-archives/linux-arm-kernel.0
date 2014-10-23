From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 23 Oct 2014 23:53:08 +0800
Subject: [PATCH v4 0/7] ARM: mediatek: Add support for interrupt polarity
Message-ID: <1414079595-26129-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is 4th version of interrupt polarity support for MediaTek SoCs.
This is based on Jiang's hierarchy irqdomain v2 [1] and my mediatek SoC
basic support [2].

This version addressed comments from previous discussion[3]. I removed
arm,hierarchy-irq-domain property. When GIC is probed by DT, it will
support hierarchy irqdomain. I still keep the first patch because this is
still base on hierarchy irqdomain v2.

In Jiang's version of irq_create_of_mapping, if irqdomain is hierarchy, it
will not perform irq_find_mapping check and set_type. The outermost
irqdomain need to take care of that. Because we will have several different
outermost irqdomain in different ARM SoCs, this cause code duplication. I
moved them back to irq_create_of_mapping. Since Jiang's changes are not
merged yet, maybe that patch should be merged there.

Simplified block diagram for interrupt on my system:

    +-------+      +-------+
 ---| SYSIRQ|------|ARM GIC|
 ---|       |------|       |
 ---|       |------|       |
 ---|       |------|       |
 ---|       |------|       |
    +-------+      +-------+

In device tree, interrupt-parent for other devices is sysirq, child of gic.
This describe HW better and allow device to specify polarity as it is sent
by the device.

When using hierarchy irq domain, gic will use irq_domain_add_linear to
create irqdomain and all interrupt numbers must come from device tree. My
/proc/interrupts looks like this now:

# cat /proc/interrupts
           CPU0
 16:       1862  MT_SYSIRQ 113  mtk_timer
 17:         67  MT_SYSIRQ  54  mtk-uart

Changes in v3:
 - Discussion in [3]
 - First implementation using hierarchy irqdomain

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/290832.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/284553.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/293766.html

Yingjoe Chen (7):
  irqdomain: Fix irq_domain_alloc_irqs return check.
  irqdomain: Add back xlate and set_type for hierarchy irq domain
  genirq: Add more helper functions to support stacked irq_chip
  irqchip: gic: Support hierarchy irq domain.
  ARM: mediatek: Add sysirq interrupt polarity support
  ARM: mediatek: Add sysirq in mt6589/mt8135/mt8127 dtsi
  dt-bindings: add bindings for mediatek sysirq

 .../bindings/arm/mediatek/mediatek,sysirq.txt      |  26 ++++
 arch/arm/boot/dts/mt6589.dtsi                      |  14 +-
 arch/arm/boot/dts/mt8127.dtsi                      |  14 +-
 arch/arm/boot/dts/mt8135.dtsi                      |  14 +-
 drivers/irqchip/Kconfig                            |   1 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic.c                          |  54 +++++--
 drivers/irqchip/irq-mtk-sysirq.c                   | 168 +++++++++++++++++++++
 include/linux/irq.h                                |   6 +
 kernel/irq/chip.c                                  |  28 ++++
 kernel/irq/irqdomain.c                             |  31 ++--
 11 files changed, 332 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
 create mode 100644 drivers/irqchip/irq-mtk-sysirq.c

-- 
1.8.1.1.dirty
