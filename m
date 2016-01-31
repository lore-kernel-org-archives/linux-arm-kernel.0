From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 31 Jan 2016 22:48:56 +0100
Subject: [PATCH 2/2] clocksource/drivers/lpc32xx: Support timer-based ARM
 delay
In-Reply-To: <CAAEAJfBYH4AWA=fgGUxUPsS+25ZfnT=X=XJ+as-nNhUpaUuixg@mail.gmail.com>
References: <1454136379-7517-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1454136379-7517-2-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGhQ9VwQtgCN8wEt1S3Y3Marz6QhZhuncSKtKaMSRgqcMDT=yw@mail.gmail.com>
 <CAAEAJfBYH4AWA=fgGUxUPsS+25ZfnT=X=XJ+as-nNhUpaUuixg@mail.gmail.com>
Message-ID: <CAGhQ9VyWE4RoaxCjP2s2E2qBoDufpHtjLuwNFxJRz2tWUdeP_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2016 at 21:15, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> On 30 January 2016 at 16:27, Joachim  Eastwood <manabian@gmail.com> wrote:
>> Hi Ezequiel,
>>
>> On 30 January 2016 at 07:46, Ezequiel Garcia
>> <ezequiel@vanguardiasur.com.ar> wrote:
>>> This commit implements the ARM timer-based delay timer for the
>>> LPC32xx, LPC18xx, LPC43xx family of SoCs.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>>> ---
>>>  drivers/clocksource/time-lpc32xx.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
>>> index 9b3d4a38c716..223bb08720d6 100644
>>> --- a/drivers/clocksource/time-lpc32xx.c
>>> +++ b/drivers/clocksource/time-lpc32xx.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/clk.h>
>>>  #include <linux/clockchips.h>
>>>  #include <linux/clocksource.h>
>>> +#include <linux/delay.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/irq.h>
>>>  #include <linux/kernel.h>
>>> @@ -55,6 +56,15 @@ static u64 notrace lpc32xx_read_sched_clock(void)
>>>         return readl(clocksource_timer_counter);
>>>  }
>>>
>>> +static unsigned long lpc32xx_delay_timer_read(void)
>>> +{
>>> +       return readl(clocksource_timer_counter);
>>> +}
>>
>> Could this use the relaxed version?
>>
>
> It seems read_current_timer is used in a busy loop in __timer_delay,
> and I'd that's why other drivers use readl() here.

As far as I can see only the armada370 and u300 clocksource drivers
use readl() in the read_current_timer callback.

> In any case, isn't __iormb a no-op on CPU_V7M ?

For LPC18xx and LPC43xx, which is ARMV7m, I don't think it matters.
But we should also consider LPC32xx, which is ARM9, as it will soon
start to use this driver.

Anyway I am fine with using readl() for now. It can always be changed later.


regards,
Joachim  Eastwood
