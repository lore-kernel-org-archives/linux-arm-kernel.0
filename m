From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 12:43:13 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120508153155.GW15893@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205081444.30915.arnd@arndb.de>
 <20120508153155.GW15893@opensource.wolfsonmicro.com>
Message-ID: <201205091243.13206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Mark Brown wrote:
> On Tue, May 08, 2012 at 02:44:30PM +0000, Arnd Bergmann wrote:
> 
> > How about a IORESOURCE_REGMAP type then with the following semantics:
> 
> The trick is allocating a bit for that flag, though I was thinking
> earlier on we might be able to get away with carving it out of the bus
> specific bits since I think anything using this wouldn't normally be
> using resources for anything else except interrupts.  It does mean that
> the resource type doesn't do the right thing though.

Right, or we could try to kill IORESOURCE_BUS, which is hardly used
anywhere and the users either get it wrong (bfin net2272), use it
only in one file (acpi, broadcom-pci) or only for printing the
contents (pnp).

> > Each struct regmap gets an embedded resource that gets a unique
> > range in the IORESOURCE_REGMAP space using allocate_resource,
> > and each device using that can have its own sub-resources registered
> > to that.
> 
> > Then we add a helper function that pulls out the regmap from the resource
> > using something like container_of(res->parent, struct regmap, resource)
> > and calculates the register number by subtracting the parent->start from
> > res->start.
> 
> That feels complicated with the subtraction there, but modulo that this
> is roughly what's happening now.  We would I think want this to work for
> non-regmap users too, it's not yet clear that every device with
> registers is going to fit into regmap (though it's looking more likely
> as things go on).

I think the subtraction in some form is needed if you want to register
the resources, to guarantee that they are non-conflicting. Registering
them has the advantage that we can print them in a similar way to what
we do for /proc/{ioports,iomem}.

	Arnd
