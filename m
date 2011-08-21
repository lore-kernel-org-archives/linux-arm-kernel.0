From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 21 Aug 2011 15:24:17 +0100
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <20110819142608.GB2800@pulham.picochip.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<20110819104816.GA5030@pulham.picochip.com>
	<CACRpkdZhg_1WM37uqT1PNmpUjWS_groWJmNnR4SBjqJ6LFQQWQ@mail.gmail.com>
	<20110819142608.GB2800@pulham.picochip.com>
Message-ID: <20110821142416.GA12272@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Aug 19, 2011 at 03:26:08PM +0100, Jamie Iles wrote:
> On Fri, Aug 19, 2011 at 04:04:54PM +0200, Linus Walleij wrote:
> > On Fri, Aug 19, 2011 at 12:48 PM, Jamie Iles <jamie@jamieiles.com> wrote:
[...]
> > But yes, there is an assumption that each pin controller will only
> > deal with one block of GPIO pins. So if I make it possible to support
> > several GPIO ranges for one pin controller, does that solve your problem?
> > 
> > Like this:
> > 
> > struct pinctrl_gpio_range {
> >     char *name;
> >     unsigned int base;
> >     unsigned int npins;
> > }
> > 
> > static unsigned int gpio_ranges[] = {
> >     {
> >         .name="chip1",
> >         .base = 0,
> >         .npins = 16,
> >     },
> >     {
> >         .name =" chip2",
> >         .base = 32,
> >         .npins = 16,
> >     },
> >     {
> >         .name = "chip3",
> >         .base = 64,
> >         .npins = 16,
> >     },
> > };
> > 
> > static struct pinctrl_desc foo_desc = {
> >         ...
> >         .gpio_ranges = gpio_ranges,
> >         .num_gpio_ranges = ARRAY_SIZE(gpio_ranges),
> > };
> > 
> > For three different 32-bit GPIO controllers muxed on
> > pins 0..31 using GPIO space pins from 0..95.
> > 
> > Then I pass the number of the instance down to the
> > driver in the gpio_request_enable() callback like
> > this:
> > 
> > int (*gpio_request_enable) (struct pinctrl_dev *pctldev,
> > 	    unsigned instance,
> > 	    unsigned offset);
> > 
> > Would this work?
> > 
> > This has a restriction: the GPIO space must be mapped in
> > continous ranges, as must the pin controller. Else we need
> > one entry per pin in the list above...

One more thing that I thought of is that for device tree, when the gpio 
controllers are registered, the base is typically dynamically assigned.  I 
suspect that this can be solved in the device tree binding for the controller 
that references the bindings of the pinctrl, but this would require 
registering the gpio_ranges at runtime (or at least the bases).

So perhaps if we had:

struct pinctrl_gpio_range {
    unsigned int pinctrl_base;
    struct gpio_chip *chip;
}

and then gpio_request_enable was:

int (*gpio_request_enable)(struct pinctrl_dev *pctldev,
			   struct gpio_chip *gc,
			   unsigned offset)

Then have pinctrl_register_gpio_chip()?

For the static devices case then we can require gc->base must match the 
pinctrl gpio base.  For the device tree case we could do some matching of 
device_nodes from the gpio_chip to the pinctrl definitions?

Jamie
