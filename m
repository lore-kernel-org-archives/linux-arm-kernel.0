From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Sep 2017 11:45:41 +0900
Subject: [PATCH v7 0/2] gpio: uniphier: UniPhier GPIO driver
Message-ID: <1506480343-9597-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds UniPhier GPIO driver.

The interrupt controller part is implemented by using hierarchy irqdomain.

IMHO, the problem of the hierarchy irqdomain is that drivers must hard-code
the fwspec of the interrupt parent.  We will never know the DT binding of
the parent unless we parse #interrupt-cell, etc.

I asked about this:
https://lkml.org/lkml/2017/7/6/758

Apparently, the current kernel does not provide a systematic way to
describe it.

In v1-v3, I hard-coded the parent hwirq numbers in the driver because
irqchip drivers are forced to hard-code more or less about the parent.
This was not accepted by Linus Walleij.

In v4, I tried to use the new API irq_domain_push_irq().  I needed to
change the irqdomain framework to make it work for DT, but seemed
controversial in the irqdomain subsystem review.

In v5, I tried another solution.  At first I thought it worked, but
I found a dead-lock if an irq is disposed from the .alloc hook.

After I considered more, I thought "interrupts" property does not
make much sense here because the last cell (which usually specifies
the trigger type) is useless for the hierarchy irqdomain.

I decided to use a vendor-specific property.  This is what some drivers
actually do.


Changes in v7:
  - Rename uniphier_gpio_irq_get_hwirq()
    (I just missed to "git commit" before "git send-email")

Changes in v6:
  - Add "socionext,interrupt-ranges"

Changes in v5:
  - Split into a separate patch for DT binding
  - Add a new patch to export of_phandle_args_to_fwspec
  - Split DT binding into a separate file
  - v4 depends on some patches that change irq_domain_push_irq(), but
    they got negative feedback in the irqdomain subsystem review.
    Yet another approach here.  Parse "interrupts" property in
    .alloc() hook.  If the parent IRQ is already mapped, dispose it
    and re-alloc in irqdomain manner.

Changes in v4:
  - Add COMPILE_TEST and select IRQ_DOMAIN_HIERARCHY
  - Reimplement irqchip part by using irq_domain_push_irq()

Changes in v3:
  - Add .irq_set_affinity() hook
  - Use irq_domain_create_hierarchy() instead of legacy
    irq_domain_add_hierarchy()

Changes in v2:
  - Remove +32 offset for parent interrupts to follow the GIC
    binding convention
  - Let uniphier_gpio_irq_alloc() fail if nr_irqs != 1
  - Allocate gpio_chip statically because just one instance is
    supported
  - Fix suspend and resume hooks

Masahiro Yamada (2):
  dt-bindings: gpio: uniphier: add UniPhier GPIO binding
  gpio: uniphier: add UniPhier GPIO controller driver

 .../devicetree/bindings/gpio/gpio-uniphier.txt     |  40 ++
 MAINTAINERS                                        |   1 +
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-uniphier.c                       | 507 +++++++++++++++++++++
 include/dt-bindings/gpio/uniphier-gpio.h           |  18 +
 6 files changed, 575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 create mode 100644 drivers/gpio/gpio-uniphier.c
 create mode 100644 include/dt-bindings/gpio/uniphier-gpio.h

-- 
2.7.4
