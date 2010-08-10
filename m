From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Aug 2010 09:36:27 +0300
Subject: [PATCH 4/5] [omap1] Bluetooth device code common to HTC
	smartphones
In-Reply-To: <AANLkTinQ+50aFPj6M0yEnE_nemamnBb8=emD--VZ_hsG@mail.gmail.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
	<1280762976-17284-5-git-send-email-darkstar6262@gmail.com>
	<20100804101507.GG9881@atomide.com>
	<AANLkTikGA9-TCM7v+_yivBYtxiX3ByJ7_ub1FOP0LgBO@mail.gmail.com>
	<20100809074300.GB32480@atomide.com>
	<AANLkTinQ+50aFPj6M0yEnE_nemamnBb8=emD--VZ_hsG@mail.gmail.com>
Message-ID: <20100810063626.GE32480@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100809 20:21]:
> On Mon, Aug 9, 2010 at 12:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Cory Maccarrone <darkstar6262@gmail.com> [100808 20:22]:
> >> On Wed, Aug 4, 2010 at 3:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> >> >> This change adds in a bluetooth controld driver/rfkill
> >> >> interface to the serial bluetooth controller found on many
> >> >> HTC smartphones such as the HTC Herald and HTC Wizard.
> >> >
> >> > To me it looks like most of this should be in drivers/bluetooth/omap7xx.c
> >> > or something like that. Then you can just pass it the gpio numbers in
> >> > the platform_data.
> >> >
> >>
> >> Not sure I agree that it fits there. ?The driver isn't really a
> >> bluetooth driver -- it's really just an RFKILL interface, and some
> >> code to toggle UART clocks on and off, plus GPIO work on a
> >> board-specific level. ?In principle, the gpios could be set and the
> >> clocks enabled in the board files, and this driver wouldn't be
> >> necessary to get working bluetooth (as we'd use hciattach on
> >> /dev/ttyS*). ?But then, we can't toggle it off for power saving.
> >> Maybe a better place would be plat-omap/? ?But it really is more
> >> specific to these HTC boards, not the architecture itself.
> >
> > Hmm well what we've used earlier is to set something like set_power
> > function pointer in the platform data, then call that in the driver
> > if set. But in this case the driver is 8250.c, so let's not mess
> > with that..
> >
> > This issue should get properly solved with the omap specific serial
> > driver once we get that merged as then we can have hooks for set_power
> > in addition to cutting serial clocks when idle.
> >
> >> So really, the only point of this driver is to be able to power on and
> >> off the external bluetooth chip, which is why I submitted it as helper
> >> code to the board files.
> >
> > Yeah. Can you take a look at the omap specific serial driver to get
> > it working on omap1?
> >
> > Then you can have your GPIO functions set in the board-*.c file
> > as set_power or similar, and the UART driver can idle properly.
> >
> 
> I can look at it.  Where is the code for that, arch/arm/mach-omap2/serial.c?

It's been floating on the list for a while now, here's the latest
version:

http://www.spinics.net/lists/linux-omap/msg31786.html

Probably doing the platform data initialization is the biggest
part that needs to be done for omap1, the driver itself should not
need much changes.

Regards,

Tony
