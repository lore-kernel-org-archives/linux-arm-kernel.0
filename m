From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 09:39:22 +0100
Subject: [PATCH v2] serial: pl011: Add Device Tree support to request DMA
 channels
In-Reply-To: <20130418081811.GF14496@n2100.arm.linux.org.uk>
References: <1366272857-14038-1-git-send-email-lee.jones@linaro.org>
 <20130418081811.GF14496@n2100.arm.linux.org.uk>
Message-ID: <20130418083922.GC3137@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Apr 2013, Russell King - ARM Linux wrote:

> On Thu, Apr 18, 2013 at 09:14:16AM +0100, Lee Jones wrote:
> > @@ -269,7 +270,10 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
> >  	dma_cap_zero(mask);
> >  	dma_cap_set(DMA_SLAVE, mask);
> >  
> > -	chan = dma_request_channel(mask, plat->dma_filter, plat->dma_tx_param);
> > +	chan = dma_request_slave_channel_compat(mask,
> > +				(plat) ? plat->dma_filter : NULL,
> > +				(plat) ? plat->dma_tx_param : NULL,
> > +				uap->port.dev, "tx");
> >  	if (!chan) {
> >  		dev_err(uap->port.dev, "no TX DMA channel!\n");
> >  		return;
> 
> This suffers the same problem with your MMCI patch.  If you're using DT and
> don't provide the DMA information, you get errors printed.  That's not on
> for an optional driver feature, especially when that feature causes
> functional difficulties on various platforms and so is _purposely_ omitted.

How does that differ from using pdata and not passing DMA information?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
