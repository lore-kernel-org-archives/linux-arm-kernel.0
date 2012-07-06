From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jul 2012 21:57:31 +0100
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FE896F9.2020806@ti.com> <1340647463.1562.127.camel@vkoul-udesk3>
 <201206252030.56025.arnd@arndb.de>
 <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
Message-ID: <20120706205731.GA31585@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 01:36:32PM +0200, Guennadi Liakhovetski wrote:
> I like this idea, but why don't we extend it to also cover the non-DT 
> case? I.e., why don't we add the above callback (call it "match" or 
> "filter" or anything else) to dmaengine operations and inside (the 
> extended) dma_request_channel(), instead of calling the filter function, 
> passed as a parameter, we loop over all registered DMAC devices and call 
> their filter callbacks, until one of them returns true? In fact, it goes 
> back to my earlier proposal from 
> http://thread.gmane.org/gmane.linux.kernel/1246957
> which I, possibly, failed to explain properly. So, the transformation 
> chain from today's API would be (all code is approximate):
> 
> (today)
> 
> <client driver>
> 	dma_request_channel(mask, filter, filter_arg);
> 
> <dmaengine_core>
> 	for_each_channel() {
> 		ret = (*filter)(chan, filter_arg);
> 		if (ret) {
> 			ret = chan->device->device_alloc_chan_resources(chan);
> 			if (!ret)
> 				return chan;
> 			else
> 				return NULL;
> 		}
> 	}
> 
> (can be transformed to)
> 
> <client driver>
> 	dma_request_channel(mask, filter_arg);
> 
> <dmaengine_core>
> 	for_each_channel() {
> 		ret = chan->device->filter(chan, filter_arg);
> 		if (ret) {
> 			<same as above>
> 		}
> 	}
> 
> (which further could be simplified to)
> 
> <client driver>
> 	dma_request_channel(mask, filter_arg);
> 
> <dmaengine_core>
> 	for_each_channel() {
> 		ret = chan->device->device_alloc_chan_resources(chan, filter_arg);

This looks like you're re-purposing a perfectly good API for something that
it wasn't designed to do, namely providing a channel selection mechanism,
rather than "allocating channel resources".  The hint is in the bloody
name, please take a look sometime!

If you want to call into the DMA engine driver for channel selection,
then create an _explicit_ API for it.  Don't bugger around with existing
APIs.

Moreover, the *big* problem that your proposal above creates is this.
What _type_ is filter_arg?  If it's void *, then your suggestion is
nonsense, even if you associate it with a size argument.  You have no
idea what the bytestream that would be passed via that pointer means,
even if the size just happens to look like it's what you expect.

If it's something else, then your mistake above was not defining it, so
there's no way to evaluate your proposal given that lack of critical
information.  And if you define it, whatever you come up with _must_
be suitable for every single DMA engine driver we have today.
