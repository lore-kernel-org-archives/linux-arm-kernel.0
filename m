From: linux@prisktech.co.nz (linux at prisktech.co.nz)
Date: Wed, 10 Oct 2012 12:26:20 +1300 (NZDT)
Subject: IRQ code inconsistencies across platforms
Message-ID: <53814.210.54.1.170.1349825180.squirrel@server.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In arch/arm/common.gic.c:

static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
urq_hw_number_t hw)
{
...
  irq_set_chip_and_handler(irq, &gic_chip, handle_fasteoi_irq);
  set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
}

but in arch/arm/mach-pxa/irq.c:

static int pxa_irq_map(struct irq_domain *d, unsigned int virq, urq_hw_number_t hw)
{
...
  irq_set_chip_and_handler(hw, &pxa_internal_irq_chip, handle_level_irq);
  set_irq_flags(hw, IRQF_VALID);
}

Is it correct to use irq/virq or hw for irq_set_chip_and_handler/set_irq_flags?

Both platforms are adding legacy domains, so while they both presumably work,
one is slightly incorrect.

Regards
Tony P
