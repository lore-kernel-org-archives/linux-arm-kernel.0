From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 20 May 2015 09:44:41 +0100
Subject: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
In-Reply-To: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150520084441.GA29274@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 03:49:12PM +0100, Tomeu Vizoso wrote:
> This callback is expected to do the same as enter() but it has to
> guarantee that interrupts aren't enabled at any point in its execution,
> as the tick is frozen.
> 
> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> 
> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
> for both the enter() and enter_freeze() callbacks.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 
> v3:	* Set CPUIDLE_FLAG_TIMER_STOP to simplify things as suggested by
> 	Lorenzo Pieralisi
> v2:	* Disable FIQs also when suspending-to-idle
> ---
>  arch/arm/mach-tegra/cpuidle-tegra114.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
> index 155807f..7e59ac0 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
> @@ -44,16 +44,12 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
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
> @@ -61,6 +57,13 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
>  
>  	return index;
>  }
> +
> +static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
> +				       struct cpuidle_driver *drv,
> +				       int index)
> +{
> +       tegra114_idle_power_down(dev, drv, index);
> +}

You do not need this function, remove it and update the enter_freeze
pointer below with tegra114_idle_power_down please.

Thanks,
Lorenzo

>  #endif
>  
>  static struct cpuidle_driver tegra_idle_driver = {
> @@ -72,8 +75,10 @@ static struct cpuidle_driver tegra_idle_driver = {
>  #ifdef CONFIG_PM_SLEEP
>  		[1] = {
>  			.enter			= tegra114_idle_power_down,
> +			.enter_freeze		= tegra114_idle_enter_freeze,
>  			.exit_latency		= 500,
>  			.target_residency	= 1000,
> +			.flags			= CPUIDLE_FLAG_TIMER_STOP,
>  			.power_usage		= 0,
>  			.name			= "powered-down",
>  			.desc			= "CPU power gated",
> -- 
> 2.4.1
> 
