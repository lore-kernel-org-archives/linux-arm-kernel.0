From: dawei.chien@mediatek.com (Dawei Chien)
Date: Mon, 16 Jan 2017 11:46:44 +0800
Subject: [PATCH v2 6/6] arm: dts: mt2701: Add thermal device node.
In-Reply-To: <1484538290.13258.3.camel@mtksdaap41>
References: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
 <1484296978-18572-7-git-send-email-erin.lo@mediatek.com>
 <c8bbd4a4-2207-44f0-4462-3761c1d6c8a9@gmail.com>
 <1484538290.13258.3.camel@mtksdaap41>
Message-ID: <1484538404.13258.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-16 at 11:44 +0800, Dawei Chien wrote:
> On Fri, 2017-01-13 at 16:27 +0100, Matthias Brugger wrote:
> > 
> > On 13/01/17 09:42, Erin Lo wrote:
> > > From: Dawei Chien <dawei.chien@mediatek.com>
> > >
> > > Add thermal controller device nodes for MT2701.
> > >
> > > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > ---
> > >  arch/arm/boot/dts/mt2701.dtsi | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> > > index 3847f70..c43d5f8 100644
> > > --- a/arch/arm/boot/dts/mt2701.dtsi
> > > +++ b/arch/arm/boot/dts/mt2701.dtsi
> > > @@ -89,6 +89,36 @@
> > >  		clock-output-names = "rtc32k";
> > >  	};
> > >
> > > +	thermal-zones {
> > > +		cpu_thermal: cpu_thermal {
> > > +			polling-delay-passive = <1000>; /* milliseconds */
> > > +			polling-delay = <1000>; /* milliseconds */
> > > +
> > > +			thermal-sensors = <&thermal 0>;
> > > +			sustainable-power = <1000>;
> > > +
> > > +			trips {
> > > +				threshold: trip-point at 0 {
> > > +					temperature = <68000>;
> > > +					hysteresis = <2000>;
> > > +					type = "passive";
> > > +				};
> > > +
> > > +				target: trip-point at 1 {
> > > +					temperature = <85000>;
> > > +					hysteresis = <2000>;
> > > +					type = "passive";
> > > +				};
> > > +
> > > +				cpu_crit: cpu_crit at 0 {
> > > +					temperature = <115000>;
> > > +					hysteresis = <2000>;
> > > +					type = "critical";
> > > +				};
> > > +			};
> > > +		};
> > > +	};
> > > +
> > >  	timer {
> > >  		compatible = "arm,armv7-timer";
> > >  		interrupt-parent = <&gic>;
> > > @@ -270,6 +300,19 @@
> > >  		status = "disabled";
> > >  	};
> > >
> > > +	thermal: thermal at 1100b000 {
> > > +		#thermal-sensor-cells = <0>;
> > > +		compatible = "mediatek,mt2701-thermal";
> > > +		reg = <0 0x1100b000 0 0x1000>;
> > > +		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> > > +		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> > > +		clock-names = "therm", "auxadc";
> > > +		resets = <&pericfg 0x10>;
> > 
> > should be MT2701_PERI_AUXADC_SW_RST, right?
> > 
> Thank you for your reminding, I didn't realize mt2701-resets.h upstream
> already, I would update on next version, thank you.
> 
> resets = <&pericfg MT2701_PERI_AUXADC_SW_RST>;

Actually, Should be MT2701_PERI_THERM_SW_RST.

resets = <&pericfg MT2701_PERI_THERM_SW_RST>;

> > > +		reset-names = "therm";
> > > +		mediatek,auxadc = <&auxadc>;
> > > +		mediatek,apmixedsys = <&apmixedsys>;
> > > +	};
> > > +
> > >  	nandc: nfi at 1100d000 {
> > >  		compatible = "mediatek,mt2701-nfc";
> > >  		reg = <0 0x1100d000 0 0x1000>;
> > >
> 
