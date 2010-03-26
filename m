From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 26 Mar 2010 16:22:57 +0300
Subject: [PATCH 1/4] cns3xxx: Add basic support for Cavium Networks
	CNS3xxx processors
In-Reply-To: <20100325202308.GA24984@n2100.arm.linux.org.uk>
References: <20100325200851.GA6470@oksana.dev.rtsoft.ru>
	<20100325201040.GA8014@oksana.dev.rtsoft.ru>
	<20100325202308.GA24984@n2100.arm.linux.org.uk>
Message-ID: <20100326132257.GA23201@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 08:23:08PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 11:10:40PM +0300, Anton Vorontsov wrote:
[...]
> > +#include <mach/io.h>
> 
> linux/io.h please.

Will fix, thanks.

[...]
> > +	mi->bank[0].node = 0;
> 
> Can you not supply this via a built-in command line or a command line
> from the boot loader?

Yep, mem=128M is actually specified in the defconfig, and
this fixup is just a leftover. Will remove.

> > +++ b/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
[...]
> > +#define VMALLOC_END		(PAGE_OFFSET + 0x18000000)
> 
> This should be defined as the maximum address of the vmalloc area,
> which should be independent of PAGE_OFFSET.

Ah, vmalloc has no fixed start address. Will fix.

But then arm/mm/mmu.c:create_mapping() wrongly assumes that vmalloc
starts at PAGE_OFFSET? At least it has 'md->virtual >= PAGE_OFFSET &&
md->virtual < VMALLOC_END' check, and prints 'overlaps vmalloc space'
error.

> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index c4ed9f9..488bcb1 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -384,7 +384,7 @@ config CPU_FEROCEON_OLD_ID
> >  
> >  # ARMv6
> >  config CPU_V6
> > -	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
> > +	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE || ARCH_CNS3XXX
> 
> So I assume by this your platform can boot without having a processor of
> any kind?

:-) Will fix.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
