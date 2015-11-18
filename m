From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Nov 2015 10:21:06 -0800
Subject: Executable mapping of on-chip registers through /dev/mem?
Message-ID: <564CC192.1000907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On the brcmstb platform, we have a special piece of hardware which tries
to be smart and checks whether a virtual mapping to the on-chip register
range (called GISB), PCIE inbound windows, or other memory-mapped
chip-selects region has the executable bit set, and if it does, it
typically issues an error condition.

It turns out, that we can re-create that condition just that by opening
/dev/mem and calling mmap() with PROT_EXEC, giving the physical base
address of the register range (0xF000_0000 typically on these
platforms), and a mapping size which spans the entire register range
(32MB), although smaller mapping size also exhibit the problem, just a
little slower.

In these two conditions, we end-up with the CPU speculatively trying to
fetch instruction streams from this range, and eventually itching this
sensitive piece of hardware and causing the error condition to occur.

Tracing through the calls from drivers/char/mem.c, we have this:

drivers/char/mem.c:
mmap_mem()
	ARM does define __HAVE_PHYS_MEM_ACCESS_PROT and we have
CONFIG_MEM_DMA_BUFFERABLE=y for our V7 builds here

arch/arm/mm/mmu.c:
	-> phys_mem_access_prot()
		-> !pfn_valid(pfn) is true
			-> pgprot_uncached()

If I do change the pgprot value to also include the XN bit, this problem
never occurs, because we satisfy the piece of hardware checking for the
executable bit (or lack, thereof) in the mapping.

What is is not really clear to me, is whether we are creating a new
mapping of this 32MB register range on this SoC, with an uncached
mapping + executable bit set, or we are modifying the existing mapping
in that case?

I cooked up a local patch which allows a machine to define a
phys_mem_access_prot-like callback, which can then look at the calling
parameters and change the pgprot_t values accordingly if the range falls
in this problematic space.

I do not like that, because this currently forces my machine to have
knowledge about where this register range is, so I am wondering if there
are better solutions like:

- making phys_mem_access_prot set L_PTE_XN unconditionally for the
!pfn_valid case, instead of pgprot_uncached(), but who am I going to
break by doing so, what if people want to execute code from a memory
mapped, like flash, FPGA, anything?

- having a better way to determine if the pfn falls within existing
register mappings? But without a map_io() or putting that information in
Device Tree, how am I sure this is an exhaustive range?

Thanks!
-- 
Florian
