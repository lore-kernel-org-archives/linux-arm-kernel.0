From: julien.grall@linaro.org (Julien Grall)
Date: Fri, 04 Apr 2014 12:41:41 +0100
Subject: [PATCH] Xen: do hv callback accounting only on x86
In-Reply-To: <12121341.4lKFpaRMcO@wuerfel>
References: <5057041.71iuvlcH4G@wuerfel> <12121341.4lKFpaRMcO@wuerfel>
Message-ID: <533E9A75.4050102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(Adding Ian and Stefano).

On 03/25/2014 04:00 PM, Arnd Bergmann wrote:
> On Tuesday 25 March 2014 16:52:25 Arnd Bergmann wrote:
>> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
>> index 5dd2ddf..8b91c256 100644
>> --- a/drivers/xen/events/events_base.c
>> +++ b/drivers/xen/events/events_base.c
>> @@ -1235,6 +1235,7 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
>>  #ifdef CONFIG_X86
>>         exit_idle();
>>  #endif
>> +       inc_irq_stat(irq_hv_callback_count);
>>
>>         __xen_evtchn_do_upcall();
>>
>> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
>> index d5a3de8..dfa12a4 100644
>> --- a/drivers/xen/events/events_base.c
>> +++ b/drivers/xen/events/events_base.c
>> @@ -1248,8 +1248,8 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
>>         irq_enter();
>>  #ifdef CONFIG_X86
>>         exit_idle();
>> -#endif
>>         inc_irq_stat(irq_hv_callback_count);
>> +#endif
>>  
>>         __xen_evtchn_do_upcall();
> 
> That was unintended: the first half of this email is actually the patch
> that introduced the bug, while the second half is my workaround.
> The way it's formatted, you won't be able to apply it without removing
> the first half again. I'll wait if the approach is ok first and then
> resend it properly if needed.

Linus has merged xen/tip yesterday and building ARM with CONFIG_XEN=y is
now broken.

Is there any plan to push this patch (without the first half of course
:)) or reverting the following commit:
commit 99c8b79d3c165f8e2a6247c14bfa1429e7efe51f
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Sun Feb 23 21:40:21 2014 +0000

    xen: Add proper irq accounting for HYPERCALL vector

Sincerely yours,

-- 
Julien Grall
