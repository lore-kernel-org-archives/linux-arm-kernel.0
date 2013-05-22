From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 17:06:43 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305221633.46705.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de>
Message-ID: <20130522170643.54a2b9d2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 22 May 2013 16:33:46 +0200, Arnd Bergmann wrote:

> >  1 The internal registers window sits at 3 GB, in the middle of the
> >    0-4 GB area of physical memory, which is quite annoying when you
> >    have more than 3 GB of memory. Having them at 0xF1000000 means that
> >    you lose less RAM when you have more than 3 GB of physical memory
> >    installed. And since Armada XP is LPAE capable, you can even have
> >    more than 4 GB memory: we already have boards with 8 GB of memory
> >    installed.
> 
> Just for completeness:
> 
> Do any of the machines that use the old boot loader have more
> than 3 GB of memory?

As Gregory said: yes. The Armada XP GP board has 8 GB of RAM. And the
OpenBlocks has 1 GB soldered, and an expansion slot in which you can
add more RAM, possibly over 3 GB.

> >  2 This is different from Kirkwood and Dove, which makes sharing some
> >    early code like earlyprintk complicated, while our goal is
> >    ultimately to merge all Marvell EBU platforms into mach-mvebu.
> > 
> > (1) is really the primary motivation here, (2) is only a nice
> > side-effect.
> > 
> > So, the new generation of bootloaders that are shipped on new Marvell
> > Armada 370/XP platforms are doing the remapping at 0xF1000000 prior to
> > starting Linux. The current kernel cannot boot on such platforms.
> 
> Does it boot if you disable the DEBUG_LL code and apply your
> patches 1-8?

Patches 1-8 do not change anything in terms of the internal register
window base address. So just like the kernel was working with and
without DEBUG_LL before patches 1-8, it continues to work after those
cleanups/improvements.

> The reason I'm asking is that you already cannot have
> DEBUG_LL on a multiplatform kernel targeted at systems which don't
> use the same UART. Adding a further restriction that they must map
> the internal registers to the same physical address does not change
> this a lot.

I'm sorry, but I don't follow you here. When you have patches 1-8 (or
no patch applied at all), the UART for mach-mvebu is *always* at
0xd0012000.

> > Therefore, the last patch of this series adds some early code in the
> > kernel, at the ->map_io() stage, to switch the internal registers from
> > 0xD0000000 to 0xF1000000 if this has not been done already by the
> > bootloader. As it was explained above, we unfortunately can't read the
> > current base address of the internal register window, so we need a
> > different mechanism to know if the bootloader has done the remapping
> > at 0xF1000000 (new generation bootloader) or has left the internal
> > registers at 0xD0000000 (old generation bootloader). In order to
> > distinguish between those two cases, a CP15 bit is being used. Old
> > bootloaders do not touch this CP15, so it is set to 0. New bootloaders
> > set this CP15 bit to 1, so that the kernel knows that the remapping
> > has already been done. The ->map_io() code looks at this bit to know
> > if the remapping should be done or not.
> 
> As you already admit, using the CP15 register is a hack. It sounds
> to me that a cleaner approach would be to put the correct address
> into the device tree and use that value everywhere, rather than
> hardcoding one or more addresses.

I don't see how this can fix the problem. Which internal register base
address do we put in our Device Tree source in arch/arm/boot/dts? The
old one? The new one?

Again, I'd like people to carefully read and read once again the cover
letter and commit log before jumping into the conclusion that 'CP15 is
a hack', and come up with a solution that seriously takes into account
all the problems that are highlighted in the cover letter and commit
log. "Putting the correct address into the device tree and use that
value everywhere" simply doesn't work for earlyprintk, for example.

I'm afraid that the only alternative to the proposed solution is to
unconditionally assume that the switch to the 0xf1000000 base address
has been made by the bootloader. This will work for all new Marvell
platforms, but will break all existing users of Mirabox and OpenBlocks
platform.

> > Unfortunately, tweaking ->map_io() is not sufficient: we also want
> > earlyprintk to work. And earlyprintk is used *before* ->map_io() is
> > called, and *after* ->map_io() is called.
> 
> Note that by the time map_io is called, we no longer care about
> the physical address, since the uart is only accessed through the
> virtual mapping after __enable_mmu.

That's not correct. ->map_io() calls debug_ll_io_init(), which calls
the addruart code of earlyprintk, from which it gets the virtual
address *AND* physical address of the UART, and sets up a mapping with
create_mapping(). See the implementation of debug_ll_io_init().

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
