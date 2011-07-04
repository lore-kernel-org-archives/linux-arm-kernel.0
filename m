From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 04 Jul 2011 18:20:25 -0400 (EDT)
Subject: what about mach-shark?
In-Reply-To: <20110704220521.GI8286@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
	<20110704220521.GI8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107041812410.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Jul 2011, Russell King - ARM Linux wrote:

> You're missing something.
> 
> FYI:
> 
> arch/arm/mach-shark/include/mach/memory.h:#define FLUSH_BASE           0xdf000000
> 
> arch/arm/mm/mmu.c:
>         /*
>          * Map the cache flushing regions.
>          */
> #ifdef FLUSH_BASE
>         map.pfn = __phys_to_pfn(FLUSH_BASE_PHYS);
>         map.virtual = FLUSH_BASE;
>         map.length = SZ_1M;
>         map.type = MT_CACHECLEAN;
>         create_mapping(&map);
> #endif
> #ifdef FLUSH_BASE_MINICACHE
>         map.pfn = __phys_to_pfn(FLUSH_BASE_PHYS + SZ_1M);
>         map.virtual = FLUSH_BASE_MINICACHE;
>         map.length = SZ_1M;
>         map.type = MT_MINICLEAN;
>         create_mapping(&map);
> #endif
> 
> And 64K < 1M, so its covered by the cache flush mapping.  Exactly the
> same applies to RiscPC which worked last time I tried it.

OK.  In that case, UNCACHEABLE_ADDR is not truly "uncacheable", which 
might inhibit clock switching in cpu_sa110_do_idle, no?


Nicolas
