From: josephl@nvidia.com (Joseph Lo)
Date: Sat, 21 Nov 2015 19:56:47 +0800
Subject: [PATCH] ARM: tegra: Ensure entire dcache is flushed on entering
 LP0/1
In-Reply-To: <1447942787-31137-1-git-send-email-jonathanh@nvidia.com>
References: <1447942787-31137-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <56505BFF.2010904@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 11/19/2015 10:19 PM, Jon Hunter wrote:
> Tegra support several low-power (LPx) states, which are:
> - LP0: CPU + Core voltage off and DRAM in self-refresh
> - LP1: CPU voltage off and DRAM in self-refresh
> - LP2: CPU voltage off
>
> When entering any of the above states the tegra_disable_clean_inv_dcache()
> function is called to flush the dcache. The function
> tegra_disable_clean_inv_dcache() will either flush the entire data cache or
> up to the Level of Unification Inner Shareable (LoUIS) depending on the
> value in r0. When tegra_disable_clean_inv_dcache() is called by
> tegra20_sleep_core_finish() or tegra30_sleep_core_finish(), to enter LP0
> and LP1 power state, the r0 register contains a physical memory address
> which will not be equal to TEGRA_FLUSH_CACHE_ALL (1) and so the data cache
> will be only flushed to the LoUIS. However, when
> tegra_disable_clean_inv_dcache() called by tegra_sleep_cpu_finish() to
> enter to LP2 power state, r0 is set to TEGRA_FLUSH_CACHE_ALL to flush the
> entire dcache.
>
> Please note that tegra20_sleep_core_finish(), tegra30_sleep_core_finish()
> and tegra_sleep_cpu_finish() are called by the boot CPU once all other CPUs
> have been disabled and so it seems appropriate to flush the entire cache at
> this stage.
>
> Therefore, ensure that r0 is set to TEGRA_FLUSH_CACHE_ALL when calling
> tegra_disable_clean_inv_dcache() from tegra20_sleep_core_finish() and
> tegra30_sleep_core_finish().
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Thanks for the fix.

Reviewed-by: Joseph Lo <josephl@nvidia.com>

>
> Please note that I have not encountered any problems without this change
> so far, but I noticed this from reviewing the suspend sequence. I have
> tested this on tegra20, tegra30, tegra114 and tegra124 and verified that
> suspend/resume to LP1 is working fine.
>
>   arch/arm/mach-tegra/sleep-tegra20.S | 3 +++
>   arch/arm/mach-tegra/sleep-tegra30.S | 3 +++
>   2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
> index e6b684e14322..f5d19667484e 100644
> --- a/arch/arm/mach-tegra/sleep-tegra20.S
> +++ b/arch/arm/mach-tegra/sleep-tegra20.S
> @@ -231,8 +231,11 @@ ENDPROC(tegra20_cpu_is_resettable_soon)
>    * tegra20_tear_down_core in IRAM
>    */
>   ENTRY(tegra20_sleep_core_finish)
> +	mov     r4, r0
>   	/* Flush, disable the L1 data cache and exit SMP */
> +	mov     r0, #TEGRA_FLUSH_CACHE_ALL
>   	bl	tegra_disable_clean_inv_dcache
> +	mov     r0, r4
>
>   	mov32	r3, tegra_shut_off_mmu
>   	add	r3, r3, r0
> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
> index 9a2f0b051e10..16e5ff03383c 100644
> --- a/arch/arm/mach-tegra/sleep-tegra30.S
> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
> @@ -242,8 +242,11 @@ ENDPROC(tegra30_cpu_shutdown)
>    * tegra30_tear_down_core in IRAM
>    */
>   ENTRY(tegra30_sleep_core_finish)
> +	mov	r4, r0
>   	/* Flush, disable the L1 data cache and exit SMP */
> +	mov	r0, #TEGRA_FLUSH_CACHE_ALL
>   	bl	tegra_disable_clean_inv_dcache
> +	mov	r0, r4
>
>   	/*
>   	 * Preload all the address literals that are needed for the
>
