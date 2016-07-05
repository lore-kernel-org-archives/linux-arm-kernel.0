From: dennis.chen@arm.com (Dennis Chen)
Date: Tue, 5 Jul 2016 12:18:36 +0800
Subject: [PATCH] arm64:mm Remove the redundant initrd memblock codes
In-Reply-To: <B1CA6829-851E-4E56-BA48-58EE72272B49@linaro.org>
References: <1467607994-14368-1-git-send-email-dennis.chen@arm.com>
 <4ABE8B9C-8027-40AA-A303-A82CF014A287@linaro.org>
 <20160705022217.GA27637@arm.com>
 <B1CA6829-851E-4E56-BA48-58EE72272B49@linaro.org>
Message-ID: <20160705041834.GA28823@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 11:41:02AM +0800, Ard Biesheuvel wrote:
> 
> > On 5 jul. 2016, at 10:22, Dennis Chen <dennis.chen@arm.com> wrote:
> > 
> >> On Mon, Jul 04, 2016 at 12:33:05PM +0200, Ard Biesheuvel wrote:
> >> 
> >>> On 4 jul. 2016, at 06:53, Dennis Chen <dennis.chen@arm.com> wrote:
> >>> 
> >>> The memory range between initrd_start and initrd_end was added to the memblock
> >>> twice unnecessarily in the same function before initrd memory range can be freed.
> >>> This patch merge those codes into one piece of block and add the initrd memory
> >>> range only once, also it makes the code clean and simple.
> >> 
> >> This is likely to break under KASLR (and I would recommend that you test with kaslr enabled when you propose changes to this code)
> > Hello Ard, I've tested it under KASLR on Juno board before proposing the changes,where the firmware provides the RNG protocol, it works well.
> 
> Ok, thanks for confirming that (and apologies for assuming you did not test it)
> 
> >> 
> >> The randomization of memstart_addr needs to execute /after/ adding back the initrd, otherwise the chosen value of memstart_addr may push the initrd beyond the end of the linear area into the userland range.
> > Yes, I know the 'range' is depends on memblock_end_of_DRAM() and memblock_start_of_DRAM(), but I can't see that the order of initrd added to the memblock will affect
> > those two values returned from memblock_ fucntions, IMHO the initrd will be loaded to somewhere within the DRAM by firmware, is that correct?
> 
> memblock_add/_remove may affect the return values of memblock_start/_end_of_DRAM, so the reordering will affect the range of the randomized memstart_addr, afaict
>
Hello Ard, since the efi stub will load the initrd block to the DRAM, and all the memory descriptions passed in by the firmware will be added to the memblock by efi
stub, so in this case adding the initrd to the memblock will not change the return value of memblock_start/_end_of_DRAM, else it's a bug from efi stub, isn't it?

Thanks,
Dennis
> 
> > 
> > Thanks,
> > Dennis  
> >> 
> >> 
> >>> Signed-off-by: Dennis Chen <dennis.chen@arm.com>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: Steve Capper <steve.capper@arm.com>
> >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> Cc: Will Deacon <will.deacon@arm.com>
> >>> ---
> >>> arch/arm64/mm/init.c | 58 +++++++++++++++++++++++-----------------------------
> >>> 1 file changed, 26 insertions(+), 32 deletions(-)
> >>> 
> >>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >>> index 2ade7a6..cf26cdb 100644
> >>> --- a/arch/arm64/mm/init.c
> >>> +++ b/arch/arm64/mm/init.c
> >>> @@ -228,6 +228,29 @@ void __init arm64_memblock_init(void)
> >>>       memblock_add(__pa(_text), (u64)(_end - _text));
> >>>   }
> >>> 
> >>> +    if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> >>> +        extern u16 memstart_offset_seed;
> >>> +        u64 range = linear_region_size -
> >>> +                (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> >>> +
> >>> +        /*
> >>> +         * If the size of the linear region exceeds, by a sufficient
> >>> +         * margin, the size of the region that the available physical
> >>> +         * memory spans, randomize the linear region as well.
> >>> +         */
> >>> +        if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> >>> +            range = range / ARM64_MEMSTART_ALIGN + 1;
> >>> +            memstart_addr -= ARM64_MEMSTART_ALIGN *
> >>> +                     ((range * memstart_offset_seed) >> 16);
> >>> +        }
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * Register the kernel text, kernel data, initrd, and initial
> >>> +     * pagetables with memblock.
> >>> +     */
> >>> +    memblock_reserve(__pa(_text), _end - _text);
> >>> +
> >>>   if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> >>>       /*
> >>>        * Add back the memory we just removed if it results in the
> >>> @@ -254,41 +277,12 @@ void __init arm64_memblock_init(void)
> >>>           memblock_remove(base, size); /* clear MEMBLOCK_ flags */
> >>>           memblock_add(base, size);
> >>>           memblock_reserve(base, size);
> >>> +            /* the generic initrd code expects virtual addresses */
> >>> +            initrd_start = __phys_to_virt(initrd_start);
> >>> +            initrd_end = __phys_to_virt(initrd_end);
> >>>       }
> >>>   }
> >>> 
> >>> -    if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> >>> -        extern u16 memstart_offset_seed;
> >>> -        u64 range = linear_region_size -
> >>> -                (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> >>> -
> >>> -        /*
> >>> -         * If the size of the linear region exceeds, by a sufficient
> >>> -         * margin, the size of the region that the available physical
> >>> -         * memory spans, randomize the linear region as well.
> >>> -         */
> >>> -        if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> >>> -            range = range / ARM64_MEMSTART_ALIGN + 1;
> >>> -            memstart_addr -= ARM64_MEMSTART_ALIGN *
> >>> -                     ((range * memstart_offset_seed) >> 16);
> >>> -        }
> >>> -    }
> >>> -
> >>> -    /*
> >>> -     * Register the kernel text, kernel data, initrd, and initial
> >>> -     * pagetables with memblock.
> >>> -     */
> >>> -    memblock_reserve(__pa(_text), _end - _text);
> >>> -#ifdef CONFIG_BLK_DEV_INITRD
> >>> -    if (initrd_start) {
> >>> -        memblock_reserve(initrd_start, initrd_end - initrd_start);
> >>> -
> >>> -        /* the generic initrd code expects virtual addresses */
> >>> -        initrd_start = __phys_to_virt(initrd_start);
> >>> -        initrd_end = __phys_to_virt(initrd_end);
> >>> -    }
> >>> -#endif
> >>> -
> >>>   early_init_fdt_scan_reserved_mem();
> >>> 
> >>>   /* 4GB maximum for 32-bit only capable devices */
> >>> -- 
> >>> 1.8.3.1
> > 
> 
