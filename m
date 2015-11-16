From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Nov 2015 13:45:19 +0000
Subject: arm64 function_graph tracer panic with CONFIG_DYNAMIC_FTRACE
In-Reply-To: <564937E3.3090501@linaro.org>
References: <20151112104243.GF5627@e104818-lin.cambridge.arm.com>
 <56457A4B.601@linaro.org> <564937E3.3090501@linaro.org>
Message-ID: <20151116134518.GC6556@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

(+ Lorenzo and Mark)

On Mon, Nov 16, 2015 at 10:56:51AM +0900, AKASHI Takahiro wrote:
> I think I fixed the problem.
> As you can see stack dump traces above, psci_cpu_suspend() and psci_suspend_finisher()
> are called in cpu suspend path, but they never return in cpu resume path and
> cpu_suspend() will resume directly via cpu_resume(). So those two functions should not be
> ftrace'd.
> 
> Please try this patch:
> ----8<----
> From c3aaaab52cf51879ae8e112f80790075425ba9be Mon Sep 17 00:00:00 2001
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Date: Mon, 16 Nov 2015 10:29:21 +0900
> Subject: [PATCH] arm64: disable ftrace in suspend path
> 
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/kernel/psci.c    |    2 +-
>  arch/arm64/kernel/suspend.c |    2 +-
>  drivers/firmware/psci.c     |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index f67f35b..78414d7 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -178,7 +178,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>  }
>  #endif
> 
> -static int psci_suspend_finisher(unsigned long index)
> +static int notrace psci_suspend_finisher(unsigned long index)
>  {
>  	u32 *state = __this_cpu_read(psci_power_state);
> 
> diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> index 44ca414..12280ef 100644
> --- a/arch/arm64/kernel/suspend.c
> +++ b/arch/arm64/kernel/suspend.c
> @@ -19,7 +19,7 @@ extern int __cpu_suspend_enter(unsigned long arg, int (*fn)(unsigned long));
>   * save_ptr: address of the location where the context physical address
>   *           must be saved
>   */
> -void notrace __cpu_suspend_save(struct cpu_suspend_ctx *ptr,
> +void __cpu_suspend_save(struct cpu_suspend_ctx *ptr,
>  				phys_addr_t *save_ptr)
>  {
>  	*save_ptr = virt_to_phys(ptr);
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 838298f..8fce2c5 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -129,7 +129,7 @@ static u32 psci_get_version(void)
>  	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
>  }
> 
> -static int psci_cpu_suspend(u32 state, unsigned long entry_point)
> +static int notrace psci_cpu_suspend(u32 state, unsigned long entry_point)
>  {
>  	int err;
>  	u32 fn;

The patch indeed fixes the crash.

> There are some other functions which are called by cpu_suspend(), e.g. psci_system_suspend().
> Should we apply a similar fix to them?

I think we need to apply the fix to any function which does not return.
In general, this should apply to all finishers passed to cpu_suspend()
and the subsequent callees.

Do we need such annotation for cpu_die() as well? It probably doesn't
matter as the CPU is coming back on a completely different path anyway.

Thanks.

-- 
Catalin
