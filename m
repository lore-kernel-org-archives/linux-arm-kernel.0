From: ccross@android.com (Colin Cross)
Date: Fri, 30 Mar 2012 12:43:29 -0700
Subject: [PATCH 2/3] ARM: OMAP4: cpuidle: Use coupled cpuidle states to
 implement SMP cpuidle.
In-Reply-To: <1333114048-26136-3-git-send-email-santosh.shilimkar@ti.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
 <1333114048-26136-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAMbhsRRAQxDh_yZKayqMedvGkeSP9UGxiud9LbotWp-aMQ7cSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 6:27 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> OMAP4 CPUDILE driver is converted mainly based on notes from the
> coupled cpuidle patch series.
>
> The changes include :
> - Register both CPUs and C-states to cpuidle driver.
> - Set struct cpuidle_device.coupled_cpus
> - Set struct cpuidle_device.safe_state to non coupled state.
> - Set CPUIDLE_FLAG_COUPLED in struct cpuidle_state.flags for each
> ?state that affects multiple cpus.
> - Separate ->enter hooks for coupled & simple idle.
> - CPU0 wait loop for CPU1 power transition.
> - CPU1 wakeup mechanism for the idle exit.
> - Enabling ARCH_NEEDS_CPU_IDLE_COUPLED for OMAP4.
>
> Thanks to Kevin Hilman and Colin Cross on the suggestions/fixes
> on the intermediate version of this patch.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Kevin Hilman <khilman@ti.com>
> Cc: Colin Cross <ccross@android.com>
> ---
> ?arch/arm/mach-omap2/Kconfig ? ? ? | ? ?1 +
> ?arch/arm/mach-omap2/cpuidle44xx.c | ?167 ++++++++++++++++++++++---------------
> ?2 files changed, 101 insertions(+), 67 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index e20c8ab..250786e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -54,6 +54,7 @@ config ARCH_OMAP4
> ? ? ? ?select PM_OPP if PM
> ? ? ? ?select USB_ARCH_HAS_EHCI
> ? ? ? ?select ARM_CPU_SUSPEND if PM
> + ? ? ? select ARCH_NEEDS_CPU_IDLE_COUPLED if CPU_IDLE
The "if CPU_IDLE" is not necessary, ARCH_NEEDS_CPU_IDLE_COUPLED is
designed to have no effect if CPU_IDLE is not set.

>
> ?comment "OMAP Core Type"
> ? ? ? ?depends on ARCH_OMAP2
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index f386cbe..5724393 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -21,6 +21,7 @@
> ?#include "common.h"
> ?#include "pm.h"
> ?#include "prm.h"
> +#include "clockdomain.h"
>
> ?#ifdef CONFIG_CPU_IDLE
>
> @@ -44,10 +45,11 @@ static struct cpuidle_params cpuidle_params_table[] = {
> ?#define OMAP4_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
>
> ?struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
> -static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
> +static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
> +static struct clockdomain *cpu_clkdm[NR_CPUS];
>
> ?/**
> - * omap4_enter_idle - Programs OMAP4 to enter the specified state
> + * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry functions
> ?* @dev: cpuidle device
> ?* @drv: cpuidle driver
> ?* @index: the index of state to be entered
> @@ -56,34 +58,40 @@ static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
> ?* specified low power state selected by the governor.
> ?* Returns the amount of time spent in the low power state.
> ?*/
> -static int omap4_enter_idle(struct cpuidle_device *dev,
> +static int omap4_enter_idle_simple(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int index)
> +{
> + ? ? ? local_fiq_disable();
> + ? ? ? omap_do_wfi();
> + ? ? ? local_fiq_enable();
> +
> + ? ? ? return index;
> +}
> +
> +static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
> ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv,
> ? ? ? ? ? ? ? ? ? ? ? ?int index)
> ?{
> ? ? ? ?struct omap4_idle_statedata *cx =
> ? ? ? ? ? ? ? ? ? ? ? ?cpuidle_get_statedata(&dev->states_usage[index]);
> - ? ? ? u32 cpu1_state;
> ? ? ? ?int cpu_id = smp_processor_id();
>
> ? ? ? ?local_fiq_disable();
>
> + ? ? ? clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
> +
> ? ? ? ?/*
> - ? ? ? ?* CPU0 has to stay ON (i.e in C1) until CPU1 is OFF state.
> + ? ? ? ?* CPU0 has to wait and stay ON until CPU1 is OFF state.
> ? ? ? ? * This is necessary to honour hardware recommondation
> ? ? ? ? * of triggeing all the possible low power modes once CPU1 is
> ? ? ? ? * out of coherency and in OFF mode.
> - ? ? ? ?* Update dev->last_state so that governor stats reflects right
> - ? ? ? ?* data.
> ? ? ? ? */
> - ? ? ? cpu1_state = pwrdm_read_pwrst(cpu1_pd);
> - ? ? ? if (cpu1_state != PWRDM_POWER_OFF) {
> - ? ? ? ? ? ? ? index = drv->safe_state_index;
> - ? ? ? ? ? ? ? cx = cpuidle_get_statedata(&dev->states_usage[index]);
> + ? ? ? if (dev->cpu == 0) {
> + ? ? ? ? ? ? ? while (pwrdm_read_pwrst(cpu_pd[1]) != PWRDM_POWER_OFF)
> + ? ? ? ? ? ? ? ? ? ? ? cpu_relax();
If something goes wrong in the core coupled code or in the cpu 1 power
state transition, this will hang forever and be hard to debug.  It
might be worth adding a timeout with a BUG_ON.

> ? ? ? ?}
>
> - ? ? ? if (index > 0)
> - ? ? ? ? ? ? ? clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
> -
> ? ? ? ?/*
> ? ? ? ? * Call idle CPU PM enter notifier chain so that
> ? ? ? ? * VFP and per CPU interrupt context is saved.
> @@ -91,25 +99,35 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
> ? ? ? ?if (cx->cpu_state == PWRDM_POWER_OFF)
> ? ? ? ? ? ? ? ?cpu_pm_enter();
This should never get called without cpu_state == PWRDM_POWER_OFF, and
even if it did, calling cpu_pm_enter shouldn't hurt anything.  It
would be clearer to unconditionally call cpu_pm_enter().

>
> - ? ? ? pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> - ? ? ? omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> -
> - ? ? ? /*
> - ? ? ? ?* Call idle CPU cluster PM enter notifier chain
> - ? ? ? ?* to save GIC and wakeupgen context.
> - ? ? ? ?*/
> - ? ? ? if ((cx->mpu_state == PWRDM_POWER_RET) &&
> - ? ? ? ? ? ? ? (cx->mpu_logic_state == PWRDM_POWER_OFF))
> - ? ? ? ? ? ? ? ? ? ? ? cpu_cluster_pm_enter();
> + ? ? ? if (dev->cpu == 0) {
> + ? ? ? ? ? ? ? pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> + ? ? ? ? ? ? ? omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> +
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* Call idle CPU cluster PM enter notifier chain
> + ? ? ? ? ? ? ? ?* to save GIC and wakeupgen context.
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? if ((cx->mpu_state == PWRDM_POWER_RET) &&
> + ? ? ? ? ? ? ? ? ? ? ? (cx->mpu_logic_state == PWRDM_POWER_OFF))
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cpu_cluster_pm_enter();
> + ? ? ? }
>
> ? ? ? ?omap4_enter_lowpower(dev->cpu, cx->cpu_state);
>
> + ? ? ? if (dev->cpu == 0) {
> + ? ? ? ? ? ? ? /* Wakeup CPU1 only if it is not offlined */
> + ? ? ? ? ? ? ? if (cpumask_test_cpu(1, cpu_online_mask)) {
> + ? ? ? ? ? ? ? ? ? ? ? clkdm_wakeup(cpu_clkdm[1]);
> + ? ? ? ? ? ? ? ? ? ? ? clkdm_allow_idle(cpu_clkdm[1]);
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> ? ? ? ?/*
> ? ? ? ? * Call idle CPU PM exit notifier chain to restore
> ? ? ? ? * VFP and per CPU IRQ context. Only CPU0 state is
> ? ? ? ? * considered since CPU1 is managed by CPU hotplug.
> ? ? ? ? */
This comment is no longer accurate?  cpu_pm_enter is called on cpu 1 above.

> - ? ? ? if (pwrdm_read_prev_pwrst(cpu0_pd) == PWRDM_POWER_OFF)
> + ? ? ? if (pwrdm_read_prev_pwrst(cpu_pd[dev->cpu]) == PWRDM_POWER_OFF)
> ? ? ? ? ? ? ? ?cpu_pm_exit();
This should get called unconditionally.  It's not explicitly stated,
but the cpu_pm_* api expects cpu_pm_exit() to be called after
cpu_pm_enter(), even if the low power state was not entered.
Otherwise, a cpu_pm_enter notifier that disables the hardware will not
get a chance to re-enable it.
