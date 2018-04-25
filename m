From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 25 Apr 2018 17:08:53 +0200
Subject: [PATCH] i2c: at91: Read all available bytes at once
In-Reply-To: <20180418124055.21333-1-david.engraf@sysgo.com>
References: <20180418124055.21333-1-david.engraf@sysgo.com>
Message-ID: <20180425150853.GU13305@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Wed, Apr 18, 2018 at 02:40:55PM +0200, David Engraf wrote:
> With FIFO enabled it is possible to read multiple bytes
> at once in the interrupt handler as long as RXRDY is
> set. This may also reduce the number of interrupts.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>  drivers/i2c/busses/i2c-at91.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index bfd1fdff64a9..d01c2b2384bd 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -518,8 +518,12 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
>  	 * the RXRDY interrupt first in order to not keep garbage data in the
>  	 * Receive Holding Register for the next transfer.
>  	 */
> -	if (irqstatus & AT91_TWI_RXRDY)
> -		at91_twi_read_next_byte(dev);
> +	if (irqstatus & AT91_TWI_RXRDY) {
> +		/* read all available bytes at once when FIFO is used */
> +		do {
> +			at91_twi_read_next_byte(dev);
> +		} while (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY);

You can avoid this check by using the RXFL field to know the number of
data you can read. Did you try to use it? If yes, did you notice some issues?

Regards

Ludovic

> +	}
>  
>  	/*
>  	 * When a NACK condition is detected, the I2C controller sets the NACK,
> -- 
> 2.14.1
> 
