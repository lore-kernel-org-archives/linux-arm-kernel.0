From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Wed, 13 Apr 2016 20:39:32 +0000
Subject: [PATCH 2/2] arm64: dts: ls2080a: fsl-mc dt node updates
In-Reply-To: <20160413055019.GK28903@tiger>
References: <1459544080-28598-1-git-send-email-stuart.yoder@nxp.com>
 <20160413055019.GK28903@tiger>
Message-ID: <HE1PR04MB1641EB3DD445D3AF3F524C3D8D960@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Wednesday, April 13, 2016 12:50 AM
> To: Stuart Yoder <stuart.yoder@nxp.com>
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; mark.rutland at arm.com;
> german.rivera at freescale.com; linux-kernel at vger.kernel.org; robh+dt at kernel.org; Yang-Leo Li
> <leoyang.li@nxp.com>
> Subject: Re: [PATCH 2/2] arm64: dts: ls2080a: fsl-mc dt node updates
> 
> On Fri, Apr 01, 2016 at 03:54:40PM -0500, Stuart Yoder wrote:
> > From: Stuart Yoder <stuart.yoder@nxp.com>
> >
> > updates to the fsl-mc node for full functionality:
> >    -msi-parent is needed for interrupt support
> >    -ranges is needed to enable the bus driver to translate bus addresses
> >    -dpmac nodes provide a basis for relating dpmac objects to PHYs
> >
> > Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   87 ++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-
> ls2080a.dtsi
> > index 9d746c6..449c635 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > @@ -265,6 +265,93 @@
> >  			compatible = "fsl,qoriq-mc";
> >  			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
> >  			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> > +			msi-parent = <&its>;
> > +			#address-cells = <3>;
> > +			#size-cells = <1>;
> > +
> > +			/*
> > +			 * Region type 0x0 - MC portals
> > +			 * Region type 0x1 - QBMAN portals
> > +			 */
> > +			ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
> > +				  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
> > +
> > +			/*
> > +			 * Define the maximum number of MACs present on the SoC.
> > +			 * They won't necessarily be all probed, since the
> > +			 * Data Path Layout file and the MC firmware can put
> > +			 * fewer actual DPMAC objects on the MC bus.
> > +			 */
> > +			dpmacs {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				dpmac1: dpmac at 1 {
> > +					compatible = "fsl,qoriq-mc-dpmac";
> 
> I did not see how this compatible is used by kernel driver.

There is no driver yet, but it will be coming soon.  But, does
it matter?  Device trees should be describing hardware
without regards to some specific kernel use of a node or 
property.

> > +					reg = <1>;
> > +				};
> 
> Please have a newline between nodes.

Ok, will do.

Stuart
