From: youlin.pei@mediatek.com (Youlin Pei)
Date: Thu, 13 Oct 2016 13:06:31 +0800
Subject: [PATCH 0/3] Add Mediatek CIRQ interrupt controller
Message-ID: <1476335194-26604-1-git-send-email-youlin.pei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
works outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.

The CIRQ controller is integrated in between MCUSYS and interrupt sources
as the second level interrupt controller. The external interrupts which 
outside MCUSYS will feed through CIRQ then bypass to GIC.

In normal mode(where MCUSYS is active), CIRQ is disabled and interrupts
will directly issue to MCUSYS. When MCUSYS enters sleep mode, where GIC
is power downed. CIRQ will be enabled and monitor all edge trigger
interrupts(only edge trigger interrupts will be lost in this scenario).
When an edge interrupt is triggered, CIRQ will record the status and
generated a pulse signal to GIC when flush command is executed. 

With CIRQ, MCUSYS can be completely turned off to improve the system 
power consumption without losing interrupts.

Youlin Pei (3):
  binding: irqchip: mtk-cirq: Add binding document
  irqchip: mtk-cirq: Add mediatek mtk-cirq implement
  ARM: dts: mt2701: Add mtk-cirq node for mt2701

 .../interrupt-controller/mediatek,cirq.txt         |  30 +++
 arch/arm/boot/dts/mt2701.dtsi                      |  11 +-
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-mtk-cirq.c                     | 257 +++++++++++++++++++++
 4 files changed, 298 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 drivers/irqchip/irq-mtk-cirq.c

-- 
1.9.1 
