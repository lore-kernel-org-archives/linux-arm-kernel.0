From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 09 Dec 2010 07:56:40 -0800
Subject: [PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire
	during suspend
In-Reply-To: <AANLkTi=9TBbuwr4uiQb6f_f=cLxK2NvWJDJYXwr2tTxu@mail.gmail.com>
	(Vitaly Wool's message of "Thu, 9 Dec 2010 00:51:29 +0100")
References: <1291848040-23394-1-git-send-email-khilman@deeprootsystems.com>
	<AANLkTi=9TBbuwr4uiQb6f_f=cLxK2NvWJDJYXwr2tTxu@mail.gmail.com>
Message-ID: <87zksfc53b.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vitaly Wool <vitalywool@gmail.com> writes:

> On Wed, Dec 8, 2010 at 11:40 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> @@ -120,8 +133,9 @@ static void omap2_enter_full_retention(void)
>> ? ? ? ? ? ? ? ?goto no_sleep;
>>
>> ? ? ? ?/* Block console output in case it is on one of the OMAP UARTs */
>> - ? ? ? if (try_acquire_console_sem())
>> - ? ? ? ? ? ? ? goto no_sleep;
>> + ? ? ? if (!is_suspending())
>> + ? ? ? ? ? ? ? if (try_acquire_console_sem())
>> + ? ? ? ? ? ? ? ? ? ? ? goto no_sleep;
>
> Combine into one if?

personal preference I guess.  I prefer it nested.

>
> <snip>
>
>> ? ? ? ?omap_uart_prepare_idle(0);
>> ? ? ? ?omap_uart_prepare_idle(1);
>> @@ -136,7 +150,8 @@ static void omap2_enter_full_retention(void)
>> ? ? ? ?omap_uart_resume_idle(1);
>> ? ? ? ?omap_uart_resume_idle(0);
>>
>> - ? ? ? release_console_sem();
>> + ? ? ? if (!is_suspending())
>> + ? ? ? ? ? ? ? release_console_sem();
>>
>> ?no_sleep:
>> ? ? ? ?if (omap2_pm_debug) {
>> @@ -284,6 +299,12 @@ out:
>> ? ? ? ?local_irq_enable();
>> ?}
>>
>> +static int omap2_pm_begin(suspend_state_t state)
>> +{
>> + ? ? ? suspend_state = state;
>> + ? ? ? return 0;
>> +}
>
> Do you really need a return code here?

yes, this function prototype is defined by the driver model, not by me.

>> ?static int omap2_pm_prepare(void)
>> ?{
>> ? ? ? ?/* We cannot sleep in idle until we have resumed */
>> @@ -333,10 +354,18 @@ static void omap2_pm_finish(void)
>> ? ? ? ?enable_hlt();
>> ?}
>>
>> +static void omap2_pm_end(void)
>> +{
>> + ? ? ? suspend_state = PM_SUSPEND_ON;
>> + ? ? ? return;
>> +}
>
> Redundant return.

but harmless

>> +
>> ?static struct platform_suspend_ops omap_pm_ops = {
>> + ? ? ? .begin ? ? ? ? ?= omap2_pm_begin,
>> ? ? ? ?.prepare ? ? ? ?= omap2_pm_prepare,
>> ? ? ? ?.enter ? ? ? ? ?= omap2_pm_enter,
>> ? ? ? ?.finish ? ? ? ? = omap2_pm_finish,
>> + ? ? ? .end ? ? ? ? ? ?= omap2_pm_end,
>> ? ? ? ?.valid ? ? ? ? ?= suspend_valid_only_mem,
>> ?};
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 0ec8a04..648b8c5 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -50,6 +50,19 @@
>> ?#include "sdrc.h"
>> ?#include "control.h"
>>
>> +#ifdef CONFIG_SUSPEND
>> +static suspend_state_t suspend_state = PM_SUSPEND_ON;
>> +static inline bool is_suspending(void)
>> +{
>> + ? ? ? return (suspend_state != PM_SUSPEND_ON);
>> +}
>> +#else
>> +static inline bool is_suspending(void)
>> +{
>> + ? ? ? return false;
>> +}
>> +#endif
>> +
>> ?/* Scratchpad offsets */
>> ?#define OMAP343X_TABLE_ADDRESS_OFFSET ? ? 0xc4
>> ?#define OMAP343X_TABLE_VALUE_OFFSET ? ? ? 0xc0
>> @@ -387,10 +400,11 @@ void omap_sram_idle(void)
>> ? ? ? ?}
>>
>> ? ? ? ?/* Block console output in case it is on one of the OMAP UARTs */
>> - ? ? ? if (per_next_state < PWRDM_POWER_ON ||
>> - ? ? ? ? ? core_next_state < PWRDM_POWER_ON)
>> - ? ? ? ? ? ? ? if (try_acquire_console_sem())
>> - ? ? ? ? ? ? ? ? ? ? ? goto console_still_active;
>> + ? ? ? if (!is_suspending())
>> + ? ? ? ? ? ? ? if (per_next_state < PWRDM_POWER_ON ||
>> + ? ? ? ? ? ? ? ? ? core_next_state < PWRDM_POWER_ON)
>> + ? ? ? ? ? ? ? ? ? ? ? if (try_acquire_console_sem())
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto console_still_active;
>
> Oh well, 3 nested ifs...

again, personal preference.

Kevin
