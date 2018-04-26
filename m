From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 26 Apr 2018 10:25:58 +0200
Subject: [PATCH] i2c: at91: Read all available bytes at once
In-Reply-To: <cab9e509-a506-5852-6b0d-ed3e4751eeb6@sysgo.com>
References: <20180418124055.21333-1-david.engraf@sysgo.com>
 <20180425150853.GU13305@rfolt0960.corp.atmel.com>
 <cab9e509-a506-5852-6b0d-ed3e4751eeb6@sysgo.com>
Message-ID: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Wed, Apr 25, 2018 at 05:43:09PM +0200, David Engraf wrote:
> Hi Ludovic,
> 
> Am 25.04.2018 um 17:08 schrieb Ludovic Desroches:
> > Hi David,
> > 
> > On Wed, Apr 18, 2018 at 02:40:55PM +0200, David Engraf wrote:
> > > With FIFO enabled it is possible to read multiple bytes
> > > at once in the interrupt handler as long as RXRDY is
> > > set. This may also reduce the number of interrupts.
> > > 
> > > Signed-off-by: David Engraf <david.engraf@sysgo.com>
> > > ---
> > >   drivers/i2c/busses/i2c-at91.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > > index bfd1fdff64a9..d01c2b2384bd 100644
> > > --- a/drivers/i2c/busses/i2c-at91.c
> > > +++ b/drivers/i2c/busses/i2c-at91.c
> > > @@ -518,8 +518,12 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
> > >   	 * the RXRDY interrupt first in order to not keep garbage data in the
> > >   	 * Receive Holding Register for the next transfer.
> > >   	 */
> > > -	if (irqstatus & AT91_TWI_RXRDY)
> > > -		at91_twi_read_next_byte(dev);
> > > +	if (irqstatus & AT91_TWI_RXRDY) {
> > > +		/* read all available bytes at once when FIFO is used */
> > > +		do {
> > > +			at91_twi_read_next_byte(dev);
> > > +		} while (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY);
> > 
> > You can avoid this check by using the RXFL field to know the number of
> > data you can read. Did you try to use it? If yes, did you notice some issues?
> 
> I did a quick test by reading RXFL and it worked as well but I decided to
> use the more readable solution by polling RXRDY. Also I don't need to check
> if the FIFO has been enabled.
> 
> If you prefer using RXFL I can create a new patch.

Honestly, I have no strong opinion about it. As you said you approach is
simple and easy to read.

About performances, I assume that both solutions are pretty the same for
small number of data. If the number increases, using the RXFL field
should give better results.

So I would say, maybe add a note in the commit log or in the code to
keep in mind there is this solution to go further.

Otherwise
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Regards

Ludovic

> 
> Best regards
> - David
> 
> 
> > Regards
> > 
> > Ludovic
> > 
> > > +	}
> > >   	/*
> > >   	 * When a NACK condition is detected, the I2C controller sets the NACK,
> > > -- 
> > > 2.14.1
> > > 
> 
