From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 12 Sep 2018 13:10:45 -0700
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
In-Reply-To: <20180912195844.GA6893@roeck-us.net>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
Message-ID: <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/12/2018 12:58 PM, Guenter Roeck wrote:
> On Wed, Sep 12, 2018 at 09:54:51AM -0700, Jae Hyun Yoo wrote:
>> On 9/11/2018 6:34 PM, Guenter Roeck wrote:
>>> On Tue, Sep 11, 2018 at 04:58:44PM -0700, Jae Hyun Yoo wrote:
>>>> On 9/11/2018 4:33 PM, Guenter Roeck wrote:
>>>>> Looking into the patch, clearing the interrupt status at the end of an
>>>>> interrupt handler is always suspicious and tends to result in race
>>>>> conditions (because additional interrupts may have arrived while handling
>>>>> the existing interrupts, or because interrupt handling itself may trigger
>>>>> another interrupt). With that in mind, the following patch fixes the
>>>>> problem for me.
>>>>>
>>>>> Guenter
>>>>>
>>>>> ---
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>>>>> index c258c4d9a4c0..c488e6950b7c 100644
>>>>> --- a/drivers/i2c/busses/i2c-aspeed.c
>>>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>>>>> @@ -552,6 +552,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>>>>>   	spin_lock(&bus->lock);
>>>>>   	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>> +	/* Ack all interrupt bits. */
>>>>> +	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>>   	irq_remaining = irq_received;
>>>>>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
>>>>> @@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>>>>>   			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>>>>>   			irq_received, irq_handled);
>>>>> -	/* Ack all interrupt bits. */
>>>>> -	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>>   	spin_unlock(&bus->lock);
>>>>>   	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>>>>>   }
>>>>>
>>>>
>>>> My intention of putting the code at the end of interrupt handler was,
>>>> to reduce possibility of combined irq calls which is explained in this
>>>> patch. But YES, I agree with you. It could make a potential race
>>>
>>> Hmm, yes, but that doesn't explain why it would make sense to acknowledge
>>> the interrupt late. The interrupt ack only means "I am going to handle these
>>> interrupts". If additional interrupts arrive while the interrupt handler
>>> is active, those will have to be acknowledged separately.
>>>
>>> Sure, there is a risk that an interrupt arrives while the handler is
>>> running, and that it is handled but not acknowledged. That can happen
>>> with pretty much all interrupt handlers, and there are mitigations to
>>> limit the impact (for example, read the interrupt status register in
>>> a loop until no more interrupts are pending). But acknowledging
>>> an interrupt that was possibly not handled is always bad idea.
>>
>> Well, that's generally right but not always. Sometimes that depends on
>> hardware and Aspeed I2C is the case.
>>
>> This is a description from Aspeed AST2500 datasheet:
>>    I2CD10 Interrupt Status Register
>>    bit 2 Receive Done Interrupt status
>>          S/W needs to clear this status bit to allow next data receiving.
>>
>> It means, driver should hold this bit to prevent transition of hardware
>> state machine until the driver handles received data, so the bit should
>> be cleared at the end of interrupt handler.
>>
> That makes sense. Does that apply to the other status bits as well ?
> Reason for asking is that the current code actually gets stuck
> in transmit, not receive.
> 
Only bit 2 has that description in datasheet. Is slave config enabled
for QEMU build? Does that get stuck in master sending or slave
receiving?

Thanks,
Jae
