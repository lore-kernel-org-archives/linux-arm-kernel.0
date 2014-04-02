From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Apr 2014 10:01:38 +0100
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <004b01cf4e27$d47da990$7d78fcb0$@samsung.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
 <7050133.LRSn2ENgQ4@wuerfel> <20140401132316.GD20061@arm.com>
 <004b01cf4e27$d47da990$7d78fcb0$@samsung.com>
Message-ID: <20140402090136.GA31892@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 04:58:39AM +0100, Jungseok Lee wrote:
> On Tuesday, April 01, 2014 10:23 PM, Catalin Marinas wrote:
> > On some previous patches I've seen posted for 4-levels I asked that 64K
> > and 4K page configurations are decoupled from the pgtable-?level.h
> > macros so that if we ever need 3-levels with 64K it's easy to enable.
> 
> Is your request to decouple page size from the number of page tables?
> In other words, would you like to prepare 4 options, 1)4KB+3Level, 2)
> 4KB+4Level, 3)64KB+2Level and 4)64KB+3Level, as combining page size
> with page table levels in kernel configuration? 

We can still use two options to make things less confusing: one for the
page size (4K/64K) and another for the size of the virtual address
space. From those two we can infer the number levels required. We can
limit the options to 39-bit, 42 (only fo 64K pages) and architecture
current maximum of 48 (for both 4K and 64K).

As for some code refactoring, for example, PTRS_PER_PTE etc. correspond
to the page size rather than the number of levels, so move them to
pgtable-{4k,64k}-hwdef.h. From the VA_BITS option above you can
calculate PTRS_PER_PGD (1 << (VA_BITS - PGDIR_SHIFT)). If this is too
large, you need a bigger PGDIR_SHIFT (another level). Some #ifdef's in
pgtable-hwdef.h and maybe create another pgtable-types.h. The
asm/memory.h file already defines the offsets in terms of VA_BITS, so
for the initial patches we should keep the same layout, make the
4-levels patches easier to review.

(and in the memory.txt doc I think we should make the end address
exclusive as it's easier to follow and can be compared with the kernel
virtual memory layout printed during boot)

-- 
Catalin
