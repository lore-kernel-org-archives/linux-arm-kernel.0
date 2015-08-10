From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Aug 2015 10:49:13 -0400 (EDT)
Subject: Disabling caches with MMU enabled
In-Reply-To: <20150810125039.GT7557@n2100.arm.linux.org.uk>
References: <20150810125039.GT7557@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1508100957080.1515@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Aug 2015, Russell King - ARM Linux wrote:

> There is an erratum for Cortex-A15 which contains this paragraph:
> 
>  2) Do not issue write-back cacheable stores at any time when the cache
>  is disabled (SCTLR.C=0) and the MMU is enabled (SCTLR.M=1). Because it
>  is implementation defined whether cacheable stores update the cache when
>  the cache is disabled it is not expected that any portable code will
>  execute cacheable stores when the cache is disabled.
> 
> The interesting part is the second sentence, which implies that having the
> MMU enabled with writeback mappings, but with the C bit clear is not an
> expected use case.  Moreover, it reinforces the ARM ARM statment that a
> disabled cache may still be searched, and updated with written data.
> 
> However, the v7_exit_coherency_flush() function creates exactly this
> scenario by clearing the C bit:
> 
> #define v7_exit_coherency_flush(level) \
>         asm volatile( \
>         ".arch  armv7-a \n\t" \
>         "stmfd  sp!, {fp, ip} \n\t" \
>         "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR \n\t" \
>         "bic    r0, r0, #"__stringify(CR_C)" \n\t" \
>         "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR \n\t" \
>         "isb    \n\t" \
> 
> However, v7_exit_coherency_flush() is careful to disable caching, flush
> the cache and then disable coherency.  Whether that's sufficient for all
> cases is open to question - and where we need this CA15 errata implemented,
> it implies that even this sequence is not permissible to use there.

Just for the record, v7_exit_coherency_flush() was created in the 
context of the MCPM layer used by both the b.L switcher and cpuidle 
driver.  This was developed in collaboration with ARM Ltd people who had 
direct access to the hardware designers when subtle issues like this 
came up.  And they did come up during those months it took to stabilize 
test results indeed.

The v7_exit_coherency_flush() in itself is probably safe given that it 
flushes the cache after disabling it with no writes to memory in 
between.  Subsequent writes won't hit the cache even if it happens to 
still be searched, and it won't be allocated anymore by virtue of not 
being enabled.

Where things becomes interesting is within the MCPM synchronization 
primitives where we do have writes from CPUs with mixed cache states, 
and even MMU states.  This is why we also created sync_cache_w() and 
sync_cache_r().  In the former case, we certainly do have some 
occurrences of MMU enabled with writeback mappings and the C bit clear.  
But the cache for those write is supposed to be clean and not allocated 
when the C bit is clear given v7_exit_coherency_flush() is used 
beforehand.

> The exynos implementation of v7_exit_coherency() is another instance.

This one I can't explain.  It is for an A15 just like the A15 we used on 
TC2 for development and we did not need special erratum handling like 
they apparently do.  When I asked for a justification from a deeper 
investigation _other than_ some automatic citation of the errata 
document I got no answer. At this point in time it appears to be 
impossible for the right people to care.

> I think all places which clear the C bit need to be re-reviewed and at
> least some of them fixed, or converted to use a macro such as the
> v7_exit_coherency_flush macro - and they should get a notice placed
> on them to discourage copy-n-pasting it.

Agreed.  At that level you really must know what you're doing and have 
the validation infrastructure in place.  Merely copying existing code 
that was validated in a different context is not OK if it doesn't come 
with a comprehensive justification.


Nicolas
