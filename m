From: youlin.pei@mediatek.com (Youlin Pei)
Date: Tue, 14 Feb 2017 10:55:58 +0800
Subject: [PATCH v3 0/3] Add Mediatek CIRQ interrupt controller
Message-ID: <1487040961-18319-1-git-send-email-youlin.pei@mediatek.com>
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

change in v3:
1. add an explicit cirq range in DT and do the range check in driver.
2. change the option "mediatek,ext-irq-start" to s"mediatek,ext-irq-range".
3. remove mtk_cirq_eoi and clear the irq status in suspend callback.
4. remove some pure copy code.
5. rebase on 4.10-rc2.

change in v2:
1. fix coding style issue.
2. change the compatible string.
3. resolve IRQ offset at alloc time.
4. clear irq status in irq_eoi function.
5. rebase on 4.9-rc1.

v1:
http://lists.infradead.org/pipermail/linux-mediatek/2016-October/007213.html
v2:
http://lists.infradead.org/pipermail/linux-mediatek/2016-November/007350.html

Youlin Pei (3):
  binding: irqchip: mtk-cirq: Add binding document
  irqchip: mtk-cirq: Add mediatek mtk-cirq implement
  ARM: dts: mt2701: Add mtk-cirq node for mt2701

 .../interrupt-controller/mediatek,cirq.txt         |  35 +++
 arch/arm/boot/dts/mt2701.dtsi                      |  12 +-
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-mtk-cirq.c                     | 288 +++++++++++++++++++++
 4 files changed, 335 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 drivers/irqchip/irq-mtk-cirq.c

-- 
1.9.1 
