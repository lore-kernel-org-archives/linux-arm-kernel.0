From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jun 2013 10:47:21 +0200
Subject: [PATCH 0/2] arm: add early_ioremap() support
In-Reply-To: <20130626232504.GB18151@rocoto.smurfnet.nu>
References: <1372182401-11029-1-git-send-email-leif.lindholm@linaro.org>
 <201306270013.55333.arnd@arndb.de>
 <20130626232504.GB18151@rocoto.smurfnet.nu>
Message-ID: <3503040.vhYAL5xGgS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 June 2013 01:25:06 Leif Lindholm wrote:
> On Thu, Jun 27, 2013 at 12:13:55AM +0200, Arnd Bergmann wrote:
> > > Sorry, I still don't get it. Are you saying that kmap_atomic is
> > > available before kmap_init() (in paging_init())?
> > > 
> > > If not, all of my mappings are discarded (well, abandoned to be more
> > > correct), so I don't see how it affects kmap.
> > 
> > Sorry, I was under the assumption that the mappings are meant to
> > stay around.
>  
> Ok, just so I'm not completely lost 
> 
> No, the purpose is just like for x86 - do early parsing of things like
> the UEFI system and configuration tables, DMI and ACPI, in order to
> populate global structs and stuff.

But are those tables actually in MMIO registers? I thought they
are just memory, and in that case using any form of ioremap is
wrong on ARM. Why do you even have to map them? Can't the boot
loader pass those tables in regular addressable memory?

> > > Indeed - almost immediately.
> > > 
> > > x86 early_ioremap can coexist with kmap; the intent of my
> > > implementation is to use the kmap region only before kmap is available.
> > 
> > So if you never plan to use fixmap and early_ioremap at the same time,
> > why even bother using the fixmap code? Wouldn't it be easier to just
> > use the same memory area and ensure we never use fixmap before 
> > we're done with early_ioremap?
> 
> Well, I did have a crazy idea that much/most of the early_ioremap code
> could be made generic and shared between x86 and arm (and any other
> 32-bit architecture). Using the fixmap macros would make that possible
> with a minimum of ifdefs.
> 
> If we ever wanted early_ioremap() to work like on x86, beyond kmap_init()
> (but not beyond the "booting" system state), using the same macros would
> help there too. I had no need for that for my EFI patches.

I guess I need to look at the EFI patches first. It sounds to me
like you shouldn't actually be using early_ioremap here or on another
architecture.

	Arnd
