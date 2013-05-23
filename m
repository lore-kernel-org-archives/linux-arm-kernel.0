From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 14:23:01 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305222240.05124.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <201305222240.05124.arnd@arndb.de>
Message-ID: <20130523142301.10dbeff9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 22 May 2013 22:40:04 +0200, Arnd Bergmann wrote:

> > So you're proposing to add two Kconfig options, one to have the UART at
> > 0xd0012000 and the other one to have the UART at 0xf1012000. The user
> > would have to know whether he is going to boot with an old bootloader
> > or new bootloader, and select the appropriate option. This means that
> > the mvebu_defconfig would no longer be able to have earlyprintk enabled
> > by default, otherwise the resulting kernel may not boot for some
> > people, but maybe it's a reasonable tradeoff.
> 
> Yes. It may also be reasonable to use the CP15 hack for DEBUG_LL, but
> I would not like to see that information getting used anywhere in the
> kernel outside of DEBUG_LL. That should really come from the DT.

Ok.

> > And what happens when Globalscale (Mirabox manufacturer) or Plathome
> > (manufacturer of OpenBlocks) release a new bootloader version, based on
> > the new bootloader from Marvell, which remaps things at 0xf1000000 ? Or
> > when those people boot from Barebox, which remaps at 0xf1000000 ?
> > 
> > Conclusion: you can't classify on one side boards that are at 0xd0 and
> > boards that are at 0xf1. It depends on which bootloader each
> > particular instance of those boards will be using. Will it be a
> > bootloader that complies with the "old" protocol (CP15 bit cleared and
> > registers at 0xd0) or the "new" protocol (CP15 bit set and registers at
> > 0xf1).
> > 
> > So we can't encode into the boards Device Tree whether the registers
> > are at 0xd0 or 0xf1, because it's not a board-related information, but
> > a bootloader-related information.
> 
> The new boot loaders will of course know that they are remapping the
> registers, so they are also able to put the correct information into the
> DT.

But that's *not* the case. Neither the old nor the new bootloaders are
changing the Device Tree in any way that allows us to know whether
registers are mapped at 0xd0 and 0xf1. Those bootloaders are already in
the field, and we have little control over that. Even if we had
control, what we would tell Marvell to implement in their U-Boot,
today? The DT binding of the mbus driver is not complete, and therefore
the mechanism to specify the location of the internal registers is
going to change when we introduce the DT binding for the mbus driver.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
