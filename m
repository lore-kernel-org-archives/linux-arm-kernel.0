From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 May 2012 15:29:41 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120511141835.GF3960@opensource.wolfsonmicro.com>
References: <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510094205.GM3908@opensource.wolfsonmicro.com>
 <1336647675.15424.390.camel@vkoul-udesk3>
 <20120511140710.GC6220@n2100.arm.linux.org.uk>
 <20120511141835.GF3960@opensource.wolfsonmicro.com>
Message-ID: <20120511142941.GA16214@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 03:18:35PM +0100, Mark Brown wrote:
> On Fri, May 11, 2012 at 03:07:10PM +0100, Russell King - ARM Linux wrote:
> > On Thu, May 10, 2012 at 04:31:15PM +0530, Vinod Koul wrote:
> > > This should not be in ASoC library. The driver should be able to detect
> > > if a tasklet was called for many dma completions and notify the client
> > > (soc-lib) accordingly.
> 
> > No.  Think about the cyclic case.  How do you correctly record how many
> > 'periods' have completed so that when your tasklet eventually gets called,
> > you call its callback the correct number of times?
> 
> I do think that (separately to what ALSA does) if we're going to have a
> callback specified per request we really should make sure that they all
> get run as best as we can since the way the API is written people using
> non-cyclic transfers may run into the same surprise; for cyclic ones the
> issue you identify is very real though.

Please stop confusing non-cyclic with cyclic transfers.  We know what the
required semantics are for non-cyclic transfers and they really aren't
under discussion here.  I'm focusing 100% on the cyclic case here.

> > It is my opinion that having this emulation of the current position in
> > soc-dmaengine-pcm is not only causing a wrong direction to be taken here,
> > but is potentially causing inefficiency by forcing conditions into the API
> > which we really don't need.
> 
> I agree entirely, it's clearly just a bodge for not being able to read
> the position and we'd be better off fixing that.
> 
> > > One way to do this would be to ensure that the descriptor is marked in
> > > irq_handler and then all descriptor completed notified in tasklet.
> 
> > No.  You're assuming that for each IRQ you have the tasklet run exactly
> > once.  There is no such guarantee.
> 
> I think the intention here was that the framework keep a list of all
> pending transfers and then in the tasklet it runs through all the
> completions up to the most recent one rather than only completing the
> most recent one.  Easier said than done for cyclic of course...

That's my point.  And keeping count of N times to call the callback in
the DMA engine driver is racy at best.

Here's what I think.  I think the best solution for cyclic transfers
is as follows:

1. The callback will be guaranteed to be called at least _once_ when one
   or more periods have expired.

2. There may be fewer callbacks issued than periods have expired.

3. All DMA engine drivers supporting cyclic transfers *must* without
   exception implement the residue in their tx_status function.

4. The residue returned _must_ be the number of bytes between the next
   byte to be read or written by DMA to/from memory and the end of the
   buffer - more explicitly, according to this mathematics:
	buffer_dma_start_address + buffer_size - next_dma_address

5. Users of DMA engine cyclic transfers are expected to use the tx_status
   function to determine how many periods have completed on each callback
   if this information matters to their operation.
