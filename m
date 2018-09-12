From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Wed, 12 Sep 2018 07:57:24 +0200
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
In-Reply-To: <20180911233302.GA18799@roeck-us.net>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
Message-ID: <f184e209-cb4b-55d4-e520-ae2cc9f0d963@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2018 01:33 AM, Guenter Roeck wrote:
> On Wed, Sep 12, 2018 at 08:23:29AM +0930, Joel Stanley wrote:
>> On Wed, 12 Sep 2018 at 07:48, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> On 9/11/2018 1:41 PM, Guenter Roeck wrote:
>>>> On Tue, Sep 11, 2018 at 01:30:41PM -0700, Jae Hyun Yoo wrote:
>>
>>>>> I checked this patch again but it doesn't have any change that could
>>>>> affect to the probing flow. I'll debug the issue on qemu 3.0 environment
>>>>> and will share if I find something.
>>>>>
>>>> The problem may be that qemu and the new code disagree how interrupts
>>>> should be generated and handled, and the new code does not handle the
>>>> interrupts it receives from the simulated hardware. This will result
>>>> in i2c device probe failure, which in turn can cause all kinds of
>>>> problems.
>>>>
>>>
>>> Yes, that makes sense. Looks like it should be reverted until the issue
>>> is fixed. Will submit a patch to revert it.
>>
>> Let's not rush. The qemu model was written in order to allow us to
>> test the kernel code, and was validated by the kernel driver we have.
>> We've had situations in the past (with the i2c driver in fact) where a
>> change in the driver required an update of the model to be more
>> accurate.
>>
>> I suggest we wait until Cedric has a chance to look at the issue
>> before reverting the patch.
>>
> 
> Looking into the patch, clearing the interrupt status at the end of an
> interrupt handler is always suspicious and tends to result in race

yes. That happened in the past with the I2C aspeed driver. I can not find
the thread anymore but we had to move up the ack of the interrupts. 

QEMU tends to be much faster to fire interrupts than real HW.


> conditions (because additional interrupts may have arrived while handling
> the existing interrupts, or because interrupt handling itself may trigger
> another interrupt). With that in mind, the following patch fixes the
> problem for me.

Acked-by: C?dric Le Goater <clg@kaod.org>

Thanks,

C.

> Guenter
> 
> ---
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index c258c4d9a4c0..c488e6950b7c 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -552,6 +552,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  
>  	spin_lock(&bus->lock);
>  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack all interrupt bits. */
> +	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>  	irq_remaining = irq_received;
>  
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> @@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>  			irq_received, irq_handled);
>  
> -	/* Ack all interrupt bits. */
> -	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>  	spin_unlock(&bus->lock);
>  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>  }
> 
