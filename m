From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 May 2012 15:07:10 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <1336647675.15424.390.camel@vkoul-udesk3>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510094205.GM3908@opensource.wolfsonmicro.com>
 <1336647675.15424.390.camel@vkoul-udesk3>
Message-ID: <20120511140710.GC6220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 04:31:15PM +0530, Vinod Koul wrote:
> This should not be in ASoC library. The driver should be able to detect
> if a tasklet was called for many dma completions and notify the client
> (soc-lib) accordingly.

No.  Think about the cyclic case.  How do you correctly record how many
'periods' have completed so that when your tasklet eventually gets called,
you call its callback the correct number of times?

I think that's totally pointless and wasteful too from the ALSA core code
point of view - all the ALSA cares about is that "some periods have
completed" and ALSA will then ask the low level driver where the DMA is,
and update things according to the current DMA position.

It is my opinion that having this emulation of the current position in
soc-dmaengine-pcm is not only causing a wrong direction to be taken here,
but is potentially causing inefficiency by forcing conditions into the API
which we really don't need.

> One way to do this would be to ensure that the descriptor is marked in
> irq_handler and then all descriptor completed notified in tasklet.

No.  You're assuming that for each IRQ you have the tasklet run exactly
once.  There is no such guarantee.
