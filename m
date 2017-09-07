From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  7 Sep 2017 20:41:56 +0900
Subject: [PATCH v4 0/6] irqdomain,
 gpio: expand irq_domain_push_irq() for DT use and use it for GPIO
Message-ID: <1504784522-26841-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds a GPIO controller for UniPhier SoC family.
It also works as an irqchip in hierarchy domain manner.

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

So, I need to have an array of parent hwirqs somehow.

Probably, most of people will try to use "interrupts" DT property,
but I noticed a potential problem for hierarchy IRQ domain.
If "interrupts" property exists in the device node, IRQ resource
may be statically allocated when platform devices are populated
from DT.  I asked this question some time ago:
https://lkml.org/lkml/2017/7/6/758

After I tackled this, I decided to put the array in the driver,
but I could not get a positive response for this.
The discussion mostly happened in v1 thread:
http://patchwork.ozlabs.org/patch/797145/

Recently, the new API irq_domain_push_irq() was merged in the
mainline.  I thought this might be useful to solve the hierarchy
domain issue.  Hence, here is a trial.

I found patch 2 is needed to avoid "type mismatch" error.

One more thing, I am worried about a race condition.

I think there is a possibility where a device tries to get IRQ
after irq_domain_create_hierarchy(), but before irq_domain_push_irq().

	priv->domain = irq_domain_create_hierarchy(...)
	if (!priv->domain)
		return -ENOMEM;

        [  *** What if a irq consumer device request the irq here? *** ]

	for (i = 0; i < nirqs; i++) {
		virq = platform_get_irq(pdev, i);
		if (virq < 0)
			continue;

		ret = irq_domain_push_irq(priv->domain, virq, (void *)(long)i);
		if (ret)
			return ret;
	}

By the time irq_domain_create_hierarchy() finished,
the irqdomain will be added to the "irq_domain_list".

If a device calls platform_get_irq(),
the domain is registered, but virq is not allocated yet.

So, irq_create_fwspec_mapping() will call irq_domain_alloc_irqs(),
then irqchip's .alloc() hook is invoked with fwspec passed as arg.

I tried to fix this by patch 3 and 4.

This topic is related to both irqdomain and GPIO,
so includes them in a series.

Comments are appreciated.

I am not sure if my approach is correct.
If I am doing wrong, I will go back to the previous adhoc solution.



Masahiro Yamada (6):
  irqdomain: rename variables in irq_domain_{push,pop}_irq()
  irqdomain: clear trigger type in irq_domain_push_irq()
  irqdomain: move IRQ_DOMAIN_NAME_ALLOCATED define to the original
    position
  irqdomain: set irq domain flags before the irq domain becomes visible
  irqdomain: add IRQ_DOMAIN_FLAG_NO_CREATE flag
  gpio: uniphier: add UniPhier GPIO controller driver

 .../devicetree/bindings/gpio/gpio-uniphier.txt     |  43 ++
 MAINTAINERS                                        |   1 +
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-uniphier.c                       | 486 +++++++++++++++++++++
 include/dt-bindings/gpio/uniphier-gpio.h           |  18 +
 include/linux/irqdomain.h                          |  22 +-
 kernel/irq/irqdomain.c                             |  93 ++--
 8 files changed, 619 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 create mode 100644 drivers/gpio/gpio-uniphier.c
 create mode 100644 include/dt-bindings/gpio/uniphier-gpio.h

-- 
2.7.4
