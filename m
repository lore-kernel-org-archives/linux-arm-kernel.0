From: sungjinn.chung@samsung.com (Sungjinn Chung)
Date: Thu, 03 Apr 2014 11:15:09 +0900
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <20140402152455.GB24018@arm.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
 <7050133.LRSn2ENgQ4@wuerfel> <20140401132316.GD20061@arm.com>
 <004b01cf4e27$d47da990$7d78fcb0$@samsung.com> <20140402090136.GA31892@arm.com>
 <20140402152455.GB24018@arm.com>
Message-ID: <001501cf4ee2$8b639b50$a22ad1f0$%chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 03, 2014 12:25 AM, Catalin Marinas wrote:
> On Wed, Apr 02, 2014 at 10:01:38AM +0100, Catalin Marinas wrote:
> > On Wed, Apr 02, 2014 at 04:58:39AM +0100, Jungseok Lee wrote:
> > > On Tuesday, April 01, 2014 10:23 PM, Catalin Marinas wrote:
> > > > On some previous patches I've seen posted for 4-levels I asked that 64K
> > > > and 4K page configurations are decoupled from the pgtable-?level.h
> > > > macros so that if we ever need 3-levels with 64K it's easy to enable.
> > >
> > > Is your request to decouple page size from the number of page tables?
> > > In other words, would you like to prepare 4 options, 1)4KB+3Level, 2)
> > > 4KB+4Level, 3)64KB+2Level and 4)64KB+3Level, as combining page size
> > > with page table levels in kernel configuration?
> >
> > We can still use two options to make things less confusing: one for the
> > page size (4K/64K) and another for the size of the virtual address
> > space. From those two we can infer the number levels required. We can
> > limit the options to 39-bit, 42 (only fo 64K pages) and architecture
> > current maximum of 48 (for both 4K and 64K).
> 
> Another reason to decouple the page size is that we have 16K pages
> specified in the ARM ARM (and we'll get hardware implementations at some
> point). As a simple formula for the max VA space we can cover (capped at
> 48-bit):
> 
> VA_BITS = (PAGE_SHIFT - 3) * levels + PAGE_SHIFT
> 
> With 16K pages and 3 levels we can cover 47 bits. So we'll eventually
> have the following VA bits options:
> 
> 39 if 4K (3 levels)
> 42 if 64K (2 levels)
> 47 if 16K (3 levels)
> 48 if 4K || 16K || 64K (4/4/3 levels depending on page size)
Separation for page size and VA bits looks great to me.

I think we can focus on only 4K and 64K at this point.
I'm worried about validation issue for 64K.
After we secure code for 4K and 64K with refactoring,
16K might not big thing. Jungseok or somebody else can do it.
How about your opinion?
> 
> The latter because of the architecture maximum.
> 
> --
> Catalin
