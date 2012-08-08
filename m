From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Aug 2012 14:53:34 -0400 (EDT)
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <CAKGA1bn7YwT33F=J0AMWAy+mSDy=7iUt2U46dmABXPc+664rNw@mail.gmail.com>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
 <20120806190856.GA1120@n2100.arm.linux.org.uk>
 <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
 <20120806194016.GB1120@n2100.arm.linux.org.uk>
 <CAKGA1b=hMZD3nd2sjXzR89-wX4BotxZwHOkkiLFoEL_CSS4zug@mail.gmail.com>
 <alpine.LFD.2.02.1208061829510.5231@xanadu.home>
 <CAKGA1bnJCSaVcErs3R8U3ZjQkhMmZAZPM=2P2R7udVc80ZmoDQ@mail.gmail.com>
 <alpine.LFD.2.02.1208061935380.5231@xanadu.home>
 <CAKGA1b=UBEf783egzoKqyXipfgziOy7QremNbFoz_i+r1X_9hQ@mail.gmail.com>
 <alpine.LFD.2.02.1208080033410.5231@xanadu.home>
 <CAKGA1bn7YwT33F=J0AMWAy+mSDy=7iUt2U46dmABXPc+664rNw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1208081436000.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Aug 2012, Matt Sealey wrote:

> On Wed, Aug 8, 2012 at 12:04 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Note that I previously opposed the idea of any hard linkage between the
> > bootloader and the device tree content.  If you are spending so much
> > time validating your DT, you might feel so confident as to not allow it
> > to be updatable unless the whole bootloader is also updated.
> 
> The DTB is seperate from the firmware. But the firmware does all the pinmuxing
> long before the DTB is loaded - that way the DTB does the correct thing and
> in the worst case describes only the currently configured and ready-to-operate
> hardware (or in the best case, describes hardware the bootloader is currently
> using..).

I do not disagree with that.  What's the problem?

> There are good reasons to pinmux stuff at runtime - configurable hardware such
> as on my HP Touchpad, the headphone port is also a UART. It's creepy, but
> you may want to listen to audio and then switch to debugging

Exact.  There are cases like that where changing pin muxing at run time 
is necessary.  We therefore have a subsystem in Linux to deal with that 
in a common way.

But if nothing has to change at run time then just let the boot loader 
set it up and be done with it... if your boot loader isn't buggy that 
is.

I'm always fighting against too much reliance on DT especially for stuff 
that the code can easily probe at run time.  I'm all for _reducing_ the 
dependencies between all the moving pieces i.e. the firmware, the 
bootloader, the DTB and the kernel.  Interactions must be kept to a 
minimum.  Hence my stance on the fixed CPU mode for booting Linux.

> But as we just saw when submitting our device tree, we got a nit from 
> the maintainer that we don't set up pinctrl - and that pinctrl setup 
> would be required in case any device drivers needed it.

And what's wrong with that statement?  The key point here is "in case 
device drivers need it".  If they don't, you don't, right?  I don't 
think you should provide information in your DTB if it is never going to 
be useful.

> I'm saying no; pinctrl shouldn't be *required* by a platform, it 
> should be optional for all those where it's impossible to entertain it 
> or where there's some kind of late-hitting errata that nobody could 
> have predicted (like the MX51 SPI chipselect bug) and the 
> collaboration between updating U-Boot and Linux to match using GPIO 
> for chipselects instead of letting the chip handle it is too much cost 
> or effort compared to adding 2 entries to a device tree and updating 
> Linux.
> 
> But not 100 entries in device tree, please, and no hard requirements..

Again, no disagreement from me on this.


Nicolas
