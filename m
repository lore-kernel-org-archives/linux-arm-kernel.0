From: fu.wei@linaro.org (Fu Wei)
Date: Mon, 21 Nov 2016 15:32:21 +0800
Subject: [PATCH v16 05/15] clocksource/drivers/arm_arch_timer: fix a bug
 in arch_timer_register about arch_timer_uses_ppi
In-Reply-To: <20161118185252.GI1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-6-git-send-email-fu.wei@linaro.org>
 <20161118185252.GI1197@leverpostej>
Message-ID: <CADyBb7v0c6t=Bn72qnpfVZjTVqcy+8QLr7XhfXP156DPXT2Vqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 19 November 2016 at 02:52, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 16, 2016 at 09:48:58PM +0800, fu.wei at linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch fix a potential bug about arch_timer_uses_ppi in
>> arch_timer_register.
>> On ARM64, we don't use ARCH_TIMER_PHYS_SECURE_PPI in Linux, so we will
>> just igorne it in init code.
>
> That's not currently the case. I assume you mean we will in later
> patches? If so, please make that clear in the commit message.
>
>> If arch_timer_uses_ppi is ARCH_TIMER_PHYS_NONSECURE_PPI, the orignal
>> code of arch_timer_uses_ppi may go wrong.
>
> How? What specifically happens?
>
> We don't currently assign ARCH_TIMER_PHYS_NONSECURE_PPI to
> arch_timer_uses_ppi, so I assume a later patch changes this. This change
> should be folded into said patch; it doesn't make sense in isolation.

yes, this patch is a preparation for the next which may set
arch_timer_use_ppi as ARCH_TIMER_PHYS_NONSECURE_PPI.
So you are right, I will merge this into the next and mention this
change in the commit message.

Great thanks

>
> Thanks,
> Mark.
>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index dd1040d..6de164f 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -699,7 +699,7 @@ static int __init arch_timer_register(void)
>>       case ARCH_TIMER_PHYS_NONSECURE_PPI:
>>               err = request_percpu_irq(ppi, arch_timer_handler_phys,
>>                                        "arch_timer", arch_timer_evt);
>> -             if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
>> +             if (!err && arch_timer_has_nonsecure_ppi()) {
>>                       ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
>>                       err = request_percpu_irq(ppi, arch_timer_handler_phys,
>>                                                "arch_timer", arch_timer_evt);
>> --
>> 2.7.4
>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
