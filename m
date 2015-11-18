From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 16:18:36 +0100
Subject: [PATCH] pinctrl: at91-pio4: use %pr format string for resource
In-Reply-To: <20151117133341.GG16931@odux.rfo.atmel.com>
References: <3726450.XyTgssZ1KT@wuerfel>
 <20151117133341.GG16931@odux.rfo.atmel.com>
Message-ID: <5158594.z9FlJvJfpz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 14:33:41 Ludovic Desroches wrote:
> Hi Arnd,
> 
> On Thu, Nov 12, 2015 at 03:15:38PM +0100, Arnd Bergmann wrote:
> > resource_size_t may be defined as 32 or 64 bit depending on configuration,
> > so it cannot be printed using the normal format strings, as gcc correctly
> > warns:
> > 
> > pinctrl-at91-pio4.c: In function 'atmel_pinctrl_probe':
> > pinctrl-at91-pio4.c:1003:41: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
> >    dev_dbg(dev, "bank %i: hwirq=%u\n", i, res->start);
> > 
> > This changes the format string to use the special "%pr" format
> > string that prints a resource, and changes the arguments so we
> > the resource structure directly. I'm also swapping out the arguments
> > to match the text in the format string.
> > 
> 
> I agree the format change but not swapping out the arguments. Why do you have
> the feeling they are not matching the text?
> 
> Few lines before you have:
> res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> atmel_pioctrl->irqs[i] = res->start;
> 
> Each bank has its own irq line this is what I want to print with hwirq.
> Of course it assumes that interrupts are declared in the right order.

Sorry, my mistake. You are completely right and I don't know how I concluded
it was wrong. It's possible I got confused by the 'hwirq' string and thought
it could not refer to the resource, which is a virtual irq number rather than
a hwirq.

Anyway, I'll submit a new version with this fixup folded in:

@@ -1000,7 +1000,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
                atmel_pioctrl->irqs[i] = res->start;
                irq_set_chained_handler(res->start, atmel_gpio_irq_handler);
                irq_set_handler_data(res->start, atmel_pioctrl);
-               dev_dbg(dev, "bank %pr: hwirq=%u\n", res, i);
+               dev_dbg(dev, "bank %i: irq=%pr\n", i, res);
        }
 
        atmel_pioctrl->irq_domain = irq_domain_add_linear(dev->of_node,

	Arnd
