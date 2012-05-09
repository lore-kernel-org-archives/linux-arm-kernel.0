From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 12:16:15 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120509093334.GS26481@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
Message-ID: <20120509111614.GH3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 10:33:34AM +0100, Russell King - ARM Linux wrote:
> On Wed, May 09, 2012 at 11:27:17AM +0200, Linus Walleij wrote:

> > There is a DMAengine helper in ALSA SoC these days,
> > sound/soc/soc-dmaengine-pcm.c which does not yet include
> > get position calls, but I expect that's where the ALSA glue will
> > end up.

> I'm more or less ignoring that because with current DMA engine stuff, it's
> buggy.  The presence of such a user doesn't really define how this
> interface supposed to work either.

We need to at least include it in the fixes; I'm currently insisting
that any dmaengine based device uses it.  If we can't come up with a
standard library to map the dmaengine based DMA controllers to the ALSA
userspace API something is seriously wrong.  We definitely shouldn't be
treating it as an API reference but we should be ensuring that it does
the best possible job with the APIs that do exist and enhancing the
underlying APIs if that's needed.

Looking at the code the current usage doesn't seem obviously wrong so
there's some work to do - we get a callback assigned on each descriptor
we submit so it's a bit surprising that this might not get delivered,
though as has been discussed further up the thread that's something that
might actually happen and perhaps we need to clarify the interfaces
here.

> Given that counting the number of period callbacks to determine the
> position is buggy, soc-dmaengine-pcm.c is buggy as it currently stands.
> I'm willing to bet that if ALSA requests a small period size, and you
> load a system up with lots of activity, you'll eventually hear
> corrupted audio.

> It's difficult to test because the corruption will probably only be
> occasional and it'll be purely audio based - it'll basically play the
> bit of the buffer that's currently being loaded with new data from time
> to time because ALSAs idea of where the DMA is vs where the hardware
> is will gradually slip over time.

Right, any driver relying on this code must currently be confident that the
completion callbacks can actually be delivered before the next period
expires (for example, by requiring a large enough period size and
ensuring that the completion gets delivered in hard IRQ context on the
DMA side so there's less impact from load).  This might break down under
extreme loads, though if it does I rather suspect that we'd underflow
anyway.

If we can resolve the issues with reading the current position in
dmaengine then this should be fairly simple to address more
comprehensively of course, though there will be some hardware imposed
limits on what we can do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/1bc521af/attachment-0001.sig>
