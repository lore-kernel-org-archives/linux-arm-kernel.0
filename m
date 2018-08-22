From: horms@verge.net.au (Simon Horman)
Date: Wed, 22 Aug 2018 11:55:06 +0200
Subject: [PATCH v3 2/2] arm64: dts: renesas: condor/v3hsk: add
 DU/LVDS/HDMI support
In-Reply-To: <2345061.kvOJ0NRlsT@avalon>
References: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
 <c78f1228-afb0-54cf-5d9e-5c812b678de3@cogentembedded.com>
 <2345061.kvOJ0NRlsT@avalon>
Message-ID: <20180822095505.tobyblbwsg7rsvgo@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 06:19:20PM +0300, Laurent Pinchart wrote:
> Hi Sergei,
> 
> Thank you for the patch.
> 
> On Wednesday, 13 June 2018 23:12:40 EEST Sergei Shtylyov wrote:
> > Define the Condor/V3HSK board dependent parts of the DU and  LVDS device
> > nodes. Also add the device nodes for Thine THC63LVD1024 LVDS decoder and
> > Analog Devices ADV7511W HDMI transmitter...
> > 
> > Based on the original (and large) patch by Vladimir Barinov.
> > 
> > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> > Changes in version 2:
> > - added the V3HSK DT update, reworded the description, renamed the patch;
> > - added a space between the HDMI node name and a brace.
> > 
> >  arch/arm64/boot/dts/renesas/r8a77980-condor.dts |  106 ++++++++++++++++++++
> >  arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  |  120 ++++++++++++++++++++
> >  2 files changed, 226 insertions(+)
> 
> I would have split that in two patchees.

I take your point but I think one is fine.

Sergei, will you address the other review items?

> 
> > 
> > Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> > ===================================================================
> > --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> > +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> > @@ -45,6 +45,56 @@
> >  		regulator-boot-on;
> >  		regulator-always-on;
> >  	};
> > +
> > +	d1_8v: regulator-2 {
> 
> Nitpicking, the naming for the regulator and clock nodes seems a bit weird. 
> That shouldn't block this patch, but the issue should still be discussed with 
> DT maintainers. A clear rule should be enacted on how to name top level nodes 
> for which no register value makes sense.
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "D1.8V";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +	hdmi-out {
> > +		compatible = "hdmi-connector";
> > +		type = "a";
> > +
> > +		port {
> > +			hdmi_con: endpoint {
> > +				remote-endpoint = <&adv7511_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	lvds-decoder {
> > +		compatible = "thine,thc63lvd1024";
> > +		vcc-supply = <&d3_3v>;
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port at 0 {
> > +				reg = <0>;
> > +				thc63lvd1024_in: endpoint {
> > +					remote-endpoint = <&lvds0_out>;
> > +				};
> > +			};
> > +
> > +			port at 2 {
> > +				reg = <2>;
> > +				thc63lvd1024_out: endpoint {
> > +					remote-endpoint = <&adv7511_in>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	x1_clk: x1-clock {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <148500000>;
> > +	};
> >  };
> > 
> >  &avb {
> > @@ -74,6 +124,13 @@
> >  	};
> >  };
> > 
> > +&du {
> > +	clocks = <&cpg CPG_MOD 724>,
> > +		 <&x1_clk>;
> > +	clock-names = "du.0", "dclkin.0";
> > +	status = "okay";
> > +};
> > +
> >  &extal_clk {
> >  	clock-frequency = <16666666>;
> >  };
> > @@ -102,6 +159,55 @@
> >  		gpio-controller;
> >  		#gpio-cells = <2>;
> >  	};
> > +
> > +	hdmi at 39 {
> > +		compatible = "adi,adv7511w";
> > +		reg = <0x39>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
> > +		avdd-supply = <&d1_8v>;
> > +		dvdd-supply = <&d1_8v>;
> > +		pvdd-supply = <&d1_8v>;
> > +		bgvdd-supply = <&d1_8v>;
> > +		dvdd-3v-supply = <&d3_3v>;
> > +
> > +		adi,input-depth = <8>;
> > +		adi,input-colorspace = "rgb";
> > +		adi,input-clock = "1x";
> > +		adi,input-style = <1>;
> > +		adi,input-justification = "evenly";
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port at 0 {
> > +				reg = <0>;
> > +				adv7511_in: endpoint {
> > +					remote-endpoint = <&thc63lvd1024_out>;
> > +				};
> > +			};
> > +
> > +			port at 1 {
> > +				reg = <1>;
> > +				adv7511_out: endpoint {
> > +					remote-endpoint = <&hdmi_con>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&lvds0 {
> > +	status = "okay";
> > +
> > +	ports {
> > +		port at 1 {
> > +			lvds0_out: endpoint {
> > +				remote-endpoint = <&thc63lvd1024_in>;
> > +			};
> > +		};
> > +	};
> >  };
> > 
> >  &mmc0 {
> > Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
> > ===================================================================
> > --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
> > +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
> > @@ -27,6 +27,63 @@
> >  		/* first 128MB is reserved for secure area. */
> >  		reg = <0 0x48000000 0 0x78000000>;
> >  	};
> > +
> > +	hdmi-out {
> > +		compatible = "hdmi-connector";
> > +		type = "a";
> > +
> > +		port {
> > +			hdmi_con: endpoint {
> > +				remote-endpoint = <&adv7511_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	lvds-decoder {
> > +		compatible = "thine,thc63lvd1024";
> > +		vcc-supply = <&vcc3v3_d5>;
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port at 0 {
> > +				reg = <0>;
> > +				thc63lvd1024_in: endpoint {
> > +					remote-endpoint = <&lvds0_out>;
> > +				};
> > +			};
> > +
> > +			port at 2 {
> > +				reg = <2>;
> > +				thc63lvd1024_out: endpoint {
> > +					remote-endpoint = <&adv7511_in>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	vcc1v8_d4: regulator-0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "VCC1V8_D4";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +	vcc3v3_d5: regulator-1 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "VCC3V3_D5";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> > +&du {
> > +	status = "okay";
> 
> No dot clock for the DU ?
> 
> Apart from that,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> >  };
> > 
> >  &extal_clk {
> > @@ -53,6 +110,64 @@
> >  	};
> >  };
> > 
> > +&lvds0 {
> > +	status = "okay";
> > +
> > +	ports {
> > +		port at 1 {
> > +			lvds0_out: endpoint {
> > +				remote-endpoint = <&thc63lvd1024_in>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c0 {
> > +	pinctrl-0 = <&i2c0_pins>;
> > +	pinctrl-names = "default";
> > +
> > +	status = "okay";
> > +	clock-frequency = <400000>;
> > +
> > +	hdmi at 39 {
> > +		compatible = "adi,adv7511w";
> > +		#sound-dai-cells = <0>;
> > +		reg = <0x39>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
> > +		avdd-supply = <&vcc1v8_d4>;
> > +		dvdd-supply = <&vcc1v8_d4>;
> > +		pvdd-supply = <&vcc1v8_d4>;
> > +		bgvdd-supply = <&vcc1v8_d4>;
> > +		dvdd-3v-supply = <&vcc3v3_d5>;
> > +
> > +		adi,input-depth = <8>;
> > +		adi,input-colorspace = "rgb";
> > +		adi,input-clock = "1x";
> > +		adi,input-style = <1>;
> > +		adi,input-justification = "evenly";
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port at 0 {
> > +				reg = <0>;
> > +				adv7511_in: endpoint {
> > +					remote-endpoint = <&thc63lvd1024_out>;
> > +				};
> > +			};
> > +
> > +			port at 1 {
> > +				reg = <1>;
> > +				adv7511_out: endpoint {
> > +					remote-endpoint = <&hdmi_con>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> >  &pfc {
> >  	gether_pins: gether {
> >  		groups = "gether_mdio_a", "gether_rgmii",
> > @@ -60,6 +175,11 @@
> >  		function = "gether";
> >  	};
> > 
> > +	i2c0_pins: i2c0 {
> > +		groups = "i2c0";
> > +		function = "i2c0";
> > +	};
> > +
> >  	scif0_pins: scif0 {
> >  		groups = "scif0_data";
> >  		function = "scif0";
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 
> 
