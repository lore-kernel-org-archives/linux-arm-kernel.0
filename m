From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 25 Oct 2016 15:08:20 +0200
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <ec7c6cc5-cf9a-9c75-4b07-e337064c7d6e@arm.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
 <1477040798.15560.96.camel@baylibre.com>
 <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
 <ec7c6cc5-cf9a-9c75-4b07-e337064c7d6e@arm.com>
Message-ID: <1477400900.2482.51.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-10-25 at 11:38 +0100, Marc Zyngier wrote:
> > 
> On 25/10/16 10:14, Linus Walleij wrote:
> > 
> > On Fri, Oct 21, 2016 at 11:06 AM, Jerome Brunet <jbrunet@baylibre.c
> > om> wrote:
> > 
> > > 
> > > > 
> > > > Isn't this usecase (also as described in the cover letter) a
> > > > textbook
> > > > example of when you should be using hierarchical irqdomain?
> > > > 
> > > > Please check with Marc et al on hierarchical irqdomains.
> > > 
> > > Linus,
> > > Do you mean I should create a new hierarchical irqdomains in each
> > > of
> > > the two pinctrl instances we have in these SoC, these domains
> > > being
> > > stacked on the one I just added for controller in irqchip ?
> > > 
> > > I did not understand this is what you meant when I asked you the
> > > question at ELCE.
> > 
> > Honestly, I do not understand when and where to properly use
> > hierarchical irqdomain, even after Marc's talk at ELC-E.
> 
> I probably didn't do that good a job explaining it then. Let's try
> again. You want to use hierarchical domains when you want to describe
> an
> interrupt whose path traverses multiple controllers without ever
> being
> multiplexed with other signals. As long as you have this 1:1
> relationship between controllers, you can use them.
> 

Linus, Marc,

The calculation is question here is meant to get the appropriate hwirq
number from a particular gpio (and deal with the gpios that can't
provide an irq at all).?

If I look at other gpio drivers, many are doing exactly this kind of
calculation before calling 'irq_create_mapping' in the to_irq callback.
For example:
- pinctrl/nomadik/pinctrl-abx500.c
- pinctrl/samsung/pinctrl-exynos5440.c

Some can afford to create all the mappings in the probe and just call
'irq_find_mapping' (gpio/gpio_tegra.c) but this would not work here. We
have only 8 upstream irqs for 130+ pins, so only 8 mappings possible at
a time.?

My understanding is that irqdomain provide a way to map hwirq to linux
virq (and back), not map gpio number to hwirq, right?

Even if I implement an another irqdomain at the gpio level, I would
still have to perform this kind of calculation, one way or the other.

> > Which is problematic since quite a few GPIO drivers now
> > need to use them.
> > 
> > I will review his slides, in the meantime I would say: whatever
> > Marc ACKs is fine with me. I trust this guy 100%. So I guess I
> > could ask that he ACK the entire chain of patches
> > from GIC->specialchip->GPIO.

Actually this discussion go me thinking about another issue we have
with this hardware.
We are looking for a way to implement support for IRQ_TYPE_EDGE_BOTH
(needed for things like gpio-keys or mmc card detect).?
The controller can do each edge but not both at the same time.
I'm thinking that implementing another irqdomain at the gpio level
would allow to properly check the pad level in the EOI callback then
set the next expected edge type accordingly (using
'irq_chip_set_type_parent')

Would it be acceptable ?

It looks a few other drivers deal with IRQ_TYPE_EDGE_BOTH in a similar
way (gpio/gpio-omap.c, gpio/gpio-dwapb.c)

> Man, I don't even trust myself... ;-)
> 
> Thanks,
> 
> 	M.

Thx
Regards

Jerome
