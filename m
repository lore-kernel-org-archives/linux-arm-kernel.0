From: marvin24@gmx.de (Marc Dietrich)
Date: Sun, 30 Oct 2011 21:39:37 +0100
Subject: [PATCH v2 2/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173EDAB4C7@HQMAIL01.nvidia.com>
References: <cover.1319658296.git.marvin24@gmx.de>
	<3520326.MNh26pzpGT@fb07-iapwap2>
	<74CDBE0F657A3D45AFBB94109FB122FF173EDAB4C7@HQMAIL01.nvidia.com>
Message-ID: <4025601.AfFCiixCcK@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 October 2011 09:49:49 Stephen Warren wrote:
> Marc Dietrich wrote at Friday, October 28, 2011 4:30 AM:
> > Am Donnerstag, 27. Oktober 2011, 09:50:03 schrieb Stephen Warren:
> > > Marc Dietrich wrote at Wednesday, October 26, 2011 1:59 PM:
> > > > This adds a dts file for paz00. As a side effect, this also
> > > > enables
> > > > the embedded controller which controls the keyboard, touchpad,
> > > > power,
> > > > leds, and some other functions.
> > > 
> > > ...
> > > 
> > > > +++ b/arch/arm/boot/dts/tegra-paz00.dts
> > > > @@ -0,0 +1,70 @@
> > > > +/dts-v1/;
> > > > +
> > > > +/memreserve/ 0x1c000000 0x04000000;
> > > > +/include/ "tegra20.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "Toshiba AC100 / Dynabook AZ";
> > > > +	compatible = "compal,paz00", "nvidia,tegra20";
> > > > +
> > > > +	chosen {
> > > > +		bootargs = "mem=448 at 0 console=ttyS0,115200n8
> > > > root=/dev/mmcblk1p1";
> > > 
> > > You shouldn't need the mem= parameter here; it wasn't in your first
> > > patch set.> 
> > that's because I forgot it. Sorry, I didn't mentioned it in the
> > changelog. I wonder why mem= is still needed.
> 
> I wonder if this is some conflict between ATAGs and the DT-specified
> memory node.
> 
> As far as I can tell, the kernel's memory information typically comes
> from ATAGs. Some boards override what's in the ATAGs in their machine
> descriptor's fixup routine, e.g. see tegra_paz00_fixup(). Presumably,
> this is because of buggy bootloaders sending incorrect memory information
> in the ATAGs. Do you have any way to check the ATAGs that the bootloader
> is sending? Probably, you could enable DEBUG_LL and using the low-level
> debugging functions to dump some of that information to the UART early
> during boot.

I got the ATAGS from /proc/atags and there is no memory entry there, only 
initrd and cmdline (which is the one from nvflash).

The machine also has a fixup routine, but it also boots without (I'm sure it 
was necessary in the past),

> When boards boot from DT, there is no fixup function to override the
> bootloader's ATAGs. 

... so I guess this is why it also works with DT.

> I also see a bunch of code to set up the memory
> information from DT e.g. setup_machine_fdt()'s call to:
> 
> 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> 
> ... but I assume that happens before the ATAGs are processed, and the
> buggy ATAGs end up overriding the information in the DT file. And further,
> I assume that specifying "mem=" on the command-line overrides that, thus
> solving the problem.
> 
> It'd be awesome if you could validate this; the simplest way is probably
> to:
> 
> a) Remove mem= from the command-line

I tested several variations. Without DT, the fixup can compensate a missing 
mem entry in the kernel command line, but with a mem= from the kernel command 
line, a fixup is not needed.

With DT, the command line specified from nvflash is ignored and the one from 
DT comes into the game. If it is also missing there, system detects 512 MB 
(which is physical right, but we cannot reserve memory for the gpu). The fixup 
is indeed ignored in this case.

> b) Modify arch/arm/kernel/setup.c:parse_tag_mem32() to do nothing;
>    comment out the call to arm_add_memory()

I leave this out because the bootloader does not send memory info in the 
ATAGS.

> c) Test booting, and check what RAM size the kernel thinks you have.

see above. RAM detection works, but it's not what we want ...

> If that works, then ATAGs are the problem. We probably need to modify the
> core ARM code not to use memory ATAGs when there is a DT?
> 
> I'm mainly pushing on this because adding "mem=" to the command-line in
> the DT file isn't a great solution; when people start using bootloaders
> that rewrite the DT to include the user-specified command-line, then every
> user is going to have to start specifying "mem=" in their command-lines.

Well, I see two options for our case:

	a) use the mem=448M at 0 in the DT so the gpu can get its memory
	b) upstream the chromeos changes to reserve gpu memory "on the fly" from 
the autodetected 512M (as it should be IMHO).

> > I've seen patches on the chromeos tree which try to reserve the gpu
> > memory on demand. While we are at it, what is the vmalloc=192M used
> > by most other boards for?
> 
> I'm not sure what vmalloc= does exactly. I somewhat doubt it's necessary
> until we have code that uses the GPU in mainline. The same goes for the
> /memreserve/ DT entries. I've been thinking of submitting a patch to
> remove this cruft, but haven't gotten around to it yet.
