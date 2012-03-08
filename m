From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Mar 2012 23:14:04 +0000
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <20120308212701.GB16533@ponder.secretlab.ca>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203072113.04369.arnd@arndb.de>
 <20120308212701.GB16533@ponder.secretlab.ca>
Message-ID: <201203082314.05385.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 March 2012, Grant Likely wrote:
> > 
> > My first guess was that clock-frequency is wrong, but it seems that
> > this one actually is correct, at least it's the same thing that
> > the platform code sets.
> > 
> > You should never need to pass the virtual address to a device,
> > most of all because it cannot be known to the device tree at all.
> > The of_serial driver (you did enable that one in Kconfig, right?)
> 
> Ugh.  Someone really needs to step up and kill the of_serial driver.  All that
> stuff belongs in the core 16550 driver.

Well, actually I would argue that nothing belongs into the core 8250 driver.
What we should do though is split the of_serial.c file into the main 8250
portion and put that into drivers/tty/serial/8250/ along with the other
14 bus glue drivers, and put the nwpserial portion into
drivers/tty/serial/nwpserial.c.

I have started a major rework of 8250 some time ago that I need to finish up,
to make the different ways for registering an 8250 device more regular,
and get rid of the more obscure ways we have in the kernel, replacing them
with platform devices or other bus specific 'struct device' versions.

The main intention of that patch series is to confine the ISA/PCI specific
inb/outb accessors in the files that need them so we can actually build
the platform drivers without defining those, but I can take care of
of_serial.c as well -- after all I wrote that file originally.

	Arnd
