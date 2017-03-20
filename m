From: fu.wei@linaro.org (Fu Wei)
Date: Mon, 20 Mar 2017 14:59:35 +0800
Subject: [PATCH v21 03/13] clocksource: arm_arch_timer: remove
 arch_timer_detect_rate
In-Reply-To: <20170317180725.GC15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-4-fu.wei@linaro.org>
 <20170317180725.GC15909@leverpostej>
Message-ID: <CADyBb7spKzLKb2wZFRDcXLPBmxkgV+JPAoCiDbSXmFq9qqbuCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 18 March 2017 at 02:07, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Feb 07, 2017 at 02:50:05AM +0800, fu.wei at linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The original counter frequency detection call(arch_timer_detect_rate)
>> include getting the frequency from the per-cpu arch-timer and the
>> memory-mapped (MMIO) timer interfaces. But they will be needed only when
>> the system initializes the relevant timer.
>>
>> This patch remove arch_timer_detect_rate founction, and use the
>> arch_timer_get_sysreg_freq and arch_timer_get_mmio_freq directly.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>
> Could you please fold this with the prior patch?

Sure, will do

>
>> @@ -1087,7 +1072,12 @@ static int __init arch_timer_mem_init(struct device_node *np)
>>        */
>>       if (!arch_timer_rate &&
>>           of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
>> -             arch_timer_detect_rate(base);
>> +             arch_timer_rate = arch_timer_get_mmio_freq(base);
>> +     if (!arch_timer_rate) {
>> +             pr_err(FW_BUG "frequency not available for MMIO timer.\n");
>
> It would be better to say "MMIO frequency not available.\n" here.

thanks , will do

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
