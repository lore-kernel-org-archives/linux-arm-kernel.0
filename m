From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 13:26:11 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120502162702.GE3548@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
Message-ID: <20120504122611.GE26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 05:27:02PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 02, 2012 at 09:31:15PM +0530, Vinod Koul wrote:
> > From what I understand (Dan please correct me as you may know this much
> > better than me), the tx_status tells you wrt passed cookie what is the
> > status. Further, (as you pointed), it also tells you which is last
> > completed cookie and what is the current "running". And wrt the
> > currently "running" cookie it tells you how may bytes are left.
> 
> That means we have a number of buggy drivers on both sides of the API...
> PL08x for example always total up all the pending bytes from the position
> in the current descriptor to the last issued descriptor.  Many other
> implementations simply always return zero.

Right, as there's been no reply on this, I'll see about changing PL08x
and SA11x0 to do exactly this.  I'll also see about implementing it in
the new OMAP DMA engine driver.

The semantics I intend to implement are:

If the cookie has completed successfully, the residue will be zero.  If
it is queued, it will be the number of bytes in the descriptor identified
by the cookie.  If it is in progress, it will be the number of bytes yet
to be transferred.

Now, there is a bit of ambiguity over "number of bytes yet to be transferred"
with DMA hardware which reads from memory into a FIFO, and then transfers
to the peripheral when the peripheral requests DMA service.  Do we define
it as the number of bytes read from memory, or the number of bytes to be
transferred to the peripheral.

The latter may not be easy for DMA hardware to report to us... so my
initial implementation will be number of bytes remaining calculated using
the DMA address pointer into memory.
