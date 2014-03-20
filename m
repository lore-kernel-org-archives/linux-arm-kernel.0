From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Mar 2014 16:14:28 +0100
Subject: [PATCH 2/2] v1 ARM: sun4i: spi: Allow Tx transfers larger than
 FIFO size
In-Reply-To: <1622018.I79WM3hSZT@nukelap.gtech>
References: <1521319.la1khlz7Zz@nukelap.gtech>
 <20140319170251.GK27873@lukather>
 <1622018.I79WM3hSZT@nukelap.gtech>
Message-ID: <20140320151428.GN27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 01:23:34PM -0500, mrnuke wrote:
> > >  	/* Enable the interrupts */
> > > 
> > > -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
> > > -						 SUN4I_INT_CTL_RF_F34);
> > > +	reg = SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
> > > +	/* Only enable Tx FIFO interrupt if we really need it */
> > > +	if (tx_len > SUN4I_FIFO_DEPTH)
> > > +		reg |= SUN4I_INT_CTL_TF_E34;
> > > +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
> > 
> > I'd be much dumber than that. Why don't you just enable both
> > interrupts all the time if we need larger transfers ?
> > 
> SUN4I_INT_CTL_TF_E34 will trigger whenever the Tx FIFO has 16 bytes or less. 
> There are 2 cases where this is relevant:
> 
>  (a) We have a Tx transaction with a length less than the FIFO size. We start 
> the transaction, and SUN4I_INT_CTL_TF_E34 gets triggered somewhere along the 
> way. We enter the interrupt handler, see that sspi->len is 0, and disable this 
> interrupt.

Well, it wouldn't be triggered, since you wouldn't have enabled
it. But it would be in the status register.

>  (b) We have a long Rx-only transaction. We start the transaction, and 
> SUN4I_INT_CTL_TF_E34 gets triggered right away, as our Tx buffer is empty. We 
> enter the handler, see that sspi->len is not zero, so we leave the interrupt 
> enabled. Exit the IRQ handler, and we're right back servicing the same 
> interrupt.

Ah, yes. That one is nasty.

> Case (a) only costs us an extra interrupt, whereas case (b) will cause an IRQ 
> storm, and essentially loop-brick the kernel. I think the current check is the 
> simplest of the alternatives. It's also why I wanted to separate the Tx part 
> in a separate patch. This interrupt is tricky.

I guess your suggestion of adding an enabled interrupt mask makes
sense then, just to avoid handling status that we don't care for in
the case of a spurious interrupt.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/9e7f5841/attachment.sig>
