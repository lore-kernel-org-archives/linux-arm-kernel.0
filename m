From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 19 Dec 2011 00:44:31 +0000
Subject: [PATCH 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <CACRpkdYu7HCBdAzqNr1pwZMgvZFyBYpcJXYo-RUx5R-U3CJ1BA@mail.gmail.com>
References: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
 <CACRpkdYu7HCBdAzqNr1pwZMgvZFyBYpcJXYo-RUx5R-U3CJ1BA@mail.gmail.com>
Message-ID: <20111219004431.GE2376@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Dec 18, 2011 at 11:01:38PM +0100, Linus Walleij wrote:
> On Sun, Dec 18, 2011 at 11:13 AM, Jamie Iles <jamie@jamieiles.com> wrote:
> 
> > The Synopsys DesignWare block is used in some ARM devices (picoxcell)
> > and can be configured to provide multiple banks of GPIO pins. ?The first
> > bank (A) can also provide IRQ capabilities.
> 
> Overall this is looking good.
> 
> Here is a problem (I think):
> 
> > +static int dwapb_irq_set_type(struct irq_data *d, u32 type)
> > +{
> > + ? ? ? struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> > + ? ? ? struct dwapb_gpio *gpio = gc->private;
> > + ? ? ? int bit = d->hwirq;
> > + ? ? ? unsigned long level, polarity;
> > +
> > + ? ? ? if (type & ~(IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING |
> > + ? ? ? ? ? ? ? ? ? ?IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> > + ? ? ? ? ? ? ? return -EINVAL;
> > +
> > + ? ? ? level = readl(gpio->regs + INT_TYPE_REG_OFFS);
> > + ? ? ? polarity = readl(gpio->regs + INT_POLARITY_REG_OFFS);
> > +
> > + ? ? ? if (type & IRQ_TYPE_EDGE_RISING) {
> > + ? ? ? ? ? ? ? level |= (1 << bit);
> > + ? ? ? ? ? ? ? polarity |= (1 << bit);
> > + ? ? ? } else if (type & IRQ_TYPE_EDGE_FALLING) {
> > + ? ? ? ? ? ? ? level |= (1 << bit);
> > + ? ? ? ? ? ? ? polarity &= ~(1 << bit);
> 
> So what if you get request for *both* falling and rising edges?
> 
> This is not uncommon at all, for example a GPIO which detecs
> MMC card insertions and removals like drivers/host/mmc/mmci.c
> will want interrupts on both edges since we want to change state
> whenever the card is inserted *or* removed.
> 
> If you check drivers/gpio/gpio-u300.c you can see how I handled
> this on another hardware where triggering on falling and rising
> edges was a binary choice and thus mutually exclusive: I toggle
> for each interrupt.
> 
> See u300_toggle_trigger(), u300_gpio_irq_type().
> 
> So either you do something like that, or you detect both set
> and return an error, else the poor caller will just get falling
> edges in this driver...

Hmm, I hadn't thought of that.  I've had a quick once-over your u300 
gpio driver and that looks pretty neat.  I'll give that a go over the 
next day or two and repost.

Thanks for the pointer!

Jamie
