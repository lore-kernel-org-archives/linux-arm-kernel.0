From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 12:23:15 -0500
Subject: [RFC] interrupts DT property for irqdomain hierarchy
In-Reply-To: <CAK7LNATme8P1uHx5hZr6Eez4KGweUi=jQ6zJ=bdBf1XmxZVoLg@mail.gmail.com>
References: <CAK7LNATme8P1uHx5hZr6Eez4KGweUi=jQ6zJ=bdBf1XmxZVoLg@mail.gmail.com>
Message-ID: <CAL_JsqLC2kUvhHHJdKd_UinvgRHpSv+vsPgRh0xGowfDX5BXYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 6, 2017 at 4:58 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi IRQ experts, DT exports,
>
>
> I have a question about CONFIG_IRQ_DOMAIN_HIERARCHY.
>
> When IRQ domains are hierarchy,
> how can we specify IRQ number re-mapping between the
> parent irqchip and the child irqchip?
>
> The following figure shows a simplified example.
>
> |----------|        |----------|       |----------|
> | parent   |        | child    |       |  IRQ     |
> | IRQ chip | <----- | IRQ chip |<----- | consumer |
> |          |        |          |       | Device   |
> |----------|        |----------|       |----------|
>
> Perhaps, we may describe DT like follows
>
>     gic: interrupt-controller {
>             ...
>             interrupt-controller;
>             #interrupt-cells = <3>;
>     };
>
>     child_intc: child-interrupt-controller {
>             ...
>             interrupt-parent = <&gic>;
>             interrupts = <0 50 0>, <0 51 0>, <0 52 0>, <0 53 0>;
>             interrupt-controller;
>             #interrupt-cells = <2>;
>     };
>
>     i2c: i2c {
>             ...
>             interrupt-parent = <&child_intc>;
>             interrupts = <0 4>;
>     };
>
>
> In this example, the I2C controller takes HWIRQ=0 of the child_intc device.
> This goes through the child IRQ chip,
> then connected to HWIRQ=50 of the parent intc.
>
> The DT above describes the hardware connection well,
> but it actually does not work.
>
> The root irqchip is usually declared with IRQCHIP_DECLARE().
> So, IRQ resources are allocated when platform devices are populated from DT.
> This means IRQ allocation happens before drivers are probed.
>
> of_pupulate_default_populate() does not know the fact about irqdomain hierarchy.

This has not been true for some time now. The irqs are resolved at
probe time rather than statically created resources and deferred probe
is supported if one of the interrupt controllers is not yet
initialized.

>
> As a result, interrupts = <0 50 0> in the child_intc,
> and interrupts = <0 4> of the I2C are allocated with different virtual
> IRQ numbers.
>
> We want to assign the same IRQ number if we want handle them
> in the hierarchy IRQ manner.
>
> How can we make it work?
>
> Of course, we can remove the
>           interrupts = <0 50 0>, <0 51 0>, <0 52 0>, <0 53 0>;
> from the child_intc device node.
>
> But, we can not retrieve the IRQ remapping information from DT.
>
>
> I saw some irqchip implementations and .alloc hook are often
> hard-coded in the case.
>
>
> For example, like this.
>
> static int child_intc_domain_alloc(struct irq_domain *domain,
>                           unsigned int virq, unsigned int nr_irqs, void *arg)
> {
>         ....
>
>         for (i = 0; i < nr_irqs; i++) {
>                 struct irq_fwspec parent_fwspec;
>
>                 ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>                                                     &priv->chip, priv);
>                 if (ret)
>                         return ret;
>
>                 /* CAUTION: parent irqchip must be GIC. */
>
>                 parent_fwspec.fwnode = domain->parent->fwnode;
>                 parent_fwspec.param_count = 3;  /*GIC: #interrupt-cells = <3> */
>                 parent_fwspec.param[0] = 0;   /* SPI of GIC */
>                 /* HWIRQ=0 of this chip corresponds to HWIRQ=50 of the parent */
>                 parent_fwspec.param[1] = hwirq + 50;
>                 parent_fwspec.param[2] = type;
>
>                 ret = irq_domain_alloc_irqs_parent(domain, virq, 1,
>                                                    &parent_fwspec);
>                 if (ret)
>                         return ret;
>
>                 virq++;
>                 hwirq++;
>         }
>
>         return 0;
> }
>
>
>
> In order to avoid hard-coding, one possible idea is
> to retrieve the IRQ information from DT, like this:
>
>         for (i = 0; i < nr_irqs; i++) {
>                 struct of_phandle_args parent_irq;
>                 struct irq_fwspec parent_fwspec;
>
>                 ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>                                                    &priv->chip, priv);
>                 if (ret)
>                         return ret;
>
>                 /* retrieve interrupt spec from DT */
>                 ret = of_irq_parse_one(irq_domain_get_of_node(domain), hwirq,
>                                        &parent_irq);
>                 if (ret)
>                         return ret;
>
>                 of_phandle_args_to_fwspec(&parent_irq, &parent_fwspec);
>
>                 ret = irq_domain_alloc_irqs_parent(domain, virq, 1,
>                                                   &parent_fwspec);
>                 if (ret)
>                         return ret;
>
>                 virq++;
>                 hwirq++;
>         }
>
>
>
> Some possible solutions:
>
> [1] stop early irq allocation and make it completely on-the-fly
> i.e. IRQ are allocated only when drivers explicitly call of_irq_get()
> or friends.
>
> This does not address one problem.
>
> If there are many IRQ lines connected between the parent and the child,
> interrupts will be very long.
>
>    #interrupts = <0 50 0>, <0 51 0>, <0 52 0>, <0 53 0>,
>                  <0 54 0>, <0 55 0>, <0 56 0>, <0 57 0>,
>                   ...
>
> This is a mess.
>
>
>
>
> [2] Introduce DT property something like "interrupt-range"
>
> The idea is similar like "ranges" property transforms "reg".
>
> "interrupt-range" is an arbitrary number of
> (child irqchip interrupt) (parent irqchip interrupt) (length) triplets.
>
> For example,
>
>    interrupt-ranges = <0 0 0 50 0 4>;
>
> This means   <0 0>, <0 1>, <0 2>, <0 3> in the child
> should be mapped to  <0 50 0>, <0 51 0>, <0 52 0>, <0 53 0> in the parent,
> respectively.

interrupt-map property does this. See here[1].

Rob

[1] http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
