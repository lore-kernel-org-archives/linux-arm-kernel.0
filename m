From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 04 May 2012 18:15:50 +0530
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120504122611.GE26481@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <20120504122611.GE26481@n2100.arm.linux.org.uk>
Message-ID: <1336135550.1540.2.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-04 at 13:26 +0100, Russell King - ARM Linux wrote:
> On Wed, May 02, 2012 at 05:27:02PM +0100, Russell King - ARM Linux wrote:
> > On Wed, May 02, 2012 at 09:31:15PM +0530, Vinod Koul wrote:
> > > From what I understand (Dan please correct me as you may know this much
> > > better than me), the tx_status tells you wrt passed cookie what is the
> > > status. Further, (as you pointed), it also tells you which is last
> > > completed cookie and what is the current "running". And wrt the
> > > currently "running" cookie it tells you how may bytes are left.
> > 
> > That means we have a number of buggy drivers on both sides of the API...
> > PL08x for example always total up all the pending bytes from the position
> > in the current descriptor to the last issued descriptor.  Many other
> > implementations simply always return zero.
> 
> Right, as there's been no reply on this, I'll see about changing PL08x
> and SA11x0 to do exactly this.  I'll also see about implementing it in
> the new OMAP DMA engine driver.
> 
> The semantics I intend to implement are:
> 
> If the cookie has completed successfully, the residue will be zero.  If
> it is queued, it will be the number of bytes in the descriptor identified
> by the cookie.  If it is in progress, it will be the number of bytes yet
> to be transferred.
Today is is supposed to be defined as:
* @residue: the remaining number of bytes left to transmit
*      on the selected transfer for states DMA_IN_PROGRESS and
*      DMA_PAUSED if this is implemented in the driver, else 0
So what you are saying is correct and already documented.

> 
> Now, there is a bit of ambiguity over "number of bytes yet to be transferred"
> with DMA hardware which reads from memory into a FIFO, and then transfers
> to the peripheral when the peripheral requests DMA service.  Do we define
> it as the number of bytes read from memory, or the number of bytes to be
> transferred to the peripheral.
> 
> The latter may not be easy for DMA hardware to report to us... so my
> initial implementation will be number of bytes remaining calculated using
> the DMA address pointer into memory.
yes, it may not be possible to get this information, so lets take the
dma pointer in memory and do the math.

-- 
~Vinod
