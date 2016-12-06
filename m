From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 06 Dec 2016 15:42:04 +0200
Subject: [PATCH v4 1/2] ARM: dts: da850-lcdk: add the dumb-vga-dac node
In-Reply-To: <1481030026-7329-2-git-send-email-bgolaszewski@baylibre.com>
References: <1481030026-7329-1-git-send-email-bgolaszewski@baylibre.com>
 <1481030026-7329-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <4410572.7ltIsoL1pV@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

Thank you for the patch.

On Tuesday 06 Dec 2016 14:13:45 Bartosz Golaszewski wrote:
> Add the dumb-vga-dac node to the board DT together with corresponding
> ports and vga connector. This allows to retrieve the edid info from
> the display automatically.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 69 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts
> b/arch/arm/boot/dts/da850-lcdk.dts index afcb482..ca437c1 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -51,6 +51,51 @@
>  			system-clock-frequency = <24576000>;
>  		};
>  	};
> +
> +	vga-bridge {
> +		compatible = "dumb-vga-dac";

Please don't. The board uses a THS8135, which has a few control signals. 
They're not used on this board so you can certainly rely on the dumb-vga-dac 
driver, but you should not use that compatible string. You should instead add 
DT bindings for ti,ths8135 and add that compatible string to the dumb-vga-dac 
driver.

The rest looks good to me.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0>;
> +
> +				vga_bridge_in: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&display_out_vga>;
> +				};
> +			};
> +
> +			port at 1 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1>;
> +
> +				vga_bridge_out: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&vga_con_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	vga {
> +		compatible = "vga-connector";
> +
> +		ddc-i2c-bus = <&i2c0>;
> +
> +		port {
> +			vga_con_in: endpoint {
> +				remote-endpoint = <&vga_bridge_out>;
> +			};
> +		};
> +	};
>  };
> 
>  &pmx_core {
> @@ -236,3 +281,27 @@
>  &memctrl {
>  	status = "okay";
>  };
> +
> +&display {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lcd_pins>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		display_out: port at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +	};
> +};
> +
> +&display_out {
> +	display_out_vga: endpoint at 0 {
> +		reg = <0>;
> +		remote-endpoint = <&vga_bridge_in>;
> +	};
> +};

-- 
Regards,

Laurent Pinchart
