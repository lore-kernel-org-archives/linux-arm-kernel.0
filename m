From: pn@denx.de (Parthiban Nallathambi)
Date: Mon, 26 Nov 2018 11:03:52 +0100
Subject: [PATCH v3 0/4] Add Actions Semi Owl family sirq support
Message-ID: <20181126100356.2840578-1-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for external interrupt controller
in Actions Semi Owl famil of SoC's (S500, S700 and S900). Actions
provides support for external interrupt controller to be connected
with it's SoC's using 3 SIRQ pins.

Each line can be configures independently, i.e 3 independent external
interrupt controller can be connected and managed parallely.

Device tree node is created only for S700 after testing it in Cubieboard7.

Changelog in v3:
- Set default operating frequency to 24MHz
- Falling edge and Low Level interrupts translated to rising edge and high level
- Introduced common function with lock handling for register read and write
- Used direct GIC interrupt number for interrupt local hwirq and finding offset
using DT entry (range) when registers are shared 
- Changed irq_ack to irq_eoi
- Added translation method for irq_domain_ops
- Clearing interrupt pending based on bitmask for edge triggered
- Added pinctrl definition for sirq for cubieboard7. This depends on,
https://lore.kernel.org/patchwork/patch/1012859/

Changelog in v2:
- Added SIRQ as hierarchical chip
        GIC <----> SIRQ <----> External interrupt controller/Child devices
- Device binding updates with vendor prefix
- Register sharing handled globally and common init sequence/data for all
actions SoC family

Thanks,
Parthiban
Saravanan

Parthiban Nallathambi (4):
  dt-bindings: interrupt-controller: Actions external interrupt
    controller
  drivers/irqchip: Add Actions external interrupts support
  arm64: dts: actions: Add sirq node for Actions Semi S700
  arm64: dts: actions: s700-cubieboard7: Enable SIRQ

 .../interrupt-controller/actions,owl-sirq.txt |  57 ++++
 .../boot/dts/actions/s700-cubieboard7.dts     |  19 ++
 arch/arm64/boot/dts/actions/s700.dtsi         |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-owl-sirq.c                | 301 ++++++++++++++++++
 5 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

-- 
2.17.2
