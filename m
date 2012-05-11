From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 May 2012 15:18:35 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120511140710.GC6220@n2100.arm.linux.org.uk>
References: <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510094205.GM3908@opensource.wolfsonmicro.com>
 <1336647675.15424.390.camel@vkoul-udesk3>
 <20120511140710.GC6220@n2100.arm.linux.org.uk>
Message-ID: <20120511141835.GF3960@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 03:07:10PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 10, 2012 at 04:31:15PM +0530, Vinod Koul wrote:
> > This should not be in ASoC library. The driver should be able to detect
> > if a tasklet was called for many dma completions and notify the client
> > (soc-lib) accordingly.

> No.  Think about the cyclic case.  How do you correctly record how many
> 'periods' have completed so that when your tasklet eventually gets called,
> you call its callback the correct number of times?

I do think that (separately to what ALSA does) if we're going to have a
callback specified per request we really should make sure that they all
get run as best as we can since the way the API is written people using
non-cyclic transfers may run into the same surprise; for cyclic ones the
issue you identify is very real though.

> It is my opinion that having this emulation of the current position in
> soc-dmaengine-pcm is not only causing a wrong direction to be taken here,
> but is potentially causing inefficiency by forcing conditions into the API
> which we really don't need.

I agree entirely, it's clearly just a bodge for not being able to read
the position and we'd be better off fixing that.

> > One way to do this would be to ensure that the descriptor is marked in
> > irq_handler and then all descriptor completed notified in tasklet.

> No.  You're assuming that for each IRQ you have the tasklet run exactly
> once.  There is no such guarantee.

I think the intention here was that the framework keep a list of all
pending transfers and then in the tasklet it runs through all the
completions up to the most recent one rather than only completing the
most recent one.  Easier said than done for cyclic of course...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120511/03e91aff/attachment.sig>
