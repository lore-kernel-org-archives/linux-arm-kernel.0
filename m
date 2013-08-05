From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 19:59:22 +0100
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <51FFEB97.30004@gmail.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <20130805140729.GC9858@sirena.org.uk>
 <51FFBF03.1000507@gmail.com> <20130805165957.GT9858@sirena.org.uk>
 <51FFEB97.30004@gmail.com>
Message-ID: <20130805185922.GC9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 08:14:47PM +0200, Sebastian Hesselbarth wrote:
> On 08/05/2013 06:59 PM, Mark Brown wrote:

> >The clocking arrangements are an example of why the boards can get
> >interesting enough to describe for themselves.

> I understand there are complex arrangements, I still don't think that
> you need a global super-node to describe them. Anyway, I am not voting
> against a super-node.

Please look back through the list archives, we've been round this loop
repeatedly.

> >>Also, all those "nvidia," properties would have fit very well into the
> >>i2s controller node

> >No, almost none of them have any place there.  For example, the audio
> >routing contains only connections to the CODEC so the I2S controller
> >isn't in play, the headphone detection is connected to the AP but isn't
> >connected to the I2S port.

> From a quick look in tegra30_hub.h, I can see configuration registers
> i2s formatting. I assume that i2s controller on Tegra can therefore
> directly connected to a I2S codec, can't it? Then, with an existing i2s
> node and an existing codec node - why is there no place to link both?

At a minimum we'd need to figure out which end of the link to put it on
and what to do about multi-drop links or links which share some or all
of the clocks but have split data lines.

> I can think of use cases that are hard to describe in a link-to-link
> way, but none of them really requires a super-node nor special
> board-specific compatible strings. With that we can just have the root
> DT node be compatible with Beaver above and register all the old
> platform_device way.

It's just plain good practice to have some way to figure out which board
we're running on.

> [...]
> >>I learned to never match "device nodes" with "drivers" as there
> >>is simply no relation between them.

> >That's clearly a thinko for device node.

> I assume with "thinko" you mean "thought wrong" - IMHO the above
> statement is very true. If it wouldn't, why not just have a node for
> kirkwood-dma and kirkwood-i2s instead of merging the drivers?
> You think that will also be accepted by DT maintainers?

We don't have a node for the DMA driver because it's just a software
wrapper for the DMA controller.  We do have a node for the board because
it's an actual physical thing that we can point at, the board driver is
representing the audio subsystem schematic.

> > From my point of view I'd rather not be shoving vendor prefixes on all
> >the properties, this is coming from DT convention requiring vendor
> >prefixes on bindings.

> I understand that those vendor prefixes are part of the helper
> functions of ASoC. But no other subsystem has a similar approach but

No?  I can't parse what you're saying here at all.

> though of properties generic enough to help drivers find what they
> need to know. Either ASoC is mis-interpreting the vendor-prefix
> requirement - or all other subsystems are.

This isn't me, this is people like Stephen (who's one of the DT
guys...).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/f1e2979e/attachment.sig>
