From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 19:34:08 +0000
Subject: Handling of modular boards
In-Reply-To: <20120504185850.GO14230@opensource.wolfsonmicro.com>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
Message-ID: <201205041934.08830.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Mark Brown wrote:
> Quite a few reference platforms (including Wolfson ones, which is why
> I'm particularly interested) use replaceable modules to allow
> configuration changes.  Since we can often identify the configuration at
> runtime we should ideally do that but currently there's no infrastructure 
> to help with that, generally this seems to be done in arch code for the
> machine but this doesn't scale when even the CPU might change and isn't
> terribly device tree compatible either.
> 
> For reference the code for current Wolfson plugin modules is in
> arch/arm/mach-s3c64xx/mach-crag6410-module.c.

Hi Mark,

Thanks for getting the discussion started. I've seen the same issue come
up for arch/arm/mach-ux500/board-mop500*uib.c and for the beaglebone.
I'm sure there are many more, but we should make sure that everyone
of these can live with whatever we come up with.

> The most obvious current fit here is the MFD subsystem but it feels like
> we need some slightly different infastructure to what MFD currently
> provides.  MFD is really set up to handle platform devices with a core
> and linear ranges of resources fanning out from that core since they're
> really oriented around chips.  In contrast these boards are more about
> remapping random collections of potentially unrelated resources and
> instantiating devices on all sorts of buses and share more with board
> files.
> 
> I'm just starting to put some stuff together for this so I was wondering
> if anyone had been thinking about this and had any bright ideas for how
> to handle it, and also if people think that MFD is a good fit for this
> or if we should split the silicon MFDs from these PCBs.

One idea that I've heard before is to put device tree fragments into the
kernel and dynamically add them to the device tree that was passed by the
boot loader whenever we detect the presence of a specific device.
This obviously means it works only for boards using DT for booting, but
it allows us to use some infrastructure that we already have.

Another idea was to put all the possible extensions into the device tree
for a given board and disable them by default, putting it into the
responsibility of the boot loader to enable the one that is actually
being used. This has serious scalibility problems when there are many
possible extensions and also relies more on the boot loader than I would
like.

An intermediate solution that I really like is the ability to
stuff device tree fragments on extension board themselves, but that
can only work for new designs and causes problems when that information
is not actually correct.

	Arnd
