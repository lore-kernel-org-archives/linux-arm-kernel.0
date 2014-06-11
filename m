From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jun 2014 11:04:21 +0200
Subject: [RFC PATCH] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <20140611081248.GS1701@ldesroches-Latitude-E6320>
References: <1401179736-8235-1-git-send-email-ludovic.desroches@atmel.com>
 <8696483.Dng95cR5kK@wuerfel>
 <20140611081248.GS1701@ldesroches-Latitude-E6320>
Message-ID: <4675005.TnHGXm92zV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 June 2014 10:12:48 Ludovic Desroches wrote:
> I have noticed that the filter function was missing in the RFC version.
> I had to add it since there are two xdma controllers in the system.
> 
> static bool at_xdmac_filter(struct dma_chan *chan, void *slave)                 
> {                                                                               
>         struct device *dma_dev = (struct device *) slave;                       
>                                                                                 
>         if (dma_dev == chan->device->dev)                                       
>                 return true;                                                    
>         else                                                                    
>                 return false;                                                   
> }

Yes, looks good. Note that you can save the typecast and just do

	struct device *dma_dev = slave; 
	if (chan->device->dev == dma_dev)
		...

or shorter

	if (chan->device->dev == slave)
		...

or shortest:

	return chan->device->dev == slave;

I find the shorter versions more readable here, but any of these
are correct.

	Arnd
