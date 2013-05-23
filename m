From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 19:39:42 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523164736.610fc55d@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305231612.42395.arnd@arndb.de> <20130523164736.610fc55d@skate>
Message-ID: <201305231939.42359.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Thomas Petazzoni wrote:
> 
> On Thu, 23 May 2013 16:12:42 +0200, Arnd Bergmann wrote:
>
> > Well, the main reason I see now is that Marvell screwed it up by
> > having two incompatible versions of u-boot. Using a different base
> > address on new machines would have been no problem at all, but
> > supporting the same machine with different addresses depending on the
> > boot loader version is madness. As you say, it's too late to change
> > that now, so maybe the best solution is to make the registers always
> > get reassigned. 5 trick.
> 
> Not sure what you mean by '5 trick', and what I should understand from
> this :(

I have no idea myself how that got there, don't remember typing it.

Very odd.

> > > What do you mean by "we know what boot loader we have when we pass
> > > the devicetree" ?
> > > 
> > > The mere user of the kernel just does:
> > > 
> > > 	make ARCH=arm mvebu_defconfig
> > > 	make ARCH=arm CROSS_COMPILE=...
> > > 	cat arch/arm/boot/zImage
> > > arch/arm/boot/dts/armada-370-mirabox.dtb > zImage.mirabox ...
> > > prepare uImage ...
> > > 
> > > and he certainly doesn't want to understand the gory details of
> > > which internal register base address to chose depending on which
> > > bootloader version he is using. This is really asking normal users
> > > to have a too much intimate knowledge of the hardware details.
> > 
> > Right, appended device tree is a problem, but if a user does that, I
> > think we can rightfully expect them to know what they are doing.
> 
> Unfortunately, not really. Appended Device Tree is the only way to go
> for old bootloaders, and we don't want users of such bootloaders to
> have to modify their Device Tree to change the base address of the
> internal registers.

But then the old boot loaders surely wouldn't use the new address either.

> > I think we should consequently make sure we never get a production
> > u-boot for Mirabox or OpenBlocks that changes the internal register
> > address and also allows ATAGS based booting.
> 
> It is impossible to prevent that. U-Boot always supports ATAGs booting
> for ARM, and optionally Device Tree based booting.
> 
> And once again, you believe we have an enormous control over what is
> happening at the bootloader level. So when you say "we should
> consequently make sure ..", this is simply not possible: we have no
> control over this.

The control you have over it is to ensure that it's impossible to
boot an upstream kernel using a broken boot loader. This seems to have
worked rather well to get all Kirkwood/Orion5x/mv78xx0/Dove boards
to use an address that is different from the power-on default.

If we see Mirabox or OpenBlocks machines (or any new ones) get out
in the wild with different addresses and no DT support, that would
be rather unfortunate, but it's not the end of the world, we could
call add a trivial .dts file that includes the original one and puts
in the correct address into the ranges property.

> > Since you explained that we want to move the internal registers to get
> > more available memory, I think what you also want to do is to
> > dynamically reassign the internal register mapping when the mbus
> > driver gets loaded, just like all the other mbus mappings.
> 
> Ideally, it should be like this. Unfortunately, moving the internal
> register mapping is really a painful operation: you have to know where
> is the address to change the internal register base address (which
> itself changes when the internal register base address changes), and all
> code interacting with peripherals before the change of the address must
> be synchronized so that after the switch it uses the new address.

But you are proposing a patch set that does exactly this, so it's
clearly possible, right?

> Switching the internal registers address at runtime after a lot of
> things have booted is *painful* and we really don't want to do that.
> Sebastian Hesselbarth, who has worked on the topic, will confirm this.

It can still be done really early, e.g. from map_io(), since that is
run at a time when we have access to the DT and are not using any
devices other than the debug_ll code that is already a hack.

> We've gone through great lengths to find a solution that does not
> touch *any* ARM generic code (even though it would have been much
> simpler!). At least one Marvell maintainer (Andrew Lunn) is fine with
> this temporary solution, and since the issue is very SoC-specific, and
> completely self-contained in the SoC-specific code, would it be
> possible to be pragmatic and let us merge such a workaround?

Maybe you can put the hack into a separate board file that gets used
only for the two boards that need it and is enabled optionally?
The part that is really worrying about your patch is that you essentially
make an undocumented extension to the boot protocol to silently ignore
the information from the official interface and use a hardcoded value
instead, for all boards in that platform.

If you make a hack there, at least make it blatently obvious that
something is wrong when you work around it:

* allow the hack only for known broken machines (e.g. OpenBlocks
  with the internal registers at 0xf1), on all other machines
  trust the DT information.

* When you detect a mismatch between DT and the hardware setup
  as passed by the boot loader, print a fat warning.

* Fix it up by modifying the DT in memory to match the actual
  hardware configuration, not by making the hardware match the DT.

* If you ever want to get rid of the hack, put a time-bomb it in
  right away, like "BUG_ON(LINUX_VERSION_CODE > KERNEL_VERSION(3,14,0))"

	Arnd
