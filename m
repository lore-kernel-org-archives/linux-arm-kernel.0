From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Nov 2010 14:46:00 -0500 (EST)
Subject: highmem and VMALLOC_END
In-Reply-To: <AANLkTim=Qjyv_v78PkbnDncYH3EX1HNsMMbg43UwHozr@mail.gmail.com>
References: <AAD1C6EB06EE3649B35B7E026785068D15054F7060@SC-VEXCH2.marvell.com>
	<AANLkTim=Qjyv_v78PkbnDncYH3EX1HNsMMbg43UwHozr@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1011231444440.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Nov 2010, Eric Miao wrote:

> On Tue, Nov 23, 2010 at 5:42 PM, Chao Xie <cxie4@marvell.com> wrote:
> > hi
> > in arch/arm/mmu,c, when define CONFIG_HIGHMEM, in sanity_check_meminfo, it will check the memory banks,
> > and if the memory bank is in high memory, it will be marked as highmem.
> > ? ? ? ?lowmem_limit = __pa(vmalloc_min - 1) + 1;
> > ? ? ? ?memblock_set_current_limit(lowmem_limit);
> >
> > ? ? ? ?for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
> > ? ? ? ? ? ? ? ?struct membank *bank = &meminfo.bank[j];
> > ? ? ? ? ? ? ? ?*bank = meminfo.bank[i];
> >
> > #ifdef CONFIG_HIGHMEM
> > ? ? ? ? ? ? ? ?if (__va(bank->start) > vmalloc_min ||
> > ? ? ? ? ? ? ? ? ? ? ? ?__va(bank->start) < (void *)PAGE_OFFSET)
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?highmem = 1;
> > if VMALLOC_END is 0xe8000000, and "vmalloc" is 0x18000000, vmalloc_min will be 0xd0000000.
> > There are two banks, each bank is 256MB. Based on __phys_to_virt(), __va(first bank start) is
> > 0xc0000000, while __va(second bank start) is 0xd0000000. Based on previous if, the second bank
> > is not marked highmem, but in fact it will occupy the virtual address from 0xd0000000 to 0xdfffffff,
> > and it should be in high memory.
> > It will be fine if change the code as
> > -- ? ? ? ? ? ? ?if (__va(bank->start) > vmalloc_min ||
> > ++ ? ? ? ? ? ? ?if (__va(bank->start) >= vmalloc_min ||
> > Is it a bug or I understand wrong? Thanks.
> >
> >
> 
> It's a bug. Nico?

Yes it is a bug.  


Nicolas
