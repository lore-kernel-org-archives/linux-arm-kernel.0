From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Mon, 16 Apr 2012 09:30:02 +0200
Subject: [PATCH] i2c-at91: fix data-loss issue
In-Reply-To: <1334317476-10044-1-git-send-email-h.feurstein@gmail.com>
References: <20120413103937.GH7154@arwen.pp.htv.fi>
 <1334317476-10044-1-git-send-email-h.feurstein@gmail.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hubert Feurstein wrote on 2012-04-13:
> In the interrupt handler both status-flags (TXCOMP and RXRDY) might be
> pending at the same time. In this case TXCOMP is handled but NOT RXRDY
> which causes a data-loss on the current transfer

Right, this is definitely a bug and must be corrected. Part of my
motivation for exclusively or-ing the irq bits was not reading/
writing beyond the buffer because of (still) pending bits despite
of an already finished transfer, so I gave TXCOMP the highest prio.

Because of other reasons, write_next_byte() already checks this and
does nothing if all data already has been written. My suggestion is
to have read_next_byte() do this check too, as I don't trust the
hardware to reset RXRDY _immediately_ after reading.

> @@ -161,18 +161,22 @@ static irqreturn_t atmel_twi_interrupt(int irq, void
> *dev_id)
>  {
>  	struct at91_twi_dev *dev = dev_id;
>  	const unsigned status = at91_twi_read(dev, AT91_TWI_SR);
> -	const unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
> +	unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
> +
> +	irqstatus &= (AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_TXCOMP);

The above line should be unnecessary as no more than those interrupts
are enabled anyway. Any special reason for this?
 
> +	if (!irqstatus)
> +		return IRQ_NONE;
> +
> +	if (irqstatus & AT91_TWI_RXRDY)
> +		at91_twi_read_next_byte(dev);
> +
> +	if (irqstatus & AT91_TWI_TXRDY)
> +		at91_twi_write_next_byte(dev);

I would like to exclusively or TXRDY and RXRDY as those really should
not be active at the same time. Keeps the decision tree lean ;-).

> @@ -189,6 +193,10 @@ static int
>  at91_do_twi_transfer(struct at91_twi_dev *dev) 	if (dev->msg->flags &
>  I2C_M_RD) { 		unsigned start_flags = AT91_TWI_START;
> +		/* clear any pending data */
> +		(void)at91_twi_read(dev, AT91_TWI_SR);
> +		(void)at91_twi_read(dev, AT91_TWI_RHR);

I would like to modify this, as this is a partial fix for the above bug
which should already be fully fixed by the modified isr.
I fear subtle data-loss if we make (partial) tabula rasa before each
transfer. I'd rather add an assertion to check if the corresponding
irqs are active as an indication for a driver/hw-bug.

I'll repost the driver with your fix on positive feedback from you.
Thanks for tracking this down.

Ben, is there any chance to get this driver into next?

Niko
