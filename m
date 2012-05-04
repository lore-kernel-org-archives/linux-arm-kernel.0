From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 23:55:14 +0100
Subject: Handling of modular boards
In-Reply-To: <20120504185850.GO14230@opensource.wolfsonmicro.com>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
Message-ID: <20120504225514.GM897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 07:58:51PM +0100, Mark Brown wrote:
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
> 
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

I don't think its true to say that there's no support for this kind of
thing.

If you're thinking about a motherboard with separate add-on cards, then
you can view the cards as their own separate platform device.  Your
platform device driver would be a "whole board driver" responsible
for creating and registering the specific devices found on the board
in its probe function, and unregistering them in the remove function.

This is exactly how I've now setup the Assabet with Neponset daughter
board - all the Neponset devices sit behind the Neponset platform
device, including things like the SA1111 multifunction chip and SMC91x
network interface.  I can bind and unbind the Neponset device from its
driver and have everything behind that driver appear and disappear
appropriately - which is useful if your modules can be hotplugged.

It also helps to give the right model to the power management support,
because you're automatically arranging the child devices below the
board-level device, which means all the child devices should be
suspended before the board level device, and the board level device
should be resumed before the child devices.
