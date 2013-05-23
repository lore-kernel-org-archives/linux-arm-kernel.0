From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 16:12:42 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523120248.51a85f50@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305222236.12652.arnd@arndb.de> <20130523120248.51a85f50@skate>
Message-ID: <201305231612.42395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Wed, 22 May 2013 22:36:12 +0200, Arnd Bergmann wrote:
> 
> > > > Maybe i'm missunderstand Arnd, but i think he is suggesting a property
> > > > somewhere in DT which says where the bootloader left the register
> > > > space before jumping to the kernel. You can then look at this property
> > > > and then decide if you need to remap or not. Only this one property
> > > > needs to differ between old and new bootloader. You could even say, if
> > > > the property is not in DT, a remap is needed.
> > 
> > No, the idea was that we don't need to remap if we know where the registers
> > are. The mbus driver might remap them if it is really careful about not
> > breaking any existing mappings, but it's probably easier to just leave
> > them alone.
> 
> Again, our aim is to get everybody to run kernels with registers
> remapped at 0xf1, so that we're back to what should have been done
> originally.
> 
> Ideally, we'd like to completely forget about supporting old
> bootloaders, and assume we only have good bootloaders that remap things
> to 0xf1. We're only proposing this *temporary* solution to make the
> transition easier, give some time to the board manufacturers to release
> updated bootloaders, to users to upgrade their bootloaders, and finally
> remove this temporary solution.
> 
> We clearly don't want to go down the road of supporting an
> arbitrarily-defined base address for the internal registers. This has
> never been the case for Kirkwood, Orion5x, Dove, and there is no
> compelling reason to make it a requirement for Armada 370/XP.

Well, the main reason I see now is that Marvell screwed it up by having
two incompatible versions of u-boot. Using a different base address on
new machines would have been no problem at all, but supporting the
same machine with different addresses depending on the boot loader
version is madness. As you say, it's too late to change that now, so
maybe the best solution is to make the registers always get reassigned.
5 trick.
> > 
> > Yes, that would not be an improvement. However, since we know what boot
> > loader we have when we pass the devicetree, that devicetree can just
> > contain the correct 'reg' property for the internal registers.
> 
> What do you mean by "we know what boot loader we have when we pass the
> devicetree" ?
> 
> The mere user of the kernel just does:
> 
> 	make ARCH=arm mvebu_defconfig
> 	make ARCH=arm CROSS_COMPILE=...
> 	cat arch/arm/boot/zImage arch/arm/boot/dts/armada-370-mirabox.dtb > zImage.mirabox
> 	... prepare uImage ...
> 
> and he certainly doesn't want to understand the gory details of which
> internal register base address to chose depending on which bootloader
> version he is using. This is really asking normal users to have a too
> much intimate knowledge of the hardware details.

Right, appended device tree is a problem, but if a user does that, I think
we can rightfully expect them to know what they are doing.

> The temporary solution we're proposing doesn't have this drawback: an
> user can boot the kernel on either an old or new bootloader, without
> having to worry about checking/changing the Device Tree source about
> this bizarre internal register address thing.
> 
> As a developer of the Armada 370/XP, I am frequently contacted by users
> to help them getting the mainline kernel booting on their Mirabox or
> OpenBlocks. And trust me: even getting the appended DTB gymnastic right
> is not easy. So getting this internal register story right is going to
> be a nightmare in terms of support.
> 
> Please do not inflict to us such a support pain :-)

I think we should consequently make sure we never get a production
u-boot for Mirabox or OpenBlocks that changes the internal register
address and also allows ATAGS based booting. Either those machines
continue to use the 0xd0 address for the internal registers, or they
must ensure to fix up the device tree properly.

Since you explained that we want to move the internal registers to get
more available memory, I think what you also want to do is to dynamically
reassign the internal register mapping when the mbus driver gets loaded,
just like all the other mbus mappings. That will let you move it even
higher to free up more memory, and it means we can tell the Mirabox
and OpenBlocks people to leave the internal register base address alone
in their u-boot, so we don't have two conflicting versions of those
machines.

	Arnd
