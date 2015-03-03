From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 03 Mar 2015 09:16:58 +0000
Subject: [PATCH] ARM64: gic: Do not allow bypass FIQ signals to reach
 to processor
In-Reply-To: <54F52690.70702@redhat.com>
References: <b449dac39614ed462c9a479e9de0aa5300d2c7cf.1423462126.git.panand@redhat.com>
 <54DDB236.4040503@redhat.com> <54F52690.70702@redhat.com>
Message-ID: <54F57C0A.6030906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/15 03:12, Pratyush Anand wrote:
> 
> On Friday 13 February 2015 01:43 PM, Pratyush Anand wrote:
>> Hi Jason,
>>
>> On Monday 09 February 2015 11:48 AM, Pratyush Anand wrote:
>>> In some case few signals of an IP(like PMU Overflow in APM88xx0x) can be
>>> mapped to nLEGACYFIQ, ie nFIQ of CPU. Until ARM64 supports FIQ handling,
>>> we will get nice "Bad mode in FIQ handler detected"
>>>
>>> Therefore force FIQBypDisGrp1 to '1', so that bypass FIQ signal is not
>>> signaled to the processor.
>>>
>>
>> Please review this patch.
> 
> ping
> 
>>
>> ~Pratyush
>>
>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>> ---
>>>   drivers/irqchip/irq-gic.c       | 9 ++++++++-
>>>   include/linux/irqchip/arm-gic.h | 1 +
>>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>> index d617ee5a3d8a..525dfc966e60 100644
>>> --- a/drivers/irqchip/irq-gic.c
>>> +++ b/drivers/irqchip/irq-gic.c
>>> @@ -362,7 +362,14 @@ static void gic_cpu_if_up(void)
>>>       */
>>>       bypass = readl(cpu_base + GIC_CPU_CTRL);
>>>       bypass &= GICC_DIS_BYPASS_MASK;
>>> -
>>> +#ifdef CONFIG_ARM64
>>> +    /* FIXME: when ARM64 starts supporting FIQ mode.
>>> +     *
>>> +     * Until ARM64 supports FIQ handling, force FIQBypDisGrp1 to
>>> +     * '1', so that bypass FIQ signal is not signaled to the processor.
>>> +     */
>>> +    bypass |= GICC_DIS_BYPASS_FIQ_TO_CPU;
>>> +#endif

This doesn't feel like the right approach at all. We have a bypass mask
already, for the same HW.

But more importantly, FIQBypDisGrp0 is only available in secure mode,
while the arm64 kernel only runs in non-secure. I understand that the
APM HW doesn't have a secure mode, but the GIC definitely has.

I suggest you move that change to your firmware, and make sure that the
kernel is only presented the non-secure version of the CPU interface.

Thanks,

	M.

>>>       writel_relaxed(bypass | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
>>>   }
>>>
>>> diff --git a/include/linux/irqchip/arm-gic.h
>>> b/include/linux/irqchip/arm-gic.h
>>> index 71d706d5f169..c9fdd1972625 100644
>>> --- a/include/linux/irqchip/arm-gic.h
>>> +++ b/include/linux/irqchip/arm-gic.h
>>> @@ -25,6 +25,7 @@
>>>   #define GICC_INT_PRI_THRESHOLD        0xf0
>>>   #define GICC_IAR_INT_ID_MASK        0x3ff
>>>   #define GICC_INT_SPURIOUS        1023
>>> +#define GICC_DIS_BYPASS_FIQ_TO_CPU    (1 << 5)
>>>   #define GICC_DIS_BYPASS_MASK        0x1e0
>>>
>>>   #define GIC_DIST_CTRL            0x000
>>>
> 


-- 
Jazz is not dead. It just smells funny...
