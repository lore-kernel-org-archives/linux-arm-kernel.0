From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 May 2014 18:12:19 +0100
Subject: [PATCH v2 1/4] devicetree: bindings: Properly document micrel
 ks8851 SPI chips
In-Reply-To: <20140528151646.GU20155@pengutronix.de>
References: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
 <1400875040-13269-2-git-send-email-sboyd@codeaurora.org>
 <20140524124858.GR22111@sirena.org.uk>
 <5385063F.30407@codeaurora.org>
 <20140528151646.GU20155@pengutronix.de>
Message-ID: <20140528171219.GD5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 05:16:46PM +0200, Uwe Kleine-K?nig wrote:
> On Tue, May 27, 2014 at 02:40:15PM -0700, Stephen Boyd wrote:
> > On 05/24/14 05:48, Mark Brown wrote:

> > > So, according to the datasheet I managed to find this device has a
> > > supply VDD_IO (so normally written vdd-io-supply here), some other
> > > supplies which are tied to VDD_IO (so can probably be omitted) and a
> > > supply VDD_A3.3 none of which are optional.  There is an internal
> > > regulator which can be used to drop a higher voltage VDD_IO down for
> > > some of the supplies tied to it but that's essentially a noop from
> > > software as far as I can tell.  None of these supplies are obviously
> > > optional, though I've not read the datasheet in detail so I may have
> > > missed something here.

> There is a difference between the supply being optional for the hardware
> to work and the need to specify it in the device tree, isn't it? My
> expectation is that when it's not specified there is just nothing the
> the software needs to care for. 

If the supply must always be physically present the bindings should be
specified as it being mandatory and the code written in that fashion; as
an extension Linux will put a dummy in but this is attempting to handle
incorrect DTs.  This means we have functional error handling in cases
where there is something to worry about and simplifies the code using
the regulator.

regulator_get_optional() should *only* be used if the supply may be
omitted from the physical design and should generally always be
accompanied by code which does something substantially different such as
using an internal regulator or changing the source for a reference
voltage instead.

> > > That said it looks like this is intended to be a supply for an external
> > > PHY rather than the device itself, but even so my original question
> > > about it being able to operate without power still applies.  Looking at
> > > the code it's certainly not doing any of the handling of a missing
> > > supply that I would associate with using _optional().

> > I agree, both supplies don't look optional. Unfortunately
> > efm32gg-dk3750.dts doesn't look to be listing any supply, and this
> > driver only recently got support for the VDD_A3.3 supply that the omap
> > board uses (adding Uwe for any comments on efm setup). I presume on

> If I read the schematic correctly there is nothing to regulate on the
> efm32 dev board. If you want to take a look on the schematic yourself,
> it's contained in the documentation package available at
> http://www.silabs.com/products/mcu/lowpower/pages/efm32gg-dk3750.aspx .
> BDR3201A_A02_sch.pdf, page 3 of 22.

That shows all the supplies connected to fixed voltage regulators
(including the internal 1.8V LDO); the device tree should represent this
accurately though the internal 1.8V regulator could be omitted for
simplicity.  It would be a remarkable device that was able to operate
without power.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/de74c033/attachment.sig>
