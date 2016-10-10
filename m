From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 10 Oct 2016 14:50:21 +0200
Subject: [PATCH v4 04/10] ARM: dts: sun8i-h3: Add dt node for the syscon
 control module
In-Reply-To: <20161010123151.GI3462@lukather>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
 <1475828757-926-5-git-send-email-clabbe.montjoie@gmail.com>
 <20161010123151.GI3462@lukather>
Message-ID: <20161010145021.00586f772e3398833217796a@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Oct 2016 14:31:51 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
> 
> On Fri, Oct 07, 2016 at 10:25:51AM +0200, Corentin Labbe wrote:
> > This patch add the dt node for the syscon register present on the
> > Allwinner H3.
> > 
> > Only two register are present in this syscon and the only one useful is
> > the one dedicated to EMAC clock.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > index 8a95e36..1101d2f 100644
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > @@ -140,6 +140,11 @@
> >  		#size-cells = <1>;
> >  		ranges;
> >  
> > +		syscon: syscon at 01c00000 {
> > +			compatible = "syscon";
> 
> It would be great to have a more specific compatible here in addition
> to the syscon, like "allwinner,sun8i-h3-system-controller".

The System Control area is just like the PRCM area: it would be simpler
to define the specific registers in the associated drivers.

Here, instead of the syscon node, plus

+		emac: ethernet at 1c30000 {
+			compatible = "allwinner,sun8i-h3-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x104>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
			...

there would be no 'syscon' node and

+		emac: ethernet at 1c30000 {
+			compatible = "allwinner,sun8i-h3-emac";
+			syscon = <&syscon>;
+			reg =	<0x01c30000 0x104>,	/* EMAC */
+				<0x01c00030 4>;		/* system control */
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
			...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
