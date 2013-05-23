From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 12:02:48 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305222236.12652.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522155134.GL2824@lunn.ch> <20130522182219.062079ac@skate>
 <201305222236.12652.arnd@arndb.de>
Message-ID: <20130523120248.51a85f50@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 22 May 2013 22:36:12 +0200, Arnd Bergmann wrote:

> > > Maybe i'm missunderstand Arnd, but i think he is suggesting a property
> > > somewhere in DT which says where the bootloader left the register
> > > space before jumping to the kernel. You can then look at this property
> > > and then decide if you need to remap or not. Only this one property
> > > needs to differ between old and new bootloader. You could even say, if
> > > the property is not in DT, a remap is needed.
> 
> No, the idea was that we don't need to remap if we know where the registers
> are. The mbus driver might remap them if it is really careful about not
> breaking any existing mappings, but it's probably easier to just leave
> them alone.

Again, our aim is to get everybody to run kernels with registers
remapped at 0xf1, so that we're back to what should have been done
originally.

Ideally, we'd like to completely forget about supporting old
bootloaders, and assume we only have good bootloaders that remap things
to 0xf1. We're only proposing this *temporary* solution to make the
transition easier, give some time to the board manufacturers to release
updated bootloaders, to users to upgrade their bootloaders, and finally
remove this temporary solution.

We clearly don't want to go down the road of supporting an
arbitrarily-defined base address for the internal registers. This has
never been the case for Kirkwood, Orion5x, Dove, and there is no
compelling reason to make it a requirement for Armada 370/XP.

> > The problem is that neither the old nor the new bootloaders are setting
> > such property in the DT. Old bootloaders shipped by Marvell don't have
> > DT support at all. New bootloaders shipped by Marvell do have DT
> > support, but they are not adding any specific DT property that allows
> > us to tell whether the registers are mapped here or there.
> > 
> > We could maybe find a way of detecting whether if the bootloader is DT
> > capable, and assume that if it's DT capable, the registers are already
> > mapped at 0xf1. But that's very fragile: nothing prevents an user to
> > use a DT-capable bootloader to boot a kernel in the old style way
> > (appended DTB). In this case, we would assume that the registers are at
> > 0xd0, because we're being booted old-style, and therefore it must be an
> > old bootloader. Very fragile, clearly not better than the CP15 trick.
> 
> Yes, that would not be an improvement. However, since we know what boot
> loader we have when we pass the devicetree, that devicetree can just
> contain the correct 'reg' property for the internal registers.

What do you mean by "we know what boot loader we have when we pass the
devicetree" ?

The mere user of the kernel just does:

	make ARCH=arm mvebu_defconfig
	make ARCH=arm CROSS_COMPILE=...
	cat arch/arm/boot/zImage arch/arm/boot/dts/armada-370-mirabox.dtb > zImage.mirabox
	... prepare uImage ...

and he certainly doesn't want to understand the gory details of which
internal register base address to chose depending on which bootloader
version he is using. This is really asking normal users to have a too
much intimate knowledge of the hardware details.

The temporary solution we're proposing doesn't have this drawback: an
user can boot the kernel on either an old or new bootloader, without
having to worry about checking/changing the Device Tree source about
this bizarre internal register address thing.

As a developer of the Armada 370/XP, I am frequently contacted by users
to help them getting the mainline kernel booting on their Mirabox or
OpenBlocks. And trust me: even getting the appended DTB gymnastic right
is not easy. So getting this internal register story right is going to
be a nightmare in terms of support.

Please do not inflict to us such a support pain :-)

> > > However, i don't know if this can actually work. How early can you
> > > parse the DT in order to know where the serial port is for
> > > earlyprintk()? It also gets messy keeping track of the two different
> > > DT binary blobs and somehow having the probe the uboot version in
> > > order to install the right one. I don't know how i would include this
> > > into the debian flash-kernel for example.
> > 
> > For earlyprintk, we can "solve" it as Arnd suggested: just have two
> > Kconfig options, one for 0xd0, one for 0xf1, and it's up to the user to
> > choose the right one. It's not entirely nice because it's no longer
> > automatic, and I'm sure our users will have a hard time figuring out
> > whether they have an "old" or a "new" bootloader. But let's assume we
> > do this. earlyprintk knows the physical address of the UART.
> > 
> > Then, we enter ->map_io(). We have access to the Device Tree. But the
> > Device Tree doesn't tell us whether the bootloader has mapped the
> > registers. As I explained to Arnd, it's not a per-board criteria: when
> > I'm booting my OpenBlocks with the manufacturer U-Boot, registers are
> > mapped at 0xd0. When I boot the same OpenBlocks with the (admittedly
> > work-in-progress) Barebox bootloader, registers are mapped at 0xf1.
> > Same board, different register location.
> 
> But since you control barebox, you can find the "regs" property of the
> mbus node in it and set it up to the same address you use when you
> map the internal registers.

We may control Barebox because the support is not yet written, but we
clearly do not have much control over what Marvell is doing with its
own U-Boot. And let's be pragmatic: 99.99% of the Marvell 370/XP
platforms will be running the U-Boot from Marvell.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
