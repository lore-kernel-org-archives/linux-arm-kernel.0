From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Nov 2009 09:37:54 +0000
Subject: [ LPC3250 ] discontinuous DDR-Ram : problem of write buffer
	coherency
In-Reply-To: <002c01ca6dd5$f19eac90$d4dc05b0$@savary@kerlink.fr>
References: <002c01ca6dd5$f19eac90$d4dc05b0$@savary@kerlink.fr>
Message-ID: <20091130093754.GB1638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 02:48:16PM +0100, Pierre Savary wrote:
> #if defined(CONFIG_MACH_LPC32XX_DRAM_SIZE_64)
> /*
>  * This support is added for systems that have 2 64MByte devices on
> different
>  * chip selects (DYCS0 and DYCS1). In this configuration, there is a memory
>  * hole between the 2 devices such that the addresses are as follows:
>  * DYCS0 - 0x80000000 - 0x83ffffff (node 0, 16Kpages)
>  * DYCS1 - 0xa0000000 - 0xa3ffffff (node 1, 16Kpages)
>  */
> #define KVADDR_TO_NID(addr) \
>       (((unsigned long) (addr) - PAGE_OFFSET) >> 26)
> 
> #define LOCAL_MAP_NR(addr) \
>        (((unsigned long)(addr) & 0x03ffffff) >> PAGE_SHIFT)
> 
> #define __virt_to_phys(x) \
> 	((((unsigned long) (x) & ~0x04000000) - PAGE_OFFSET + PHYS_OFFSET)
> |\
> 	(((unsigned long) (x) & 0x04000000) << 3))
> 
> #define __phys_to_virt(x) \
> 	((((unsigned long) (x) & ~0x20000000) - PHYS_OFFSET + PAGE_OFFSET)
> |\
> 	(((unsigned long) (x) & 0x20000000) >> 3))
> #endif
> [...]

Two questions to start with:
1. Please use sparsemem rather than discontigmem.  Discontigmem is for
   NUMA.
2. Do you actually require the non-linear phys_to_virt/virt_to_phys
   translations?

> CPU: Testing write buffer coherency: <4>------------[ cut here ]------------
> WARNING: at
> /mnt/workdir/gestion_conf_klk/klk-SWe/sources/linux/linux-2.6.27.8/mm/vmallo
> c.c:107 map_vm_area+0x114/0x1d0()

This means you have mappings in the vmalloc region, and hence we were
unable to create the mapping we desired.

> /mnt/workdir/gestion_conf_klk/klk-SWe/sources/linux/linux-2.6.27.8/mm/memory
> .c:130: bad pmd a080041e.

And this means we couldn't tear down the mapping because there was a
section mapping in the way, and it nicely tells us that the contents
of the 1st level page table was 0xa080041e.

That is:

- section
- TEXCB=xxx11
- bit4=1
- domain 0
- kernel rw user na
- phys 0xa0800000

Looks like a RAM mapping in the middle of the vmalloc area.  I've no idea
how you've managed to do that.
