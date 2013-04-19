From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 19 Apr 2013 17:37:00 -0400 (EDT)
Subject: [PATCH] ARM: make cpu_init() notrace
In-Reply-To: <1366302046.3388.8.camel@linaro1.home>
References: <1366302046.3388.8.camel@linaro1.home>
Message-ID: <alpine.LFD.2.03.1304191735270.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Apr 2013, Jon Medhurst (Tixy) wrote:

> On resume from CPU power down any trace hooks enabled in cpu_init()
> will get called before that function has done set_my_cpu_offset(),
> so any use of per-cpu variables by trace hook code will cause bad
> things to happen. Prevent this by marking the function notrace.
> 
> This fixes lockups/crashes seen when enabling function tracer on TC2
> with the not yet mainlined cpuidle driver.

This has potential to fix things on other platforms too.

> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

I think you may send it to RMK's patch system.


> ---
>  arch/arm/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index d343a6c..943cbf0 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -390,7 +390,7 @@ static void __init feat_v6_fixup(void)
>   *
>   * cpu_init sets up the per-CPU stacks.
>   */
> -void cpu_init(void)
> +void notrace cpu_init(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	struct stack *stk = &stacks[cpu];
> -- 
> 1.7.10.4
> 
> 
