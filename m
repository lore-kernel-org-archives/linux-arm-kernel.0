From: carlo@caione.org (Carlo Caione)
Date: Tue,  1 Dec 2015 17:24:16 +0100
Subject: [PATCH v3 0/6] pinctrl: meson: enable support for external GPIO
 interrupts
Message-ID: <1448987062-31225-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

In Meson SoCs we have 8 independent GPIO interrupts that can be programmed to
use any of the GPIOs in the chip as interrupt source.

These GPIOs are managed by GIC but they can be conditioned (and enabled) by
some registers external to the GIC.

GPIOs |--[mux1 or mux2]--[polarity]--[filter]--[edge_select]--> GIC

Changelog:

* V2:
    - Introduced .irq_request_resources() and .irq_release_resources()
    - s/virq/irq/ and s/pin/hwirq/
    - Moved to the new irq_fwspec

* V3:
    - EXPORT_SYMBOL_GPL for of_irq_find_parent()
    - split GPIO management and irqchip side
    - the GIC IRQs list is not kept as set of fwspecs. it's now a regular
      integer array.
    - irq_of_phandle_args_to_fwspec discarded


Carlo Caione (6):
  of/irq: Export of_irq_find_parent again
  pinctrl: meson: Update pinctrl data with GPIO IRQ info
  pinctrl: meson: Make helper functions public
  pinctrl: meson: Enable GPIO IRQs
  pinctrl: dt-binding: Extend meson documentation with GPIO IRQs support
  ARM: meson: DTS: Enable GPIO IRQs

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |  11 +
 arch/arm/boot/dts/meson8b.dtsi                     |   5 +
 drivers/of/irq.c                                   |   3 +-
 drivers/pinctrl/Kconfig                            |   1 +
 drivers/pinctrl/meson/Makefile                     |   2 +-
 drivers/pinctrl/meson/irqchip-gpio-meson.c         | 321 +++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.c              |  40 ++-
 drivers/pinctrl/meson/pinctrl-meson.h              |  28 +-
 drivers/pinctrl/meson/pinctrl-meson8.c             |  36 ++-
 drivers/pinctrl/meson/pinctrl-meson8b.c            |  36 ++-
 include/linux/of_irq.h                             |   6 +
 11 files changed, 451 insertions(+), 38 deletions(-)
 create mode 100644 drivers/pinctrl/meson/irqchip-gpio-meson.c

-- 
2.5.0
