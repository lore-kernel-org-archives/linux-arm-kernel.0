From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 14 Sep 2016 01:55:02 -0700
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <20160914014246.31847-1-stephen.boyd@linaro.org>
References: <20160914014246.31847-1-stephen.boyd@linaro.org>
Message-ID: <147384330268.13546.17843140335600627152@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2016-09-13 18:42:46)
> On the db410c 96boards platform we have a TC7USB40MU[1] on the
> board to mux the D+/D- lines from the SoC between a micro usb
> "device" port and a USB hub for "host" roles. Upon a role switch,
> we need to change this mux to forward the D+/D- lines to either
> the port or the hub. Therefore, introduce a driver for this
> device that intercepts extcon USB_HOST events and logically
> asserts a gpio to mux the "host" D+/D- lines when a host cable is
> attached. When the cable goes away, it will logically deassert
> the gpio and mux the "device" lines.
> 
> [1] https://toshiba.semicon-storage.com/ap-en/product/logic/bus-switch/detail.TC7USB40MU.html
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
> 
> Should I make the extcon part optional? I could see a case where there are two
> "OTG" ports connected to the mux (or two hubs), and for some reason the
> software may want to mux between them at runtime. If we mandate an extcon,
> that won't be possible to support. Perhaps it would be better to have
> the node, but connect it to the usb controller with a phandle (maybe of_graph
> endpoints would be useful too) so that when the controller wants to mux over
> a port it can do so.

Here's some dts mock-up on top of the db410c for the of_graph stuff. I
haven't written any code around it, but the idea is to allow the binding
to specify how the mux is connected to upstream and downstream D+/D-
lines. This way, we can do some dt parsing of the endpoints and their
parent nodes to figure out if the mux needs to be set high or low to use
a device connector or a usb hub based on if the id cable is present.
Maybe I'm over thinking things though and we could just have a DT
property for that.

	soc {
		usb at 78d9000 {
			extcon = <&usb_id>, <&usb_id>;
			usb-controller; // needed?

			ports {
				#address-cells = <1>;
				#size-cells = <0>;

				port at 0 {
					#address-cells = <1>;
					#size-cells = <0>;
					reg = <0>;

					usb_output: endpoint at 0 { // USB D+/D-
						reg = <0>;
						remote-endpoint = <&usb_switch_input>;
					};
				};
			};
		};
	};

	usb2513 {
		compatible = "smsc,usb3503";
		reset-gpios = <&pm8916_gpios 3 GPIO_ACTIVE_LOW>;
		initial-mode = <1>;
		usb-hub; // indicate this is a hub

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port at 0 {
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <0>;

				usb_hub_input: endpoint at 0 { // USB{DP,DM}_UP
					reg = <0>;
					remote-endpoint = <&usb_switch_hub_ep>;
				};

				usb_hub_output1: endpoint at 1 { // USB{DP,DM}_DN1
					reg = <1>;
					remote-endpoint = <&usb_a2_connector>;
				};

				usb_hub_output2: endpoint at 2 { // USB{DP,DM}_DN2
					reg = <2>;
					remote-endpoint = <&usb_a1_connector>;
				};

				usb_hub_output3: endpoint at 3 { // USB{DP,DM}_DN3
					reg = <3>;
					// goes to expansion connector
				};
			};
		};
	};

	usb_id: usb-id {
		compatible = "linux,extcon-usb-gpio";
		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
		pinctrl-names = "default";
		pinctrl-0 = <&usb_id_default>;
	};

	usb-switch {
		compatible = "toshiba,tc7usb40mu";
		switch-gpios = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
		extcon = <&usb_id>;
		pinctrl-names = "default";
		pinctrl-0 = <&usb_sw_sel_pm>;

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port at 0 {
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <0>;

				usb_switch_input: endpoint at 0 { // D+/D-
					reg = <0>;
					remote-endpoint = <&usb_output>;
				};

				usb_switch_device_ep: endpoint at 1 { // D1+/D1-
					reg = <1>;
					remote-endpoint = <&usb_ub_connector>;
				};

				usb_switch_hub_ep: endpoint at 2 { // D2+/D2-
					reg = <2>;
					remote-endpoint = <&usb_hub_input>;
				};
			};
		};
	};

	uB-connector {
		compatible = "usb-ub-connector";
		#address-cells = <1>;
		#size-cells = <0>;
		usb-connector;
		port at 0 {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <0>;
			usb_ub_connector: endpoint at 0 {
				reg = <0>;
				remote-endpoint = <&usb_switch_device_ep>;
			};
		};
	};

	usb-A-connector1 {
		compatible = "usb-A-connector";
		#address-cells = <1>;
		#size-cells = <0>;
		usb-connector;
		port at 0 {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <0>;
			usb_a1_connector: endpoint at 0 {
				reg = <0>;
				remote-endpoint = <&usb_hub_output2>;
			};
		};
	};

	usb-A-connector2 {
		compatible = "usb-A-connector";
		#address-cells = <1>;
		#size-cells = <0>;
		usb-connector;
		port at 0 {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <0>;
			usb_a2_connector: endpoint at 0 {
				reg = <0>;
				remote-endpoint = <&usb_hub_output1>;
			};
		};
	};
};
