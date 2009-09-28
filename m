From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 28 Sep 2009 17:50:35 +0100
Subject: Disable highmem with SMP if no h/w TLB broadcasting
In-Reply-To: <20090927202937.GA26521@n2100.arm.linux.org.uk>
References: <20090927202937.GA26521@n2100.arm.linux.org.uk>
Message-ID: <1254156635.21619.37.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2009-09-27 at 21:29 +0100, Russell King - ARM Linux wrote:
> We suffer an unfortunate combination of "features" which makes highmem
> support on platforms without hardware TLB maintainence broadcast difficult:
> 
> - we need kmap_high_get() support for DMA cache coherence
> - this requires kmap_high() to take a spinlock with IRQs disabled
> - kmap_high() occasionally calls flush_all_zero_pkmaps() to clear
>   out old mappings
> - flush_all_zero_pkmaps() calls flush_tlb_kernel_range(), which
>   on s/w IPI'd systems eventually calls smp_call_function_many()
> - smp_call_function_many() must not be called with IRQs disabled:

I think the last point above is an artificial restriction. I understand
the possible deadlock situation but we can work around this without
performance penalty.

A patch I keep around is to allow DMA cache maintenance operations to
work correctly on ARM11MPCore (which doesn't broadcast the cache
operations in hardware):

http://www.linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=8c8d4d8cc50492f57a4a2f91f76d986130d3dfbf

This patch allows IPIs with interrupts disabled by using a combination
of spin_trylock() and polling in the unlikely case that other CPU is
sending an IPI.

I recall that I raised the issue on LKML when the generic SMP call was
introduced but people didn't seem interested in allowing IPIs with
interrupts disabled. If you are interested, the above patch can be split
so that we have an ARM-specific IPI mechanism again and allow interrupts
to be disabled.

Alternatively we can push the fix into the generic code but it needs a
bit more convincing.

-- 
Catalin
