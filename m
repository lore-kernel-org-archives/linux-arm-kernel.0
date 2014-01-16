From: yao.yuan@freescale.com (Yao Yuan)
Date: Thu, 16 Jan 2014 06:54:24 +0000
Subject: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
In-Reply-To: <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
Message-ID: <b55917fd1b664ebeaeb135330ff806bd@DM2PR03MB349.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, mark

> -----Original Message-----
> > +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> > +       struct platform_device *pdev = to_platform_device(port->dev);
> > +       struct device_node *np = pdev->dev.of_node;
> > +
> > +       if (of_get_property(np, "dmas", NULL)) {
> > +               sport->lpuart_dma_use = true;
> > +               lpuart_dma_tx_request(port);
> > +               lpuart_dma_rx_request(port);
> > +               temp = readb(port->membase + UARTCR5);
> > +               writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
> 
> Rather than reading the raw dt to find out if you have dmas, can you not
> just attempt to request the dmas and if either fail give up on using them?

Yes, the dma request function can also confirm it. But maybe it's better that add the judge
as a dma entrance first?
I think if the dmas is be written it means dma want be support. At this time, rather than 
silently change to no dma model, we may throw the error when some errors happened.
But dma request failed may have many other reasons. Also the judge will just run only once, 
it will not waste of performance.
If the dmas is not be written, we don't need to do anything about dma.
