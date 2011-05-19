From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 19:32:22 +0200
Subject: [PATCH] ARM: smp_twd: Reconfigure clockevents after cpufreq change
In-Reply-To: <1305588114-23728-1-git-send-email-ccross@android.com>
References: <1305588114-23728-1-git-send-email-ccross@android.com>
Message-ID: <BANLkTim4U-CJ_D3VSNzwd23XL3fDXT7onQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/17 Colin Cross <ccross@android.com>:

> This patch depends on Thomas Gleixner's patch to add clockevents_reconfigure
> See: https://lkml.org/lkml/2011/5/13/122

Patch set has evolved, see below.
Also note that you more or less reimplement Rob Herrings patch:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6802/1
(no big deal I guess, give him a nod)

To work with Thomas full changeset just create a fresh branch and:
git pull git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
timers/clockevents

Pls change subject from ARM: to clockevents: and merge through
Thomas tree (IMHO).

> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 60636f4..dbf58d4 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -10,21 +10,29 @@
> ?*/
> ?#include <linux/init.h>
> ?#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> ?#include <linux/delay.h>
> ?#include <linux/device.h>
> +#include <linux/err.h>
> ?#include <linux/smp.h>
> ?#include <linux/jiffies.h>
> ?#include <linux/clockchips.h>
> ?#include <linux/irq.h>
> ?#include <linux/io.h>
> +#include <linux/percpu.h>
>
> ?#include <asm/smp_twd.h>
> ?#include <asm/hardware/gic.h>
>
> +#define TWD_MIN_RANGE 4
> +

Loose this. Let the framework decide using the function below.

> ?/* set up by the platform code */
> ?void __iomem *twd_base;
>
> +static struct clk *twd_clk;
> ?static unsigned long twd_timer_rate;
> +static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
>
> ?static void twd_set_mode(enum clock_event_mode mode,
> ? ? ? ? ? ? ? ? ? ? ? ?struct clock_event_device *clk)
> @@ -80,6 +88,49 @@ int twd_timer_ack(void)
> ? ? ? ?return 0;
> ?}
>
> +/*
> + * Updates clockevent frequency when the cpu frequency changes.
> + * Called on the cpu that is changing frequency with interrupts disabled.
> + */
> +static void twd_update_frequency(void *data)
> +{
> + ? ? ? twd_timer_rate = clk_get_rate(twd_clk);
> +
> + ? ? ? clockevents_reconfigure(__get_cpu_var(twd_ce), twd_timer_rate,
> + ? ? ? ? ? ? ? ? ? ? ? TWD_MIN_RANGE);

Changed name to clockevents_update_freq(), dropped range argument.

> +}
> +
> +static int twd_cpufreq_transition(struct notifier_block *nb,
> + ? ? ? unsigned long state, void *data)
> +{
> + ? ? ? struct cpufreq_freqs *freqs = data;
> +
> + ? ? ? /*
> + ? ? ? ?* The twd clock events must be reprogrammed to account for the new
> + ? ? ? ?* frequency. ?The timer is local to a cpu, so cross-call to the
> + ? ? ? ?* changing cpu.
> + ? ? ? ?*/
> + ? ? ? if (state == CPUFREQ_POSTCHANGE || state == CPUFREQ_RESUMECHANGE)
> + ? ? ? ? ? ? ? smp_call_function_single(freqs->cpu, twd_update_frequency,
> + ? ? ? ? ? ? ? ? ? ? ? NULL, 1);
> +
> + ? ? ? return NOTIFY_OK;
> +}
> +
> +static struct notifier_block twd_cpufreq_nb = {
> + ? ? ? .notifier_call = twd_cpufreq_transition,
> +};
> +
> +static int twd_cpufreq_init(void)
> +{
> + ? ? ? if (!IS_ERR_OR_NULL(twd_clk))
> + ? ? ? ? ? ? ? return cpufreq_register_notifier(&twd_cpufreq_nb,
> + ? ? ? ? ? ? ? ? ? ? ? CPUFREQ_TRANSITION_NOTIFIER);
> +
> + ? ? ? return 0;
> +}
> +core_initcall(twd_cpufreq_init);
> +
> ?static void __cpuinit twd_calibrate_rate(void)
> ?{
> ? ? ? ?unsigned long count;
> @@ -124,7 +175,16 @@ static void __cpuinit twd_calibrate_rate(void)
> ?*/
> ?void __cpuinit twd_timer_setup(struct clock_event_device *clk)
> ?{
> - ? ? ? twd_calibrate_rate();
> + ? ? ? if (twd_clk == NULL) {
> + ? ? ? ? ? ? ? twd_clk = clk_get_sys("smp_twd", NULL);
> + ? ? ? ? ? ? ? if (IS_ERR_OR_NULL(twd_clk))
> + ? ? ? ? ? ? ? ? ? ? ? pr_warn("%s: no clock found\n", __func__);
> + ? ? ? }
> +
> + ? ? ? if (!IS_ERR_OR_NULL(twd_clk))
> + ? ? ? ? ? ? ? twd_timer_rate = clk_get_rate(twd_clk);
> + ? ? ? else
> + ? ? ? ? ? ? ? twd_calibrate_rate();
>
> ? ? ? ?clk->name = "local_timer";
> ? ? ? ?clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> @@ -132,13 +192,16 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
> ? ? ? ?clk->rating = 350;
> ? ? ? ?clk->set_mode = twd_set_mode;
> ? ? ? ?clk->set_next_event = twd_set_next_event;
> - ? ? ? clk->shift = 20;
> - ? ? ? clk->mult = div_sc(twd_timer_rate, NSEC_PER_SEC, clk->shift);
> +
> + ? ? ? clockevents_calc_mult_shift(clk, twd_timer_rate, TWD_MIN_RANGE);
> +
> ? ? ? ?clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
> ? ? ? ?clk->min_delta_ns = clockevent_delta2ns(0xf, clk);

Get rid of everything between clk->shift ... and here and replace it with:

clockevents_config_and_register(clk, twd_timer_rate,
                                       0xf, 0xffffffff);

> ? ? ? ?/* Make sure our local interrupt controller has this enabled */
> ? ? ? ?gic_enable_ppi(clk->irq);
>
> + ? ? ? __get_cpu_var(twd_ce) = clk;
> +
> ? ? ? ?clockevents_register_device(clk);
> ?}


Or just smack in this patch on top:
