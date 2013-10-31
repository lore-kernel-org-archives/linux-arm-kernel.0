From: r.sricharan@ti.com (R, Sricharan)
Date: Thu, 31 Oct 2013 10:50:04 +0000
Subject: [PATCH V2 1/7] DRIVERS: IRQCHIP: IRQ-GIC: Add support for
 routable irqs
In-Reply-To: <alpine.DEB.2.02.1310301608380.24686@ionos.tec.linutronix.de>
References: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
 <1383145040-15852-2-git-send-email-r.sricharan@ti.com>,
 <alpine.DEB.2.02.1310301608380.24686@ionos.tec.linutronix.de>
Message-ID: <F934AE11CE617240AE4A874A49F629E4832564@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
  Sorry for top posting. My mailer is not allowing me any formatting.

  I agree with both of your comments below.
  I will post V3 for this.

Regards,
 Sricharan

________________________________________
From: Thomas Gleixner [tglx at linutronix.de]
Sent: Wednesday, October 30, 2013 8:45 PM
To: R, Sricharan
Cc: linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-doc at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; linus.walleij at linaro.org; linux at arm.linux.org.uk; tony at atomide.com; Nayak, Rajendra; marc.zyngier at arm.com; grant.likely at linaro.org; mark.rutland at arm.com; robherring2 at gmail.com; Shilimkar, Santosh; Rob Herring
Subject: Re: [PATCH V2 1/7] DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable irqs

On Wed, 30 Oct 2013, Sricharan R wrote:
> @@ -700,11 +709,22 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
>       *out_hwirq = intspec[1] + 16;
>
>       /* For SPIs, we need to add 16 more to get the GIC irq ID number */
> -     if (!intspec[0])
> +     if (!intspec[0]) {
>               *out_hwirq += 16;

Minor nit. This should be in the default implementation. The crossbar
implementation will fill out_hwirq in its own way and is not
interested in the +16 operation at all.

> +             ret = gic_routable_irq_domain_ops->xlate(d, controller,
> +                                                      intspec,
> +                                                      intsize,
> +                                                      out_hwirq,
> +                                                      out_type);
> +

> +             gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
> +                                     hwirq_base, &gic_irq_domain_ops, gic);
> +     } else {
> +             if (WARN_ON(!gic_routable_irq_domain_ops))
> +                     return;

This warning is pointless, because you have default ops now.

> +
> +             gic->domain = irq_domain_add_linear(node, nr_routable_irqs,
> +                                                 &gic_irq_domain_ops,
> +                                                 gic);
>       }

Thanks,

        tglx
