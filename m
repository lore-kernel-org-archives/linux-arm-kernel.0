From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 16:33:46 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201305221633.46705.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 May 2013, Thomas Petazzoni wrote:
> Unfortunately, for Armada 370 and Armada XP, the current generation of
> bootloaders that are being shipped on Marvell evaluation boards, but
> also on products like the Plathome OpenBlocks AX3 or the Globalscale
> Mirabox do not do the remapping, and are leaving the internal
> registers at 0xD0000000.
> 
> However, this is causing some problems:
> 
>  1 The internal registers window sits at 3 GB, in the middle of the
>    0-4 GB area of physical memory, which is quite annoying when you
>    have more than 3 GB of memory. Having them at 0xF1000000 means that
>    you lose less RAM when you have more than 3 GB of physical memory
>    installed. And since Armada XP is LPAE capable, you can even have
>    more than 4 GB memory: we already have boards with 8 GB of memory
>    installed.

Just for completeness:

Do any of the machines that use the old boot loader have more
than 3 GB of memory?

>  2 This is different from Kirkwood and Dove, which makes sharing some
>    early code like earlyprintk complicated, while our goal is
>    ultimately to merge all Marvell EBU platforms into mach-mvebu.
> 
> (1) is really the primary motivation here, (2) is only a nice
> side-effect.
> 
> So, the new generation of bootloaders that are shipped on new Marvell
> Armada 370/XP platforms are doing the remapping at 0xF1000000 prior to
> starting Linux. The current kernel cannot boot on such platforms.

Does it boot if you disable the DEBUG_LL code and apply your
patches 1-8? The reason I'm asking is that you already cannot have
DEBUG_LL on a multiplatform kernel targeted at systems which don't
use the same UART. Adding a further restriction that they must map
the internal registers to the same physical address does not change
this a lot.

> Therefore, the last patch of this series adds some early code in the
> kernel, at the ->map_io() stage, to switch the internal registers from
> 0xD0000000 to 0xF1000000 if this has not been done already by the
> bootloader. As it was explained above, we unfortunately can't read the
> current base address of the internal register window, so we need a
> different mechanism to know if the bootloader has done the remapping
> at 0xF1000000 (new generation bootloader) or has left the internal
> registers at 0xD0000000 (old generation bootloader). In order to
> distinguish between those two cases, a CP15 bit is being used. Old
> bootloaders do not touch this CP15, so it is set to 0. New bootloaders
> set this CP15 bit to 1, so that the kernel knows that the remapping
> has already been done. The ->map_io() code looks at this bit to know
> if the remapping should be done or not.

As you already admit, using the CP15 register is a hack. It sounds
to me that a cleaner approach would be to put the correct address
into the device tree and use that value everywhere, rather than
hardcoding one or more addresses.

> Unfortunately, tweaking ->map_io() is not sufficient: we also want
> earlyprintk to work. And earlyprintk is used *before* ->map_io() is
> called, and *after* ->map_io() is called.

Note that by the time map_io is called, we no longer care about
the physical address, since the uart is only accessed through the
virtual mapping after __enable_mmu.

	Arnd
