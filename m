From: yao.yuan@freescale.com (Yao Yuan)
Date: Tue, 7 Jan 2014 06:32:02 +0000
Subject: [PATCH] the eDMA support for the LPUART send driver
In-Reply-To: <20140105145031.GB27432@n2100.arm.linux.org.uk>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
 <201401051544.50036.arnd@arndb.de>
 <20140105145031.GB27432@n2100.arm.linux.org.uk>
Message-ID: <0602455564214ab7986348ea985fc820@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your suggestion. It's important for me.

I read the source code for dma_map_single again. I found that both of them(as first argument is dma or uart) worked well. But in my code I found that the *sport->port.dev->dma_mask is not zero. By contrast the dma_mask for dma device is zero.
You are right. There should be dma device. But I also have a doubt here. Why I find many other driver use the first argument here rather than the dma device pointer.
They usually use the device like uart. 


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Sunday, January 05, 2014 10:51 PM
To: Yuan Yao-B46683
Cc: Arnd Bergmann; linux-arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org; linux-serial at vger.kernel.org
Subject: Re: [PATCH] the eDMA support for the LPUART send driver

On Sun, Jan 05, 2014 at 03:44:49PM +0100, Arnd Bergmann wrote:
> On Friday 27 December 2013, Yuan Yao wrote:
> > +	dma_phys = dma_map_single(sport->port.dev,
> > +				sport->port.state->xmit.buf,
> > +				UART_XMIT_SIZE, DMA_TO_DEVICE);
> 
> This is wrong: Since the dma is performed by the dma engine rather 
> than the uart, the first argument here needs to be the dma device 
> pointer. In fact, dma_map_single is normally supposed to fail on the 
> uart device as the dma_mask value should be zero. Not sure why this 
> worked.
> 
> > +	if (!dma_phys) {
> > +		dev_err(sport->port.dev, "Dma_phys single failed\n");
> > +		return -ENOMEM;
> > +	}
> 
> Please also change all references to "phys" -- it's not a phys address 
> but a bus address. These are often the same, but that's not for the 
> driver to know.

This is also not how you test for failure of dma_map_single().  I recommend reading the documentation for the APIs you're trying to use...  Hint: dma_mapping_error().

--
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
