From: carlo@caione.org (Carlo Caione)
Date: Wed, 29 Jun 2016 16:07:00 +0200
Subject: [PATCH 0/2] pinctrl: Enable support for external GPIO interrupts
In-Reply-To: <CACRpkdZivUN8HKZ7oTDW6C35vSMv6+9G6-8M7=-kJM3B9vmH-A@mail.gmail.com>
References: <5772301F.3030904@baylibre.com>
 <CACRpkdZivUN8HKZ7oTDW6C35vSMv6+9G6-8M7=-kJM3B9vmH-A@mail.gmail.com>
Message-ID: <20160629140700.GA21287@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/16 10:53, Linus Walleij wrote:
> On Tue, Jun 28, 2016 at 10:06 AM, Neil Armstrong
> <narmstrong@baylibre.com> wrote:
> 
> > I have another implementation idea about this subject, by using static GPIO-irq
> > association in DT instead of using a very complex dynamic allocation.
> >
> > The idea is to add a simple property :
> > irqs-gpios = <>
> >
> > To map a GPIO to the irqs, then we can either use the DT irq mapping or use the
> > gpiolib to_irq() if the gpio is in the table.
> >
> > The relative drawback is that we will need DT changes to enable routing of a gpio
> > to an IRQ, but the complete system is based on a DT description anyway.
> >
> > In this case, we could use gpiochip_irqchip.
> >
> > Do you think this structure would be acceptable ?

I put some thoughts on this.

Having to statically define the IRQ-GPIO relation in the DT is not the
most elegant solution but this is a really stupid controller and the
whole cascade IRQ controller story revealed to be really a PITA with
this hw when I was trying to write the driver. 

On a side note the driver was working fine but the real problem was on
some misunderstanding on the gpiolib .to_irq hook. My bad in having lost
interest in fixing / clarifying that mess, sorry for that.

The latest respin was https://patchwork.kernel.org/patch/7738781/. Neil,
probably you want also to review that (also privately since after 1 year
I guess it needs to be updated) before someone starts writing the code
for the DT-only solution?

> That depends on:
> 
> - A nod from the DT maintainers that this is acceptable from a HW description
>   point of view and a simplification that probably all other OS:es
> will also want
>   to do.

hardware wise this makes sense at board level and to the best of my
knowledge we are the only one OS using this DT.

> - Rough consensus from the maintainess of the platform that this makes
>   sense, do noone appear three months down the road and says "oh wait I
>   have this usecase that require us to do this dynamically".

this is the real problem I see especially in case someone comes up with
some homemade driver for some expansion board hooked up on the headers.

> I think the dynamic solution is always more elegant, computers should resolve
> complex problems, doing it in DT makes a human do a machine's work which
> is as a rule of thumb not a good idea. But there is also the question
> of maintenance
> cost and what makes sense at a human level so I'm not totally
> inflexible on this.

Totally agree on this.

-- 
Carlo Caione
