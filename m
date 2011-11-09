From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 10 Nov 2011 09:22:54 +1100
Subject: [PATCH v4 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <20111109195925.GB17406@legolas.emea.dhcp.ti.com>
References: <cover.1320853921.git.n.voss@weinmann.de>
 <fc7ccca66f0ffea1aa9c0409162b4a66974c46b3.1320853921.git.n.voss@weinmann.de>
 <20111109195925.GB17406@legolas.emea.dhcp.ti.com>
Message-ID: <4EBAFD3E.5070609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/11 06:59, Felipe Balbi wrote:

> Hi,
> 
> On Tue, Nov 08, 2011 at 11:49:46AM +0100, Nikolaus Voss wrote:
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index e8a1852..fba6da6 100644

>> +	ckdiv = 0;
>> +	while (cdiv > 255) {
>> +		ckdiv++;
>> +		cdiv = cdiv >> 1;
>> +	}
>> +
>> +	if (cpu_is_at91rm9200() && (ckdiv > 5)) {
>> +		dev_err(dev->dev, "AT91RM9200 Erratum #22: using ckdiv = 5.\n");
> 
> is it really an error ? Or would it be enough as dev_dbg() ?


dev_warn is probably appropriate.

> 
>> +static int at91_do_twi_transfer(struct at91_twi_dev *dev, bool is_read)
>> +{
>> +	int ret;
>> +
>> +	INIT_COMPLETION(dev->cmd_complete);
>> +	if (is_read) {
>> +		if (!dev->buf_len)
>> +			at91_twi_write(dev, AT91_TWI_CR,
>> +				       AT91_TWI_START | AT91_TWI_STOP);
>> +		else
>> +			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_START);
>> +		at91_twi_write(dev, AT91_TWI_IER,
>> +			       AT91_TWI_TXCOMP | AT91_TWI_RXRDY);
>> +	} else {
>> +		at91_twi_write_next_byte(dev);
>> +		at91_twi_write(dev, AT91_TWI_IER,
>> +			       AT91_TWI_TXCOMP | AT91_TWI_TXRDY);
>> +	}
>> +
>> +	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
>> +							dev->adapter.timeout);
>> +	if (ret == 0) {
>> +		dev_err(dev->dev, "controller timed out\n");
>> +		at91_init_twi_bus(dev);
>> +		return -ETIMEDOUT;
>> +	}
>> +	if (dev->transfer_status & AT91_TWI_NACK) {
>> +		dev_dbg(dev->dev, "received nack\n");
>> +		return -ENODEV;
> 
> not sure error code matches here. If the HW replies with NACK you tell
> your users there's no I2C adapter ? Sounds a bit weird to me...


I think -ENODEV was used because a NACK can mean that there is no device
at the address you are trying to talk to. Other drivers appear to use
-EIO or -EREMOTEIO. The latter is possibly more correct.

~Ryan
