From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 17 Aug 2011 23:36:38 -0700
Subject: [RFC PATCH v2 06/13] docs/dt: Document nvidia,tegra20-pinmux
	binding
In-Reply-To: <201108171337.26166.arnd@arndb.de>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108161551.31389.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA2537D@HQMAIL01.nvidia.com>
	<201108171337.26166.arnd@arndb.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AF6F3063@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote at Wednesday, August 17, 2011 5:37 AM:
...
> > > > +Each mux pin group is represented as a sub-node of the nvidia,mux-groups node.
> > > > +The name of the sub-node should be the name of the mux pingroup. The following
> > > > +names are valid:
> > > > +
> > > > +	ata
> > > > +	atb
> > > > +	atc
> > > > +	atd
> > > > +	ate
> > > > +	cdev1
> > > > +	cdev2
> > > > ...
> > >
> > > I noticed that each board you define has a complete list of these. Would
> > > it be possible to move a generic list into a tegra20-pinmux.dtsi file and
> > > just override the pins in the per-board .dts file that require some special
> > > setup?
> >
> > I'm not sure how much commonality there will really be.
> >
> > Certainly, many boards are based off our reference designs and so will
> > have many similarities that could be shared.
> >
> > That said, comparing even tegra-harmony.dts and tegra-seaboard.dts shows
> > a lot of differences. It seems a lot less error-prone to just completely
> > describe the entire pinmux state in each board's .dts file, rather than
> > trying to represent half the information as default in the SoC .dtsi file,
> > and just the diff in the board .dts file. I suppose perhaps if we put the
> > hardware's own default settings in tegra20.dtsi, that'd make sense, since
> > people are presumably reasonably aware of the delta relative to that.
> >
> > We'd need to add new properties to override defaults, like:
> >
> > nvidia,tristate --> nvidia,drive
> > nvidia,pull-*   --> nvidia,no-pull
> 
> The split I had in mind is more to the effect that the .dtsi file
> describes the set of pins that is there with their names and addresses,
> while the board specific file describes how they are set up. Does that
> make sense? I think I'm still missing some essential aspect of what the
> pinmux code actually does ;-)
> 
> I now saw that you have the full description in the
> arch/arm/mach-tegra/pinmux-t2-tables.c and arch/arm/mach-tegra/pinmux.c
> files, with all the names again, and apparently your patch set leaves
> these around. Do you think it's possible to actually move the static
> tables from there into the device tree and do the entire setup based
> on that?

Ah, so you're looking for tegra20.dtsi to define the set pin groups that
can be configured, and tegra-harmony.dts to provide the configuration for
each of those pingroups.

As you see from my patches, I had assumed that the Tegra pinmux driver
would be what ended up defining the available pin groups, the register
addresses and fields for those groups, just like it does today. The DT
would only provide the configuration for each group. That's the reason
I didn't understand your questions the first time around.

So yes, I think we could represent the set of available pin groups in
tegra20.dtsi; it's just some data tables. I don't think this provides as
much benefit as moving the per-board configuration data into DT though,
because it changes only per SoC generation, not per board.

Still, putting the list of pingroups in tegra20.dtsi does move that data
out of the kernel, although it bloats each DTB with almost static data
that'll take a bunch of time to parse. It's worth considering though.

I'm unclear how to resolve where the best location for the data is though;
should we just go ahead and move it from the pinmux driver to DT right now,
or discuss more or ...?

-- 
nvpublic
