From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Tue, 14 Aug 2012 11:49:01 -0700
Subject: [PATCH 1/2] ARM: local timers: Unmask interrupt before new TVAL
 is set
In-Reply-To: <cdb51f00bafa8151a880d8cc7898631e@localhost>
References: <1344635854-5033-1-git-send-email-rvaswani@codeaurora.org>
 <cdb51f00bafa8151a880d8cc7898631e@localhost>
Message-ID: <502A9D9D.7070901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/11/2012 3:17 AM, Marc Zyngier wrote:
> On Fri, 10 Aug 2012 14:57:34 -0700, Rohit Vaswani
> <rvaswani@codeaurora.org>
> wrote:
>> Level triggered interrupt is deasserted when a new TVAL is written
>> only when the interrupt is unmasked. Make sure that the interrupt
>> is unmasked in CTL register before TVAL is written.
>> If this order is not followed, there are chances that on some
>> hardware you would not receive any timer interrupts.
>>
>> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
>> ---
>>   arch/arm/kernel/arch_timer.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
>> index dd58035..1d0d9df 100644
>> --- a/arch/arm/kernel/arch_timer.c
>> +++ b/arch/arm/kernel/arch_timer.c
>> @@ -126,8 +126,8 @@ static int arch_timer_set_next_event(unsigned long
> evt,
>>   	ctrl |= ARCH_TIMER_CTRL_ENABLE;
>>   	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
>>   
>> -	arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
>>   	arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
>> +	arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
> But by doing so, you're opening a window where TVAL can be negative (from
> a previous timer trigger) and the interrupt unmasked, which would lead to
> an immediate trigger, before TVAL is updated with the new value.
>
> Does your hardware deassert the interrupt even when the enable bit is not
> set? If so, would the following sequence work?
>
>          ctrl &= ~(ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK);
>          arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
>
> 	arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
>
>          ctrl |= ARCH_TIMER_CTRL_ENABLE;
>          arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
>
> Thanks,
>
>          M.
Thanks Marc, this works. I will re-send the patch with these changes.

Thanks,
Rohit Vaswani

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
