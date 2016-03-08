From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Mar 2016 09:15:43 +0700
Subject: [PATCH v2 1/2] arm64: vmemmap: use virtual projection of linear
 region
In-Reply-To: <56DE25DD.4010401@gmail.com>
References: <1456505834-8638-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456505834-8638-2-git-send-email-ard.biesheuvel@linaro.org>
 <56DE25DD.4010401@gmail.com>
Message-ID: <E540D948-6371-4F71-A8B6-025BC39A0515@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 8 mrt. 2016, at 08:07, David Daney <ddaney.cavm@gmail.com> wrote:
> 
>> On 02/26/2016 08:57 AM, Ard Biesheuvel wrote:
>> Commit dd006da21646 ("arm64: mm: increase VA range of identity map") made
>> some changes to the memory mapping code to allow physical memory to reside
>> at an offset that exceeds the size of the virtual mapping.
>> 
>> However, since the size of the vmemmap area is proportional to the size of
>> the VA area, but it is populated relative to the physical space, we may
>> end up with the struct page array being mapped outside of the vmemmap
>> region. For instance, on my Seattle A0 box, I can see the following output
>> in the dmesg log.
>> 
>>    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
>>              0xffffffbfc0000000 - 0xffffffbfd0000000   (   256 MB actual)
>> 
>> We can fix this by deciding that the vmemmap region is not a projection of
>> the physical space, but of the virtual space above PAGE_OFFSET, i.e., the
>> linear region. This way, we are guaranteed that the vmemmap region is of
>> sufficient size, and we can even reduce the size by half.
>> 
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> I see this commit now in Linus' kernel.org tree in v4.5-rc7.
> 
> FYI:  I am seeing a crash that goes away when I revert this.  My kernel has some other modifications (our NUMA patches) so I haven't yet fully tracked this down on an unmodified kernel, but this is what I am getting:
> 

Hi David,

You are the second one to report this issue on a 64k pages kernel, but i haven't managed to reproduce yet.

Any chance you could instrument vmemmap_populate_basepages to figure out whether the faulting address is populated, and if not, why?

Thanks,
Ard.

> .
> .
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000001400000-0x00000000fffeffff]
> [    0.000000]   node   0: [mem 0x00000000ffff0000-0x00000000ffffffff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x00000003f51cffff]
> [    0.000000]   node   0: [mem 0x00000003f51d0000-0x00000003f51dffff]
> [    0.000000]   node   0: [mem 0x00000003f51e0000-0x00000003fa9bffff]
> [    0.000000]   node   0: [mem 0x00000003fa9c0000-0x00000003faa8ffff]
> [    0.000000]   node   0: [mem 0x00000003faa90000-0x00000003ffa3ffff]
> [    0.000000]   node   0: [mem 0x00000003ffa40000-0x00000003ffa9ffff]
> [    0.000000]   node   0: [mem 0x00000003ffaa0000-0x00000003ffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000001400000-0x00000003ffffffff]
> [    0.000000] Unable to handle kernel paging request at virtual address fffffdff60ff0000
> [    0.000000] pgd = fffffe0000e00000
> [    0.000000] [fffffdff60ff0000] *pgd=00000003ffd90003, *pud=00000003ffd90003, *pmd=00000003ffd90003, *pte=0000000000000000
> [    0.000000] Internal error: Oops: 96000007 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc7-numa+ #123
> [    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
> [    0.000000] task: fffffe0000b39880 ti: fffffe0000b00000 task.ti: fffffe0000b00000
> [    0.000000] PC is at memmap_init_zone+0xe0/0x130
> [    0.000000] LR is at memmap_init_zone+0xc0/0x130
> [    0.000000] pc : [<fffffe0000a85b28>] lr : [<fffffe0000a85b08>] pstate: 800002c5
> [    0.000000] sp : fffffe0000b03cf0
> [    0.000000] x29: fffffe0000b03cf0 x28: fffffe03febe1b80
> [    0.000000] x27: fffffe03febe2a08 x26: fffffe0000b30000
> [    0.000000] x25: 0000000000040000 x24: 0000000000000000
> [    0.000000] x23: 1000000000000000 x22: 0000000000000000
> [    0.000000] x21: 0000000000000001 x20: 00000000ffffffff
> [    0.000000] x19: 000000000003fd40 x18: fffffe0000d7c240
> [    0.000000] x17: 0000000000000009 x16: 0000000400000000
> [    0.000000] x15: 0000000000000008 x14: 0000000000000004
> [    0.000000] x13: 0000000000000000 x12: 000000000001c854
> [    0.000000] x11: 00000003fffe37a8 x10: 0000000000000004
> [    0.000000] x9 : 0000000000000000 x8 : fffffe03febc0000
> [    0.000000] x7 : 0000000000000000 x6 : fffffe0000d7c240
> [    0.000000] x5 : fffffdff60000000 x4 : 0000000000000007
> [    0.000000] x3 : fffffdff60000000 x2 : fffffe0000d7c300
> [    0.000000] x1 : 0000000000ff0000 x0 : 0000000000000001
> [    0.000000]
> [    0.000000] Process swapper (pid: 0, stack limit = 0xfffffe0000b00020)
> [    0.000000] Stack: (0xfffffe0000b03cf0 to 0xfffffe0000b04000)
> [    0.000000] 3ce0:                                   fffffe0000b03d40 fffffe0000a85fd4
> [    0.000000] 3d00: fffffe03febe2400 fffffe0000aa3000 0000000000000000 0000000000030000
> [    0.000000] 3d20: fffffe0000b5eab4 fffffe0000b5eab8 0000000000000001 fffffe0000734d18
> [    0.000000] 3d40: fffffe0000b03df0 fffffe0000a56928 0000000000000000 fffffe0000b32e68
> [    0.000000] 3d60: 0000000000000004 fffffe0000b32e70 fffffe0000b30000 fffffe03febe1b80
> [    0.000000] 3d80: fffffe0000c40000 0000000002200000 fffffe0000081198 00000003f51eaa0c
> [    0.000000] 3da0: fffffe0000d7bc90 0000000000030000 fffffe000093f148 fffffe000093f008
> [    0.000000] 3dc0: fffffe000093efb0 fffffe000093efd8 0000000000010000 fffffe0000af6798
> [    0.000000] 3de0: 0000000000000140 0000000000040000 fffffe0000b03e90 fffffe0000a44e84
> [    0.000000] 3e00: fffffe0000b03ec8 0000000001400000 0000000000040000 fffffe0000b30000
> [    0.000000] 3e20: fffffe0000b30000 0000000001400000 fffffe0000c40000 0000000002200000
> [    0.000000] 3e40: fffffe0000081198 00000003f51eaa0c 0000000000040000 0000000000000000
> [    0.000000] 3e60: fffffe0000b30000 0000000001400000 ffffffff00c40000 00000000ffffffff
> [    0.000000] 3e80: 000000000003ffaa 0000000000040000 fffffe0000b03ee0 fffffe0000a452d4
> [    0.000000] 3ea0: fffffe03febd0000 fffffe0000b30b98 fffffe0000080000 fffffe0000a45168
> [    0.000000] 3ec0: fffffe0000b03ee0 0000000000010000 0000000000040000 0000000000000000
> [    0.000000] 3ee0: fffffe0000b03f00 fffffe0000a42f2c fffffdfffa800000 00000003ffaa0000
> [    0.000000] 3f00: fffffe0000b03fa0 fffffe0000a40680 0000000000000000 fffffe0000b30b98
> [    0.000000] 3f20: 0000000021200000 00000003f50de7c8 fffffe0000b30000 0000000001400000
> [    0.000000] 3f40: 00000000021d0000 0000000002200000 fffffe0000081198 00000000ffffffc8
> [    0.000000] 3f60: 00000003f50deb40 fffffe00007200a8 0000000000000001 0000000021200000
> [    0.000000] 3f80: ffffffffffffffff 0000000000000000 0000000080808080 fefefefefefefefe
> [    0.000000] 3fa0: 0000000000000000 fffffe00000811b4 00000003f50deb40 0000000000000e12
> [    0.000000] 3fc0: 0000000021200000 00000003f50de7c8 00000003f50de7dd 0000000001400000
> [    0.000000] 3fe0: 0000000000000000 fffffe0000a88a28 0000000000000000 0000000000000000
> [    0.000000] Call trace:
> [    0.000000] Exception stack(0xfffffe0000b03b30 to 0xfffffe0000b03c50)
> [    0.000000] 3b20:                                   000000000003fd40 00000000ffffffff
> [    0.000000] 3b40: fffffe0000b03cf0 fffffe0000a85b28 00000003fffba000 0000000000006000
> [    0.000000] 3b60: 0000000000000004 0000000000000000 fffffe0000b03be0 fffffe00001d253c
> [    0.000000] 3b80: 00000003fffba000 0000000000006000 fffffe0000a5abec 0000000000000080
> [    0.000000] 3ba0: 0000000000000000 0000000000000000 0000000000010000 fffffe0000b674f0
> [    0.000000] 3bc0: fffffe0000942288 00000003fffba000 0000000000000001 0000000000ff0000
> [    0.000000] 3be0: fffffe0000d7c300 fffffdff60000000 0000000000000007 fffffdff60000000
> [    0.000000] 3c00: fffffe0000d7c240 0000000000000000 fffffe03febc0000 0000000000000000
> [    0.000000] 3c20: 0000000000000004 00000003fffe37a8 000000000001c854 0000000000000000
> [    0.000000] 3c40: 0000000000000004 0000000000000008
> [    0.000000] [<fffffe0000a85b28>] memmap_init_zone+0xe0/0x130
> [    0.000000] [<fffffe0000a85fd4>] free_area_init_node+0x45c/0x4a4
> [    0.000000] [<fffffe0000a56928>] free_area_init_nodes+0x594/0x5ec
> [    0.000000] [<fffffe0000a44e84>] bootmem_init+0xc8/0xf8
> [    0.000000] [<fffffe0000a452d4>] paging_init_rest+0x1c/0xdc
> [    0.000000] [<fffffe0000a42f2c>] setup_arch+0x118/0x5a0
> [    0.000000] [<fffffe0000a40680>] start_kernel+0xa8/0x3e0
> [    0.000000] [<fffffe00000811b4>] 0xfffffe00000811b4
> [    0.000000] Code: cb414261 f2dfbfe5 d37ae421 f2ffffe5 (f8656820)
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception
> 
> .
> .
> .
> 
> 
>> ---
>> v2: simplify the expression for vmemmap, forward compatible with the patch that
>>     changes the type of memstart_addr to s64
>> 
>>  arch/arm64/include/asm/pgtable.h | 7 ++++---
>>  arch/arm64/mm/init.c             | 4 ++--
>>  2 files changed, 6 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 16438dd8916a..43abcbc30813 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -34,18 +34,19 @@
>>  /*
>>   * VMALLOC and SPARSEMEM_VMEMMAP ranges.
>>   *
>> - * VMEMAP_SIZE: allows the whole VA space to be covered by a struct page array
>> + * VMEMAP_SIZE: allows the whole linear region to be covered by a struct page array
>>   *    (rounded up to PUD_SIZE).
>>   * VMALLOC_START: beginning of the kernel vmalloc space
>>   * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
>>   *    fixed mappings and modules
>>   */
>> -#define VMEMMAP_SIZE        ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
>> +#define VMEMMAP_SIZE        ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
>> 
>>  #define VMALLOC_START        (MODULES_END)
>>  #define VMALLOC_END        (PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
>> 
>> -#define vmemmap            ((struct page *)(VMALLOC_END + SZ_64K))
>> +#define VMEMMAP_START        (VMALLOC_END + SZ_64K)
>> +#define vmemmap            ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
>> 
>>  #define FIRST_USER_ADDRESS    0UL
>> 
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index e1f425fe5a81..4ea7efc28e65 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -380,8 +380,8 @@ void __init mem_init(void)
>>            MLK_ROUNDUP(_text, _etext),
>>            MLK_ROUNDUP(_sdata, _edata),
>>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -          MLG((unsigned long)vmemmap,
>> -              (unsigned long)vmemmap + VMEMMAP_SIZE),
>> +          MLG(VMEMMAP_START,
>> +              VMEMMAP_START + VMEMMAP_SIZE),
>>            MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
>>                (unsigned long)virt_to_page(high_memory)),
>>  #endif
> 
