From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 9 Jan 2018 10:03:18 +0000
Subject: [PATCH V3 2/2] ARM: dts: imx7s: add snvs rtc clock
In-Reply-To: <20180109094716.GH26312@b29396-OptiPlex-7040>
References: <1515489651-13488-1-git-send-email-Anson.Huang@nxp.com>
 <1515489651-13488-2-git-send-email-Anson.Huang@nxp.com>
 <20180109094716.GH26312@b29396-OptiPlex-7040>
Message-ID: <AM3PR04MB13150428BE76FF16EA9C15DDF5100@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang


> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86 at gmail.com]
> Sent: 2018-01-09 5:47 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Horia Geant? <horia.geanta@nxp.com>; Aymen Sghaier
> <aymen.sghaier@nxp.com>; herbert at gondor.apana.org.au;
> davem at davemloft.net; robh+dt at kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; linux at armlinux.org.uk;
> mturquette at baylibre.com; sboyd at codeaurora.org; Adriana Reus
> <adriana.reus@nxp.com>; stefan at agner.ch; linux-crypto at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-clk at vger.kernel.org; dl-linux-imx <linux-
> imx at nxp.com>
> Subject: Re: [PATCH V3 2/2] ARM: dts: imx7s: add snvs rtc clock
> 
> On Tue, Jan 09, 2018 at 05:20:51PM +0800, Anson Huang wrote:
> > Add i.MX7 SNVS RTC clock.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since v2:
> > 	improve the binding doc statement about clocks.
> >  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 15
> +++++++++++++++
> >  arch/arm/boot/dts/imx7s.dtsi                          |  2 ++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > index 76aec8a..7329f29 100644
> > --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > @@ -415,12 +415,25 @@ Secure Non-Volatile Storage (SNVS) Low Power (LP)
> RTC Node
> >  	value type: <u32>
> >  	Definition: LP register offset. default it is 0x34.
> >
> > +   - clocks
> > +      Usage: required if SNVS LP RTC requires explicit enablement of clocks
> > +      Value type: <prop_encoded-array>
> > +      Definition:  a clock specifier describing the clock required for
> > +          enabling and disabling SNVS LP RTC.
> > +
> 
> This clock seem optional.
> Should we indicate it here explicitly?

Will add a optional in usage.


> 
> BTW, i thought we probably could update poweroff and key as well at the same
> time since device tree changes can go separately.
> Does it make sense?

I think this patch set is only for RTC case since snvs-rtc driver already handle the clock.
But for poweroff and powerkey, their drivers are NOT handling clocks currently, we
can add them when driver ready to handle clocks. Should be in another patch set later.

Anson.

> 
> Regards
> Dong Aisheng
> 
> > +   - clock-names
> > +      Usage: required if SNVS LP RTC requires explicit enablement of clocks
> > +      Value type: <string>
> > +      Definition: clock name string should be "snvs-rtc".
> > +
> >  EXAMPLE
> >  	sec_mon_rtc_lp at 1 {
> >  		compatible = "fsl,sec-v4.0-mon-rtc-lp";
> >  		interrupts = <93 2>;
> >  		regmap = <&snvs>;
> >  		offset = <0x34>;
> > +		clocks = <&clks IMX7D_SNVS_CLK>;
> > +		clock-names = "snvs-rtc";
> >  	};
> >
> >
> ============================================================
> =========
> > @@ -543,6 +556,8 @@ FULL EXAMPLE
> >  			regmap = <&sec_mon>;
> >  			offset = <0x34>;
> >  			interrupts = <93 2>;
> > +			clocks = <&clks IMX7D_SNVS_CLK>;
> > +			clock-names = "snvs-rtc";
> >  		};
> >
> >  		snvs-pwrkey at 020cc000 {
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi index 9aa2bb9..02baf42 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -551,6 +551,8 @@
> >  					offset = <0x34>;
> >  					interrupts = <GIC_SPI 19
> IRQ_TYPE_LEVEL_HIGH>,
> >  						     <GIC_SPI 20
> IRQ_TYPE_LEVEL_HIGH>;
> > +					clocks = <&clks IMX7D_SNVS_CLK>;
> > +					clock-names = "snvs-rtc";
> >  				};
> >
> >  				snvs_poweroff: snvs-poweroff {
> > --
> > 1.9.1
> >
