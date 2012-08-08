From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 8 Aug 2012 12:53:39 -0500
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <alpine.LFD.2.02.1208080033410.5231@xanadu.home>
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
Message-ID: <CAKGA1bn7YwT33F=J0AMWAy+mSDy=7iUt2U46dmABXPc+664rNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 12:04 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 7 Aug 2012, Matt Sealey wrote:
>
>> On Mon, Aug 6, 2012 at 7:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Mon, 6 Aug 2012, Matt Sealey wrote:
>
>> lines flailing around during a mux change, and GPIO directions
>> changing on the fly for no good reason.
>
> But if Linux is re-initializing everything identically to the bootloader
> then the hardware should see a no-op, no?

Not necessarily.. it is most likely implementation dependent, I'd think.
It also depends on what is outside the chip.

> right person to discuss pinmux design issues.  If you have concerns
> about redundant initialization or similar issues then I strongly
> suggest you start a new thread to initiate a discussion on that.

Been doing that since 2005, still going strong..

> Note that I previously opposed the idea of any hard linkage between the
> bootloader and the device tree content.  If you are spending so much
> time validating your DT, you might feel so confident as to not allow it
> to be updatable unless the whole bootloader is also updated.

The DTB is seperate from the firmware. But the firmware does all the pinmuxing
long before the DTB is loaded - that way the DTB does the correct thing and
in the worst case describes only the currently configured and ready-to-operate
hardware (or in the best case, describes hardware the bootloader is currently
using..).

On OF since every node tends to have a driver backed to it, you just write
small stub drivers that pinmux then add it to the tree. U-Boot and other FW
are more clunky but the same effect can be achieved - just make sure every
entry you commit to the Linux arch/arm/boot/dts tree definitely has it's pinmux
set up.

There are good reasons to pinmux stuff at runtime - configurable hardware such
as on my HP Touchpad, the headphone port is also a UART. It's creepy, but
you may want to listen to audio and then switch to debugging - the microphone
part is always input (uart rx on host side) and the left audio is
output (uart tx),
and ground is ground. The right audio pin is not used in UART. You don't want
to reboot in the middle of debugging an app that specifically uses the headphone
and with correct board design and prudent use by the developer it's safe.. but
not all boards are designed that way. One thing we can change is the software
to work around hardware. We can make sure DTBs describe the breakages well
and make sure that FW solves all the problems it can before Linux gets to
it (for instance ARM errata settings in SCU, PL310, aux cp registers which would
otherwise be done in cpu init once at boot, need to be done before running any
code so FW should do them).

But as we just saw when submitting our device tree, we got a nit from
the maintainer
that we don't set up pinctrl - and that pinctrl setup would be
required in case any
device drivers needed it. I'm saying no; pinctrl shouldn't be
*required* by a platform,
it should be optional for all those where it's impossible to entertain
it or where there's
some kind of late-hitting errata that nobody could have predicted
(like the MX51 SPI
chipselect bug) and the collaboration between updating U-Boot and Linux to match
using GPIO for chipselects instead of letting the chip handle it is
too much cost or
effort compared to adding 2 entries to a device tree and updating Linux.

But not 100 entries in device tree, please, and no hard requirements..

> wrong.  Please make your DTB into a separate flash area, separate from
> the boot loader so it can easily be updated without any risk of breaking
> the device.  Just in case...

Our DTB is on the filesystem, ext2 or ext3 or ext4 or vfat. SD card, PATA,
SATA or USB, or even NFS or TFTP. You could even take an SD card, put
it in a Windows box, and copy a new one in place, no Linux required. It's
totally userspace/user friendly. We made absolutely sure of it.

Thanks,

I'll leave the discussion for the other thread I spawned from this ;)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
