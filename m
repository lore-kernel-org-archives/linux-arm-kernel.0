From: yao.yuan@freescale.com (Yao Yuan)
Date: Thu, 16 Jan 2014 08:19:18 +0000
Subject: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
In-Reply-To: <201401151025.34628.arnd@arndb.de>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <201401151025.34628.arnd@arndb.de>
Message-ID: <4a519c52821b4ceb841cbefcf2a0432b@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

> -----Original Message-----
> >  #define DRIVER_NAME	"fsl-lpuart"
> >  #define DEV_NAME	"ttyLP"
> >  #define UART_NR		6
> > @@ -121,6 +132,26 @@ struct lpuart_port {
> >  	struct clk		*clk;
> >  	unsigned int		txfifo_size;
> >  	unsigned int		rxfifo_size;
> > +
> > +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> > +	bool			lpuart_dma_use;
> > +	struct dma_chan		*dma_tx_chan;
> > +	struct dma_chan		*dma_rx_chan;
> > +	struct dma_async_tx_descriptor  *dma_tx_desc;
> > +	struct dma_async_tx_descriptor  *dma_rx_desc;
> > +	dma_addr_t		dma_tx_buf_bus;
> > +	dma_addr_t		dma_rx_buf_bus;
> > +	dma_cookie_t		dma_tx_cookie;
> > +	dma_cookie_t		dma_rx_cookie;
> > +	unsigned char		*dma_tx_buf_virt;
> > +	unsigned char		*dma_rx_buf_virt;
> > +	unsigned int		dma_tx_bytes;
> > +	unsigned int		dma_rx_bytes;
> > +	int			dma_tx_in_progress;
> > +	int			dma_rx_in_progress;
> > +	unsigned int		dma_rx_timeout;
> > +	struct timer_list	lpuart_timer;
> > +#endif
> >  };
> 
> This part will result in a slight increase in data size even if dma
> support is turned off at compile time.
> 

Yes, someone also want me define a independent struct for dma and allocate the memory when dma be use.
But I think this way will add a more memory access time, like a->b->c and a->c. And the variable 
about dma is just a few bytes but used frequently. So I think I'd better define the variable about dma in lpuart_port struct.
