From: nandor.han@ge.com (Han, Nandor (GE Healthcare))
Date: Fri, 13 Oct 2017 14:47:12 +0000
Subject: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if dma
 in use
In-Reply-To: <7c5a3ef3-6da7-815e-04a3-a1f18344032e@boundarydevices.com>
References: <20171007014648.6989-1-troy.kisky@boundarydevices.com>
 <AM3P101MB01800FAA2029393C5A859629E64A0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
 <7c5a3ef3-6da7-815e-04a3-a1f18344032e@boundarydevices.com>
Message-ID: <AM3P101MB01801D525028F3992D8E284AE6480@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Troy Kisky [mailto:troy.kisky at boundarydevices.com]
> Sent: 11 October 2017 19:10
> To: Han, Nandor (GE Healthcare) <nandor.han@ge.com>;
> gregkh at linuxfoundation.org
> Cc: fabio.estevam at nxp.com; l.stach at pengutronix.de; u.kleine-
> koenig at pengutronix.de; linux-serial at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: EXT: Re: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if
> dma in use
> 
> On 10/10/2017 11:22 PM, Han, Nandor (GE Healthcare) wrote:

<snip>

> >> -			imx_rxint(irq, dev_id);
> >> +	if (!sport->dma_is_enabled && (sts & (USR1_RRDY |
> >> USR1_AGTIM))) {
> >> +		imx_rxint(irq, dev_id);
> >
> > I don't think we need the check `!sport->dma_is_enabled ` since RRDY and
> AGTIM interrupts should be disable when DMA is enabled.
> 
> If I AND the status with its corresponding interrupt enable. But that is just as
> complicated, and more different from the original.
> 
> 

Yes, I agree, but it would be the right thing to do. :) 

> >
> >>  		ret = IRQ_HANDLED;
> >>  	}
> >>
> >> @@ -1207,10 +1181,6 @@ static void imx_enable_dma(struct imx_port
> >> *sport)
> >>  	temp |= UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN;
> >>  	writel(temp, sport->port.membase + UCR1);
> >>
> >> -	temp = readl(sport->port.membase + UCR2);
> >> -	temp |= UCR2_ATEN;
> >> -	writel(temp, sport->port.membase + UCR2);
> >> -
> >
> > I think this should be moved to imx_startup. At least RRDY is configured
> there.
> >
> 
> 
> Currently, non-dma mode does not use the ageing timer. You get an interrupt
> immediately when
> 1 character is in the fifo. So, enabling the ageing timer and changing fifo level,
> should really be a separate patch. But it would be a nice patch.
> 
> 

Ok but in this case, we are left with aging timer and rrdy check in the interrupt and imx-startup enables only rrdy. (which is not much different than what it was before, since aging timer didn't get a chance to be triggered)
I agree that changing the fifo level to give a chance also to the aging timer will be the right thing to do here.

Overall, I think is ok, my main concern with not enabling the aging timer in startup is that people can be confused about this.

Reviewed-by: Nandor Han <Nandor.han@ge.com>
