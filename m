From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Jul 2010 09:01:16 +0900
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on	S5PV210/S5PC110.
In-Reply-To: <20100707075622.GA21830@n2100.arm.linux.org.uk>
References: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
	<20100706071245.GA5058@n2100.arm.linux.org.uk>
	<013001cb1d62$de72ff30$9b58fd90$%kim@samsung.com>
	<20100707075622.GA21830@n2100.arm.linux.org.uk>
Message-ID: <01be01cb1e30$b2d52e10$187f8a30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> On Wed, Jul 07, 2010 at 08:27:53AM +0900, Kukjin Kim wrote:
> > Russell King wrote:
> > > What is the spacing of chunks of memory, and minimum alignment of
those
> > > chunks in physical address space?
> >
> > Some S5PC110(MCP D-type) has only available 80MiB in a bank.
> > So the space accounts for 432MiB in a DMC0, but larger memory(256MiB +
> > 128MiB) exists in a DMC1.
> 
> Ok.
> 
> > As you know, the size of a section should be a power of 2 and a physical
> > address space of a section should be contiguous.
> > If a section size is greater than 16MiB, a section have a hole. So the
> > SECTION_SIZE_BITS should be 16MiB.
> 
> Where is this hole?  Please show it as a diagram similar to the one
> you've produced below.
> 
Ok...let's suppose the size of section is 32MiB.

            Physical Mem.    Sections
                  .              .
                  .              .
                  .              .
            |          |    |          | 
0x30000000  ------------    ------------  0x30000000
            |          |    |  offline |
            |          |    ------------  0x2C000000
            |          |    |  offline |
            |          |    ------------  0x2A000000
            |   none   |    |  offline |
            |          |    ------------  0x28000000
            |          |    |  offline |
            |          |    ------------  0x26000000
0x25000000  ------------    |  *online |
            |          |    ------------  0x24000000
            |          |    |  online  |
            |  80 MiB  |    ------------  0x22000000
            |          |    |  online  |
0x20000000  ------------    ------------  0x20000000

In the above diagram, *section includes a 'hole' that is invalid online area
between 0x25000000 and 0x26000000.

> > > Also, what is the maximum physical address which memory can be
located?
> >
> > Following is memory map of S5PV210/S5PC110.
> >
> > 0x80000000  -------------------
> >             |          |
> > 0x70000000  |          |
> >             |          |
> > 0x60000000  |  DMC 1  |  up to 1GiB
> >             |          |
> > 0x50000000  |          |
> >             |          |
> > 0x40000000  -----------------
> >             |          |
> > 0x30000000  |  DMC 0  |  up to 512MiB
> >             |          |
> > 0x20000000  -------------------
> 
> Right, so MAX_PHYSMEM_BITS is 31 and not 32 as you don't have memory
> at or above 0x80000000.  This will immediately halve the amount of
> sparsemem supporting structures irrespective of the SECTION_SIZE_BITS
> value.

Ok..will fix it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
