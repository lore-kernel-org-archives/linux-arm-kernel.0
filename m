From: alison.wang@freescale.com (Huan Wang)
Date: Tue, 14 Jul 2015 10:09:04 +0000
Subject: [PATCH] dts: ls1021a: audio: Add dts nodes for audio on LS1021A
In-Reply-To: <20150713141913.GT23464@tiger>
References: <1435895912-47451-1-git-send-email-b18965@freescale.com>
 <20150713141913.GT23464@tiger>
Message-ID: <BN3PR0301MB0867ED329D703100B07AF18DFE9B0@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

> On Fri, Jul 03, 2015 at 11:58:32AM +0800, Alison Wang wrote:
> > This patch adds dts nodes for audio on LS1021A.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> > ---
> >  arch/arm/boot/dts/ls1021a-qds.dts | 71
> > +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/ls1021a-twr.dts | 63
> ++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/ls1021a.dtsi    | 14 ++++----
> >  3 files changed, 142 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a-qds.dts
> > b/arch/arm/boot/dts/ls1021a-qds.dts
> > index f16a061..9533f1d 100644
> > --- a/arch/arm/boot/dts/ls1021a-qds.dts
> > +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> > @@ -58,6 +58,57 @@
> >  		enet0_sgmii_phy = &sgmii_phy1c;
> >  		enet1_sgmii_phy = &sgmii_phy1d;
> >  	};
> > +
> > +	clocks {
> > +		sys_mclk: clock {
> 
> The generic node name works only when there is a @unit-address after it.
> Otherwise, when you have more clocks to add, they will have the same
> node name.
> 
> But one of the device tree maintainer doesn't like the idea of "clocks"
> container at all.  So you may just want to put the node directly under
> root with a unit node name, something like the following.
> 
> 	sys_mclk: clock-mclk {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <24576000>;
> 	};
[Alison Wang] Thanks for your explanation and suggestion.
I will change in v2.
> 
> Shawn
> 
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <24576000>;
> > +		};
> > +	};
> > +
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg_3p3v: regulator at 0 {
> > +			compatible = "regulator-fixed";
> > +			reg = <0>;
> > +			regulator-name = "3P3V";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +	};
> > +
> > +	sound {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,widgets =
> > +			"Microphone", "Microphone Jack",
> > +			"Headphone", "Headphone Jack",
> > +			"Speaker", "Speaker Ext",
> > +			"Line", "Line In Jack";
> > +		simple-audio-card,routing =
> > +			"MIC_IN", "Microphone Jack",
> > +			"Microphone Jack", "Mic Bias",
> > +			"LINE_IN", "Line In Jack",
> > +			"Headphone Jack", "HP_OUT",
> > +			"Speaker Ext", "LINE_OUT";
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&sai2>;
> > +			frame-master;
> > +			bitclock-master;
> > +		};
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&codec>;
> > +			frame-master;
> > +			bitclock-master;
> > +		};
> > +	};
> >  };
> >
> >  &dspi0 {
> > @@ -99,6 +150,7 @@
> >  	status = "okay";
> >
> >  	pca9547: mux at 77 {
> > +		compatible = "nxp,pca9547";
> >  		reg = <0x77>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > @@ -153,6 +205,21 @@
> >  				reg = <0x4c>;
> >  			};
> >  		};
> > +
> > +		i2c at 4 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x4>;
> > +
> > +			codec: sgtl5000 at 2a {
> > +				#sound-dai-cells = <0>;
> > +				compatible = "fsl,sgtl5000";
> > +				reg = <0x2a>;
> > +				VDDA-supply = <&reg_3p3v>;
> > +				VDDIO-supply = <&reg_3p3v>;
> > +				clocks = <&sys_mclk 1>;
> > +			};
> > +		};
> >  	};
> >  };
> >
> > @@ -251,6 +318,10 @@
> >  	};
> >  };
> >
> > +&sai2 {
> > +	status = "okay";
> > +};
> > +
> >  &uart0 {
> >  	status = "okay";
> >  };
> > diff --git a/arch/arm/boot/dts/ls1021a-twr.dts
> > b/arch/arm/boot/dts/ls1021a-twr.dts
> > index 4b61766..a0d9ad6 100644
> > --- a/arch/arm/boot/dts/ls1021a-twr.dts
> > +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> > @@ -56,6 +56,57 @@
> >  		enet0_sgmii_phy = &sgmii_phy2;
> >  		enet1_sgmii_phy = &sgmii_phy0;
> >  	};
> > +
> > +	clocks {
> > +		sys_mclk: clock {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <24576000>;
> > +		};
> > +	};
> > +
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg_3p3v: regulator at 0 {
> > +			compatible = "regulator-fixed";
> > +			reg = <0>;
> > +			regulator-name = "3P3V";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +	};
> > +
> > +	sound {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,widgets =
> > +			"Microphone", "Microphone Jack",
> > +			"Headphone", "Headphone Jack",
> > +			"Speaker", "Speaker Ext",
> > +			"Line", "Line In Jack";
> > +		simple-audio-card,routing =
> > +			"MIC_IN", "Microphone Jack",
> > +			"Microphone Jack", "Mic Bias",
> > +			"LINE_IN", "Line In Jack",
> > +			"Headphone Jack", "HP_OUT",
> > +			"Speaker Ext", "LINE_OUT";
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&sai1>;
> > +			frame-master;
> > +			bitclock-master;
> > +		};
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&codec>;
> > +			frame-master;
> > +			bitclock-master;
> > +		};
> > +	};
> >  };
> >
> >  &dspi1 {
> > @@ -99,6 +150,14 @@
> >
> >  &i2c1 {
> >  	status = "okay";
> > +	codec: sgtl5000 at a {
> > +		#sound-dai-cells = <0>;
> > +		compatible = "fsl,sgtl5000";
> > +		reg = <0x0a>;
> > +		VDDA-supply = <&reg_3p3v>;
> > +		VDDIO-supply = <&reg_3p3v>;
> > +		clocks = <&sys_mclk 1>;
> > +	};
> >  };
> >
> >  &ifc {
> > @@ -138,6 +197,10 @@
> >  	};
> >  };
> >
> > +&sai1 {
> > +	status = "okay";
> > +};
> > +
> >  &uart0 {
> >  	status = "okay";
> >  };
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index 6c41b10..4ad30d0 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -345,28 +345,30 @@
> >  		};
> >
> >  		sai1: sai at 2b50000 {
> > +			#sound-dai-cells = <0>;
> >  			compatible = "fsl,vf610-sai";
> >  			reg = <0x0 0x2b50000 0x0 0x10000>;
> >  			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&platform_clk 1>;
> > -			clock-names = "sai";
> > +			clocks = <&platform_clk 1>, <&platform_clk 1>,
> > +				 <&platform_clk 1>, <&platform_clk 1>;
> > +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> >  			dma-names = "tx", "rx";
> >  			dmas = <&edma0 1 47>,
> >  			       <&edma0 1 46>;
> > -			big-endian;
> >  			status = "disabled";
> >  		};
> >
> >  		sai2: sai at 2b60000 {
> > +			#sound-dai-cells = <0>;
> >  			compatible = "fsl,vf610-sai";
> >  			reg = <0x0 0x2b60000 0x0 0x10000>;
> >  			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&platform_clk 1>;
> > -			clock-names = "sai";
> > +			clocks = <&platform_clk 1>, <&platform_clk 1>,
> > +				 <&platform_clk 1>, <&platform_clk 1>;
> > +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> >  			dma-names = "tx", "rx";
> >  			dmas = <&edma0 1 45>,
> >  			       <&edma0 1 44>;
> > -			big-endian;
> >  			status = "disabled";
> >  		};
> >
> > --
> > 2.1.0.27.g96db324
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
