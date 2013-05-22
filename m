From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 22:36:12 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522182219.062079ac@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522155134.GL2824@lunn.ch> <20130522182219.062079ac@skate>
Message-ID: <201305222236.12652.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 May 2013, Thomas Petazzoni wrote:
> On Wed, 22 May 2013 17:51:34 +0200, Andrew Lunn wrote:
> 
> > Maybe i'm missunderstand Arnd, but i think he is suggesting a property
> > somewhere in DT which says where the bootloader left the register
> > space before jumping to the kernel. You can then look at this property
> > and then decide if you need to remap or not. Only this one property
> > needs to differ between old and new bootloader. You could even say, if
> > the property is not in DT, a remap is needed.

No, the idea was that we don't need to remap if we know where the registers
are. The mbus driver might remap them if it is really careful about not
breaking any existing mappings, but it's probably easier to just leave
them alone.

> The problem is that neither the old nor the new bootloaders are setting
> such property in the DT. Old bootloaders shipped by Marvell don't have
> DT support at all. New bootloaders shipped by Marvell do have DT
> support, but they are not adding any specific DT property that allows
> us to tell whether the registers are mapped here or there.
> 
> We could maybe find a way of detecting whether if the bootloader is DT
> capable, and assume that if it's DT capable, the registers are already
> mapped at 0xf1. But that's very fragile: nothing prevents an user to
> use a DT-capable bootloader to boot a kernel in the old style way
> (appended DTB). In this case, we would assume that the registers are at
> 0xd0, because we're being booted old-style, and therefore it must be an
> old bootloader. Very fragile, clearly not better than the CP15 trick.

Yes, that would not be an improvement. However, since we know what boot
loader we have when we pass the devicetree, that devicetree can just
contain the correct 'reg' property for the internal registers.

> > However, i don't know if this can actually work. How early can you
> > parse the DT in order to know where the serial port is for
> > earlyprintk()? It also gets messy keeping track of the two different
> > DT binary blobs and somehow having the probe the uboot version in
> > order to install the right one. I don't know how i would include this
> > into the debian flash-kernel for example.
> 
> For earlyprintk, we can "solve" it as Arnd suggested: just have two
> Kconfig options, one for 0xd0, one for 0xf1, and it's up to the user to
> choose the right one. It's not entirely nice because it's no longer
> automatic, and I'm sure our users will have a hard time figuring out
> whether they have an "old" or a "new" bootloader. But let's assume we
> do this. earlyprintk knows the physical address of the UART.
> 
> Then, we enter ->map_io(). We have access to the Device Tree. But the
> Device Tree doesn't tell us whether the bootloader has mapped the
> registers. As I explained to Arnd, it's not a per-board criteria: when
> I'm booting my OpenBlocks with the manufacturer U-Boot, registers are
> mapped at 0xd0. When I boot the same OpenBlocks with the (admittedly
> work-in-progress) Barebox bootloader, registers are mapped at 0xf1.
> Same board, different register location.

But since you control barebox, you can find the "regs" property of the
mbus node in it and set it up to the same address you use when you
map the internal registers.

	Arnd
