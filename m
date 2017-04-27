From: majun258@huawei.com (majun (Euler7))
Date: Thu, 27 Apr 2017 09:27:14 +0800
Subject: [PATCH] irqchip/mbigen: Fix the clear register offset
In-Reply-To: <07081162-ca52-fa46-00e6-e72e1b4fd092@arm.com>
References: <1493086563-36396-1-git-send-email-majun258@huawei.com>
 <68214147-bc4d-c542-ce40-78f69a63e53d@linaro.org>
 <07081162-ca52-fa46-00e6-e72e1b4fd092@arm.com>
Message-ID: <590148F2.1030502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc:

? 2017/4/26 16:01, Marc Zyngier ??:
> On 26/04/17 04:10, Hanjun Guo wrote:
>> Hi Majun,
>>
>> On 2017/4/25 10:16, Majun wrote:
>>> From: MaJun <majun258@huawei.com>
>>>
>>> Don't minus reserved interrupts (64) when get the clear register offset,because
>>> the clear register space includes the space of these 64 interrupts.
>>
>> Could you mention the background that there is a timeout mechanism
>> to clear the register in the mbigen to make the code work even we clear
>> the wrong (and noneffective) register? that will help for review I
>> think.
> 
> A timeout? So if you don't clear the interrupt in a timely manner, it
> will still bypass the masking? That feels very wrong. How is this
> timeout configured? Can it be entirely disabled?

You are right. The timeout should be turn off usually, it's just a debug or
testing function in our chip. Because of configuration mistake in BIOS, this function
is turned on now and covered the bug in clear offset calculate.
Now, it's time to fix this.

Thanks
MaJun

> 
>>
>>>
>>> Signed-off-by: MaJun <majun258@huawei.com>
>>> ---
>>>  drivers/irqchip/irq-mbigen.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>>> index 061cdb8..75818a5 100644
>>> --- a/drivers/irqchip/irq-mbigen.c
>>> +++ b/drivers/irqchip/irq-mbigen.c
>>> @@ -108,7 +108,6 @@ static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
>>>  {
>>>  	unsigned int ofst;
>>>
>>> -	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
>>>  	ofst = hwirq / 32 * 4;
>>>
>>>  	*mask = 1 << (hwirq % 32);
>>
>> How about following to save more lines of code:
>>
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -106,10 +106,7 @@ static inline void 
>> get_mbigen_type_reg(irq_hw_number_t hwirq,
>>   static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
>>                                          u32 *mask, u32 *addr)
>>   {
>> -       unsigned int ofst;
>> -
>> -       hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
>> -       ofst = hwirq / 32 * 4;
>> +       unsigned int ofst = hwirq / 32 * 4;
>>
>>          *mask = 1 << (hwirq % 32);
>>          *addr = ofst + REG_MBIGEN_CLEAR_OFFSET;
> 
> Well, this is not a code deletion contest... ;-)
> 
> 	M.
> 
