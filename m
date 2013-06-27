From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 27 Jun 2013 11:29:34 +0200
Subject: [PATCH 0/2] arm: add early_ioremap() support
In-Reply-To: <3503040.vhYAL5xGgS@wuerfel>
References: <1372182401-11029-1-git-send-email-leif.lindholm@linaro.org>
 <201306270013.55333.arnd@arndb.de>
 <20130626232504.GB18151@rocoto.smurfnet.nu>
 <3503040.vhYAL5xGgS@wuerfel>
Message-ID: <20130627092934.GD18151@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 10:47:21AM +0200, Arnd Bergmann wrote:
> > No, the purpose is just like for x86 - do early parsing of things like
> > the UEFI system and configuration tables, DMI and ACPI, in order to
> > populate global structs and stuff.
> 
> But are those tables actually in MMIO registers? I thought they
> are just memory, and in that case using any form of ioremap is
> wrong on ARM. Why do you even have to map them? Can't the boot
> loader pass those tables in regular addressable memory?
 
Don't get too stuck on the name - x86 frequently uses *ioremap() in
many places when just accessing memory, and that has carried into EFI,
ACPI and DMI subsystems, which we now want to use on ARM. In fact, they
have early_memremap(), but don't use it for either EFI or ACPI.

The ia64 implementation actually performs a lookup in the EFI memmap
to decide whether early_ioremap() returns cacheable memory or not
(and falls back to noncacheable before memory map is available).

That said, I had somehow managed to get into my mind that the kernel
used -fno-unaligned-access, so thought MT_DEV_NONSHARED was safe.
Clearly it isn't, so that will need to change, making the semantic
match even worse...

As for the need of mapping - some of these descriptors are needed very
early in the boot process. Also, depending on platform, they may reside
at any offset from start of RAM (<2^32 physical address), rendering
__va()/__phys_to_virt()/... unusable.

> > Well, I did have a crazy idea that much/most of the early_ioremap code
> > could be made generic and shared between x86 and arm (and any other
> > 32-bit architecture). Using the fixmap macros would make that possible
> > with a minimum of ifdefs.
> > 
> > If we ever wanted early_ioremap() to work like on x86, beyond kmap_init()
> > (but not beyond the "booting" system state), using the same macros would
> > help there too. I had no need for that for my EFI patches.
> 
> I guess I need to look at the EFI patches first. It sounds to me
> like you shouldn't actually be using early_ioremap here or on another
> architecture.

No, but I had been kind of hoping not having to rework the early memory
initialisation for three subsystems on two other platforms in order to
be able to merge common code between them. And it would have felt silly
to invent a new mechanism just for ARM, preventing that option.

/
    Leif
