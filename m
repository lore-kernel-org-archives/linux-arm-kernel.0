From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 5 May 2015 13:37:07 +0800
Subject: [PATCH 6/7] ARM: dts: mt8135: enable basic SMP bringup for mt8135
In-Reply-To: <20150504143105.GK4946@pengutronix.de>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
 <1430466210-22963-7-git-send-email-yingjoe.chen@mediatek.com>
 <20150504143105.GK4946@pengutronix.de>
Message-ID: <1430804227.15346.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-05-04 at 16:31 +0200, Sascha Hauer wrote:
> On Fri, May 01, 2015 at 03:43:29PM +0800, Yingjoe Chen wrote:
> > Add arch timer node to enable arch-timer support. MT8135 firmware
> > doesn't correctly setup arch-timer frequency and CNTVOFF, add
> > properties to workaround this.
> > 
> > This also set cpu enable-method to enable SMP.
> > 
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt8135.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> > index 612bd22..eb5e06f 100644
> > --- a/arch/arm/boot/dts/mt8135.dtsi
> > +++ b/arch/arm/boot/dts/mt8135.dtsi
> > @@ -46,6 +46,7 @@
> >  	cpus {
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		enable-method = "mediatek,mt81xx-tz-smp";
> >  
> >  		cpu0: cpu at 0 {
> >  			device_type = "cpu";
> > @@ -103,6 +104,21 @@
> >  		};
> >  	};
> >  
> > +	timer {
> > +		compatible = "arm,armv7-timer";
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> > +					  IRQ_TYPE_LEVEL_LOW)>;
> > +		clock-frequency = <13000000>;
> > +		arm,cpu-registers-not-fw-configured;
> > +	};
> 
> This is the SoC dtsi file. What you say here is that all MT8135
> present and future firmwares on all boards do this wrong.
> Shouldn't you fix the firmware instead? Shouldn't this property be board
> specific?

Hi Sascha,

To fix this we'll have to change initial boot code. Since 8135 or 8127
already MP for some time now, I'm afraid we won't be able to do that, even
for new boards. I can put it in board dts, but this means we'll have to
duplicate this in all board dts.

Joe.C
