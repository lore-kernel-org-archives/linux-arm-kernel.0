From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 5 Jul 2016 22:53:19 +0300
Subject: [PATCH RFC 1/7] clk: add prepare_hw and prepare_done support
In-Reply-To: <1467208335-29876-2-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
 <1467208335-29876-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <577C102F.5020503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2016 04:52 PM, Dong Aisheng wrote:
> Introduce prepare_hw and prepare_done to support calling
> clk_prepare_enable in early kernel booting where we still
> can't schedule.
> 
> The prepare_hw callback is intended to do the hw part
> initialization of prepare work. It should cooperate with
> prepare_done callback to do the whole prepare work.
> The clock core will check @prepare_done in sleep or
> polling way according to system state to decide whether the
> whole prepare work is done.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/clk/clk.c            | 57 ++++++++++++++++++++++++++++++++++++++++++--
>   include/linux/clk-provider.h | 32 +++++++++++++++++++++++++
>   2 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d584004f7af7..7dcb34c75a9f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -12,6 +12,7 @@
>   #include <linux/clk.h>
>   #include <linux/clk-provider.h>
>   #include <linux/clk/clk-conf.h>
> +#include <linux/delay.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/spinlock.h>
> @@ -60,6 +61,8 @@ struct clk_core {
>   	bool			orphan;
>   	unsigned int		enable_count;
>   	unsigned int		prepare_count;
> +	unsigned long		delay_min;
> +	unsigned long		delay_max;
>   	unsigned long		min_rate;
>   	unsigned long		max_rate;
>   	unsigned long		accuracy;
> @@ -566,6 +569,8 @@ EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest);
>   
>   static void clk_core_unprepare(struct clk_core *core)
>   {
> +	unsigned long timeout;
> +
>   	lockdep_assert_held(&prepare_lock);
>   
>   	if (!core)
> @@ -584,8 +589,30 @@ static void clk_core_unprepare(struct clk_core *core)
>   
>   	trace_clk_unprepare(core);
>   
> -	if (core->ops->unprepare)
> +	if (core->ops->unprepare) {
>   		core->ops->unprepare(core->hw);
> +	} else if (core->ops->unprepare_hw) {
> +		core->ops->unprepare_hw(core->hw);
> +		if (core->ops->unprepare_done) {
> +			timeout = jiffies + msecs_to_jiffies(10);
> +			while (!core->ops->unprepare_done(core->hw)) {
> +				if (time_after(jiffies, timeout)) {
> +					pr_err("%s: clock %s unprepare timeout\n",
> +						__func__, core->name);
> +					break;
> +				}
> +				if (system_state == SYSTEM_BOOTING)
> +					/*
> +					 * Busy loop as we can't schedule in
> +					 * early boot
> +					 */
> +					continue;
> +				else
> +					usleep_range(core->delay_min,
> +						     core->delay_max);
> +			}
> +		}
> +	}
>   
>   	trace_clk_unprepare_complete(core);
>   	clk_core_unprepare(core->parent);
> @@ -615,6 +642,7 @@ EXPORT_SYMBOL_GPL(clk_unprepare);
>   
>   static int clk_core_prepare(struct clk_core *core)
>   {
> +	unsigned long timeout;
>   	int ret = 0;
>   
>   	lockdep_assert_held(&prepare_lock);
> @@ -629,8 +657,31 @@ static int clk_core_prepare(struct clk_core *core)
>   
>   		trace_clk_prepare(core);
>   
> -		if (core->ops->prepare)
> +		if (core->ops->prepare) {
>   			ret = core->ops->prepare(core->hw);
> +		} else if (core->ops->prepare_hw) {
> +			ret = core->ops->prepare_hw(core->hw);
> +			if (!ret && core->ops->prepare_done) {
> +				timeout = jiffies + msecs_to_jiffies(10);
> +				while (!core->ops->prepare_done(core->hw)) {
> +					if (time_after(jiffies, timeout)) {
> +						pr_err("%s: clock %s prepare timeout\n",
> +							__func__, core->name);
> +						ret = -ETIMEDOUT;
> +						break;
> +					}
> +					if (system_state == SYSTEM_BOOTING)

It looks like there could be a small problem :( The system_state will be changed from
SYSTEM_BOOTING --> SYSTEM_RUNNING too late during boot, even after all initcalls are completed and
drivers probed. As result, all clk APIs will be switched to polling mode not only at early boot, but also
during late boot and this might introduce some boot delays, because most of clk manipulations are 
done at boot time.

> +						/*
> +						 * Busy loop as we can't
> +						 * schedule in early boot
> +						 */
> +						continue;
> +					else
> +						usleep_range(core->delay_min,
> +							     core->delay_max);
> +				}
> +			}
> +		}
>   
>   		trace_clk_prepare_complete(core);
>   
> @@ -2490,6 +2541,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>   	core->hw = hw;
>   	core->flags = hw->init->flags;
>   	core->num_parents = hw->init->num_parents;
> +	core->delay_min = hw->init->delay_min;
> +	core->delay_max = hw->init->delay_max;
>   	core->min_rate = 0;
>   	core->max_rate = ULONG_MAX;
>   	hw->core = core;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index fb39d5add173..b37174360f1c 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -72,10 +72,34 @@ struct clk_rate_request {
>    *		do any initialisation that may sleep. Called with
>    *		prepare_lock held.

[..]

PS. I've found this while tried to enable ___might_sleep() functionality early during boot
for debugging purposes (boot is good stress test). And tried to add smth. like SYSTEM_BOOTING_LATE
and set it right after scheduler is fully operational during the boot [1].
Not sure I've selected right place where "scheduler is fully operational", but it was ok for debugging :P

[1]
https://git.ti.com/~gragst/ti-linux-kernel/gragsts-ti-linux-kernel/commit/5777eba0ad40c687b666a7d0df7ae4567b8aced7
-- 
regards,
-grygorii
