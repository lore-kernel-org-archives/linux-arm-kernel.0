From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Tue, 30 Aug 2011 13:40:43 +0900
Subject: [PATCH] CPUFREQ: ARM Exynos4210 PM/Suspend Compatibility with
	Different Bootloaders
In-Reply-To: <1313664316-15440-1-git-send-email-myungjoo.ham@samsung.com>
References: <1313664316-15440-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <CAJ0PZbRKEF4uELY_VVbisx9oKc1JePp8HQ2n+081iXGAx0_qQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Kgene to the recipient list.


Please note that even without the cases using different bootloader, we
might have cases where CPUFREQ calling the target function right
before syscore suspend or right after syscore resume where we might
fail at the target function.

Anyway, I guess CPUFREQ'd be better use suspend callbacks that are
earlier than syscore (preferably somewhere before dpm_suspend or at
dpm_suspend) because CPUFREQ's target callback uses other device
drivers, but this could be just a case of S5PV210 and Exynos4210.


Cheers,
MyungJoo

On Thu, Aug 18, 2011 at 7:45 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> We have various bootloaders for Exynos4210 machines. Some of they
> set the ARM core frequency at boot time even when the boot is a resume
> from suspend-to-RAM. Such changes may create inconsistency in the
> data of CPUFREQ driver and have incurred hang issues with suspend-to-RAM.
>
> This patch enables to save and restore CPU frequencies with pm-notifier and
> sets the frequency at the initial (boot-time) value so that there wouldn't
> be any inconsistency between bootloader and kernel. This patch does not
> use CPUFREQ's suspend/resume callbacks because they are syscore-ops, which
> do not allow to use mutex that is being used by regulators that are used by
> the target function.
>
> This also prevents any CPUFREQ transitions during suspend-resume context,
> which could be dangerous at noirq-context along with regulator framework.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?drivers/cpufreq/exynos4210-cpufreq.c | ?106 ++++++++++++++++++++++++++++++++-
> ?1 files changed, 102 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
> index b7c3a84..101898a 100644
> --- a/drivers/cpufreq/exynos4210-cpufreq.c
> +++ b/drivers/cpufreq/exynos4210-cpufreq.c
> @@ -17,6 +17,8 @@
> ?#include <linux/slab.h>
> ?#include <linux/regulator/consumer.h>
> ?#include <linux/cpufreq.h>
> +#include <linux/notifier.h>
> +#include <linux/suspend.h>
>
> ?#include <mach/map.h>
> ?#include <mach/regs-clock.h>
> @@ -36,6 +38,10 @@ static struct regulator *int_regulator;
> ?static struct cpufreq_freqs freqs;
> ?static unsigned int memtype;
>
> +static unsigned int locking_frequency;
> +static bool frequency_locked;
> +static DEFINE_MUTEX(cpufreq_lock);
> +
> ?enum exynos4_memory_type {
> ? ? ? ?DDR2 = 4,
> ? ? ? ?LPDDR2,
> @@ -405,22 +411,32 @@ static int exynos4_target(struct cpufreq_policy *policy,
> ?{
> ? ? ? ?unsigned int index, old_index;
> ? ? ? ?unsigned int arm_volt, int_volt;
> + ? ? ? int err = -EINVAL;
>
> ? ? ? ?freqs.old = exynos4_getspeed(policy->cpu);
>
> + ? ? ? mutex_lock(&cpufreq_lock);
> +
> + ? ? ? if (frequency_locked && target_freq != locking_frequency) {
> + ? ? ? ? ? ? ? err = -EAGAIN;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> ? ? ? ?if (cpufreq_frequency_table_target(policy, exynos4_freq_table,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? freqs.old, relation, &old_index))
> - ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? ? ? ? ? goto out;
>
> ? ? ? ?if (cpufreq_frequency_table_target(policy, exynos4_freq_table,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? target_freq, relation, &index))
> - ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? ? ? ? ? goto out;
> +
> + ? ? ? err = 0;
>
> ? ? ? ?freqs.new = exynos4_freq_table[index].frequency;
> ? ? ? ?freqs.cpu = policy->cpu;
>
> ? ? ? ?if (freqs.new == freqs.old)
> - ? ? ? ? ? ? ? return 0;
> + ? ? ? ? ? ? ? goto out;
>
> ? ? ? ?/* get the voltage value */
> ? ? ? ?arm_volt = exynos4_volt_table[index].arm_volt;
> @@ -447,10 +463,16 @@ static int exynos4_target(struct cpufreq_policy *policy,
>
> ? ? ? ?cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>
> - ? ? ? return 0;
> +out:
> + ? ? ? mutex_unlock(&cpufreq_lock);
> + ? ? ? return err;
> ?}
>
> ?#ifdef CONFIG_PM
> +/*
> + * These suspend/resume are used as syscore_ops, it is already too
> + * late to set regulator voltages at this stage.
> + */
> ?static int exynos4_cpufreq_suspend(struct cpufreq_policy *policy)
> ?{
> ? ? ? ?return 0;
> @@ -462,6 +484,78 @@ static int exynos4_cpufreq_resume(struct cpufreq_policy *policy)
> ?}
> ?#endif
>
> +/**
> + * exynos4_cpufreq_pm_notifier - block CPUFREQ's activities in suspend-resume
> + * ? ? ? ? ? ? ? ? ? ? context
> + * @notifier
> + * @pm_event
> + * @v
> + *
> + * While frequency_locked == true, target() ignores every frequency but
> + * locking_frequency. The locking_frequency value is the initial frequency,
> + * which is set by the bootloader. In order to eliminate possible
> + * inconsistency in clock values, we save and restore frequencies during
> + * suspend and resume and block CPUFREQ activities. Note that the standard
> + * suspend/resume cannot be used as they are too deep (syscore_ops) for
> + * regulator actions.
> + */
> +static int exynos4_cpufreq_pm_notifier(struct notifier_block *notifier,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long pm_event, void *v)
> +{
> + ? ? ? struct cpufreq_policy *policy = cpufreq_cpu_get(0); /* boot CPU */
> + ? ? ? static unsigned int saved_frequency;
> + ? ? ? unsigned int temp;
> +
> + ? ? ? mutex_lock(&cpufreq_lock);
> + ? ? ? switch (pm_event) {
> + ? ? ? case PM_SUSPEND_PREPARE:
> + ? ? ? ? ? ? ? if (frequency_locked)
> + ? ? ? ? ? ? ? ? ? ? ? goto out;
> + ? ? ? ? ? ? ? frequency_locked = true;
> +
> + ? ? ? ? ? ? ? if (locking_frequency) {
> + ? ? ? ? ? ? ? ? ? ? ? saved_frequency = exynos4_getspeed(0);
> +
> + ? ? ? ? ? ? ? ? ? ? ? mutex_unlock(&cpufreq_lock);
> + ? ? ? ? ? ? ? ? ? ? ? exynos4_target(policy, locking_frequency,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?CPUFREQ_RELATION_H);
> + ? ? ? ? ? ? ? ? ? ? ? mutex_lock(&cpufreq_lock);
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? break;
> + ? ? ? case PM_POST_SUSPEND:
> +
> + ? ? ? ? ? ? ? if (saved_frequency) {
> + ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ?* While frequency_locked, only locking_frequency
> + ? ? ? ? ? ? ? ? ? ? ? ?* is valid for target(). In order to use
> + ? ? ? ? ? ? ? ? ? ? ? ?* saved_frequency while keeping frequency_locked,
> + ? ? ? ? ? ? ? ? ? ? ? ?* we temporarly overwrite locking_frequency.
> + ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? temp = locking_frequency;
> + ? ? ? ? ? ? ? ? ? ? ? locking_frequency = saved_frequency;
> +
> + ? ? ? ? ? ? ? ? ? ? ? mutex_unlock(&cpufreq_lock);
> + ? ? ? ? ? ? ? ? ? ? ? exynos4_target(policy, locking_frequency,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?CPUFREQ_RELATION_H);
> + ? ? ? ? ? ? ? ? ? ? ? mutex_lock(&cpufreq_lock);
> +
> + ? ? ? ? ? ? ? ? ? ? ? locking_frequency = temp;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? frequency_locked = false;
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +out:
> + ? ? ? mutex_unlock(&cpufreq_lock);
> +
> + ? ? ? return NOTIFY_OK;
> +}
> +
> +static struct notifier_block exynos4_cpufreq_nb = {
> + ? ? ? .notifier_call = exynos4_cpufreq_pm_notifier,
> +};
> +
> ?static int exynos4_cpufreq_cpu_init(struct cpufreq_policy *policy)
> ?{
> ? ? ? ?policy->cur = policy->min = policy->max = exynos4_getspeed(policy->cpu);
> @@ -501,6 +595,8 @@ static int __init exynos4_cpufreq_init(void)
> ? ? ? ?if (IS_ERR(cpu_clk))
> ? ? ? ? ? ? ? ?return PTR_ERR(cpu_clk);
>
> + ? ? ? locking_frequency = exynos4_getspeed(0);
> +
> ? ? ? ?moutcore = clk_get(NULL, "moutcore");
> ? ? ? ?if (IS_ERR(moutcore))
> ? ? ? ? ? ? ? ?goto out;
> @@ -540,6 +636,8 @@ static int __init exynos4_cpufreq_init(void)
> ? ? ? ? ? ? ? ?printk(KERN_DEBUG "%s: memtype= 0x%x\n", __func__, memtype);
> ? ? ? ?}
>
> + ? ? ? register_pm_notifier(&exynos4_cpufreq_nb);
> +
> ? ? ? ?return cpufreq_register_driver(&exynos4_driver);
>
> ?out:
> --
> 1.7.4.1
>
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
