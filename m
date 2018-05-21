From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 May 2018 17:50:50 +0300
Subject: [PATCH v4 2/3] arm64: dts: renesas: draak: Describe CVBS input
In-Reply-To: <1526913942-15426-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526913942-15426-3-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1958464.yiJe0NDHa3@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

Thank you for the patch.

On Monday, 21 May 2018 17:45:41 EEST Jacopo Mondi wrote:
> Describe CVBS video input through analog video decoder ADV7180
> connected to video input interface VIN4.
> 
> The video input signal path is shared with HDMI video input, and
> selected by on-board switches SW-53 and SW-54 with CVBS input selected
> by the default switches configuration.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3 -> v4:
> - Use 'adi,adv7180cp' compatible string in place of just 'adi,adv7180'
>   as suggested by Laurent.
> - Re-structure CVBS input ports definition according to adv7180cp
>   bindings: add port at 0 for composite input, add port at 3 for parallel
>   video output.
> - Change node label to 'composite-in' as in Gose board bindings.
> 
> v2 -> v3:
> - Add comment to describe the shared input video path.
> - Add my SoB and Niklas' R-b tags.
> ---
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 68
> ++++++++++++++++++++++++++ 1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index 9d73de8..ad59032
> 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> @@ -59,6 +59,16 @@
>  		};
>  	};
> 
> +	composite-in {
> +		compatible = "composite-video-connector";
> +
> +		port {
> +			composite_con_in: endpoint {
> +				remote-endpoint = <&adv7180_in>;
> +			};
> +		};
> +	};
> +
>  	memory at 48000000 {
>  		device_type = "memory";
>  		/* first 128MB is reserved for secure area. */
> @@ -142,6 +152,11 @@
>  		groups = "usb0";
>  		function = "usb0";
>  	};
> +
> +	vin4_pins_cvbs: vin4 {
> +		groups = "vin4_data8", "vin4_sync", "vin4_clk";
> +		function = "vin4";
> +	};
>  };
> 
>  &i2c0 {
> @@ -154,6 +169,39 @@
>  		reg = <0x50>;
>  		pagesize = <8>;
>  	};
> +
> +	composite-in at 20 {
> +		compatible = "adi,adv7180cp";
> +		reg = <0x20>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				adv7180_in: endpoint {
> +					remote-endpoint = <&composite_con_in>;
> +				};
> +			};
> +
> +			port at 3 {
> +				reg = <3>;
> +
> +				/*
> +				 * The VIN4 video input path is shared between
> +				 * CVBS and HDMI inputs through SW[49-53]
> +				 * switches.
> +				 *
> +				 * CVBS is the default selection, link it to
> +				 * VIN4 here.
> +				 */
> +				adv7180_out: endpoint {
> +					remote-endpoint = <&vin4_in>;
> +				};
> +			};
> +		};
> +	};
>  };
> 
>  &i2c1 {
> @@ -246,3 +294,23 @@
>  	timeout-sec = <60>;
>  	status = "okay";
>  };
> +
> +&vin4 {
> +	pinctrl-0 = <&vin4_pins_cvbs>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port at 0 {
> +			reg = <0>;
> +
> +			vin4_in: endpoint {
> +				remote-endpoint = <&adv7180_out>;
> +			};
> +		};
> +	};
> +};


-- 
Regards,

Laurent Pinchart
