From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 21 Jul 2013 18:49:40 +0200
Subject: [PATCH 1/3] misc: Add crossbar driver
In-Reply-To: <51E83A4F.5080904@ti.com>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com>
 <1374165830-6367-2-git-send-email-r.sricharan@ti.com>
 <51E83A4F.5080904@ti.com>
Message-ID: <CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 8:56 PM, Nishanth Menon <nm@ti.com> wrote:

> I carry forward my TI internal objection to this approach:

It is actually a very good sign of FOSS-maturity that you as a company
take unresolved architectural issues to the community. Kudos!

> Lets see what happens as a result of this:
>
> https://patchwork.kernel.org/patch/2825148/ (introducing DTS for DRA7)
> uart1 to uart6 is defined. while in fact 10 uarts exist on IP block.
> uart1: serial at 4806a000 {
> <snip>
> +                       interrupts = <0 72 0x4>;
> Assumes that GIC interrupt by default mapping used.

So introducing this inbetween the GIC lines and its actual device IRQ
lines inevitably means that the GIC three-cell concept is completely
ill-devised to handle this.

For routing IRQs, I think the proper solution would be to use a
cascaded struct irqchip, which in turn contains an irqdomain
translation to remux the signal onto the GIC inputs.

I.e. the interrupt-controller given to that serial would be the
crossbar irqchip, and that in turn will hog and allocate apropriate
lines from the gic to it would probably itself list *all* the IRQs
of the GIC as "its" IRQs.

We already have plenty of cascading irqchips such as GPIO
controller providing IRQs, just that they only multiplex on a
single GIC line instead of the whole lot.

Mock example:

                intc: interrupt-controller at 0 {
                        compatible = "arm,cortex-a9-gic";
                        #interrupt-cells = <3>;
                        #address-cells = <1>;
                        interrupt-controller;
                        reg = ...;
                };

                crossbar: crossbar at 0 {
                        compatible = "...";
                        interrupt-controller;
                        #interrupt-cells = <1>;
                        interrupt-parent = <&intc>;
                        interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
                                          <0 1 IRQ_TYPE_LEVEL_HIGH>,
                                          <0 2 IRQ_TYPE_LEVEL_HIGH>,
                                          ....
                                          <0 n IRQ_TYPE_LEVEL_HIGH>;
                };

                uart0: serial at 0 {
                        compatible = "...";
                        interrupt-parent = <&crossbar>;
                        interrupts = <1234>;
                 };

Maybe the interrupts provided from crossbar cannot even be
specified by a number, maybe a line name need to be used
or so. I don't know the particulars.

Whether this as a whole is a good idea, I don't know,
but you would have to go about it something like this.

What happens if there is no line to mux in a certain IRQ?

Yours,
Linus Walleij
