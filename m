From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 2 Feb 2012 17:21:21 +0100
Subject: [RFC PATCH v4 2/4] ARM: omap: Remove cpuidle timekeeping and irq
 enable/disable
In-Reply-To: <1328065215-28108-3-git-send-email-rob.lee@linaro.org>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
 <1328065215-28108-3-git-send-email-rob.lee@linaro.org>
Message-ID: <CAORVsuXLPjc7X+D1jVP1KyjgUWZhtUnA3F-iz-d-DqtHRmLShA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Wed, Feb 1, 2012 at 4:00 AM, Robert Lee <rob.lee@linaro.org> wrote:
> Now that the core cpuidle driver keeps time and handles irq enabling,
> remove this functionality. ?Also, remove irq disabling as all paths to
> cpuidle_idle_call already call local_irq_disable. ?Also, restructure
> idle functions as needed by the cpuidle core driver changes.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> ?arch/arm/mach-omap2/cpuidle34xx.c | ? 96 ++++++++++++++++--------------------
> ?1 files changed, 43 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 464cffd..9ecded5 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
...

> @@ -100,23 +107,20 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int index)
> ?{
> - ? ? ? struct omap3_idle_statedata *cx =
> - ? ? ? ? ? ? ? ? ? ? ? cpuidle_get_statedata(&dev->states_usage[index]);
> - ? ? ? struct timespec ts_preidle, ts_postidle, ts_idle;
> - ? ? ? u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
> - ? ? ? int idle_time;
> + ? ? ? struct omap3_idle_drvdata *dd = dev->states_usage[index].driver_data
A build error is triggered by the missing ";".

...

> @@ -147,18 +151,12 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
> ? ? ? ? ? ? ? ?pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> ? ? ? ?}
>
> -return_sleep_time:
> - ? ? ? getnstimeofday(&ts_postidle);
> - ? ? ? ts_idle = timespec_sub(ts_postidle, ts_preidle);
> -
> - ? ? ? local_irq_enable();
> +leave:
> ? ? ? ?local_fiq_enable();
>
> - ? ? ? idle_time = ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * \
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? USEC_PER_SEC;
> -
> - ? ? ? /* Update cpuidle counters */
> - ? ? ? dev->last_residency = idle_time;
> + ? ? ? /* Restore original PER state if it was modified */
> + ? ? ? if (dd->per_next_state != dd->per_saved_state)
> + ? ? ? ? ? ? ? pwrdm_set_next_pwrst(per_pd, dd->per_saved_state);
This code is not necessarily balanced with the PER state change in
omap3_enter_idle_bm (cf. "/* Are we changing PER target state? */"
here below), since in the core cpuidle code there is no guarantee that
the calls to pre_enter and enter callbacks are balanced.
In general I fear that splitting the code in two functions introduces
a risk of programming non-coherent settings in the PRCM.

...

> @@ -255,8 +255,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
> ?{
> ? ? ? ?int new_state_idx;
> - ? ? ? u32 core_next_state, per_next_state = 0, per_saved_state = 0, cam_state;
> - ? ? ? struct omap3_idle_statedata *cx;
> + ? ? ? u32 core_next_state, cam_state;
> + ? ? ? struct omap3_idle_drvdata *dd = dev->states_usage[index].driver_data;
> + ? ? ? struct omap3_idle_statedata *cx = &dd->state_data[index];
> ? ? ? ?int ret;
The build throws a few warnings about unused variables:

arch/arm/mach-omap2/cpuidle34xx.c: In function 'omap3_enter_idle_bm':
arch/arm/mach-omap2/cpuidle34xx.c:261: warning: unused variable 'ret'
arch/arm/mach-omap2/cpuidle34xx.c:257: warning: unused variable 'new_state_idx'

...

>
> ?DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> @@ -337,7 +329,8 @@ static inline void _fill_cstate(struct cpuidle_driver *drv,
> ? ? ? ?state->exit_latency ? ? = cpuidle_params_table[idx].exit_latency;
> ? ? ? ?state->target_residency = cpuidle_params_table[idx].target_residency;
> ? ? ? ?state->flags ? ? ? ? ? ?= CPUIDLE_FLAG_TIME_VALID;
> - ? ? ? state->enter ? ? ? ? ? ?= omap3_enter_idle_bm;
> + ? ? ? state->pre_enter ? ? ? ?= omap3_enter_idle_bm;
> + ? ? ? state->enter ? ? ? ? ? ?= omap3_enter_idle;
> ? ? ? ?sprintf(state->name, "C%d", idx + 1);
> ? ? ? ?strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
>
...

Also the line at 373 is not needed anymore in omap3_idle_init, since
the enter callback is filled in in the _fill_cstate function:
        /* C1 . MPU WFI + Core active */
        _fill_cstate(drv, 0, "MPU ON + CORE ON");
        (&drv->states[0])->enter = omap3_enter_idle;             <==
not needed anymore
        drv->safe_state_index = 0;

More testing on OMAP3 is needed. Let me come back with the results asap.

Regards,
Jean
