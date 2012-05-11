From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 11 May 2012 08:30:14 +0530
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120510225429.GG12727@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <20120504122611.GE26481@n2100.arm.linux.org.uk>
 <1336135550.1540.2.camel@vkoul-udesk3>
 <20120510225429.GG12727@n2100.arm.linux.org.uk>
Message-ID: <1336705214.15424.1369.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-10 at 23:54 +0100, Russell King - ARM Linux wrote:
> On Fri, May 04, 2012 at 06:15:50PM +0530, Vinod Koul wrote:
> > On Fri, 2012-05-04 at 13:26 +0100, Russell King - ARM Linux wrote:
> > > On Wed, May 02, 2012 at 05:27:02PM +0100, Russell King - ARM Linux wrote:
> > > > On Wed, May 02, 2012 at 09:31:15PM +0530, Vinod Koul wrote:
> > > > > From what I understand (Dan please correct me as you may know this much
> > > > > better than me), the tx_status tells you wrt passed cookie what is the
> > > > > status. Further, (as you pointed), it also tells you which is last
> > > > > completed cookie and what is the current "running". And wrt the
> > > > > currently "running" cookie it tells you how may bytes are left.
> > > > 
> > > > That means we have a number of buggy drivers on both sides of the API...
> > > > PL08x for example always total up all the pending bytes from the position
> > > > in the current descriptor to the last issued descriptor.  Many other
> > > > implementations simply always return zero.
> > > 
> > > Right, as there's been no reply on this, I'll see about changing PL08x
> > > and SA11x0 to do exactly this.  I'll also see about implementing it in
> > > the new OMAP DMA engine driver.
> > > 
> > > The semantics I intend to implement are:
> > > 
> > > If the cookie has completed successfully, the residue will be zero.  If
> > > it is queued, it will be the number of bytes in the descriptor identified
> > > by the cookie.  If it is in progress, it will be the number of bytes yet
> > > to be transferred.
> > Today is is supposed to be defined as:
> > * @residue: the remaining number of bytes left to transmit
> > *      on the selected transfer for states DMA_IN_PROGRESS and
> > *      DMA_PAUSED if this is implemented in the driver, else 0
> > So what you are saying is correct and already documented.
> 
> BTW.  Not quite - it's ambiguous, and we really must get rid of that
> 'else 0' clause there and require it to be implemented if we're going
> to end up with users of the DMA engine API using it.
> 
> The statement also implies that a pending transfer should return a
> residue of zero.  Is that really consistent with what we want this
> API to do?
> 
> It also talks about 'bytes left to transmit'.  That could be interpreted
> strictly as the number of bytes to be transferred from the DMA engine
> to the peripheral, or from the DMA engine to memory.  That's not quite
> the same as calculating the residue off the DMA address pointer.
Yes this needs to be mandatory. Let me add that explicitly.

  * @last: last completed DMA cookie
  * @used: last issued DMA cookie (i.e. the one in progress)
- * @residue: the remaining number of bytes left to transmit
- *     on the selected transfer for states DMA_IN_PROGRESS and
- *     DMA_PAUSED if this is implemented in the driver, else 0
+ * @residue: is defined as:
+ *   - for completed descriptor: 0
+ *   - for descriptors which are in DMA_PAUSED, DMA_IN_PROGRESS:
+ *     length - (current_addr - start_addr), where:
+ *             length = descriptor dma length
+ *             current_addr = current dma pointer queried for dma channel
+ *             start_addr: starting address of this descriptor
+ *   This is mandatory and needs to be correctly filled by driver
  */
Does this make it clear?


-- 
~Vinod
