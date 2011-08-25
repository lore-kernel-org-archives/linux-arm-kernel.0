From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2011 17:56:54 +0200
Subject: [PATCH v2 2/4] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <20110825082151.GB17748@S2100-06.ap.freescale.net>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<CAGsJ_4zA0yaRu3O+cwSKDCORBDr5EVtKSmSGEMxWj90=_+oiNg@mail.gmail.com>
	<20110825082151.GB17748@S2100-06.ap.freescale.net>
Message-ID: <201108251756.54254.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2011, Shawn Guo wrote:
> > > To me, it seems that the above code snippet can be as simply as the
> > > following.
> > >
> > >        np = of_find_compatible_node(NULL, NULL, "sirf,prima2-pwrc");
> > >        sirfsoc_pwrc_base = of_iomap(np, 0);
> > >        if (!sirfsoc_pwrc_base)
> > >                return -ENOMEM;
> > 
> > you might want to read earlier thread in v1. PWRC is not in memory space.
> > 
> Ah, just read.  Then you at least should be able to use
> of_property_read_u32().

I think of_get_address would be even more appropriate, but I could
be misreading that function.

> > >> +
> > >> +static int __init sirfsoc_memc_init(void)
> > >> +{
> > >> +     return platform_driver_register(&sirfsoc_memc_driver);
> > >> +}
> > >> +postcore_initcall(sirfsoc_memc_init);
> > >
> > > Doing the same thing - mapping address, why sirfsoc_pwrc_base uses
> > > a function, while sirfsoc_memc_base needs a platform_driver?  You
> > > will have more stuff about memc to add there?
> > 
> > memc is in memory space, actually simple_bus, then a platform device
> > has existed for it.
> > pwrc is now not compitable with simple_bus. it looks like not worth a
> > platform for the moment too.
> > 
> It seems a little complicated to register a platform_driver just for
> getting an address.  I'm not sure how hard Arnd is on this position.
> I'm going to send a patch to test it :)

I think it's a grey area. In general, I always recommend a device
driver unless the mapping is absolutely needed at boot time before
we bring up the driver subsystem.
This enforces an object-oriented mental model about the building
blocks: Everything you want to talk to has to export its own functions
and we can stack modules on top of other modules. Clearly there are
a few cases where this is not possible or only adds complexity without
any benefit, but I would like to see the model of having a device
driver for each device be the rule, with few exceptions.

One argument that I can accept for this specific case is that the
power management code has to be written in assembly and doesn't
really understand the device object model anyway, so we just end
up exporting the base address, which is not something that proper
drivers are doing. However, as soon as more functionality gets added
that uses the memc register space, my preference would increasingly
lean towards doing a device driver here.

	Arnd
