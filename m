From: dawei.chien@mediatek.com (dawei chien)
Date: Mon, 11 Jul 2016 16:56:55 +0800
Subject: [PATCH 3/3] arm: dts: thermal: add thermal/auxadc node.
In-Reply-To: <577E465D.8070004@ti.com>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
 <1467882386-40544-4-git-send-email-dawei.chien@mediatek.com>
 <577E465D.8070004@ti.com>
Message-ID: <1468227415.15776.34.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Keerthy,

On Thu, 2016-07-07 at 17:39 +0530, Keerthy wrote:
> 
> On Thursday 07 July 2016 02:36 PM, Dawei Chien wrote:
> > This adds the thermal controller and auxadc nodes
> > to the Mediatek MT2701 dtsi file.
> >
> > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > ---
> > This patch depned on:
> > https://patchwork.kernel.org/patch/9213545/
> > ---
> >   arch/arm/boot/dts/mt2701.dtsi |   43 +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 43 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> > index 2ac8b50..0834a23 100644
> > --- a/arch/arm/boot/dts/mt2701.dtsi
> > +++ b/arch/arm/boot/dts/mt2701.dtsi
> > @@ -77,6 +77,36 @@
> >   		#clock-cells = <0>;
> >   	};
> >
> > +	thermal-zones {
> > +		cpu_thermal: cpu_thermal {
> > +			polling-delay-passive = <1000>; /* milliseconds */
> > +			polling-delay = <1000>; /* milliseconds */
> > +
> > +			thermal-sensors = <&thermal 0>;
> > +			sustainable-power = <1000>;
> > +
> > +			trips {
> > +				threshold: trip-point at 0 {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> > +				target: trip-point at 1 {
> > +					temperature = <85000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> > +				cpu_crit: cpu_crit at 0 {
> > +					temperature = <115000>;
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> 
> are there any corresponding cooling-maps?

Since MT2701 does not register CPUFREQ cooling device and its' own
device node, I could not add cooling-maps so far.
Could we add cooling map after CPUFREQ ready, thank you.

> 
> >   	timer {
> >   		compatible = "arm,armv7-timer";
> >   		interrupt-parent = <&gic>;
> > @@ -183,4 +213,17 @@
> >   		clocks = <&uart_clk>;
> >   		status = "disabled";
> >   	};
> > +
> > +	thermal: thermal at 1100b000 {
> > +		#thermal-sensor-cells = <0>;
> > +		compatible = "mediatek,mt2701-thermal";
> > +		reg = <0 0x1100b000 0 0x1000>;
> > +		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> > +		clock-names = "therm", "auxadc";
> > +		resets = <&pericfg 0x10>;
> > +		reset-names = "therm";
> > +		mediatek,auxadc = <&auxadc>;
> > +		mediatek,apmixedsys = <&apmixedsys>;
> > +	};
> >   };
> >
