From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 21 Feb 2011 09:44:04 +0100
Subject: [PATCH] perf: add OMAP support for the new power events
In-Reply-To: <ec45f3f591691ce6a5253dfb70cc8e90@mail.gmail.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com>
	<ec45f3f591691ce6a5253dfb70cc8e90@mail.gmail.com>
Message-ID: <AANLkTiktdLja39dC38E_LciYZK7+pTp3_Sgm9jf5FA4R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Sat, Feb 19, 2011 at 7:55 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>> owner at vger.kernel.org] On Behalf Of jean.pihet at newoldbits.com
>> Sent: Friday, February 18, 2011 11:41 PM
>> To: Kevin Hilman; Thomas Renninger; linux-omap at vger.kernel.org;
>> linux-arm-kernel at lists.infradead.org
>> Cc: Jean Pihet
>> Subject: [PATCH] perf: add OMAP support for the new power events
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The patch adds the new power management trace points for
>> the OMAP architecture.
>>
>> The trace points are for:
>> - default idle handler. Since the cpuidle framework is
>> ? instrumented in the generic way there is no need to
>> ? add trace points in the OMAP specific cpuidle handler;
>> - cpufreq (DVFS),
>> - SoC clocks changes (enable, disable, set_rate),
>> - power domain states: the desired target state and -if different-
>> ? the actually hit state.
>>
>> Because of the generic nature of the changes, OMAP3 and OMAP4 are
>> supported.
>>
>> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> ?arch/arm/mach-omap2/clock.c ? ? ? | ? ?8 +++++++-
>> ?arch/arm/mach-omap2/pm34xx.c ? ? ?| ? ?7 +++++++
>> ?arch/arm/mach-omap2/powerdomain.c | ? 26 +++++++++++++++++++++++---
>> ?3 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-
>> omap2/clock.c
>> index 2a2f152..72af75d 100644
>> --- a/arch/arm/mach-omap2/clock.c
>> +++ b/arch/arm/mach-omap2/clock.c
>> @@ -22,7 +22,9 @@
>> ?#include <linux/clk.h>
>> ?#include <linux/io.h>
>> ?#include <linux/bitops.h>
>> +#include <trace/events/power.h>
>>
>> +#include <asm/cpu.h>
>> ?#include <plat/clock.h>
>> ?#include "clockdomain.h"
>> ?#include <plat/cpu.h>
>> @@ -261,6 +263,7 @@ void omap2_clk_disable(struct clk *clk)
>>
>> ? ? ? pr_debug("clock: %s: disabling in hardware\n", clk->name);
>>
>> + ? ? trace_clock_disable(clk->name, 0, smp_processor_id());
>> ? ? ? clk->ops->disable(clk);
>>
>> ? ? ? if (clk->clkdm)
>> @@ -312,6 +315,7 @@ int omap2_clk_enable(struct clk *clk)
>> ? ? ? ? ? ? ? }
>> ? ? ? }
>>
>> + ? ? trace_clock_enable(clk->name, 1, smp_processor_id());
>> ? ? ? ret = clk->ops->enable(clk);
>> ? ? ? if (ret) {
>> ? ? ? ? ? ? ? WARN(1, "clock: %s: could not enable: %d\n", clk->name,
>> ret);
>> @@ -349,8 +353,10 @@ int omap2_clk_set_rate(struct clk *clk,
>> unsigned long rate)
>> ? ? ? pr_debug("clock: set_rate for clock %s to rate %ld\n", clk-
>> >name, rate);
>>
>> ? ? ? /* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
>> - ? ? if (clk->set_rate)
>> + ? ? if (clk->set_rate) {
>> + ? ? ? ? ? ? trace_clock_set_rate(clk->name, rate,
>> smp_processor_id());
>> ? ? ? ? ? ? ? ret = clk->set_rate(clk, rate);
>> + ? ? }
>>
>> ? ? ? return ret;
>> ?}
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
>> omap2/pm34xx.c
>> index 2f864e4..d1cc3f4 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -29,6 +29,7 @@
>> ?#include <linux/delay.h>
>> ?#include <linux/slab.h>
>> ?#include <linux/console.h>
>> +#include <trace/events/power.h>
>>
>> ?#include <plat/sram.h>
>> ?#include "clockdomain.h"
>> @@ -519,8 +520,14 @@ static void omap3_pm_idle(void)
>> ? ? ? if (omap_irq_pending() || need_resched())
>> ? ? ? ? ? ? ? goto out;
>>
>> + ? ? trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> + ? ? trace_cpu_idle(1, smp_processor_id());
>> +
>
> This default idle code won't be used when you enable the
> CONFIG_CPUIDLE. That case the cpuidle34xx.c idle code gets
> registered.
That is correct. OMAP has a default idle handler (omap3_pm_idle) and a
cpuidle handler (omap3_enter_idle in
arch/arm/mach-omap2/cpuidle34xx.c).

> Shouldn't you patch that code instead? This is more or less
> dead code and it is just like default idle code when idle
> drivers isn't registered.
The cpuidle framework already is instrumented in a generic way. This
code adds the instrumentation to the default idle handler so that all
cases are covered. BTW the patch description gives that information.

If there is dead code then it is not only the code from this patch but
all the code for the default idle handler.

Thanks for reviewing.

Regards,
Jean

>
>
>> ? ? ? omap_sram_idle();
>>
>> + ? ? trace_power_end(smp_processor_id());
>> + ? ? trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>> +
>> ?out:
>> ? ? ? local_fiq_enable();
>> ? ? ? local_irq_enable();
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
>> omap2/powerdomain.c
>> index eaed0df..1495eed 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -19,12 +19,15 @@
>> ?#include <linux/list.h>
>> ?#include <linux/errno.h>
>> ?#include <linux/string.h>
>> +#include <trace/events/power.h>
>> +
>> ?#include "cm2xxx_3xxx.h"
>> ?#include "prcm44xx.h"
>> ?#include "cm44xx.h"
>> ?#include "prm2xxx_3xxx.h"
>> ?#include "prm44xx.h"
>>
>> +#include <asm/cpu.h>
>> ?#include <plat/cpu.h>
>> ?#include "powerdomain.h"
>> ?#include "clockdomain.h"
>> @@ -32,6 +35,8 @@
>>
>> ?#include "pm.h"
>>
>> +#define PWRDM_TRACE_STATES_FLAG ? ? ?(1<<31)
>> +
>> ?enum {
>> ? ? ? PWRDM_STATE_NOW = 0,
>> ? ? ? PWRDM_STATE_PREV,
>> @@ -130,8 +135,7 @@ static void
>> _update_logic_membank_counters(struct powerdomain *pwrdm)
>> ?static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>> ?{
>>
>> - ? ? int prev;
>> - ? ? int state;
>> + ? ? int prev, state, trace_state = 0;
>>
>> ? ? ? if (pwrdm == NULL)
>> ? ? ? ? ? ? ? return -EINVAL;
>> @@ -148,6 +152,17 @@ static int _pwrdm_state_switch(struct
>> powerdomain *pwrdm, int flag)
>> ? ? ? ? ? ? ? ? ? ? ? pwrdm->state_counter[prev]++;
>> ? ? ? ? ? ? ? if (prev == PWRDM_POWER_RET)
>> ? ? ? ? ? ? ? ? ? ? ? _update_logic_membank_counters(pwrdm);
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* If the power domain did not hit the desired state,
>> + ? ? ? ? ? ? ?* generate a trace event with both the desired and hit
>> states
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? if (state != prev) {
>> + ? ? ? ? ? ? ? ? ? ? trace_state = (PWRDM_TRACE_STATES_FLAG |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?((state & OMAP_POWERSTATE_MASK) <<
> 8)
>> |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?((prev & OMAP_POWERSTATE_MASK) <<
>> 0));
>> + ? ? ? ? ? ? ? ? ? ? trace_power_domain_target(pwrdm->name,
>> trace_state,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? smp_processor_id());
>> + ? ? ? ? ? ? }
>> ? ? ? ? ? ? ? break;
>> ? ? ? default:
>> ? ? ? ? ? ? ? return -EINVAL;
>> @@ -406,8 +421,13 @@ int pwrdm_set_next_pwrst(struct powerdomain
>> *pwrdm, u8 pwrst)
>> ? ? ? pr_debug("powerdomain: setting next powerstate for %s to
>> %0x\n",
>> ? ? ? ? ? ? ? ?pwrdm->name, pwrst);
>>
>> - ? ? if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
>> + ? ? if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>> + ? ? ? ? ? ? /* Trace the pwrdm desired target state */
>> + ? ? ? ? ? ? trace_power_domain_target(pwrdm->name, pwrst,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? smp_processor_id());
>> + ? ? ? ? ? ? /* Program the pwrdm desired target state */
>> ? ? ? ? ? ? ? ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>> + ? ? }
>>
>> ? ? ? return ret;
>> ?}
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
