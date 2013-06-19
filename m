From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 14:37:20 +0200
Subject: [RFC PATCH v3 0/2] drivers: mfd: Versatile Express SPC support
In-Reply-To: <20130619093014.GX7161@zurbaran>
References: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1371547782.16725.11.camel@hornet> <20130619093014.GX7161@zurbaran>
Message-ID: <201306191437.20759.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Samuel Ortiz wrote:
> > 2. Move the vexpress-sysreg "platform management" functions into misc
> > (unless we get any better place for it)
> This is for Arnd and Greg to decide I suppose.


I think when vexpress-sysreg was created, we didn't have the syscon driver
yet, otherwise I think we should have used that, and put separate
drivers on top.

Not sure if it's too late for changing it to that now, given that
we already have a binding.

It seems we should use the same code for versatile and realview, or
at least it will only need small modifications to apply to all of
these platforms.

What I think could be helpful here is:

* export a "syscon" for the low-level registers

* add a gpio driver based on the syscon interface, and move the gpiochip
  implementation there

* move the low-leve "config" code from the sysreg driver into the
  vexpress-config driver and make it use the syscon.

* move the other global functions from the driver into the callers
  and use syscon there.

That would end up eliminating the sysreg driver, aside from maybe
a one-line change to the syscon driver to allow it to probe the
right device.

> > 3. Move vexpress-config into drivers/bus as it is (however I see no one
> > in MAINTAINERS for this directory)
> ISTR that Arnd originally created that directory, so he may help here.
> Arnd also had some concerns about implementing this code as a bus,
> mostly about it not being a discoverable bus. IMHO that's a valid
> concern, and this is why you ended up putting it under MFD which can be
> seen as some sort of platform devices bus. But I still believe the bus
> API would make this code look cleaner and easier to maintain.

Sorry, I don't see why it would be a bus. I assume that there is code
missing somewhere that is not yet merged, right?

	Arnd
