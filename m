From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 12 Feb 2014 11:20:55 +0100
Subject: [RFC PATCH 4/4] ARM: dts: imx6qdl: Add PU power-domain
 information to gpc node
In-Reply-To: <20140212072510.GI31484@S2101-09.ap.freescale.net>
References: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
 <1392125231-28387-5-git-send-email-p.zabel@pengutronix.de>
 <20140212072510.GI31484@S2101-09.ap.freescale.net>
Message-ID: <1392200455.5536.36.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 12.02.2014, 15:25 +0800 schrieb Shawn Guo:
> On Tue, Feb 11, 2014 at 02:27:11PM +0100, Philipp Zabel wrote:
> > The PGC that is part of GPC controls isolation and power sequencing of the
> > PU power domain. The power domain will be handled by the generic pm domain
> > framework and needs a phandle to the PU regulator to turn off power when
> > the domain is disabled.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index 253d82c..595750d 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -598,9 +598,17 @@
> >  			};
> >  
> >  			gpc: gpc at 020dc000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> >  				compatible = "fsl,imx6q-gpc";
> >  				reg = <0x020dc000 0x4000>;
> >  				interrupts = <0 89 0x04 0 90 0x04>;
> > +				pu-supply = <&reg_pu>;
> > +
> > +				pd_pu: power-domain at 020dc260 {
> > +					compatible = "fsl,power-domain";
> > +					reg = <0x020dc260 0x10>;
> > +				};
> 
> It's time to have a binding doc for gpc/pgc?

Yes, I'll add one for the next version.

> And I'm not sure
> "fsl,power-domain" is a good compatible as it's so generic.

fsl,imx6q-power-domain ?

Currently there is no need for a compatible property at all, since this
node is just used as a phandle target.
Even the 0x260 register offset is hardcoded in the driver, but this
might change when imx6sl support is added.

regards
Philipp
