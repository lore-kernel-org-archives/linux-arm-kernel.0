From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 13 Sep 2017 17:56:27 +0900
Subject: [PATCH v5 0/3] gpio: uniphier: UniPhier GPIO driver
Message-ID: <1505292990-22957-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds UniPhier GPIO driver.

The interrupt controller part is implemented by using hierarchy irqdomain.

My problem is mapping of IRQ from this controller to the parent
irqchip is not contiguous.

  IRQ line of GPIO  --->  Parent interrupt
        0           --->     48
        1           --->     49
                ...
        15          --->     63
        16          --->    154
        17          --->    155
                ...
        20          --->    158
        21          --->    217
        22          --->    218
                ...

At first, I tried to hard-code parent irq numbers because it easily avoids
the statically allocated IRQ resource problem.
(https://lkml.org/lkml/2017/7/6/758)
But, hard-coding interrupts made Linus Walleij unhappy.

In v4, I tried to use the new API irq_domain_push_irq().
I needed to change it to make it work for DT, but seems controversial
in the irqdomain subsystem review.

In v5, I came up with another solution.  The idea is simple.
.alloc() hook can call of_irq_parse_one() to retrieve the irq information
from DT property.
If virq is already allocated, we can simply dispose it and re-alloc it
in hierarchy domain manner.


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

Masahiro Yamada (3):
  irqdomain: export of_phandle_args_to_fwspec
  dt-bindings: gpio: uniphier: add UniPhier GPIO binding
  gpio: uniphier: add UniPhier GPIO controller driver

 .../devicetree/bindings/gpio/gpio-uniphier.txt     |  43 ++
 MAINTAINERS                                        |   1 +
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-uniphier.c                       | 504 +++++++++++++++++++++
 include/dt-bindings/gpio/uniphier-gpio.h           |  18 +
 include/linux/irqdomain.h                          |   2 +
 kernel/irq/irqdomain.c                             |   5 +-
 8 files changed, 580 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 create mode 100644 drivers/gpio/gpio-uniphier.c
 create mode 100644 include/dt-bindings/gpio/uniphier-gpio.h

-- 
2.7.4
