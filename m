From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 26 Aug 2014 18:15:39 +0800
Subject: [PATCH 1/6] ARM: dts: microsom-ar8035: MDIO pad must be set open
 drain
In-Reply-To: <53F9B416.5030907@gmail.com>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7M1-0002yD-K3@rmk-PC.arm.linux.org.uk> <53F9B416.5030907@gmail.com>
Message-ID: <20140826101538.GA28777@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 10:44:54AM +0100, Iain Paton wrote:
> On 23/08/14 10:11, Russell King wrote:
> > From: Rabeeh Khoury <rabeeh@solid-run.com>
> > To: Shawn Guo <shawn.guo@freescale.com>
> > 
> > MDIO pad must be set open drain.
> > 
> > Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> > index d16066608e21..db9f45b2c573 100644
> > --- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> > @@ -17,7 +17,7 @@
> >  	enet {
> >  		pinctrl_microsom_enet_ar8035: microsom-enet-ar8035 {
> >  			fsl,pins = <
> > -				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
> > +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
> >  				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> >  				/* AR8035 reset */
> >  				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0
> > 
> 
> Can you elaborate some more on the reasons for this?  

I just got the following text from Rabeeh explaining the change.

"This patch is important for the MicroSOM implementation due to the
following details -

1. VIH of the Atheros phy is 1.7V.
2. NVCC_ENET which is the power domain of the MDIO pad is driven by the
   PHY's LDO (i.e. either 1.8v or 2.5v).
3. The MicroSOM implements an onbouard 1.6kohm pull up to 3.3v (R3000).

In the case the PHY's LDO was 1.8v then there would be only a 100mV
margin for the signal to be acknowledged as high (1.8v-1.7v).
Due to that setting the pad as an open drain will let the 1.6kohm pull
that signal high to 3.3 that assures enough margins to the PHY to be
acked as '1' logic.

Notice that this change is not required to the SabreSD boards since that
hardware drives the NVCC_EIM power island from a 3.3v power rail."

> 
> I'd like to understand if it's something specific to the hardware on that 
> board, or if other i.MX6 boards using the ar8035 are doing it wrong as well.

So from text above, it's a MicroSOM board specific change, I think.

Shawn

> 
> The datasheet strongly suggests this is the correct thing to do as MDIO 
> should electrically be open drain. However that suggests many more instances 
> of this incorrect configuration exist which also need changed, and not just 
> for ar8035.
> 
> While I'm reluctant to attribute something like this to the fec/interrupt 
> problems some people are seeing, I'd also like to be able to rule it out.
> 
> 
