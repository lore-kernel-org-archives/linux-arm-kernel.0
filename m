From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Mar 2014 16:08:45 +0100
Subject: [PATCH 1/2] v1 ARM: sun4i: spi: Allow Rx transfers larger than
 FIFO size
In-Reply-To: <29069269.5VPQtL8a7I@nukelap.gtech>
References: <2167943.Zs1zPAMITN@nukelap.gtech>
 <20140319165507.GJ27873@lukather>
 <29069269.5VPQtL8a7I@nukelap.gtech>
Message-ID: <20140320150845.GM27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 01:03:45PM -0500, mrnuke wrote:
> > > -	/* We don't support transfer larger than the FIFO */
> > > -	if (tfr->len > SUN4I_FIFO_DEPTH)
> > > +	if (tfr->len > SUN4I_MAX_XFER_SIZE)
> > > +		return -EINVAL;
> > 
> > Why do you still need this test?
> > 
> SUN4I_MAX_XFER_SIZE is not the FIFO size. It is the max number we can write in 
> SUN4I_BURST_CNT_REG. That's the maximum SPI burst size (16 MiB - 1) that the 
> hardware supports. Anything larger, and we'd need to break up the transfer in 
> several bursts. That's a different problem than the one I'm addressing.

Ok, it makes sense.

> > > +	/* Receive FIFO 3/4 full */
> > > +	if (status & SUN4I_INT_CTL_RF_F34) {
> > > +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> > > +		/* Only clear the interrupt _after_ draining the FIFO */
> > > +		sun4i_spi_write(sspi, SUN4I_INT_STA_REG,
> > > SUN4I_INT_CTL_RF_F34);
> > 
> > Not that it's important, but it really doesn't matter to do it before
> > or after, the interrupts are disabled in the handler.
> > 
> I think this was one of those bits that keeps being set by hardware until the 
> Rx FIFO is under 48 bytes (less than 3/4 full).  I'll have to look into this 
> again.

Ok, it would deserve to be in the comments then :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/ef35c9fe/attachment-0001.sig>
