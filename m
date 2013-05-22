From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 18:08:42 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305221735.11815.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de>
Message-ID: <20130522180842.7edcc3ee@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 22 May 2013 17:35:11 +0200, Arnd Bergmann wrote:

> Ok, but going back to the discussion about remapping physical memory
> addresses, would you actually be able to map more of the available
> RAM when the registers are moved out of the way?

Yes, we can.

> IIRC the translation is rather coarse-grained, and the new location
> is still in the same 1GB window from 0xc0000000-0xffffffff.

We have four different CS for RAM, and therefore when we have 8 GB of
RAM installed, if the internal registers are at 0xD0000000, we loose
768 MB of RAM. When they are mapped at 0xF1000000, we loose only 256 MB
of RAM. A win of 512 MB of RAM, which is not negligible.

And the new bootloaders that are remapping to 0xf1000000 on Armada
370/XP are already being shipped by Marvell, so it's not like we have
much choice here.

> > > > So, the new generation of bootloaders that are shipped on new Marvell
> > > > Armada 370/XP platforms are doing the remapping at 0xF1000000 prior to
> > > > starting Linux. The current kernel cannot boot on such platforms.
> > > 
> > > Does it boot if you disable the DEBUG_LL code and apply your
> > > patches 1-8?
> > 
> > Patches 1-8 do not change anything in terms of the internal register
> > window base address. So just like the kernel was working with and
> > without DEBUG_LL before patches 1-8, it continues to work after those
> > cleanups/improvements.
> 
> I mean with the new boot loader which breaks unmodified kernels.

If you boot the kernel with, or without 1-8, it will not boot with a
new bootloader. Only if you apply the 9th patch will it work. And the
kernel will continue to work with both an old and a new bootloader.

> > I'm sorry, but I don't follow you here. When you have patches 1-8 (or
> > no patch applied at all), the UART for mach-mvebu is *always* at
> > 0xd0012000.
> 
> No. UART0 is always at 0xd0012000 but there are also UARTs at 0xd0012100,
> 0xd0012200 and 0xd0012300. You don't currently support using them for
> early output, but you might need to add that, similar to how other
> SoC platforms handle this.

Right.

> More importantly, you can build a kernel with any number of other SoCs
> already, and if you have a combined ArmadaXP+OMAP+Highbank kernel,
> there is no way to get a working early debug output.

So you're proposing to add two Kconfig options, one to have the UART at
0xd0012000 and the other one to have the UART at 0xf1012000. The user
would have to know whether he is going to boot with an old bootloader
or new bootloader, and select the appropriate option. This means that
the mvebu_defconfig would no longer be able to have earlyprintk enabled
by default, otherwise the resulting kernel may not boot for some
people, but maybe it's a reasonable tradeoff.

> > > As you already admit, using the CP15 register is a hack. It sounds
> > > to me that a cleaner approach would be to put the correct address
> > > into the device tree and use that value everywhere, rather than
> > > hardcoding one or more addresses.
> > 
> > I don't see how this can fix the problem. Which internal register base
> > address do we put in our Device Tree source in arch/arm/boot/dts? The
> > old one? The new one?
> 
> The one matching the boot loader for that board, i.e. the new address
> for all boards but Mirabox and OpenBlocks.

And what happens when Globalscale (Mirabox manufacturer) or Plathome
(manufacturer of OpenBlocks) release a new bootloader version, based on
the new bootloader from Marvell, which remaps things at 0xf1000000 ? Or
when those people boot from Barebox, which remaps at 0xf1000000 ?

Conclusion: you can't classify on one side boards that are at 0xd0 and
boards that are at 0xf1. It depends on *which* bootloader each
particular instance of those boards will be using. Will it be a
bootloader that complies with the "old" protocol (CP15 bit cleared and
registers at 0xd0) or the "new" protocol (CP15 bit set and registers at
0xf1).

So we can't encode into the boards Device Tree whether the registers
are at 0xd0 or 0xf1, because it's not a board-related information, but
a bootloader-related information.

> > > > Unfortunately, tweaking ->map_io() is not sufficient: we also want
> > > > earlyprintk to work. And earlyprintk is used *before* ->map_io() is
> > > > called, and *after* ->map_io() is called.
> > > 
> > > Note that by the time map_io is called, we no longer care about
> > > the physical address, since the uart is only accessed through the
> > > virtual mapping after __enable_mmu.
> > 
> > That's not correct. ->map_io() calls debug_ll_io_init(), which calls
> > the addruart code of earlyprintk, from which it gets the virtual
> > address *AND* physical address of the UART, and sets up a mapping with
> > create_mapping(). See the implementation of debug_ll_io_init().
> 
> Ah right, but that is also something that could easily be changed.

I must admit I'm not sure why we have this debug_ll_io_init() function.
When DEBUG_LL is enabled, there is already a call to addruart from
arch/arm/kernel/head.S, which does create a virtual -> physical mapping
that covers the UART area. Since debug_ll_io_init() is also only
enabled under DEBUG_LL, I am not sure to understand what it does that
the assembly code in arch/arm/kernel/head.S hasn't done already. Adding
Rob in Cc, as he's the one who added debug_ll_io_init() in the first
place.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
