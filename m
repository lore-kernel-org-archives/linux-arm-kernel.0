From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 22 Jan 2014 03:41:08 +0000
Subject: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
In-Reply-To: <b55917fd1b664ebeaeb135330ff806bd@DM2PR03MB349.namprd03.prod.outlook.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
 <b55917fd1b664ebeaeb135330ff806bd@DM2PR03MB349.namprd03.prod.outlook.com>
Message-ID: <3da53d9f2adb44d18c45c44c13621288@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark

Think twice.
Yes, you are right. "of_get_property" is not necessary here.

Thanks for your suggestion.

> -----Original Message-----
> From: linux-serial-owner at vger.kernel.org [mailto:linux-serial-
> owner at vger.kernel.org] On Behalf Of Yao Yuan
> Sent: Thursday, January 16, 2014 2:54 PM
> To: Mark Rutland
> Cc: gregkh at linuxfoundation.org; shawn.guo at linaro.org;
> linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org;
> arnd at arndb.de; linux-serial at vger.kernel.org
> Subject: RE: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
> 
> Hi, mark
> 
> > -----Original Message-----
> > > +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> > > +       struct platform_device *pdev = to_platform_device(port->dev);
> > > +       struct device_node *np = pdev->dev.of_node;
> > > +
> > > +       if (of_get_property(np, "dmas", NULL)) {
> > > +               sport->lpuart_dma_use = true;
> > > +               lpuart_dma_tx_request(port);
> > > +               lpuart_dma_rx_request(port);
> > > +               temp = readb(port->membase + UARTCR5);
> > > +               writeb(temp | UARTCR5_TDMAS, port->membase +
> > > + UARTCR5);
> >
> > Rather than reading the raw dt to find out if you have dmas, can you
> > not just attempt to request the dmas and if either fail give up on
> using them?
> 
> Yes, the dma request function can also confirm it. But maybe it's better
> that add the judge as a dma entrance first?
> I think if the dmas is be written it means dma want be support. At this
> time, rather than silently change to no dma model, we may throw the error
> when some errors happened.
> But dma request failed may have many other reasons. Also the judge will
> just run only once, it will not waste of performance.
> If the dmas is not be written, we don't need to do anything about dma.
>   ?
 & ~ &   +-  ?  w  ?   m b  lz   )   w*jg   
     ?j/   z ?  2 ?
> & )? a    
 G   h  j:+v   w ?
