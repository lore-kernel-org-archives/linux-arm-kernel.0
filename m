From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 15:17:29 +0800
Subject: [PATCH 2/2] ARM: dts: imx6q-udoo: Add USB host support
In-Reply-To: <20131202115303.GH12952@e106331-lin.cambridge.arm.com>
References: <1384394987-15134-1-git-send-email-festevam@gmail.com>
 <1384394987-15134-2-git-send-email-festevam@gmail.com>
 <20131202115303.GH12952@e106331-lin.cambridge.arm.com>
Message-ID: <20131203071727.GC10840@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 11:53:03AM +0000, Mark Rutland wrote:
> On Thu, Nov 14, 2013 at 02:09:47AM +0000, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Udoo board has USBH1 port connected to a USB2514 hub.
> > 
> > Add support for it.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6q-udoo.dts | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/imx6q-udoo.dts
> > index 1c7f7a1..109b997 100644
> > --- a/arch/arm/boot/dts/imx6q-udoo.dts
> > +++ b/arch/arm/boot/dts/imx6q-udoo.dts
> > @@ -19,6 +19,23 @@
> >  	memory {
> >  		reg = <0x10000000 0x40000000>;
> >  	};
> > +
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> 
> This should have a ranges property, or it's not a simple-bus.

You're right.  It's not a real bus.  We're having node 'regulators' be a
container for all those fixed regulators, so that we can put them
together and name them in the generic regulator at num way.

Since kernel does not refuse to probe 'simple-bus' that does not have
the 'ranges' property, we forgot about it.  This is the common pattern
used by a lot of existing DTS files.  If we want to improve the thing,
we may need to consider it as a global move.

Shawn

> 
> Why do you even need this anyway? The regulators can live under the root
> quite happily.
