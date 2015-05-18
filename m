From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 18 May 2015 15:21:55 +0100
Subject: [PATCH v2] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
In-Reply-To: <1431941933-18574-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1431941933-18574-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150518142155.GA17942@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 10:38:51AM +0100, Tomeu Vizoso wrote:
> This callback is expected to do the same as enter() only that won't
> re-enable interrupts on exit.
> 
> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 
> v2:	* Disable FIQs also when suspending-to-idle
> ---
>  arch/arm/mach-tegra/cpuidle-tegra114.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
> index 155807f..e7c4359 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
> @@ -35,32 +35,42 @@
>  #endif
>  
>  #ifdef CONFIG_PM_SLEEP
> -static int tegra114_idle_power_down(struct cpuidle_device *dev,
> -				    struct cpuidle_driver *drv,
> -				    int index)
> +static void tegra114_idle_power_down(void)
>  {
>  	local_fiq_disable();
>  
>  	tegra_set_cpu_in_lp2();
>  	cpu_pm_enter();
>  
> -	tick_broadcast_enter();
> -
>  	call_firmware_op(prepare_idle);
>  
>  	/* Do suspend by ourselves if the firmware does not implement it */
>  	if (call_firmware_op(do_idle, 0) == -ENOSYS)
>  		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
>  
> -	tick_broadcast_exit();
> -
>  	cpu_pm_exit();
>  	tegra_clear_cpu_in_lp2();
>  
>  	local_fiq_enable();
> +}
> +
> +static int tegra114_idle_enter(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv,
> +			       int index)
> +{
> +	tick_broadcast_enter();
> +	tegra114_idle_power_down();
> +	tick_broadcast_exit();

The tick broadcast is managed by the CPUidle core if you set the
CPUIDLE_FLAG_TIMER_STOP in the respective idle state there is no
need to separate the functions, all you have to do is adding the
flag in the idle state and initialize the enter_freeze pointer,
easier, cleaner.

Thanks,
Lorenzo

>  
>  	return index;
>  }
> +
> +static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
> +				       struct cpuidle_driver *drv,
> +				       int index)
> +{
> +	tegra114_idle_power_down();
> +}
>  #endif
>  
>  static struct cpuidle_driver tegra_idle_driver = {
> @@ -71,7 +81,8 @@ static struct cpuidle_driver tegra_idle_driver = {
>  		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
>  #ifdef CONFIG_PM_SLEEP
>  		[1] = {
> -			.enter			= tegra114_idle_power_down,
> +			.enter			= tegra114_idle_enter,
> +			.enter_freeze		= tegra114_idle_enter_freeze,
>  			.exit_latency		= 500,
>  			.target_residency	= 1000,
>  			.power_usage		= 0,
> -- 
> 2.4.0
> 
