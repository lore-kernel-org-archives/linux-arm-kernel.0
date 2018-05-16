From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 17 May 2018 00:23:18 +0200
Subject: [PATCH v2 3/3] arm64: dts: renesas: draak: Describe HDMI input
In-Reply-To: <1526478129-16465-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526478129-16465-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180516222318.GI17948@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

Thanks for your patch.

On 2018-05-16 15:42:09 +0200, Jacopo Mondi wrote:
> Describe HDMI input connector and ADV7612 HDMI decoder installed on
> R-Car Gen3 Draak board.
> 
> The video signal routing to the HDMI decoder to the video input interface
> VIN4 is multiplexed with CVBS input path, and enabled/disabled through
> on-board switches SW-49, SW-50, SW-51 and SW-52.
> 
> As the default board switches configuration connects CVBS input to VIN4,
> leave the HDMI decoder unconnected in DTS.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

I'm not sure we have a policy about describing hardware which can't be 
used without flipping switches. I have no opinion on if we should do 
that or not I leave that to others, but for the change itself.

Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

I think it's good we describe it as it's part of the Draak board itself 
and not an expansion board which we have seen a lot of :-) Maybe even 
add a commented out line in the adv7612 port at 2 which hints which VIN 
this is connected to if the switches are flipped?

> ---
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> index 9aba28f..ea99dc9 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> @@ -59,6 +59,17 @@
>  		};
>  	};
>  
> +	hdmi-in {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&adv7612_in>;
> +			};
> +		};
> +	};
> +
>  	memory at 48000000 {
>  		device_type = "memory";
>  		/* first 128MB is reserved for secure area. */
> @@ -170,6 +181,33 @@
>  			};
>  		};
>  	};
> +
> +	hdmi-decoder at 4c {
> +		compatible = "adi,adv7612";
> +		reg = <0x4c>;
> +		default-input = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				adv7612_in: endpoint {
> +					remote-endpoint = <&hdmi_con_in>;
> +				};
> +			};
> +
> +			port at 2 {
> +				reg = <2>;
> +				adv7612_out: endpoint {
> +					pclk-sample = <0>;
> +					hsync-active = <0>;
> +					vsync-active = <0>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &i2c1 {
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas S?derlund
