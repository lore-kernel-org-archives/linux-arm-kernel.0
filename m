From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 11:40:57 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120502144555.GA4456@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
Message-ID: <20120507104057.GB2132@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 03:45:55PM +0100, Russell King - ARM Linux wrote:

> Alternatively, we could document that for cyclic transfers, one callback
> will be made after the expiry of a period or number of periods.  In
> other words, if two periods expire before we issue the callback, the
> user will only get _one_ callback issued.  In that case, we definitely
> need some way to determine the DMA position...

One callback is fine for audio providing it's possible to read the
position to at least some extent.  If we've been delayed long enough to
miss delivering the callback then we've already lost anyway and things
should recover as well as they're going to by just looking at the
postition.

> useful.  What would be more useful is if this was defined as the number
> of bytes to the end of the cyclic buffer - or something similar.  That
> then would allow the current DMA position to be determined for applications
> like ASoC to know how much of the buffer it could refill with new data.

Yes, ideally we'd want to know where we are in the buffer.  In practice
all some hardware can give you is the last buffer processed but that
should be adequate providing the cycle can be split into multiple
buffers but that's going to be required anyway for audio.
