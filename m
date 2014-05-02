From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 May 2014 17:13:46 +0200
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <53639A0C.8070306@ti.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <5279118.J5305KQNjB@wuerfel> <53639A0C.8070306@ti.com>
Message-ID: <4526988.X68ZFJZdRl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 May 2014 09:13:48 Santosh Shilimkar wrote:
> On Friday 02 May 2014 05:58 AM, Arnd Bergmann wrote:
> > On Thursday 01 May 2014 14:12:10 Grant Likely wrote:
> >>>> I've got two concerns here. of_dma_get_range() retrieves only the first
> >>>> tuple from the dma-ranges property, but it is perfectly valid for
> >>>> dma-ranges to contain multiple tuples. How should we handle it if a
> >>>> device has multiple ranges it can DMA from?
> >>>>
> >>>
> >>> We've not found any cases in current Linux where more than one dma-ranges
> >>> would be used. Moreover, The MM (definitely for ARM) isn't supported such
> >>> cases at all (if i understand everything right).
> >>> - there are only one arm_dma_pfn_limit
> >>> - there is only one MM zone is used for ARM
> >>> - some arches like x86,mips can support 2 zones (per arch - not per device or bus)
> >>>   DMA & DMA32, but they configured once and forever per arch.
> >>
> >> Okay. If anyone ever does implement multiple ranges then this code will
> >> need to be revisited.
> > 
> > I wonder if it's needed for platforms implementing the standard "ARM memory map" [1].
> > The document only talks about addresses as seen from the CPU, and I can see
> > two logical interpretations how the RAM is supposed to be visible from a device:
> > either all RAM would be visible contiguously at DMA address zero, or everything
> > would be visible at the same physical address as the CPU sees it.
> > 
> > If anyone picks the first interpretation, we will have to implement that
> > in Linux. We can of course hope that all hardware designs follow the second
> > interpretation, which would be more convenient for us here.
> >
> not sure if I got your point correctly but DMA address 0 isn't used as DRAM start in
> any of the ARM SOC today, mainly because of the boot architecture where address 0 is
> typically used by ROM code. RAM start will be at some offset always and hence I
> believe ARM SOCs will follow second interpretation. This was one of the main reason
> we ended up fixing the max*pfn stuff. 
> 26ba47b {ARM: 7805/1: mm: change max*pfn to include the physical offset of memory}

Marvell normally has memory starting at physical address zero.

Even if RAM starts elsewhere, I don't think that is a reason to have
the DMA address do the same. The memory controller internally obviously
starts at zero, and it wouldn't be unreasonable to have the DMA space
match what the memory controller sees rather than have it match what
the CPU sees.

If you look at the table 3.1.4, you have both addresses listed:

	  Physical Addresses in SoC	Offset	 		Internal DRAM address

2 GBytes	0x00 8000 0000 ?	-0x00 8000 0000		0x00 0000 0000 ?
		0x00 FFFF FFFF			 		0x00 7FFF FFFF

30 GBytes	0x08 8000 0000 ? 	-0x08 0000 0000		0x00 8000 0000 ?
		0x0F FFFF FFFF					0x07 FFFF FFFF

32 GBytes	0x88 0000 0000 -	-0x80 0000 0000	 	0x08 0000 0000 -
		0x8F FFFF FFFF					0x0F FFFF FFFF

The wording "Physical Addresses in SoC" would indeed suggest that the
same address is used for DMA, but I would trust everybody to do that.

	Arnd
