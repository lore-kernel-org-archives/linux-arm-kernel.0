From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Apr 2011 16:59:49 +0530
Subject: [PATCH 5/5] OMAP3: cpuidle: change the power domains modes
	determination logic
In-Reply-To: <1304069186-3086-6-git-send-email-j-pihet@ti.com>
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
	<1304069186-3086-6-git-send-email-j-pihet@ti.com>
Message-ID: <4DBAA12D.6070203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/29/2011 2:56 PM, jean.pihet at newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> The achievable power modes of the power domains in cpuidle
> depends on the system wide 'enable_off_mode' knob in debugfs.
> Upon changing enable_off_mode, do not change the C-states
> 'valid' field but instead dynamically restrict the power modes
> when entering idle.
>
> The C-states 'valid' field is just used to enable/disable some
> C-states at init and shall not be changed later on.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/cpuidle34xx.c |   59 +++++++++++++++---------------------
>   arch/arm/mach-omap2/pm.h          |    4 --
>   arch/arm/mach-omap2/pm34xx.c      |   12 -------
>   3 files changed, 25 insertions(+), 50 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4673cc6..45ccfa7 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -147,22 +147,40 @@ return_sleep_time:
>   }
>
>   /**
> - * next_valid_state - Find next valid c-state
> + * next_valid_state - Find next valid C-state
>    * @dev: cpuidle device
> - * @state: Currently selected c-state
> + * @state: Currently selected C-state
>    *
>    * If the current state is valid, it is returned back to the caller.
>    * Else, this function searches for a lower c-state which is still
>    * valid.
> + *
> + * A state is valid if the 'valid' field is enabled and
> + * if it satisfies the enable_off_mode condition.
>    */
>   static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
>   					      struct cpuidle_state *curr)
>   {
>   	struct cpuidle_state *next = NULL;
>   	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr);
> +	u32 mpu_deepest_state = PWRDM_POWER_RET;
> +	u32 core_deepest_state = PWRDM_POWER_RET;
> +
> +	if (enable_off_mode) {
> +		mpu_deepest_state = PWRDM_POWER_OFF;
> +		/*
> +		 * Erratum i583: valable for ES rev<  Es1.2 on 3630.
> +		 * CORE OFF mode is not supported in a stable form, restrict
> +		 * instead the CORE state to RET.
> +		 */
> +		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
> +			core_deepest_state = PWRDM_POWER_OFF;
> +	}
>
Since you have started clean-up, we should get rid of the
"enable_off_mode" some how. I got that done for OMAP4 using
prepare() hook and IGNORE flag as per Kevin's suggestion
but unfortunately its seems to getting removed from
core cpuidle code.

Regards
Santosh
