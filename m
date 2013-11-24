From: grant.likely@linaro.org (Grant Likely)
Date: Sun, 24 Nov 2013 21:27:57 +0000
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131123015034.GP10023@atomide.com>
References: <20131123004334.GJ10023@atomide.com> <20131123005509.GJ16735@
 n2100.arm.linux.org.uk> <20131123010850.GN10023@atomide.com> <
 20131123011515.GO10023@atomide.com> <20131123015034.GP10023@atomide.com>
Message-ID: <20131124212757.7D224C402A3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Nov 2013 17:50:35 -0800, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [131122 17:16]:
> > * Tony Lindgren <tony@atomide.com> [131122 17:09]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [131122 16:56]:
> > > > On Fri, Nov 22, 2013 at 04:43:35PM -0800, Tony Lindgren wrote:
> > > > > +		/* See of_device_resource_notify for populating interrupts */
> > > > > +		for (i = 0; i < num_irq; i++, res++) {
> > > > > +			res->flags = IORESOURCE_IRQ;
> > > > > +			res->start = -EPROBE_DEFER;
> > > > > +			res->end = -EPROBE_DEFER;
> > > > 
> > > > NAK.  Definitely a bad idea to start introducing magic values other into
> > > > resources.  Please don't do this.
> > > 
> > > Do you have any better ideas on how to sort out this issue then?
> > 
> > I guess we could allocate all the resources lazily here, I'll take a look
> > at that.
> 
> Here's a version that allocates the resources lazily with the notifier.
> Seems to boot, need to play with it a bit more though to make sure we're
> not overwriting resources for any legacy devices.

Blurg. Using a notifier really feels like we don't have a good handle on
a reasonable solution yet. Basically it means we're hooking into the
driver core without /looking/ like we're hooking into the driver core. I
don't think this is any better, but I don't have a better suggestion at
the moment.   :-(

g.
