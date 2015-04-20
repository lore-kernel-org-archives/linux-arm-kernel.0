From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Apr 2015 21:48:49 +0100
Subject: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
In-Reply-To: <20150420043747.GH6325@pengutronix.de>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
Message-ID: <20150420204849.GJ14892@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 06:37:47AM +0200, Sascha Hauer wrote:
> On Sat, Apr 18, 2015 at 06:34:07PM +0100, Mark Brown wrote:
> > On Fri, Apr 10, 2015 at 04:14:07PM +0800, Koro Chen wrote:

> > > +Each external interface (called "IO" in this driver) is presented as a
> > > +DAI to ASoC. An IO must be connected via the interconnect to a memif.
> > > +The connection paths are configured through the device tree.

> > Why are these connection paths configured via device tree?  I would
> > expect that either there would be runtime configurability of these
> > things (particularly if loopback configurations within the hardware are
> > possible) or we'd just allocate memory interfaces to DAIs automatically
> > as DAIs come into use.

> There is a crossbar switch between the memory interfaces and the DAIs.
> Not every connection is possible, so not every memory interface can be
> used for every DAI. An algorithm choosing a suitable memory interface
> must be quite clever, complicated and also SoC dependent (the same but
> different hardware is used on MT8135 aswell), so I thought offering a
> static configuration via device tree is a good start. Should there be
> runtime configuration possible later the device tree settings could
> provide a good default.

What exactly do the restrictions look like and how often do they vary in
practice (can we get away with just doing a single static setup in the
driver)?  I'd have thought it should be fairly straightforward to have a
table of valid mappings and just pick the first free memory interface?
I'd rather not get stuck with the tables in the DT.  It's partly to
avoid setting bad precendents, we really don't want everyone coming
along hard coding this stuff, and partly because the hardware you
described didn't seem that hard to handle.

> > > +- mem-interface-playback:
> > > +  mem-interface-capture: property of memif, format is: <memif irq use_sram>;
> > > +	                 memif: which memif to be used
> > > +			        (defined in include/dt-bindings/sound/mtk-afe.h)
> > > +		         irq: which irq to be used
> > > +			      (defined in include/dt-bindings/sound/mtk-afe.h)
> > > +		         use_sram: 1 is yes, 0 is no

> > Again, this looks like stuff we should be able to figure out at runtime
> > - the use of SRAM in particular looks like something we might want to
> > change depending on use case.  Assuming it adds buffering then for a
> > VoIP application we might not want to use SRAM to minimize latency but
> > during music playback we might want to enable SRAM to minimize power
> > consumption.

> That's exactly the usecase. How could such a runtime configurability
> look like? sysfs? Or something based on the buffer sizes?

Yeah, one of those :) but probably an ALSA control is going to be the
easiest for applications.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150420/c4e99187/attachment.sig>
