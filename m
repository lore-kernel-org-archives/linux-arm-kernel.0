From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 19 May 2015 12:31:17 +0100
Subject: [PATCH v2 3/5] arm64: Juno: Add memory mapped timer node
In-Reply-To: <1432033003.3047.43.camel@linaro.org>
References: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
 <1431970109-8902-4-git-send-email-Liviu.Dudau@arm.com>
 <1432033003.3047.43.camel@linaro.org>
Message-ID: <20150519113116.GH2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 11:56:43AM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2015-05-18 at 18:28 +0100, Liviu Dudau wrote:
> > Juno based boards have a memory mapped timer @ 0x2a810000. This
> > is disabled on r0 version of the board due to an SoC errata.
> 
> So wouldn't it make more sense then to disable it in the dts for r0? As
> it is, you disable it in the common file below then have to later
> re-enable it in juno-r1.dts.

>From what I have seen in the existing DTs the preffer approach seems to be of
disabling by default the node declared in the common files and enable
it in the DT that makes use of it. My quick grep through the arch/arm/boot/dts
files shows 2638 .dtsi files using 'status = "disabled";' string vs 93 .dts
files. 'status = "okay";' is more evenly balances with 805 .dtsi files using
it vs 3256 .dts files.

If there is any guidance on how to describe this sort of situations I
would really love to read it.

> 
> Apart from that, the whole series looks good to be and I've given it a
> spin on r0 and r1. So consider that an
> Acked-by: Jon Medhurst <tixy@linaro.org>

Many thanks,
Liviu

> 
> 
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > ---
> >  arch/arm64/boot/dts/arm/juno-base.dtsi | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> > index 5c4c035..b7e862f 100644
> > --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> > +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> > @@ -2,6 +2,21 @@
> >  	 *  Devices shared by all Juno boards
> >  	 */
> >  
> > +	memtimer: timer at 2a810000 {
> > +		compatible = "arm,armv7-timer-mem";
> > +		reg = <0x0 0x2a810000 0x0 0x10000>;
> > +		clock-frequency = <50000000>;
> 
> 
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +		status = "disabled";
> > +		frame at 2a830000 {
> > +			frame-number = <1>;
> > +			interrupts = <0 60 4>;
> > +			reg = <0x0 0x2a830000 0x0 0x10000>;
> > +		};
> > +	};
> > +
> >  	gic: interrupt-controller at 2c010000 {
> >  		compatible = "arm,gic-400", "arm,cortex-a15-gic";
> >  		reg = <0x0 0x2c010000 0 0x1000>,
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
