From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Jan 2014 14:50:32 +0000
Subject: [PATCH] the eDMA support for the LPUART send driver
In-Reply-To: <201401051544.50036.arnd@arndb.de>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
 <201401051544.50036.arnd@arndb.de>
Message-ID: <20140105145031.GB27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 03:44:49PM +0100, Arnd Bergmann wrote:
> On Friday 27 December 2013, Yuan Yao wrote:
> > +	dma_phys = dma_map_single(sport->port.dev,
> > +				sport->port.state->xmit.buf,
> > +				UART_XMIT_SIZE, DMA_TO_DEVICE);
> 
> This is wrong: Since the dma is performed by the dma engine rather
> than the uart, the first argument here needs to be the dma device
> pointer. In fact, dma_map_single is normally supposed to fail on
> the uart device as the dma_mask value should be zero. Not sure
> why this worked.
> 
> > +	if (!dma_phys) {
> > +		dev_err(sport->port.dev, "Dma_phys single failed\n");
> > +		return -ENOMEM;
> > +	}
> 
> Please also change all references to "phys" -- it's not a phys
> address but a bus address. These are often the same, but that's
> not for the driver to know.

This is also not how you test for failure of dma_map_single().  I
recommend reading the documentation for the APIs you're trying to
use...  Hint: dma_mapping_error().

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
