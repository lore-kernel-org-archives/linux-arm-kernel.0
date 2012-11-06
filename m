From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Nov 2012 21:41:37 +0000
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
Message-ID: <20121106214137.GA21764@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 09:12:27PM +0000, Nicolas Pitre wrote:
> 
> ... instead of flush_cache_all().  The later unconditionally flushes
> the L2 cache on ARMv7 architectures such as Cortex A15 and A7 which
> is costly and unnecessary in some scenarios where setup_mm_for_reboot()
> is used.  If L2 has to be flushed as well, it should already be done
> separately on other architectures anyway.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index ab88ed4f8e..2c61085a10 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -104,7 +104,7 @@ early_initcall(init_static_idmap);
>  void setup_mm_for_reboot(void)
>  {
>  	/* Clean and invalidate L1. */
> -	flush_cache_all();
> +	flush_cache_louis();
>  
>  	/* Switch to the identity mapping. */
>  	cpu_switch_mm(idmap_pgd, &init_mm);

We could probably even predicate this on the half-implemented
TLB_CAN_READ_FROM_L1_CACHE option, but that can come later.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
