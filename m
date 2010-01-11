From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 15:45:16 -0800
Subject: [RFC 06/18] arm: msm: implement proper dmb() for 7x27
In-Reply-To: <20100111233924.GL7925@n2100.arm.linux.org.uk>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
	<20100111233924.GL7925@n2100.arm.linux.org.uk>
Message-ID: <1263253516.26505.42.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 23:39 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 02:47:25PM -0800, Daniel Walker wrote:
> > From: Larry Bassel <lbassel@quicinc.com>
> > 
> > For 7x27 it is necessary to write to strongly
> > ordered memory after executing the coprocessor 15
> > instruction dmb instruction.
> > 
> > This is only for data barrier dmb().
> > Note that the test for 7x27 is done on all MSM platforms
> > (even ones such as 7201a whose kernel is distinct from
> > that of 7x25/7x27).
> > 
> > Acked-by: Willie Ruan <wruan@quicinc.com>
> > Signed-off-by: Larry Bassel <lbassel@quicinc.com>
> > Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> 
> Can only see half of this change - what's the actual implementation of
> arch_barrier_extra()?
> 
> I'd prefer not to include asm/memory.h into asm/system.h to avoid
> needlessly polluting headers.

I don't have a real patch for it yet, but here are the pieces ..

+#define arch_barrier_extra() do \
+       { if (machine_is_msm7x27_surf() || machine_is_msm7x27_ffa())  \
+               write_to_strongly_ordered_memory(); \
+       } while (0)

(btw, the machine types above registered either..)

and memory.c

/* arch/arm/mach-msm/memory.c
 *
 * Copyright (C) 2007 Google, Inc.
 * Copyright (c) 2009, Code Aurora Forum. All rights reserved.
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#include <linux/mm.h>
#include <linux/mm_types.h>
#include <linux/bootmem.h>
#include <asm/pgtable.h>
#include <asm/io.h>
#include <asm/mach/map.h>

int arch_io_remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
			    unsigned long pfn, unsigned long size, pgprot_t prot)
{
	unsigned long pfn_addr = pfn << PAGE_SHIFT;
	if ((pfn_addr >= 0x88000000) && (pfn_addr < 0xD0000000)) {
		prot = pgprot_device(prot);
		printk("remapping device %lx\n", prot);
	}
	return remap_pfn_range(vma, addr, pfn, size, prot);
}

void *zero_page_strongly_ordered;

static void map_zero_page_strongly_ordered(void)
{
	if (zero_page_strongly_ordered)
		return;

	zero_page_strongly_ordered =
		ioremap_strongly_ordered(page_to_pfn(empty_zero_page)
		<< PAGE_SHIFT, PAGE_SIZE);
}

void write_to_strongly_ordered_memory(void)
{
	map_zero_page_strongly_ordered();
	*(int *)zero_page_strongly_ordered = 0;
}

void flush_axi_bus_buffer(void)
{
	__asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
				    : : "r" (0) : "memory");
	write_to_strongly_ordered_memory();
}

void *alloc_bootmem_aligned(unsigned long size, unsigned long alignment)
{
	void *unused_addr = NULL;
	unsigned long addr, tmp_size, unused_size;

	/* Allocate maximum size needed, see where it ends up.
	 * Then free it -- in this path there are no other allocators
	 * so we can depend on getting the same address back
	 * when we allocate a smaller piece that is aligned
	 *@the end (if necessary) and the piece we really want,
	 * then free the unused first piece.
	 */

	tmp_size = size + alignment - PAGE_SIZE;
	addr = (unsigned long)alloc_bootmem(tmp_size);
	free_bootmem(__pa(addr), tmp_size);

	unused_size = alignment - (addr % alignment);
	if (unused_size)
		unused_addr = alloc_bootmem(unused_size);

	addr = (unsigned long)alloc_bootmem(size);
	if (unused_size)
		free_bootmem(__pa(unused_addr), unused_size);

	return (void *)addr;
}
