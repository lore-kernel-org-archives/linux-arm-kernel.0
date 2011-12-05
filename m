From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 5 Dec 2011 09:19:00 -0800
Subject: [PATCH 2/2] gpio/tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <20111205065527.GD2980@S2100-06.ap.freescale.net>
References: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
 <1322700336-26866-2-git-send-email-swarren@nvidia.com>
 <20111205065527.GD2980@S2100-06.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B7702E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote at Sunday, December 04, 2011 11:55 PM:
> On Wed, Nov 30, 2011 at 05:45:36PM -0700, Stephen Warren wrote:
> [...]
> >  static void tegra_gpio_irq_ack(struct irq_data *d)
> >  {
> > -	int gpio = d->irq - INT_GPIO_BASE;
> > +	int gpio = d->hwirq;
> >
> Though it's working right now, I'm not sure it's safe enough.  This
> only works when d->hwirq_base is 0, which is true for now.  But I doubt
> it will be always true.  I guess hwirq_base was introduced there for
> some reason.  When some day irqdomain starts using this field, the
> above code starts being broken.  IMO, the way that generic-chip.c is
> using to calculate the number, d->irq - gc->irq_base, is much more
> safer.

If I'm understanding IRQ domains correctly, the hwirq_base value is
picked by the driver when registering the IRQ domain. Hence, there's
no way for hwirq_base to not be zero without someone editing gpio-tegra.c,
and as part of doing that, the quoted code could be adjusted if required.
Does that seem reasonable?

Rob, you suggested the code above - what's your take?

-- 
nvpublic
