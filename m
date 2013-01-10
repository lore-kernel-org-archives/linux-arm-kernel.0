From: mporter@ti.com (Matt Porter)
Date: Thu, 10 Jan 2013 14:27:40 -0500
Subject: [RFC PATCH v3 08/16] ARM: dts: add AM33XX EDMA support
In-Reply-To: <508D1414.2000506@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-9-git-send-email-mporter@ti.com>
 <508D1414.2000506@ti.com>
Message-ID: <20130110192740.GO14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 04:46:36PM +0530, Sekhar Nori wrote:
> On 10/18/2012 6:56 PM, Matt Porter wrote:
> > Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> > Documentation/devicetree/bindings/dma/ti-edma.txt
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> >  arch/arm/boot/dts/am33xx.dtsi |   31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index bb31bff..ab9c78f 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -62,6 +62,37 @@
> >  			reg = <0x48200000 0x1000>;
> >  		};
> >  
> > +		edma: edma at 49000000 {
> > +			compatible = "ti,edma3";
> > +			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > +			reg =	<0x49000000 0x10000>,
> > +				<0x44e10f90 0x10>;
> > +			interrupt-parent = <&intc>;
> > +			interrupts = <12 13 14>;
> > +			#dma-cells = <1>;
> > +			dma-channels = <64>;
> > +			ti,edma-regions = <4>;
> > +			ti,edma-slots = <256>;
> > +			ti,edma-reserved-channels = <0  2
> > +						     14 2
> > +						     26 6
> > +						     48 4
> > +						     56 8>;
> > +			ti,edma-reserved-slots = <0  2
> > +						  14 2
> > +						  26 6
> > +						  48 4
> > +						  56 8
> > +						  64 127>;
> 
> No need to reserve any channels or slots on AM335x, I think. This is
> used on DaVinci devices to share channels with DSP. I am not sure the
> cortex-M3 or PRU on the AM335x need to (or even can) have EDMA access.

I agree. I'm dropping this from the .dtsi in v4 as it is board/application
specific. The PRU, at least, can use the EDMA and I've seen examples as
such, but we can't hardcode this. The feature is there and documented in
the binding if somebody needs to reserve channels in their .dts.

-Matt
