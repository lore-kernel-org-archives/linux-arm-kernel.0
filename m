From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 21 Sep 2011 10:59:37 +0100
Subject: DT vs ARM static mappings
In-Reply-To: <1316598109.4611.613.camel@hornet.cambridge.arm.com>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<4E78A546.9040604@gmail.com>
	<1316535403.4611.534.camel@hornet.cambridge.arm.com>
	<201109202128.55517.arnd@arndb.de>
	<1316598109.4611.613.camel@hornet.cambridge.arm.com>
Message-ID: <20110921095926.GA2041@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 10:41:49AM +0100, Pawel Moll wrote:
> > > 2. Single DT_MACHINE_START matching (the most generic) "arm,vexpress"
> > > and doing (rougly) this in v2m_map_io:
> > > 
> > > of_scan_flat_dt(v2m_dt_iotable_init, NULL);
> > > 
> > > v2m_dt_iotable_init(...)
> > > {
> > > 	if (depth != 0)
> > > 		return 0;
> > > 	if (of_flat_dt_is_compatible(node, "arm,vexpress-legacy"))
> > > 		iotable_init(v2m_io_desc_legacy);
> > > 	else (of_flat_dt_is_compatible(node, "arm,vexpress-rs1"))
> > > 		iotable_init(v2m_io_desc_rs1);
> > > 	else
> > > 		panic();
> > > }
> > > 
> > > Neither of them seem particularly appealing... ;-)
> > 
> > But I think both ways would be acceptable in the end. It's not a lot
> > of extra code either way. In the second case, I would probably have
> > the legacy case as a special variant of the map_io function and have
> > all others be the default instead of falling back to panic though.
> 
> Ok, I'll go (roughly) that way.
> 
> > > In my case it's sysreg and sysctl. There are two more users of static
> > > mappings: timer01 and timer23, but they could at some point do ioremap()
> > > on their own (especially with Nico's changes).
> > 
> > Well, I think with Nico's cahnges, you /can/ actually do ioremap for
> > areas that have been mapped through the iotable before kmalloc is up.
> > IIRC, omap does this for a number of peripherals.
> > 
> > It's a bit of a hack, but I think it's much better than taking hardcoded
> > addresses.
> 
> Yes, I was thinking about that last night. If you think it's acceptable
> I'll do this (killing MMIO_P2V on the way ;-)
> 
> > With the combination of the points mentioned above, you should be
> > able to do:
> > 
> > - map the entire I/O area in map_io(), depending on the board
> > - have an __iomem pointer for the sysreg
> > - populate that pointer using of_iomap from the device tree address
> >   before you first access it.
> > 
> > Do you think that would work?
> 
> Yes, I suppose so. The last bit (getting the offset from DT) will be a
> little ugly, I think, but let's wait till I get some code done.

I won't attempt to modify the rest of the patch yet, but we can roll
changes in when you've decided on a way forward.

Alternatively, the requisite changes can be done as patches on top of
the basic patch -- since the initial patch doesn't attempt to support
multiple core tiles anyway.

Cheers
---Dave
