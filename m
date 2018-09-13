From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 13 Sep 2018 06:33:29 -0700
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
In-Reply-To: <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
References: <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
Message-ID: <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2018 10:45 PM, C?dric Le Goater wrote

[ ... ]

>> ---
>> qemu:
>>
>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
>> index c762c73..0d4aa08 100644
>> --- a/hw/i2c/aspeed_i2c.c
>> +++ b/hw/i2c/aspeed_i2c.c
>> @@ -180,6 +180,33 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
>>       return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
>>   }
>>   
>> +static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
>> +{
>> +    int ret;
>> +
>> +    if (!(bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
>> +        return;
>> +    }
> 
> it deserves a comment to understand which scenario we are trying to handle.
> 
>> +    if (bus->intr_status & I2CD_INTR_RX_DONE) {
>> +        return;
>> +    }
> 
> should be handled in aspeed_i2c_bus_handle_cmd() I think
> 

I moved those two checks into the calling code.


>> +    aspeed_i2c_set_state(bus, I2CD_MRXD);
>> +    ret = i2c_recv(bus->bus);
>> +    if (ret < 0) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>> +        ret = 0xff;
>> +    } else {
>> +        bus->intr_status |= I2CD_INTR_RX_DONE;
>> +    }
>> +    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
>> +    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
>> +        i2c_nack(bus->bus);
>> +    }
>> +    bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
>> +    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
>> +}
>> +
>>   /*
>>    * The state machine needs some refinement. It is only used to track
>>    * invalid STOP commands for the moment.
>> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>   {
>>       bus->cmd &= ~0xFFFF;
>>       bus->cmd |= value & 0xFFFF;
>> -    bus->intr_status = 0;> +    bus->intr_status &= I2CD_INTR_RX_DONE;
> 
> it deserves a comment to understand which scenario we are trying to handle.
>    

Ok. FWIW, I wonder if intr_status should be touched here in the first place,
but I neither have the hardware nor a datasheet, so I don't know if any bits
are auto-cleared.

>>       if (bus->cmd & I2CD_M_START_CMD) {
>>           uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
>> @@ -227,22 +254,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>       }
>>   
>>       if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
>> -        int ret;
>> -
>> -        aspeed_i2c_set_state(bus, I2CD_MRXD);
>> -        ret = i2c_recv(bus->bus);
>> -        if (ret < 0) {
>> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>> -            ret = 0xff;
>> -        } else {
>> -            bus->intr_status |= I2CD_INTR_RX_DONE;
>> -        }
>> -        bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
>> -        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
>> -            i2c_nack(bus->bus);
>> -        }
>> -        bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
>> -        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
>> +        aspeed_i2c_handle_rx_cmd(bus);
>>       }
>>   
>>       if (bus->cmd & I2CD_M_STOP_CMD) {
>> @@ -263,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>>                                    uint64_t value, unsigned size)
>>   {
>>       AspeedI2CBus *bus = opaque;
>> +    int status;
>>   
>>       switch (offset) {
>>       case I2CD_FUN_CTRL_REG:
>> @@ -283,9 +296,16 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>>           bus->intr_ctrl = value & 0x7FFF;
>>           break;
>>       case I2CD_INTR_STS_REG:
>> +        status = bus->intr_status;
>>           bus->intr_status &= ~(value & 0x7FFF);
>> -        bus->controller->intr_status &= ~(1 << bus->id);
>> -        qemu_irq_lower(bus->controller->irq);
>> +        if (!bus->intr_status) {
>> +            bus->controller->intr_status &= ~(1 << bus->id);
>> +            qemu_irq_lower(bus->controller->irq);
>> +        }
> 
> That part below is indeed something to fix. I had a similar patch.
> 

Should I split it out as separate patch ? Alternatively, if you submitted
your patch already, I'll be happy to use it as base for mine.

Thanks,
Guenter

> 
>> +        if ((status & I2CD_INTR_RX_DONE) && !(bus->intr_status & I2CD_INTR_RX_DONE)) {
>> +            aspeed_i2c_handle_rx_cmd(bus);
>> +            aspeed_i2c_bus_raise_interrupt(bus);
>> +        }
> 
> ok.
> 
> Thanks for looking into this.
> 
> C.
> 
>>           break;
>>       case I2CD_DEV_ADDR_REG:
>>           qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
>>
> 
> 
