From: dgilbert@interlog.com (Douglas Gilbert)
Date: Sat, 24 Jan 2015 23:42:24 +0100
Subject: [PATCH] at91: i2c-at91: improve time-out handling
In-Reply-To: <20150113152752.GK7660@katana>
References: <54A58BA5.3080003@interlog.com>
 <20150107103113.GA30897@ldesroches-Latitude-E6320>
 <20150113152752.GK7660@katana>
Message-ID: <54C41FD0.2010607@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-01-13 04:27 PM, Wolfram Sang wrote:
> On Wed, Jan 07, 2015 at 11:31:14AM +0100, Ludovic Desroches wrote:
>> Hi Douglas,
>>
>> On Thu, Jan 01, 2015 at 01:02:13PM -0500, Douglas Gilbert wrote:
>>> With lk 3.19.0-rc2 and a at91sam9g25 (9x5) based system I
>>> connected a NXP SC16IS750 I2C to serial bridge. After
>>> routing the 750's IRQ back to the sc16is7xx driver and some
>>> simple successful test, it was time for some intense testing:
>>> Tx looped back to Rx on the 750, open picocom on /dev/ttySC0
>>> at 38400, and use hexdump to blast a binary file (in hex) at
>>> ttySC0. The I2C SCL speed was 200,000 Hz.
>>>
>>> It worked as expected for a few seconds then it wedged the
>>> I2C bus. That was repeatable. In the cases that I checked SCL
>>> was high, SDA was low (driven by _both_ the G25's macrocell
>>> and the 750!!) and IRQ was active (low). This patch stopped
>>> the G25 macrocell from driving SDA low in the above wedge
>>> (and stopped copious error reports going to the log). I was
>>> surprised that a NXP I2C chip got into this situation, IMO
>>> SDA on a slave should have a driven low timeout. IMO all
>>> I2C master drivers should have provision to drive a gpio
>>> connected to a (or all the) slave's RESET line(s).
>>>
>>>
>>> ChangeLog:
>>>     when handling an I2C bus time-out, first clean-up the
>>>     DMA transfer, then do an I2C macrocell software reset
>>>     and restore some registers, including the interrupt
>>>     mask
>>>
>>
>> I am wondering why you need to call at91_twi_irq_save() and
>> at91_twi_irq_restore(). The interrupts enabled in the driver are
>> AT91_TWI_TXCOMP, AT91_TWI_RXRDY and AT91_TWI_TXRDY and they are managed
>> in at91_do_twi_transfer() so they would be set correctly for the next
>> transfer.
>
> Douglas, any more info you could provide?

I reran the torture tests without the at91_twi_irq_save() and
at91_twi_irq_restore() calls and got the same results. So it
seems that those calls are not needed; revised patch attached.

Other observations: after the torture test wedges (after
several seconds at 38400 baud) grounding the RESET pin on the
SC16IS750 clears the I2C bus jam; thereafter I2C
transmissions can continue. That implies to me that Atmel's
I2C macrocell is not wedged.

When the sc16is7xx driver is built as a module, then rmmod
runs into a slow path dump in the logs. That comes from the
clk_disable() call in:
   sc16is7xx_i2c_remove+0x88/0xa4 [sc16is7xx]

Tests done with lk 3.19.0-rc4 using a AT91SAM9G25 system
(Acme Arietta).

For the attached patch:
   Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>


>> Regards
>>
>> Ludovic
>>
>>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>>
>>> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
>>> index 636fd2e..4d78708 100644
>>> --- a/drivers/i2c/busses/i2c-at91.c
>>> +++ b/drivers/i2c/busses/i2c-at91.c
>>> @@ -382,6 +382,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>>>   {
>>>   	int ret;
>>>   	bool has_unre_flag = dev->pdata->has_unre_flag;
>>> +	bool timed_out = false;
>>>
>>>   	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
>>>   		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);
>>> @@ -440,7 +441,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>>>   					     dev->adapter.timeout);
>>>   	if (ret == 0) {
>>>   		dev_err(dev->dev, "controller timed out\n");
>>> -		at91_init_twi_bus(dev);
>>> +		timed_out = true;
>>>   		ret = -ETIMEDOUT;
>>>   		goto error;
>>>   	}
>>> @@ -471,6 +472,11 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>>>
>>>   error:
>>>   	at91_twi_dma_cleanup(dev);
>>> +	if (timed_out) {
>>> +		at91_twi_irq_save(dev);
>>> +		at91_init_twi_bus(dev);
>>> +		at91_twi_irq_restore(dev);
>>> +	}
>>>   	return ret;
>>>   }
>>>
>>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-at91_tmout2.patch
Type: text/x-patch
Size: 1570 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150124/c0035c2f/attachment.bin>
