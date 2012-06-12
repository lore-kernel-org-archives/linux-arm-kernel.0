From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 13:49:27 +0000
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201206121349.27696.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Gregory CLEMENT wrote:
> You'll find in this patch set the new version of the initial support for a
> new family of ARMv7-compatible Marvell SoCs initially submitted by my
> colleague Thomas Petazzoni. Following the conclusion of the discussion when
> we submitted our first version we have chosen to add this support for this
> SoC family in the to support in the arch/arm/mach-mvebu/ directory.
> 
> As for the previous release, both the Armada 370 and the Armada XP SoCs are
> supported in this directory, and we are able to build a single kernel image
> that boots on both SoCs. Both SoCs use the PJ4B processor, a
> Marvell-developed ARM core that implements the ARMv7 instruction set. We are
> currently using Marvell evaluation boards for both of those SoCs, and the
> support for those boards is added in this patch set.

Ok, very good.

> Andrew Lunn asked for refactoring the _restart() function to being used by
> any MVEBU SOC, but we didn't find a nice way to do it. Indeed the registers
> mapping differs between the SOC and the bit mask too. A solution could be to
> get this mapping through the device tree, but we are not sure it was a good
> usage of the device tree.

As I suggested in my reply to patch 4/8, I think this can be encapsulated
in one file that acts as a driver for the generic ("bridge regs") registers
and provides functions for that based on the "compatible" property.

On a more general note, I'd prefer to have the patches renaming the existing
files first for the mach-mvebu directory first, and then adding your patches
on top.

I can provide a new version of the patch I did once we have agreement on what
goes where. I've put some more thought into it and the best I could come up
with is now.

arch/arm/mach-{orion5x,dove,kirkwood,mv78xx0}/include/mach/*
	-> arch/arm/mach-mvebu/include/mach/
arch/arm/plat-orion/include/plat/*
	-> arch/arm/mach-mvebu/include/mach/
arch/arm/plat-orion/*
	-> arch/arm/mach-mvebu/
arch/arm/mach-{orion5x,dove,kirkwood,mv78xx0}/{add-map,common,irq,mpp,pci}.*
	-> arch/arm/mach-mvebu/
arch/arm/mach-kirkwood/board-* (DT files)
	-> arch/arm/mach-mvebu/

This is basically the same as the patch I sent out before, but with the
new machine name, and leaving all the *-setup.c files in their existing
locations, where they can either get removed after being converted to DT
or after being assumed dead.

	Arnd
