From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 11 Jun 2014 10:12:48 +0200
Subject: [RFC PATCH] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <8696483.Dng95cR5kK@wuerfel>
References: <1401179736-8235-1-git-send-email-ludovic.desroches@atmel.com>
 <6544148.4RKn2Y8vCE@wuerfel>
 <20140611073525.GQ1701@ldesroches-Latitude-E6320>
 <8696483.Dng95cR5kK@wuerfel>
Message-ID: <20140611081248.GS1701@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 09:41:47AM +0200, Arnd Bergmann wrote:
> On Wednesday 11 June 2014 09:35:25 Ludovic Desroches wrote:
> > > > +     if (dma_spec->args_count != 2) {
> > > > +             dev_err(&pdev->dev, "dma phandler args: bad number of args\n");
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     dma_cap_zero(mask);
> > > > +     dma_cap_set(DMA_SLAVE, mask);
> > > > +     chan = dma_request_channel(mask, NULL, NULL);
> > > > +     if (!chan) {
> > > > +             dev_err(&pdev->dev, "can't get a dma channel\n");
> > > > +             return NULL;
> > > > +     }
> > > 
> > > You must use dma_get_any_slave_channel. dma_request_channel gives you a
> > > channel from a random dma engine that is present in the system, not
> > > necessarily the one you are managing here.
> > 
> > It is planned to use dma_get_any_slave_channel but currently I am doing
> > tests on a 3.10 kernel that's why I am still using dma_request_channel.
> 
> Ok, I see. The correct way to do this then would be to have a filter
> function that compares the channel's dmadevice pointer to the one
> you get from the of_dma_data pointer. Since you already plan to
> change this, and you probably know that there are no other engines
> in the system, maybe you can do it like this in the meantime:
> 
> 	/* FIXME: use dma_get_any_slave_chan to avoid the WARN_ON */
> 	if (!chan || WARN_ON(chan->device != dev)) {
> 		dev_err(&pdev->dev, "can't get a dma channel\n");
> 		return NULL;
> 	}
> 

I have noticed that the filter function was missing in the RFC version.
I had to add it since there are two xdma controllers in the system.

static bool at_xdmac_filter(struct dma_chan *chan, void *slave)                 
{                                                                               
        struct device *dma_dev = (struct device *) slave;                       
                                                                                
        if (dma_dev == chan->device->dev)                                       
                return true;                                                    
        else                                                                    
                return false;                                                   
}


Ludovic
