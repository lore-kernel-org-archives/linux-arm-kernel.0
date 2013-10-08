From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 8 Oct 2013 09:28:52 +0530
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <Pine.LNX.4.64.1310072235360.27047@axis700.grange>
References: <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
 <Pine.LNX.4.64.1310071409080.20796@axis700.grange>
 <20131007142511.GJ2954@intel.com>
 <Pine.LNX.4.64.1310071725300.20796@axis700.grange>
 <20131007154854.GM2954@intel.com>
 <Pine.LNX.4.64.1310072235360.27047@axis700.grange>
Message-ID: <20131008035852.GP2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 10:43:51PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 7 Oct 2013, Vinod Koul wrote:
> 
> > On Mon, Oct 07, 2013 at 05:28:37PM +0200, Guennadi Liakhovetski wrote:
> > > > > > > > No, not something in the middle. I was thinking about
> > > > > > > > 
> > > > > > > > (1) cookie 1-3 are submitted
> > > > > > > > (2) cookie 1 succeeds
> > > > > > > > (3) a DMA error occurs, cookies 2-3 are discarded
> > > > > > discarded using terminate_all right?
> > > > > 
> > > > > No, by the dmaengine driver as a part of the error processing.
> > > > And how will that be done...?
> > > 
> > > Sorry, I meant - DMA descriptors with cookies #2 and #3 will be cancelled 
> > > and recycled by the dmaengine driver. That's what you have to do, when 
> > > processing DMA error IRQ.
> > well the term cancel means someone went ahead and requested abort/terminate of a
> > transaction...
> > 
> > As we discussed in other mail on this thread the most common occurrence will be
> > timeout on client side and client cant cancel selectively.
> > 
> > For dma driver detection error, which is quite rare in slave usages, if people
> > think its common for them we cna indicate this thru status in callback. Then
> > client will know and doesnt need to query.
> > 
> > Recycling cookie has a large space so i dont think we will get confused
> > with a recycled one
> 
> If you reset cookies, as you proposed, IMHO, this can very well lead to a 
> confusion: suppose cookie #1000 caused an error. We drop queued transfers 
> with cookies #1001-1005 and reset to #1. When we're at #100 the user asks 
> for a status of cookie #1003, which we have aborted. However, the 
> following check in dma_async_is_complete():
Well you are missing an important point. Who is doing abort. It is the client
driver, the user.
And as i said previously before calling terminate_all he will forget about the
cookies allocated previosuly, So after that he cant invoke any of the old
cookie. If he is, then that is wrong and needs to be fixed :)

So while user is dealing with new transactions (cookies), he doesnt know
anything about old ones and cant query as in above example 1003!
> 
> 	if (last_complete <= last_used) {
> 		if ((cookie <= last_complete) || (cookie > last_used))
> 			return DMA_SUCCESS;
> 
> will confirm success to the user.
Not in above example!, if you are at #100, query for #1003 will return
DMA_IN_PROGRESS.

--
~Vinod
