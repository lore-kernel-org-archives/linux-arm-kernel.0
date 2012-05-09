From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 10:33:34 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
Message-ID: <20120509093334.GS26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 11:27:17AM +0200, Linus Walleij wrote:
> On Wed, May 2, 2012 at 6:27 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> >> > What is the desired behaviour of the callback for cyclic DMA?
> >>
> >> Typically cyclic DMA is used in the case of sound. This is where alsa
> >> expects the "period" callback for every DMA period.
> >> Generally, such notification serves the purpose of letting client know
> >> that one "block" has been completed.
> >
> > Yes, though as we have this interface as something generic I didn't want
> > to call it "the alsa dma interface".
> 
> There is a DMAengine helper in ALSA SoC these days,
> sound/soc/soc-dmaengine-pcm.c which does not yet include
> get position calls, but I expect that's where the ALSA glue will
> end up.

I'm more or less ignoring that because with current DMA engine stuff, it's
buggy.  The presence of such a user doesn't really define how this
interface supposed to work either.

> >> IIRC had pointed Lars to this API, but quick check of code reveals that
> >> this is unused. I think returning residue as remaining bytes of current
> >> "block" makes sense. This easily gives knowledge of where DMA pointer is
> >> wrt current ongoing transaction. Was that your meaning of end of cyclic
> >> buffer, not sure what end means here?
> >
> > I think the residue thing was something Linus created, which is why he's
> > included in this thread...
> 
> Lars-Peter Clausen is the person writing the ALSA SoC wrapper.
> Lars-Peter: do you have plans to implement residue calls for
> getting buffer position?
> 
> It was originally created to be able to use DMA for ALSA SoC on
> the U300. I still don't know if there is some other viable usecase
> but I expect that things like multimedia codecs would use a DMA
> engine much the same way.

Given that counting the number of period callbacks to determine the
position is buggy, soc-dmaengine-pcm.c is buggy as it currently stands.
I'm willing to bet that if ALSA requests a small period size, and you
load a system up with lots of activity, you'll eventually hear
corrupted audio.

It's difficult to test because the corruption will probably only be
occasional and it'll be purely audio based - it'll basically play the
bit of the buffer that's currently being loaded with new data from time
to time because ALSAs idea of where the DMA is vs where the hardware
is will gradually slip over time.
