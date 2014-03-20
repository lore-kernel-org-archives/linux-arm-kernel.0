From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 12:46:48 +0000
Subject: Forcing DEBUG_UART_{PHYS, VIRT} changes when switching between
 v7 platforms?
In-Reply-To: <201403201245.34108.arnd@arndb.de>
References: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
 <8099777.qvOx0M5YBS@wuerfel> <20140320101127.GN7528@n2100.arm.linux.org.uk>
 <201403201245.34108.arnd@arndb.de>
Message-ID: <20140320124648.GS7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 12:45:33PM +0100, Arnd Bergmann wrote:
> On Thursday 20 March 2014, Russell King - ARM Linux wrote:
> > So yes, eventually these will have to be specified manually.  I'm
> > probably going to move them into file(s) in Documentation/arm/
> > so that we retain the information in an easily accessible form.
> 
> Ok, thanks for the clarification. On a semi-related topic, we have
> (once more) discussed adding an early printk implementation during
> the Linaro Connect meeting this month. I think this would all become
> much less painful if we had a way to handle console output in a
> platform independent way before the regular console kicks in, like
> a few other architectures do.
> 
> debug_ll is great for debugging the extremely early code, since
> it works basically from the first instruction on, but a lot of
> problems actually happen much later. The early console code
> runs from parse_early_param(), which comes after setup_arch(),
> so we can't use to debug that part but it means we already
> have an unflattened device tree to work with for finding typical
> 8250 or pl011 ports. At the moment, pl011 doesn't even have a
> console_initcall, so it comes up only at arch_initcall time,
> which is about the earliest a normal tty driver can get registered,
> and a lot can go wrong between parse_early_param() and
> arch_initcall().

It depends how much crap you want to shovel into serial drivers.  Fixing
stuff to work at console_initcall time basically means that the driver
has to have some way to find where the console is independent of the
driver model - because the driver model won't be up and running at that
point.

Yes, we could have a console_initcall() in there parsing the device tree
for a console port, but what console= parameter would that correspond
with?  You wouldn't know which ttyAM* port it should tie up with because
you don't have that information at that point in time - and it's important
to know that so that /dev/console in userspace works.

8250 gets around this by having a static list of ports and a serial port
at well known address.  We are far from having such a luxury on ARM - this
is unfortunately one of the prices we have to pay for the mistakes of the
past where there is no common layout for peripherals.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
