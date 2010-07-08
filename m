From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Jul 2010 20:01:33 +0900
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on	S5PV210/S5PC110.
In-Reply-To: <20100708080232.GA5297@n2100.arm.linux.org.uk>
References: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
	<20100706071245.GA5058@n2100.arm.linux.org.uk>
	<013001cb1d62$de72ff30$9b58fd90$%kim@samsung.com>
	<20100707075622.GA21830@n2100.arm.linux.org.uk>
	<01be01cb1e30$b2d52e10$187f8a30$%kim@samsung.com>
	<20100708080232.GA5297@n2100.arm.linux.org.uk>
Message-ID: <020101cb1e8c$f01d7c30$d0587490$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> On Thu, Jul 08, 2010 at 09:01:16AM +0900, Kukjin Kim wrote:
> > Ok...let's suppose the size of section is 32MiB.
> >
> >             Physical Mem.    Sections
> >                   .              .
> >                   .              .
> >                   .              .
> >             |          |    |          |
> > 0x30000000  ------------    ------------  0x30000000
> >             |          |    |  offline |
> >             |          |    ------------  0x2C000000
> >             |          |    |  offline |
> >             |          |    ------------  0x2A000000
> >             |   none   |    |  offline |
> >             |          |    ------------  0x28000000
> >             |          |    |  offline |
> >             |          |    ------------  0x26000000
> > 0x25000000  ------------    |  *online |
> >             |          |    ------------  0x24000000
> >             |          |    |  online  |
> >             |  80 MiB  |    ------------  0x22000000
> >             |          |    |  online  |
> > 0x20000000  ------------    ------------  0x20000000
> >
> > In the above diagram, *section includes a 'hole' that is invalid online
area
> > between 0x25000000 and 0x26000000.
> 
> So, memory starts at 0x20000000 and finishes at 0x25000000.  That's fine.
> That doesn't mean the section size is 16MB.
> 
> As I've already said, the section size has _nothing_ what so ever to do
> with the size of memory, or the granularity of the size of memory.  By
> way of illustration, it is perfectly legal to have a section size of
> 256MB but only have 1MB in a section and this is perfectly legal.  So
> sections do not have to be completely filled.
> 
Actually, as you know, the hole's area of mem_map is freed from bootmem if a
section has a hole when initializing sparse memory.

I identified that a section doesn't need to be a contiguous area of physical
memory when reading your comment with the fact that the mem_map of a section
can be smaller than the size of a section.

I found, however, the kernel panics when modifying min_free_kbytes file in
the proc filesystem if a section has a hole.

While processing the change of min_free_kbytes in the kernel, page
descriptors in a hole of an online section is accessed.

Hmm...

> > > > > Also, what is the maximum physical address which memory can be
> > located?
> > > >
> > > > Following is memory map of S5PV210/S5PC110.
> > > >
> > > > 0x80000000  -------------------
> > > >             |          |
> > > > 0x70000000  |          |
> > > >             |          |
> > > > 0x60000000  |  DMC 1  |  up to 1GiB
> > > >             |          |
> > > > 0x50000000  |          |
> > > >             |          |
> > > > 0x40000000  -----------------
> > > >             |          |
> > > > 0x30000000  |  DMC 0  |  up to 512MiB
> > > >             |          |
> > > > 0x20000000  -------------------
> 
> So from this diagram, the sections should be 512MB - SECTION_SIZE_BITS
> should be 28.

Maybe typo...should be 29 when it is 512MiB.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
