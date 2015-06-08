From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 10:24:16 +0100
Subject: [PATCH v5 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433747496-7642-2-git-send-email-wxt@rock-chips.com>
References: <1433747496-7642-1-git-send-email-wxt@rock-chips.com>
 <1433747496-7642-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20150608092416.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 03:11:34PM +0800, Caesar Wang wrote:
> We need different orderings when turning a core on and turning a core
> off.  In one case we need to assert reset before turning power off.
> In ther other case we need to turn power on and the deassert reset.
> 
> In general, the correct flow is:
> 
> CPU off:
>     reset_control_assert
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))
>     wait_for_power_domain_to_turn_off
> CPU on:
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
>     wait_for_power_domain_to_turn_on
>     reset_control_deassert
> 
> This is needed for stressing CPU up/down, as per:
>     cd /sys/devices/system/cpu/
>     for i in $(seq 10000); do
>         echo "================= $i ============"
>         for j in $(seq 100); do
>             while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" != "000"" ]]
>                 echo 0 > cpu1/online
>                 echo 0 > cpu2/online
>                 echo 0 > cpu3/online
>             done
>             while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" != "111" ]]; do
>                 echo 1 > cpu1/online
>                 echo 1 > cpu2/online
>                 echo 1 > cpu3/online
>             done
>         done
>     done
> 
> The following is reproducile log:

"reproducable"

>     [34466.186812] PM: noirq suspend of devices complete after 0.669 msecs
>     [34466.186824] Disabling non-boot CPUs ...
>     [34466.187509] CPU1: shutdown
>     [34466.188672] CPU2: shutdown
>     [34473.736627] Kernel panic - not syncing:Watchdog detected hard LOCKUP on cpu 0
>     .......
> or others similar log:
>     .......
>     [ 4072.454453] CPU1: shutdown
>     [ 4072.504436] CPU2: shutdown
>     [ 4072.554426] CPU3: shutdown
>     [ 4072.577827] CPU1: Booted secondary processor
>     [ 4072.582611] CPU2: Booted secondary processor
>     [ 4072.587426] CPU3: Booted secondary processor
>     <hang>
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> 
> Changes in v5:
>     - back to v2 cpu on/off flow, As Heiko point out in patch v3.
>     - delay more time in rockchip_boot_secondary().
>     From CPU up/down tests, Needed more time to complete CPU process.
>     In order to ensure a more, Here that be delayed 1ms.
> 
> Changes in v4:
>     - Add reset_control_put(rstc) for the non-error case.
> 
> Changes in v3:
>     - FIx the PATCH v2, it doesn't work on chromium 3.14.
> 
> Changes in v2:
>     - As Heiko suggestion, re-adjust the cpu on/off flow.
>     CPU off:
>     reset_control_assert
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))
>     wait_for_power_domain_to_turn_off
>     CPU on:
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
>     wait_for_power_domain_to_turn_on
>     reset_control_deassert
> 
> ---
> 
>  arch/arm/mach-rockchip/platsmp.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index 5b4ca3c..bd40852 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -72,6 +72,7 @@ static struct reset_control *rockchip_get_core_reset(int cpu)
>  static int pmu_set_power_domain(int pd, bool on)
>  {
>  	u32 val = (on) ? 0 : BIT(pd);
> +	struct reset_control *rstc = rockchip_get_core_reset(pd);
>  	int ret;
>  
>  	/*
> @@ -80,20 +81,15 @@ static int pmu_set_power_domain(int pd, bool on)
>  	 * processor is powered down.
>  	 */
>  	if (read_cpuid_part() != ARM_CPU_PART_CORTEX_A9) {
> -		struct reset_control *rstc = rockchip_get_core_reset(pd);
> -
> +		/* We only require the reset on the RK3288 at the moment */
>  		if (IS_ERR(rstc)) {
>  			pr_err("%s: could not get reset control for core %d\n",
>  			       __func__, pd);
>  			return PTR_ERR(rstc);
>  		}
>  
> -		if (on)
> -			reset_control_deassert(rstc);
> -		else
> +		if (!on)
>  			reset_control_assert(rstc);
> -
> -		reset_control_put(rstc);
>  	}
>  
>  	ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
> @@ -112,6 +108,12 @@ static int pmu_set_power_domain(int pd, bool on)
>  		}
>  	}
>  
> +	if (read_cpuid_part() != ARM_CPU_PART_CORTEX_A9 && on)
> +		reset_control_deassert(rstc);
> +
> +	if (!IS_ERR(rstc))
> +		reset_control_put(rstc);
> +
>  	return 0;
>  }
>  
> @@ -148,7 +150,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
>  		 * sram_base_addr + 4: 0xdeadbeaf
>  		 * sram_base_addr + 8: start address for pc
>  		 * */
> -		udelay(10);
> +		mdelay(1);

The reason for this delay needs a comment, as it's not obvious why you
would need to delay before writing to the SRAM.  Also documenting in
a comment why the delay is necessary would be good.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
