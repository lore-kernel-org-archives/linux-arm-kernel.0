From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 23:05:21 +0100
Subject: what about mach-shark?
In-Reply-To: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
References: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
Message-ID: <20110704220521.GI8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 04:08:56PM -0400, Nicolas Pitre wrote:
> 
> Is this used?
> 
> While it probably does compile, it is likely to oops soon after boot. I 
> notice that it defines UNCACHEABLE_ADDR to 0xdf010000 in 
> mach-shark/include/mach/hardware.h which is used by cpu_sa110_do_idle in 
> mm/proc-sa110.S, and therefore it must be a virtual address.  However I 
> can't find where this 0xdf010000 is actually mapped.
> 
> So either no one has been using this for a long time as this is not 
> going to run past a schedule to the idle loop, or I'm missing something 
> obvious.  If the former I'm proposing to remove mach-shark from the 
> tree, if the later I'd like to know where the actual mapping for that 
> 0xdf010000 is.

You're missing something.

FYI:

arch/arm/mach-shark/include/mach/memory.h:#define FLUSH_BASE           0xdf000000

arch/arm/mm/mmu.c:
        /*
         * Map the cache flushing regions.
         */
#ifdef FLUSH_BASE
        map.pfn = __phys_to_pfn(FLUSH_BASE_PHYS);
        map.virtual = FLUSH_BASE;
        map.length = SZ_1M;
        map.type = MT_CACHECLEAN;
        create_mapping(&map);
#endif
#ifdef FLUSH_BASE_MINICACHE
        map.pfn = __phys_to_pfn(FLUSH_BASE_PHYS + SZ_1M);
        map.virtual = FLUSH_BASE_MINICACHE;
        map.length = SZ_1M;
        map.type = MT_MINICLEAN;
        create_mapping(&map);
#endif

And 64K < 1M, so its covered by the cache flush mapping.  Exactly the
same applies to RiscPC which worked last time I tried it.
