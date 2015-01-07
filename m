From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 7 Jan 2015 11:31:14 +0100
Subject: [PATCH] at91: i2c-at91: improve time-out handling
In-Reply-To: <54A58BA5.3080003@interlog.com>
References: <54A58BA5.3080003@interlog.com>
Message-ID: <20150107103113.GA30897@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Douglas,

On Thu, Jan 01, 2015 at 01:02:13PM -0500, Douglas Gilbert wrote:
> With lk 3.19.0-rc2 and a at91sam9g25 (9x5) based system I
> connected a NXP SC16IS750 I2C to serial bridge. After
> routing the 750's IRQ back to the sc16is7xx driver and some
> simple successful test, it was time for some intense testing:
> Tx looped back to Rx on the 750, open picocom on /dev/ttySC0
> at 38400, and use hexdump to blast a binary file (in hex) at
> ttySC0. The I2C SCL speed was 200,000 Hz.
> 
> It worked as expected for a few seconds then it wedged the
> I2C bus. That was repeatable. In the cases that I checked SCL
> was high, SDA was low (driven by _both_ the G25's macrocell
> and the 750!!) and IRQ was active (low). This patch stopped
> the G25 macrocell from driving SDA low in the above wedge
> (and stopped copious error reports going to the log). I was
> surprised that a NXP I2C chip got into this situation, IMO
> SDA on a slave should have a driven low timeout. IMO all
> I2C master drivers should have provision to drive a gpio
> connected to a (or all the) slave's RESET line(s).
> 
> 
> ChangeLog:
>    when handling an I2C bus time-out, first clean-up the
>    DMA transfer, then do an I2C macrocell software reset
>    and restore some registers, including the interrupt
>    mask
> 

I am wondering why you need to call at91_twi_irq_save() and
at91_twi_irq_restore(). The interrupts enabled in the driver are
AT91_TWI_TXCOMP, AT91_TWI_RXRDY and AT91_TWI_TXRDY and they are managed
in at91_do_twi_transfer() so they would be set correctly for the next
transfer.

Regards

Ludovic

> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>

> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 636fd2e..4d78708 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -382,6 +382,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  {
>  	int ret;
>  	bool has_unre_flag = dev->pdata->has_unre_flag;
> +	bool timed_out = false;
>  
>  	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
>  		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);
> @@ -440,7 +441,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  					     dev->adapter.timeout);
>  	if (ret == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -		at91_init_twi_bus(dev);
> +		timed_out = true;
>  		ret = -ETIMEDOUT;
>  		goto error;
>  	}
> @@ -471,6 +472,11 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  
>  error:
>  	at91_twi_dma_cleanup(dev);
> +	if (timed_out) {
> +		at91_twi_irq_save(dev);
> +		at91_init_twi_bus(dev);
> +		at91_twi_irq_restore(dev);
> +	}
>  	return ret;
>  }
>  
