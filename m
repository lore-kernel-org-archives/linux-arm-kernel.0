From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jul 2010 21:49:52 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <AANLkTilrLJb97NkK4Q-Oan_ufXRdafIw7n6060mItaXj@mail.gmail.com>
References: <001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092658.GB29885@csn.ul.ie>
	<20100713093815.GD20590@n2100.arm.linux.org.uk>
	<20100713095035.GE29885@csn.ul.ie>
	<20100713173744.GB30142@n2100.arm.linux.org.uk>
	<20100713203250.GA21600@csn.ul.ie>
	<AANLkTim55BDz4_vWhTnDVj1EP42MxAMZzP2PR80j5fLN@mail.gmail.com>
	<20100714084943.GA9115@n2100.arm.linux.org.uk>
	<AANLkTilrLJb97NkK4Q-Oan_ufXRdafIw7n6060mItaXj@mail.gmail.com>
Message-ID: <20100714204952.GD18138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 08:04:07PM +0900, Minchan Kim wrote:
> On Wed, Jul 14, 2010 at 5:49 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Jul 14, 2010 at 08:59:06AM +0900, Minchan Kim wrote:
> >> But I think Kukjin case's best solution is to make section size 16M, not 256M.
> >> Regardless of this, Your idea is the direction we should proceed, I think.
> >
> > So what if someone decides to fit 8MB DRAMs to the board?
> >
> 
> Hmm. It might be a problem.
> Should we consider all configuration?
> 
> Then, in below cases ram size never can change?
> How does it acked and merged?
> I don't know below board can't configurable ram size. Just out of curiosity.

All of these, SECTION_SIZE_BITS refers to the _spacing_ of memory, not
the minimum size of DRAM which can ever be fitted.

Reducing SECTION_SIZE_BITS is really not an option for some of these
platforms - just look at where memory starts in physical space:

arch/arm/mach-clps711x/include/mach/memory.h:#define PHYS_OFFSET UL(0xc0000000)
arch/arm/mach-clps711x/include/mach/memory.h:#define SECTION_SIZE_BITS  24
arch/arm/mach-lh7a40x/include/mach/memory.h:#define PHYS_OFFSET UL(0xc0000000)
arch/arm/mach-lh7a40x/include/mach/memory.h:#define SECTION_SIZE_BITS   24
arch/arm/mach-realview/include/mach/memory.h:#define PHYS_OFFSET UL(0x70000000)
arch/arm/mach-realview/include/mach/memory.h:#define SECTION_SIZE_BITS  28
arch/arm/mach-realview/include/mach/memory.h:#define PHYS_OFFSET UL(0x00000000)
arch/arm/mach-rpc/include/mach/memory.h:#define PHYS_OFFSET UL(0x10000000)
arch/arm/mach-rpc/include/mach/memory.h:#define SECTION_SIZE_BITS       26
arch/arm/mach-s5pv210/include/mach/memory.h:#define PHYS_OFFSET UL(0x20000000)
arch/arm/mach-s5pv210/include/mach/memory.h:#define SECTION_SIZE_BITS   28
arch/arm/mach-sa1100/include/mach/memory.h:#define PHYS_OFFSET UL(0xc0000000)
arch/arm/mach-sa1100/include/mach/memory.h:#define SECTION_SIZE_BITS    27

If physical memory starts at 3GB, with SECTION_SIZE_BITS set at 24,
there's 256 sections already.  Reducing SECTION_SIZE_BITS to the multiple
of RAM size will increase the number of sections to many thousands.
Clearly, sparsemem doesn't handle sparse memory very well, and is
defficient.

I don't know what the answer is to this; I'm totally fed up with being
pushed into using things, and then later down the line being told that
its all wrong and shouldn't be used like we are.  Maybe we should just
delete these sub-architectures which use sparsemem and say to people
that the kernel just doesn't support their memory layouts.

<depressed>.
