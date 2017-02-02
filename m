From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Feb 2017 15:36:13 +0000
Subject: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170202143602.GA3078@fireball>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170202103129.GE13549@linaro.org>
 <20170202111637.GA31394@leverpostej>
 <20170202143602.GA3078@fireball>
Message-ID: <20170202153612.GN31394@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 11:36:04PM +0900, AKASHI Takahiro wrote:
> On Thu, Feb 02, 2017 at 11:16:37AM +0000, Mark Rutland wrote:
> > On Thu, Feb 02, 2017 at 07:31:30PM +0900, AKASHI Takahiro wrote:
> > > On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> > > > On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:

> > Imagine we have phyiscal memory:
> > 
> > singe RAM bank:    |---------------------------------------------------|
> > kernel image:              |---|
> > crashkernel:                                      |------|
> > 
> > ... we reserve the image and crashkernel region, but these would still
> > remain part of the memory memblock, and we'd have a memblock layout
> > like:
> > 
> > memblock.memory:   |---------------------------------------------------|
> > memblock.reserved:         |---|                  |------|
> > 
> > ... in map_mem() we iterate over memblock.memory, so we only have a
> > single entry to handle in this case. With the code above, we'd find that
> > it overlaps the crashk_res, and we'd map the parts which don't overlap,
> > e.g.
> > 
> > memblock.memory:   |---------------------------------------------------|
> > crashkernel:                                      |------|
> > mapped regions:    |-----------------------------|        |------------|
> 
> I'm afraid that you might be talking about my v30.
> The code in v31 was a bit modified, and now
> 
> > ... hwoever, this means we've mapped the portion which overlaps with the
> > kernel's linear alias (i.e. the case that we try to handle in
> > __map_memblock()). What we actually wanted was:
> > 
> > memblock.memory:   |---------------------------------------------------|
> > kernel image:              |---|
> > crashkernel:                                      |------|
> 
>                      |-----------(A)---------------|        |----(B)-----|
> 
> __map_memblock() is called against each of (A) and (B),
> so I think we will get
> 
> > mapped regions:    |------|     |----------------|        |------------|
> 
> this mapping.

Ah, I see. You are correct; this will work.

Clearly I needed more coffee before considering this. :/

> > To handle all cases I think we have to isolate *both* the image and
> > crashkernel in map_mem(). That would leave use with:
> > 
> > memblock.memory:   |------||---||----------------||------||------------|
> > memblock.reserved:         |---|                  |------|
> > 
> > ... so then we can check for overlap with either the kernel or
> > crashkernel in __map_memblock(), and return early, e.g.
> > 
> > __map_memblock(...)
> > 	if (overlaps_with_kernel(...))
> > 		return;
> > 	if (overlaps_with_crashekrenl(...))
> > 		return;
> > 	
> > 	__create_pgd_mapping(...);
> > }
> > 
> > We can pull the kernel alias mapping out of __map_memblock() and put it
> > at the end of map_mem().
> > 
> > Does that make sense?
> 
> OK, I now understand your anticipation.

Thinking about it, we can do this consistently in one place if we use nomap
(temporarily), which would allow us to simplify the existing code. We'd have to
introduce memblock_clear_nomap(), but that's less of an internal detail than
memblock_isolate_range(), so that seems reasonable.

I think we can handle this like:

/*
 * Create a linear mapping for all memblock memory regions which are mappable.
 */
static void __init __map_mem(pgd_t *pgd)
{
        struct memblock_region *reg;

        /* map all the memory banks */
        for_each_memblock(memory, reg) {
                phys_addr_t start = reg->base;
                phys_addr_t end = start + reg->size;

                if (start >= end)
                        break;
                if (memblock_is_nomap(reg))
                        continue;

                __create_pgd_mapping(pgd, start, __phys_to_virt(start),
                                     end - start, PAGE_KERNEL,
                                     early_pgtable_alloc,
                                     debug_pagealloc_enabled());
        }   
}

/*
 * Create a linear mapping for mappable memory, handling regions which have
 * special mapping requirements.
 */
static void __init map_mem(pgd_t *pgd)
{
        unsigned long kernel_start = __pa(_text);
        unsigned long kernel_end = __pa(__init_begin);

        memblock_mark_nomap(kernel_start, kernel_end);

        // mark crashkernel nomap here

        __map_mem(pgd);

        /*  
         * Map the linear alias of the [_text, __init_begin) interval as
         * read-only/non-executable. This makes the contents of the
         * region accessible to subsystems such as hibernate, but
         * protects it from inadvertent modification or execution.
         */
        __create_pgd_mapping(pgd, kernel_start, __phys_to_virt(kernel_start),
                             kernel_end - kernel_start, PAGE_KERNEL_RO,
                             early_pgtable_alloc, debug_pagealloc_enabled());
        memblock_clear_nomap(kernel_start, kernel_end);

        // map crashkernel here
        // clear nomap for crashkernel
}

Thoughts?

Thanks,
Mark.
