From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 May 2012 07:38:59 +0100
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC45E6B.2070202@gmail.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
 <4FC45E6B.2070202@gmail.com>
Message-ID: <20120530063858.GB6484@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 06:28:11AM +0100, bill4carson wrote:
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -170,6 +170,10 @@ ENDPROC(v6_coherent_kern_range)
>   ENTRY(v6_flush_kern_dcache_area)
>          add     r1, r0, r1
>   1:
> +#ifdef CONFIG_SMP
> +       ldr     r2, [r0]                        @ read for ownership
> +       str     r2, [r0]                        @ write for ownership
> +#endif /* CONFIG_SMP */
>   #ifdef HARVARD_CACHE
>          mcr     p15, 0, r0, c7, c14, 1          @ clean & invalidate D line
>   #else

I don't think the invalidation is needed here, so you probably don't need to
hack this function at all.

> But I have no idea on how to accomplish the v6_flush_kern_cache_all, 
> maybe IPI is needed?

We could add an IPI to invalidate the I-caches on the other cores, however
I haven't checked to see if we could instead do something on the CPU
migration path which avoid the need for the broadcasting.

Will
