From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 20 Dec 2010 11:28:45 +0100
Subject: [PATCH v4 6/7] OMAP3: PM: make omap3_cpuidle_update_states
	independent of enable_off_mode
In-Reply-To: <1292712817-24999-7-git-send-email-nm@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-7-git-send-email-nm@ti.com>
Message-ID: <AANLkTi=ANt1_SeX1322g1pm0RZcRa5dyiMD2iK8bcnbG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> Currently omap3_cpuidle_update_states makes whole sale decision
> on which C states to update based on enable_off_mode variable
> Instead, achieve the same functionality by independently providing
> mpu and core deepest states the system is allowed to achieve and
> update the idle states accordingly.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Jean Pihet <j-pihet@ti.com>

> ---
> ?arch/arm/mach-omap2/cpuidle34xx.c | ? 19 ++++++++++---------
> ?arch/arm/mach-omap2/pm.h ? ? ? ? ?| ? ?3 ++-
> ?arch/arm/mach-omap2/pm34xx.c ? ? ?| ? ?2 +-
> ?3 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 0d50b45..f80d3f6 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -293,25 +293,26 @@ select_state:
> ?DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>
> ?/**
> - * omap3_cpuidle_update_states - Update the cpuidle states.
> + * omap3_cpuidle_update_states() - Update the cpuidle states
> + * @mpu_deepest_state: Enable states upto and including this for mpu domain
> + * @core_deepest_state: ? ? ? ?Enable states upto and including this for core domain
> ?*
> - * Currently, this function toggles the validity of idle states based upon
> - * the flag 'enable_off_mode'. When the flag is set all states are valid.
> - * Else, states leading to OFF state set to be invalid.
> + * This goes through the list of states available and enables and disables the
> + * validity of C states based on deepest state that can be achieved for the
> + * variable domain
> ?*/
> -void omap3_cpuidle_update_states(void)
> +void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
> ?{
> ? ? ? ?int i;
>
> ? ? ? ?for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
> ? ? ? ? ? ? ? ?struct omap3_processor_cx *cx = &omap3_power_states[i];
>
> - ? ? ? ? ? ? ? if (enable_off_mode) {
> + ? ? ? ? ? ? ? if ((cx->mpu_state >= mpu_deepest_state) &&
> + ? ? ? ? ? ? ? ? ? (cx->core_state >= core_deepest_state)) {
> ? ? ? ? ? ? ? ? ? ? ? ?cx->valid = 1;
> ? ? ? ? ? ? ? ?} else {
> - ? ? ? ? ? ? ? ? ? ? ? if ((cx->mpu_state == PWRDM_POWER_OFF) ||
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (cx->core_state == PWRDM_POWER_OFF))
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cx->valid = 0;
> + ? ? ? ? ? ? ? ? ? ? ? cx->valid = 0;
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
> ?}
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 5e0bee9..92ef400 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -58,7 +58,8 @@ extern u32 sleep_while_idle;
> ?#endif
>
> ?#if defined(CONFIG_CPU_IDLE)
> -extern void omap3_cpuidle_update_states(void);
> +extern void omap3_cpuidle_update_states(u32 core_deepest_state,
> + ? ? ? ? ? ? ? u32 core_deepest_state);
> ?#endif
>
> ?#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 4ba7a06..21cd36e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -928,7 +928,7 @@ void omap3_pm_off_mode_enable(int enable)
> ? ? ? ? ? ? ? ?state = PWRDM_POWER_RET;
>
> ?#ifdef CONFIG_CPU_IDLE
> - ? ? ? omap3_cpuidle_update_states();
> + ? ? ? omap3_cpuidle_update_states(state, state);
> ?#endif
>
> ? ? ? ?list_for_each_entry(pwrst, &pwrst_list, node) {
> --
> 1.6.3.3
>
>
