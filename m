From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 03 Aug 2012 15:44:33 +0530
Subject: [PATCH/RFC 1/4] dma: add a function to request a DMA channel
 for a specific client
In-Reply-To: <Pine.LNX.4.64.1208021101350.11412@axis700.grange>
References: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
 <Pine.LNX.4.64.1207171242230.17060@axis700.grange>
 <1343284293.1726.8966.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1208021101350.11412@axis700.grange>
Message-ID: <1343988873.1726.14439.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-08-02 at 11:11 +0200, Guennadi Liakhovetski wrote:
> > > +           chan = device->mux->request_chan(device, dev, direction, name);
> > NAK
> > 
> > 1. We dont want dmacs to have anything to do with filtering and
> > allocating. That is role of dmaengien and we need to add stuff there
> > only.
> > 2. Even if we start using optional name argument here we still don't
> > know out of 4 channels dmac supports which one to allocate.
> 
> I don't think we can be generic enough in the dmaengine core to identify 
> which channels are suitable for all slave requests. This is why I proposed 
> a concept of a DMA channel multiplexer driver, and this is exactly what 
> this callback is. I tried to explain this in the patch description above. 
> I thought we discussed this earlier in this thread and agreed, that a 
> multiplexer API is the way to go with channel allocation. I think, I 
> mentioned in one of my mails, that in the beginning I wanted to implement 
> multiplexers as a proper (platform) device, but at least one problem with 
> this is, that at least on my hardware the multiplexer and the DMAC share 
> registers, and an MFD seems an overkill for this, but we can discuss this. 
> I don't know, whether there are systems, where multiplexers are really 
> separate hardware blocks, if there are, we can think of a way to handle 
> those nicely too.
I would disagree.

As I have said in past, we need the mapping information to be available
with dmaengine for slave channels even before any slave allocation
occurs. This way dmaengine knows what to do with a channel.
I am planning to add the support in dmanegine for this...

The problem with this solution here is again how the hell will a dmac
know what to do with alloc request. It doesn't and any current way it
does is just a hack and nothing else. This also prevenrts us form
building genric dmac driver which should only know how to deal with dmac
only and nothing else.

-- 
~Vinod
