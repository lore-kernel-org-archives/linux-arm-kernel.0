From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Apr 2015 11:49:26 +0200
Subject: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
In-Reply-To: <20150420204849.GJ14892@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
 <20150420204849.GJ14892@sirena.org.uk>
Message-ID: <20150421094926.GU6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 09:48:49PM +0100, Mark Brown wrote:
> On Mon, Apr 20, 2015 at 06:37:47AM +0200, Sascha Hauer wrote:
> > On Sat, Apr 18, 2015 at 06:34:07PM +0100, Mark Brown wrote:
> > > On Fri, Apr 10, 2015 at 04:14:07PM +0800, Koro Chen wrote:
> 
> > > > +Each external interface (called "IO" in this driver) is presented as a
> > > > +DAI to ASoC. An IO must be connected via the interconnect to a memif.
> > > > +The connection paths are configured through the device tree.
> 
> > > Why are these connection paths configured via device tree?  I would
> > > expect that either there would be runtime configurability of these
> > > things (particularly if loopback configurations within the hardware are
> > > possible) or we'd just allocate memory interfaces to DAIs automatically
> > > as DAIs come into use.
> 
> > There is a crossbar switch between the memory interfaces and the DAIs.
> > Not every connection is possible, so not every memory interface can be
> > used for every DAI. An algorithm choosing a suitable memory interface
> > must be quite clever, complicated and also SoC dependent (the same but
> > different hardware is used on MT8135 aswell), so I thought offering a
> > static configuration via device tree is a good start. Should there be
> > runtime configuration possible later the device tree settings could
> > provide a good default.
> 
> What exactly do the restrictions look like and how often do they vary in
> practice (can we get away with just doing a single static setup in the
> driver)? I'd have thought it should be fairly straightforward to have a
> table of valid mappings and just pick the first free memory interface?

I think this could be done. I checked the possible connections in the
crossbar switch and it seems all memory interfaces can be connected with
all relevant external interfaces. So indeed the memory interfaces could
be dynamically allocated instead of statically associated to an
external interface. There are two problems I see: Some memory interfaces
are limited in the rates they support, they can only do 8k/16k/32k (for
speech). How can we know such memory interface should be used? Also
there are two programmable hardware gain blocks which can be inserted to
the digital audio path using the crossbar switch. There must be some
mechanism to configure them into different places.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
