From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 11 Aug 2014 20:01:41 +0200
Subject: [PATCH 3/4] ARM: dts: rockchip: add rk3288 dma controllers
In-Reply-To: <CAD=FV=VWBh3STfZWLDuYerS9wiceQL=UEJyjqp0-GLh0=-hTdw@mail.gmail.com>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <1406661128-7614-4-git-send-email-heiko@sntech.de>
 <CAD=FV=VWBh3STfZWLDuYerS9wiceQL=UEJyjqp0-GLh0=-hTdw@mail.gmail.com>
Message-ID: <1560376.L4H27Lgx9N@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 11. August 2014, 10:01:08 schrieb Doug Anderson:
> Heiko,
> 
> On Tue, Jul 29, 2014 at 12:12 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Add both the bus and peripheral pl330 dma controllers present in rk3288
> > socs. The first dma controller can change between secure and non-secure
> > mode and is left by the bootloader in secure mode, which gets added here.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/boot/dts/rk3288.dtsi | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> 
> This is outside of my area of expertise, but comparing this to
> bindings, TRM, and other platforms it looks reasonable to me.
> 
> > diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> > index 3ef8951..3f39d26 100644
> > --- a/arch/arm/boot/dts/rk3288.dtsi
> > +++ b/arch/arm/boot/dts/rk3288.dtsi
> > @@ -62,6 +62,33 @@
> > 
> >                 };
> >         
> >         };
> > 
> > +       amba {
> > +               compatible = "arm,amba-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +
> > +               dmac1: dma at ffb20000 {
> 
> I'm curious: why did you choose "dmac1" for the alias here?  I would
> have called it "dmac_peri", "pdma", or something similar as per the
> address map in the TRM.  I found a single reference in the TRM to
> "dmac2" but it wasn't immediately clear to me which DMA that was
> referring to.  In a commit in a temporary tree I see that someone at
> Rockchip called the DMA at ff250000 "pdma1".

I think I just kept the alias similar to the clock-name. The naming of the 
dma-controllers seems to be inconsistent ... the clocks are named dmac1 and 
dmac2, while the interrupt table in the rk3188-TRM calls them dmac0 and dmac1. 
So I guess I just duplicated the naming for the rk3288.

I guess for the rk3288, the one at 0xffb20000 should be named something like 
dmac_bus and the other one dmac_peri, reflecting what they're called in the 
TRM, but I'm of course open for suggestions :-) .


Also for an upcoming v2, I've also changed the structure a bit, as the first 
dma-controller has both a secure and non-secure version of it.
So currently the rk3288.dtsi looks like [0]:

	amba {
		compatible = "arm,amba-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		/* dma1 in secure state */
		dma-controller at ffb20000 {
			compatible = "arm,pl330", "arm,primecell";
			reg = <0xffb20000 0x4000>;
			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
			#dma-cells = <1>;
			clocks = <&cru ACLK_DMAC1>;
			clock-names = "apb_pclk";
			status = "disabled";
		};

		/* dma1 in non-secure state */
		dma-controller at ffb60000 {
			compatible = "arm,pl330", "arm,primecell";
			reg = <0xffb60000 0x4000>;
			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
			#dma-cells = <1>;
			clocks = <&cru ACLK_DMAC1>;
			clock-names = "apb_pclk";
			status = "disabled";
		};

		dmac2: dma-controller at ff250000 {
			compatible = "arm,pl330", "arm,primecell";
			reg = <0xff250000 0x4000>;
			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
			#dma-cells = <1>;
			clocks = <&cru ACLK_DMAC2>;
			clock-names = "apb_pclk";
		};
	};

and the board is responsible for enabling the correct variant [1], as most 
likely the bootloader decides in which mode to start the dma controller:

	amba {
		/* dma1 in secure state */
		dmac1: dma-controller at ffb20000 {
			status = "okay";
		};
	};

This is based on some mailinglist discussion, I found at some point, about 
this but for the life of me am not able to find anymore. So of course feedback 
would appreciated there too.



[0] https://github.com/mmind/linux-rockchip/blob/devel/workbench/arch/arm/boot/dts/rk3288.dtsi
[1] https://github.com/mmind/linux-rockchip/blob/devel/workbench/arch/arm/boot/dts/rk3288-evb.dtsi

> 
> > +                       compatible = "arm,pl330", "arm,primecell";
> > +                       reg = <0xffb20000 0x4000>;
> > +                       interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> > +                       #dma-cells = <1>;
> > +                       clocks = <&cru ACLK_DMAC1>;
> > +                       clock-names = "apb_pclk";
> > +               };
> > +
> > +               dmac2: dma at ff250000 {
> 
> nit: when we have easy addresses to compare to, we should probably
> sort by address?

correct :-)

> 
> > +                       compatible = "arm,pl330", "arm,primecell";
> > +                       reg = <0xff250000 0x4000>;
> > +                       interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> > +                       #dma-cells = <1>;
> > +                       clocks = <&cru ACLK_DMAC2>;
> > +                       clock-names = "apb_pclk";
> > +               };
> > +       };
> > +
> > 
> >         xin24m: oscillator {
> >         
> >                 compatible = "fixed-clock";
> >                 clock-frequency = <24000000>;
> > 
> > --
> > 2.0.1
