From: mr.nuke.me@gmail.com (mrnuke)
Date: Wed, 19 Mar 2014 13:23:34 -0500
Subject: [PATCH 2/2] v1 ARM: sun4i: spi: Allow Tx transfers larger than
 FIFO size
In-Reply-To: <20140319170251.GK27873@lukather>
References: <1521319.la1khlz7Zz@nukelap.gtech>
 <20140319170251.GK27873@lukather>
Message-ID: <1622018.I79WM3hSZT@nukelap.gtech>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 19, 2014 06:02:51 PM Maxime Ripard wrote:

> > +static inline int sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
> 
> return an u32 here
> 
> > +static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi,
> > u32
> > intm)
> 
> Please rename the variable "mask" here, and add a matching
> enable_interrupt function for consistency.
>
OK, and OK.

> >  	/* Enable the interrupts */
> > 
> > -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
> > -						 SUN4I_INT_CTL_RF_F34);
> > +	reg = SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
> > +	/* Only enable Tx FIFO interrupt if we really need it */
> > +	if (tx_len > SUN4I_FIFO_DEPTH)
> > +		reg |= SUN4I_INT_CTL_TF_E34;
> > +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
> 
> I'd be much dumber than that. Why don't you just enable both
> interrupts all the time if we need larger transfers ?
> 
SUN4I_INT_CTL_TF_E34 will trigger whenever the Tx FIFO has 16 bytes or less. 
There are 2 cases where this is relevant:

 (a) We have a Tx transaction with a length less than the FIFO size. We start 
the transaction, and SUN4I_INT_CTL_TF_E34 gets triggered somewhere along the 
way. We enter the interrupt handler, see that sspi->len is 0, and disable this 
interrupt.

 (b) We have a long Rx-only transaction. We start the transaction, and 
SUN4I_INT_CTL_TF_E34 gets triggered right away, as our Tx buffer is empty. We 
enter the handler, see that sspi->len is not zero, so we leave the interrupt 
enabled. Exit the IRQ handler, and we're right back servicing the same 
interrupt.

Case (a) only costs us an extra interrupt, whereas case (b) will cause an IRQ 
storm, and essentially loop-brick the kernel. I think the current check is the 
simplest of the alternatives. It's also why I wanted to separate the Tx part 
in a separate patch. This interrupt is tricky.

> > +	/* Transmit FIFO 3/4 empty */
> > +	if (status & SUN4I_INT_CTL_TF_E34) {
> > +		/* See how much data can fit */
> > +		cnt = SUN4I_FIFO_DEPTH - sun4i_spi_get_tx_fifo_count(sspi);
> > +		sun4i_spi_fill_fifo(sspi, cnt);
> 
> Making sure that you don't write to much data should be part of
> _fill_fifo
> 
I thought about it and the symmetry with _drain_fifo. I think this makes it a 
little clearer to see what's going on, but I'm perfectly fine with the 
symmetric way.

Alex
