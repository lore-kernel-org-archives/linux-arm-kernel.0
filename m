From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Mar 2013 13:03:47 -0500
Subject: [PATCH 02/11] ARM: remove extra timer-sp control register clearing
In-Reply-To: <CACRpkdZLn=KjJisPTN2eHn64UuaZvpBDDhmeqQXF-TVS8VZ7pA@mail.gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <1363820051-24428-3-git-send-email-robherring2@gmail.com>
 <CACRpkdZLn=KjJisPTN2eHn64UuaZvpBDDhmeqQXF-TVS8VZ7pA@mail.gmail.com>
Message-ID: <514B4B83.60809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 12:58 PM, Linus Walleij wrote:
> On Wed, Mar 20, 2013 at 11:54 PM, Rob Herring <robherring2@gmail.com> wrote:
> 
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> The timer-sp initialization code clears the control register before
>> initializing the timers, so every platform doing this is redundant.
>>
>> For unused timers, we should not care what state they are in.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> (...)
>> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
>> index ea96144..4cb322d 100644
>> --- a/arch/arm/mach-integrator/integrator_ap.c
>> +++ b/arch/arm/mach-integrator/integrator_ap.c
>> @@ -643,10 +643,6 @@ static void __init ap_timer_init(void)
>>         clk_prepare_enable(clk);
>>         rate = clk_get_rate(clk);
>>
>> -       writel(0, TIMER0_VA_BASE + TIMER_CTRL);
>> -       writel(0, TIMER1_VA_BASE + TIMER_CTRL);
>> -       writel(0, TIMER2_VA_BASE + TIMER_CTRL);
>> -
> 
> As noted this is not an init function for timer-sp.c so please drop this
> hunk of the patch. Maybe this zeroing is pointless but that would
> be a separate patch that I can test.

Okay. I'll split this out.

> 
>> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
>> index 2b0db82..c68e7d8 100644
>> --- a/arch/arm/mach-integrator/integrator_cp.c
>> +++ b/arch/arm/mach-integrator/integrator_cp.c
>> @@ -33,7 +33,6 @@
>>  #include <mach/platform.h>
>>  #include <asm/setup.h>
>>  #include <asm/mach-types.h>
>> -#include <asm/hardware/arm_timer.h>
> 
> What doe this change has to do with $SUBJECT?

If I remove TIMER_CTRL use, then I don't need the header that defines it
any more.

Rob
