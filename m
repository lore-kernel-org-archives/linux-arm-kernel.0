From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 12:45:33 +0100
Subject: Forcing DEBUG_UART_{PHYS,
 VIRT} changes when switching between v7 platforms?
In-Reply-To: <20140320101127.GN7528@n2100.arm.linux.org.uk>
References: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
 <8099777.qvOx0M5YBS@wuerfel> <20140320101127.GN7528@n2100.arm.linux.org.uk>
Message-ID: <201403201245.34108.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Russell King - ARM Linux wrote:
> On Thu, Mar 20, 2014 at 08:07:52AM +0100, Arnd Bergmann wrote:
> > On Wednesday 19 March 2014 16:38:45 Florian Fainelli wrote:
> > > Hi,
> > > 
> > > When switching between different Multi v7 platform which all select
> > > DEBUG_UART_8250, whichever platform managed to set
> > > DEBUG_UART_{PHYS,VIRT} first will end-up forcing its value to the
> > > others.
> > > 
> > > What I am seeing at the moment is for instance enabling BCM_MOBILE
> > > will set DEBUG_UART_PHYS to 0x3e000000, disabling BCM_MOBILE and now
> > > enabling MVEBU won't force a new DEBUG_UART_PHYS address to be
> > > re-computed.
> > > 
> > > Should we add some sort of specific annotation to the Kconfig symbol
> > > to force a recalculation of the UART PHYS address?
> > 
> > Russell has plans to change the Konfig logic in the future, removing the
> > platform specific options. With the current code, you could probably
> > do something along the lines of
> 
> The only reason the default values are there is to provide an easy way
> for people to locate the values they need for the time being.  The
> plan is to kill them off, so you have to enter them manually.  The
> issue with that is it becomes quite painful if you have to keep searching
> around for the right values when something breaks.
> 
> (Personally, I've ended up a number of times searching around for the
> right address to generate uImage's for various target platforms which
> can only load uImages... but I've now ended up with a script which has
> that information stored in it...)
> 
> So yes, eventually these will have to be specified manually.  I'm
> probably going to move them into file(s) in Documentation/arm/
> so that we retain the information in an easily accessible form.

Ok, thanks for the clarification. On a semi-related topic, we have
(once more) discussed adding an early printk implementation during
the Linaro Connect meeting this month. I think this would all become
much less painful if we had a way to handle console output in a
platform independent way before the regular console kicks in, like
a few other architectures do.

debug_ll is great for debugging the extremely early code, since
it works basically from the first instruction on, but a lot of
problems actually happen much later. The early console code
runs from parse_early_param(), which comes after setup_arch(),
so we can't use to debug that part but it means we already
have an unflattened device tree to work with for finding typical
8250 or pl011 ports. At the moment, pl011 doesn't even have a
console_initcall, so it comes up only at arch_initcall time,
which is about the earliest a normal tty driver can get registered,
and a lot can go wrong between parse_early_param() and
arch_initcall().

	Arnd
