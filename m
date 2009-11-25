From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2009 17:06:25 +0000
Subject: [PATCH 01/17] ARM: pxa/raumfeld: add basic structure for devices
In-Reply-To: <200911251751.40666.marek.vasut@gmail.com>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-2-git-send-email-daniel@caiaq.de>
	<4B0D4CA8.4020107@compulab.co.il>
	<200911251751.40666.marek.vasut@gmail.com>
Message-ID: <20091125170625.GG5136@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 05:51:40PM +0100, Marek Vasut wrote:
> Dne St 25. listopadu 2009 16:26:32 Mike Rapoport napsal(a):
> > Daniel,
> > Below are my comments to the patches. Some of the comments apply to several
> > patches, but I'm too lazy to copy them into relevant threads :)
> > 
> > Daniel Mack wrote:
> > > +static void __init raumfeld_common_init(void)
> > > +{
> > > +	enable_irq_wake(IRQ_WAKEUP0);
> > > +	pxa_set_ffuart_info(NULL);
> > > +
> > > +	gpio_request(mfp_to_gpio(GPIO_W2W_RESET), "Wi2Wi reset");
> > 
> > gpio_request may fail, thought it's unlikely to happen. Anyway, adding
> >  check for it's return value seems to be a good practice.
> 
> Well if the gpio_request fails here, you are doomed anyway. There's nowhere
> to return to. But it's a good idea to fail and don't try to request other
> GPIOs.

Not entirely true.  If a gpio request fails because somehow it was claimed
by something else, that doesn't mean other stuff will also fail.  Also,
don't think that if a gpio_request in such a function fails you have to
exit from it.

A good idea is to do this:

	ret = gpio_request(gpio, name);
	if (ret)
		printk(KERN_ERR "Myplatform: gpio%u(%s) request failed: %d\n",
			gpio, name, ret);

Even better:

static void claim_gpio_output(int gpio, const char *name, int value)
{
	int ret = gpio_request(gpio, name);
	if (ret) {
		printk(KERN_ERR "Myplatform: gpio%u(%s) request failed: %d\n",
			gpio, name, ret);
	} else {
		gpio_direction_output(gpio, value);
	}
}

and then you're not duplicating the multiple gpio calls.
