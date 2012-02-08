From: dmitry.antipov@linaro.org (Dmitry Antipov)
Date: Wed, 08 Feb 2012 07:15:26 -0800
Subject: [PATCH] sched: generalize CONFIG_IRQ_TIME_ACCOUNTING for X86
 and ARM
In-Reply-To: <20120208131833.GK889@n2100.arm.linux.org.uk>
References: <1328705314-20978-1-git-send-email-dmitry.antipov@linaro.org>
 <20120208131833.GK889@n2100.arm.linux.org.uk>
Message-ID: <4F32918E.9000905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2012 05:18 AM, Russell King - ARM Linux wrote:

>> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
>> index 5416c7c..56d2a9d 100644
>> --- a/arch/arm/kernel/sched_clock.c
>> +++ b/arch/arm/kernel/sched_clock.c
>> @@ -162,5 +162,8 @@ void __init sched_clock_postinit(void)
>>   	if (read_sched_clock == jiffy_sched_clock_read)
>>   		setup_sched_clock(jiffy_sched_clock_read, 32, HZ);
>>
>> +	if (!no_sched_irq_time)
>> +		enable_sched_clock_irqtime();
>
> Why are you placing this here?  sched_clock is available from the point
> that it's registered, which should be before the first sched_clock()
> call.

This is just because I'm thinking about:

if (read_sched_clock == jiffy_sched_clock_read)
         setup_sched_clock(jiffy_sched_clock_read, 32, HZ);
else if (!no_sched_irq_time)
	enable_sched_clock_irqtime();

I suppose that "fine granularity task irq time accounting"
makes no sense if sched_clock() granularity is poor.

> This could have been written:
>
> 	depends on X86 || (ARM&&  HAVE_SCHED_CLOCK)
>
> However, ARM will always have HAVE_SCHED_CLOCK after the next merge window,
> so this can become a much simpler:
>
> 	depends on X86 || ARM

OK.

Dmitry
