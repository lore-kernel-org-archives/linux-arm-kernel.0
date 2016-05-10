From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 10 May 2016 09:22:50 +0100
Subject: [PATCH] firmware/drivers/psci: Fix unused functions when
 CONFIG_CPU_IDLE=n
In-Reply-To: <1462864729-11793-1-git-send-email-daniel.lezcano@linaro.org>
References: <1462864729-11793-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160510082250.GA14662@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 09:18:49AM +0200, Daniel Lezcano wrote:
> On the ARM64 architecture, when CPUIDLE is not set in the configuration,
> the compilation raises a couple of warnings:
> 
> drivers/firmware/psci.c:70:12: warning: 'psci_pd_power_off' defined but not used [-Wunused-function]
> drivers/firmware/psci.c:273:12: warning: 'psci_set_suspend_mode_osi' defined but not used [-Wunused-function]

That's not mainline code :)

Thanks,
Lorenzo

> Fix those warnings by moving the functions inside the #ifdef CONFIG_CPU_IDLE
> section.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/firmware/psci.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 9c6a1f9..d7e0632 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -54,7 +54,6 @@
>   */
>  static int resident_cpu = -1;
>  static bool psci_has_osi_pd;
> -static bool psci_suspend_mode_is_osi;
>  static DEFINE_PER_CPU(u32, cluster_state_id);
>  
>  static inline u32 psci_get_composite_state_id(u32 cpu_state)
> @@ -67,13 +66,6 @@ static inline void psci_reset_composite_state_id(void)
>  	this_cpu_write(cluster_state_id, 0);
>  }
>  
> -static int psci_pd_power_off(u32 state_idx, u32 param,
> -		const struct cpumask *mask)
> -{
> -	__this_cpu_add(cluster_state_id, param);
> -	return 0;
> -}
> -
>  bool psci_tos_resident_on(int cpu)
>  {
>  	return cpu == resident_cpu;
> @@ -270,6 +262,11 @@ static int __init psci_features(u32 psci_func_id)
>  			      psci_func_id, 0, 0);
>  }
>  
> +#ifdef CONFIG_CPU_IDLE
> +static bool psci_suspend_mode_is_osi;
> +
> +static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> +
>  static int psci_set_suspend_mode_osi(bool enable)
>  {
>  	int ret;
> @@ -290,8 +287,12 @@ static int psci_set_suspend_mode_osi(bool enable)
>  	return psci_to_linux_errno(ret);
>  }
>  
> -#ifdef CONFIG_CPU_IDLE
> -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> +static int psci_pd_power_off(u32 state_idx, u32 param,
> +		const struct cpumask *mask)
> +{
> +	__this_cpu_add(cluster_state_id, param);
> +	return 0;
> +}
>  
>  static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  {
> -- 
> 1.9.1
> 
