From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 23:08:23 +0000
Subject: [PATCH 1/4] cns3xxx: Add basic support for Cavium Networks
	CNS3xxx processors
In-Reply-To: <20100326132257.GA23201@oksana.dev.rtsoft.ru>
References: <20100325200851.GA6470@oksana.dev.rtsoft.ru>
	<20100325201040.GA8014@oksana.dev.rtsoft.ru>
	<20100325202308.GA24984@n2100.arm.linux.org.uk>
	<20100326132257.GA23201@oksana.dev.rtsoft.ru>
Message-ID: <20100326230823.GE29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 04:22:57PM +0300, Anton Vorontsov wrote:
> > > +++ b/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
> [...]
> > > +#define VMALLOC_END		(PAGE_OFFSET + 0x18000000)
> > 
> > This should be defined as the maximum address of the vmalloc area,
> > which should be independent of PAGE_OFFSET.
> 
> Ah, vmalloc has no fixed start address. Will fix.
> 
> But then arm/mm/mmu.c:create_mapping() wrongly assumes that vmalloc
> starts at PAGE_OFFSET? At least it has 'md->virtual >= PAGE_OFFSET &&
> md->virtual < VMALLOC_END' check, and prints 'overlaps vmalloc space'
> error.

No it does not.  You can't create device mappings inbetween PAGE_OFFSET
and VMALLOC_END, and that is what the test you point out is doing.

The print can be extended to be "overlaps kernel direct mapped RAM and vmalloc space"
but I think that's getting excessively long.
