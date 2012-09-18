From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 18 Sep 2012 14:20:37 -0400 (EDT)
Subject: [RFC PATCH v2 5/5] ARM: mm: update __v7_setup() to the new LoUIS
 cache maintenance API
In-Reply-To: <1347986135-17979-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.02.1209181419520.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Sep 2012, Lorenzo Pieralisi wrote:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> The ARMv7 processor setup function __v7_setup() cleans and invalidates the
> CPU cache before enabling MMU to start the CPU with a clean CPU local cache.
> 
> But on ARMv7 architectures like Cortex-[A15/A8], this code will end
> up flushing the L2 caches(up to level of Coherency) which is undesirable
> and expensive. The setup functions are used in the CPU hotplug scenario too
> and hence flushing all cache levels should be avoided.
> 
> This patch replaces the cache flushing call with the newly introduced
> v7 dcache LoUIS API where only cache levels up to LoUIS are cleaned and
> invalidated when a processors executes __v7_setup which is the expected
> behavior.
> 
> For processors like A9 and A5 where the L2 cache is an outer one the
> behavior should be unchanged.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mm/proc-v7.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index c2e2b66..846d279 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -172,7 +172,7 @@ __v7_ca15mp_setup:
>  __v7_setup:
>  	adr	r12, __v7_setup_stack		@ the local stack
>  	stmia	r12, {r0-r5, r7, r9, r11, lr}
> -	bl	v7_flush_dcache_all
> +	bl      v7_flush_dcache_louis
>  	ldmia	r12, {r0-r5, r7, r9, r11, lr}
>  
>  	mrc	p15, 0, r0, c0, c0, 0		@ read main ID register
> -- 
> 1.7.12
> 
> 
