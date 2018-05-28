From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 28 May 2018 08:46:09 +0200
Subject: [Query] PAGE_OFFSET on KASLR enabled ARM64 kernel
In-Reply-To: <CACi5LpO8KVVD_6ZJTW2SiyR8v0uDMA3H9yKHNw1=RKO+fd7KjA@mail.gmail.com>
References: <CACi5LpO8KVVD_6ZJTW2SiyR8v0uDMA3H9yKHNw1=RKO+fd7KjA@mail.gmail.com>
Message-ID: <CAKv+Gu_KSDZyoLNUTAM2d769gQRfbtnGRTcU=8xOrYbmj2O4fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 May 2018 at 23:03, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> Hi ARM64 maintainers,
>
> I am confused about the PAGE_OFFSET value (or the start of the linear
> map) on a KASLR enabled ARM64 kernel that I am seeing on a board which
> supports a compatible EFI firmware (with EFI_RNG_PROTOCOL support).
>
> 1. 'arch/arm64/include/asm/memory.h' defines PAGE_OFFSET as:
>
> /*
>  * PAGE_OFFSET - the virtual address of the start of the linear map (top
>  *         (VA_BITS - 1))
>  */
> #define PAGE_OFFSET        (UL(0xffffffffffffffff) - \
>     (UL(1) << (VA_BITS - 1)) + 1)
>
> So for example on a platform with VA_BITS=48, we have:
> PAGE_OFFSET = 0xffff800000000000
>
> 2. However, for the KASLR case, we set the 'memstart_offset_seed ' to
> use the 16-bits of the 'kaslr-seed' to randomize the linear region in
> 'arch/arm64/kernel/kaslr.c' :
>
> u64 __init kaslr_early_init(u64 dt_phys)
> {
> <snip..>
>     /* use the top 16 bits to randomize the linear region */
>     memstart_offset_seed = seed >> 48;
> <snip..>
> }
>
> 3. Now, we use the 'memstart_offset_seed' value to randomize the
> 'memstart_addr' value in 'arch/arm64/mm/init.c':
>
> void __init arm64_memblock_init(void)
> {
> <snip..>
>
>     if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>         extern u16 memstart_offset_seed;
>         u64 range = linear_region_size -
>                 (memblock_end_of_DRAM() - memblock_start_of_DRAM());
>
>         /*
>          * If the size of the linear region exceeds, by a sufficient
>          * margin, the size of the region that the available physical
>          * memory spans, randomize the linear region as well.
>          */
>         if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
>             range = range / ARM64_MEMSTART_ALIGN + 1;
>             memstart_addr -= ARM64_MEMSTART_ALIGN *
>                      ((range * memstart_offset_seed) >> 16);
>         }
>     }
> <snip..>
> }
>
> 4. Since 'memstart_addr' indicates the start of physical RAM, we
> randomize the same on basis of 'memstart_offset_seed' value above.
> Also the 'memstart_addr' value is available in '/proc/kallsyms' and
> hence can be accessed by user-space applications to read the
> 'memstart_addr' value.
>
> 5. Now since the PAGE_OFFSET value is also used by several user space
> tools (for e.g. makedumpfile tool uses the same to determine the start
> of linear region and hence to read PT_NOTE fields from /proc/kcore), I
> am not sure how to read the randomized value of the same in the KASLR
> enabled case.
>
> 6. Reading the code further and adding some debug prints, it seems the
> 'memblock_start_of_DRAM()' value is more closer to the actual start of
> linear region rather than 'memstart_addr' and 'PAGE_OFFSET" in case of
> KASLR enabled kernel:
>
> [root at qualcomm-amberwing] # dmesg | grep -i "arm64_memblock_init" -A 5
>
> [    0.000000] inside arm64_memblock_init, memstart_addr = ffff976a00000000,
> linearstart_addr = ffffe89600200000, memblock_start_of_DRAM = ffffe89600200000,
> PHYS_OFFSET = ffff976a00000000, PAGE_OFFSET = ffff800000000000,
> KIMAGE_VADDR = ffff000008000000, kimage_vaddr = ffff20c2d7800000
>
> [root at qualcomm-amberwing] # dmesg | grep -i "Virtual kernel memory layout" -A 15
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000
> (   128 MB)
> [    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000
> (126847 GB)
> [    0.000000]       .text : 0xffff20c2d7880000 - 0xffff20c2d8040000
> (  7936 KB)
> [    0.000000]     .rodata : 0xffff20c2d8040000 - 0xffff20c2d83a0000
> (  3456 KB)
> [    0.000000]       .init : 0xffff20c2d83a0000 - 0xffff20c2d8750000
> (  3776 KB)
> [    0.000000]       .data : 0xffff20c2d8750000 - 0xffff20c2d891b200
> (  1837 KB)
> [    0.000000]        .bss : 0xffff20c2d891b200 - 0xffff20c2d90a5198
> (  7720 KB)
> [    0.000000]     fixed   : 0xffff7fdffe790000 - 0xffff7fdffec00000
> (  4544 KB)
> [    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000
> (    16 MB)
> [    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000
> (   128 GB maximum)
> [    0.000000]               0xffff7ffa25800800 - 0xffff7ffa2b800000
> (    95 MB actual)
> [    0.000000]     memory  : 0xffffe89600200000 - 0xffffe8ae00000000
> ( 98302 MB)
>
> As one can see above, the 'memblock_start_of_DRAM()' value of
> 0xffffe89600200000 represents the start of linear region:
>
> [    0.000000]     memory  : 0xffffe89600200000 - 0xffffe8ae00000000
> ( 98302 MB)
>
> So, my question is to access the start of linear region (which was
> earlier determinable via PAGE_OFFSET macro), whether I should:
>
> - do some back-computation for the start of linear region from the
> 'memstart_addr' in user-space, or
> - use a new global variable in kernel which is assigned the value of
> memblock_start_of_DRAM()' and assign it to '/proc/kallsyms', so that
> it can be read by user-space tools, or
> - whether we should rather look at removing the PAGE_OFFSET usage from
> the kernel and replace it with a global variable instead which is
> properly updated for KASLR case as well.
>
> Kindly share your opinions on what can be a suitable solution in this case.
>
> Thanks for your help.
>

Hello Bhupesh,

Could you explain what the relevance is of PAGE_OFFSET to userland?
The only thing that should matter is where the actual linear mapping
of DRAM is, and I am not sure I understand why we care about where it
resides relative to the base of the linear region.
