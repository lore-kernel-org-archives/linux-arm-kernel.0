From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 16:47:36 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305231612.42395.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305222236.12652.arnd@arndb.de> <20130523120248.51a85f50@skate>
 <201305231612.42395.arnd@arndb.de>
Message-ID: <20130523164736.610fc55d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 23 May 2013 16:12:42 +0200, Arnd Bergmann wrote:

> > Ideally, we'd like to completely forget about supporting old
> > bootloaders, and assume we only have good bootloaders that remap
> > things to 0xf1. We're only proposing this *temporary* solution to
> > make the transition easier, give some time to the board
> > manufacturers to release updated bootloaders, to users to upgrade
> > their bootloaders, and finally remove this temporary solution.
> > 
> > We clearly don't want to go down the road of supporting an
> > arbitrarily-defined base address for the internal registers. This
> > has never been the case for Kirkwood, Orion5x, Dove, and there is no
> > compelling reason to make it a requirement for Armada 370/XP.
> 
> Well, the main reason I see now is that Marvell screwed it up by
> having two incompatible versions of u-boot. Using a different base
> address on new machines would have been no problem at all, but
> supporting the same machine with different addresses depending on the
> boot loader version is madness. As you say, it's too late to change
> that now, so maybe the best solution is to make the registers always
> get reassigned. 5 trick.

Not sure what you mean by '5 trick', and what I should understand from
this :(

> > What do you mean by "we know what boot loader we have when we pass
> > the devicetree" ?
> > 
> > The mere user of the kernel just does:
> > 
> > 	make ARCH=arm mvebu_defconfig
> > 	make ARCH=arm CROSS_COMPILE=...
> > 	cat arch/arm/boot/zImage
> > arch/arm/boot/dts/armada-370-mirabox.dtb > zImage.mirabox ...
> > prepare uImage ...
> > 
> > and he certainly doesn't want to understand the gory details of
> > which internal register base address to chose depending on which
> > bootloader version he is using. This is really asking normal users
> > to have a too much intimate knowledge of the hardware details.
> 
> Right, appended device tree is a problem, but if a user does that, I
> think we can rightfully expect them to know what they are doing.

Unfortunately, not really. Appended Device Tree is the only way to go
for old bootloaders, and we don't want users of such bootloaders to
have to modify their Device Tree to change the base address of the
internal registers.

> > The temporary solution we're proposing doesn't have this drawback:
> > an user can boot the kernel on either an old or new bootloader,
> > without having to worry about checking/changing the Device Tree
> > source about this bizarre internal register address thing.
> > 
> > As a developer of the Armada 370/XP, I am frequently contacted by
> > users to help them getting the mainline kernel booting on their
> > Mirabox or OpenBlocks. And trust me: even getting the appended DTB
> > gymnastic right is not easy. So getting this internal register
> > story right is going to be a nightmare in terms of support.
> > 
> > Please do not inflict to us such a support pain :-)
> 
> I think we should consequently make sure we never get a production
> u-boot for Mirabox or OpenBlocks that changes the internal register
> address and also allows ATAGS based booting.

It is impossible to prevent that. U-Boot always supports ATAGs booting
for ARM, and optionally Device Tree based booting.

And once again, you believe we have an enormous control over what is
happening at the bootloader level. So when you say "we should
consequently make sure ..", this is simply not possible: we have no
control over this.

> Either those machines continue to use the 0xd0 address for the
> internal registers, or they must ensure to fix up the device tree
> properly.

We don't have such control over bootloaders. I believe Marvell has done
a great achievement by pushing all this Armada 370/XP code to the
mainline kernel. However, they are not (yet) at the same level of
open-source involvement as far as bootloaders are concerned, so we have
little control over that. I'm hoping that the situation will evolve
over time, but for now, we have to live with the assumption that the
control we have over what the bootloader is doing is minimal.

So any solution you propose with "the bootloader should do X or Y" will
unfortunately not work practically for us.

> Since you explained that we want to move the internal registers to get
> more available memory, I think what you also want to do is to
> dynamically reassign the internal register mapping when the mbus
> driver gets loaded, just like all the other mbus mappings.

Ideally, it should be like this. Unfortunately, moving the internal
register mapping is really a painful operation: you have to know where
is the address to change the internal register base address (which
itself changes when the internal register base address changes), and all
code interacting with peripherals before the change of the address must
be synchronized so that after the switch it uses the new address.

Switching the internal registers address at runtime after a lot of
things have booted is *painful* and we really don't want to do that.
Sebastian Hesselbarth, who has worked on the topic, will confirm this.

So, just like it has been the case for years in Kirkwood, Dove and
Orion5x, Armada 370/XP will have their registers mapped at 0xf1000000
when the kernel is booted. As far as Linux is concerned, it should
assume that the base address of the register is *not* configurable,
just like it is the case for many other ARM SoCs.

What we're only asking is to have a temporary, SoC-specific, workaround
to ease the transition towards this goal.

We've gone through great lengths to find a solution that does not
touch *any* ARM generic code (even though it would have been much
simpler!). At least one Marvell maintainer (Andrew Lunn) is fine with
this temporary solution, and since the issue is very SoC-specific, and
completely self-contained in the SoC-specific code, would it be
possible to be pragmatic and let us merge such a workaround?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
