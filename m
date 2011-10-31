From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 31 Oct 2011 09:09:13 -0700
Subject: [PATCH v2 2/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <4025601.AfFCiixCcK@ax5200p>
References: <cover.1319658296.git.marvin24@gmx.de>
	<3520326.MNh26pzpGT@fb07-iapwap2>
	<74CDBE0F657A3D45AFBB94109FB122FF173EDAB4C7@HQMAIL01.nvidia.com>
	<4025601.AfFCiixCcK@ax5200p>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173EDAB782@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Sunday, October 30, 2011 2:40 PM:
> On Friday 28 October 2011 09:49:49 Stephen Warren wrote:
> > Marc Dietrich wrote at Friday, October 28, 2011 4:30 AM:
> > > Am Donnerstag, 27. Oktober 2011, 09:50:03 schrieb Stephen Warren:
> > > > Marc Dietrich wrote at Wednesday, October 26, 2011 1:59 PM:
> > > > > This adds a dts file for paz00. As a side effect, this also
> > > > > enables
> > > > > the embedded controller which controls the keyboard, touchpad,
> > > > > power,
> > > > > leds, and some other functions.
> > > >
> > > > ...
> > > >
> > > > > +++ b/arch/arm/boot/dts/tegra-paz00.dts
> > > > > @@ -0,0 +1,70 @@
> > > > > +/dts-v1/;
> > > > > +
> > > > > +/memreserve/ 0x1c000000 0x04000000;
> > > > > +/include/ "tegra20.dtsi"
> > > > > +
> > > > > +/ {
> > > > > +	model = "Toshiba AC100 / Dynabook AZ";
> > > > > +	compatible = "compal,paz00", "nvidia,tegra20";
> > > > > +
> > > > > +	chosen {
> > > > > +		bootargs = "mem=448 at 0 console=ttyS0,115200n8
> > > > > root=/dev/mmcblk1p1";
> > > >
> > > > You shouldn't need the mem= parameter here; it wasn't in your first
> > > > patch set.
> > > that's because I forgot it. Sorry, I didn't mentioned it in the
> > > changelog. I wonder why mem= is still needed.
> >
> > I wonder if this is some conflict between ATAGs and the DT-specified
> > memory node.
> >
> > As far as I can tell, the kernel's memory information typically comes
> > from ATAGs. Some boards override what's in the ATAGs in their machine
> > descriptor's fixup routine, e.g. see tegra_paz00_fixup(). Presumably,
> > this is because of buggy bootloaders sending incorrect memory information
> > in the ATAGs. Do you have any way to check the ATAGs that the bootloader
> > is sending? Probably, you could enable DEBUG_LL and using the low-level
> > debugging functions to dump some of that information to the UART early
> > during boot.
> 
> I got the ATAGS from /proc/atags and there is no memory entry there, only
> initrd and cmdline (which is the one from nvflash).
> 
> The machine also has a fixup routine, but it also boots without (I'm sure it
> was necessary in the past),
...
> I tested several variations. Without DT, the fixup can compensate a missing
> mem entry in the kernel command line, but with a mem= from the kernel command
> line, a fixup is not needed.

OK, that makes sense.

> With DT, the command line specified from nvflash is ignored and the one from
> DT comes into the game.

I assume you're using CONFIG_ARM_APPENDED_DTB but not CONFIG_ARM_ATAG_DTB_COMPAT.

> If it is also missing there, system detects 512 MB.

That makes sense; that's the value in the .dts file you posted.

> (which is physical right, but we cannot reserve memory for the gpu). The fixup
> is indeed ignored in this case.

It's not "ignored" as such.

When booting without DT, the machine descriptor in board-paz00.c is used,
since the descriptor is selected based on the machine ID in the descriptor,
and that descriptor includes:

	.fixup          = tegra_paz00_fixup,

... which causes that fixup function to be called.

When booting with DT, the machine descriptor in board-dt.c is used, since
the descriptor is selected based on the DT's overall compatible property,
and that descriptor doesn't refer to tegra_paz00_fixup() at all, so it's
not called.

> > b) Modify arch/arm/kernel/setup.c:parse_tag_mem32() to do nothing;
> >    comment out the call to arm_add_memory()
> 
> I leave this out because the bootloader does not send memory info in the
> ATAGS.
> 
> > c) Test booting, and check what RAM size the kernel thinks you have.
> 
> see above. RAM detection works, but it's not what we want ...

At this point, I'd argue that exposing the full 512M to the kernel /is/
what we want. There is no Tegra GPU support in the mainline kernel at
present. As such, I'd argue that we should give the entire RAM space to
the kernel to use. As and when we add GPU support to the kernel, we can
use an appropriate mechanism to take RAM away from the kernel for that
purpose.

So, I'm planning to remove all the /memreserve/ entries from the Tegra
.dts files as soon as I can find a minute to do so.

But, as Grant mentioned, the /memreserve/ .dts directive should work
right now to reserve memory. I'm not sure if you'd tried that and it didn't
work? If so, it'd be good to debug that just to make sure the mechanism
works, even if we don't intend to use it.

-- 
nvpublic
