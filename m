From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 07 Dec 2016 21:34:18 +0200
Subject: [PATCH v2 1/4] ARM: dts: davinci: da850: VPIF: add node and muxing
In-Reply-To: <20161207193137.27947-2-khilman@baylibre.com>
References: <20161207193137.27947-1-khilman@baylibre.com>
 <20161207193137.27947-2-khilman@baylibre.com>
Message-ID: <37047453.6bLpOkkjm4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Thank you for the patch.

On Wednesday 07 Dec 2016 11:31:34 Kevin Hilman wrote:
> Add VPIF node an pins to da850 and enable on boards.  VPIF has two input
> channels described using the standard DT ports and enpoints.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts  |  6 ++++++
>  arch/arm/boot/dts/da850-lcdk.dts |  6 ++++++
>  arch/arm/boot/dts/da850.dtsi     | 38 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts
> b/arch/arm/boot/dts/da850-evm.dts index 41de15fe15a2..212b50d4f84b 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -289,3 +289,9 @@
>  		};
>  	};
>  };
> +
> +&vpif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&vpif_capture_pins>;
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts
> b/arch/arm/boot/dts/da850-lcdk.dts index 7b8ab21fed6c..67f846f5bb35 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -219,3 +219,9 @@
>  		};
>  	};
>  };
> +
> +&vpif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&vpif_capture_pins>;
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index f79e1b91c680..dd2a13ed106e 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -186,7 +186,18 @@
>  					0xc 0x88888888 0xffffffff
> 
>  				>;
> 
>  			};
> -
> +			vpif_capture_pins: vpif_capture_pins {
> +				pinctrl-single,bits = <
> +					/* VP_DIN[2..7], VP_CLKIN1, VP_CLKIN0 
*/
> +					0x38 0x11111111 0xffffffff
> +					/* VP_DIN[10..15,0..1] */
> +					0x3c 0x11111111 0xffffffff
> +					/* VP_DIN[8..9] */
> +					0x40 0x00000011 0x000000ff
> +					/* VP_CLKIN3, VP_CLKIN2 */
> +					0x4c 0x00010100 0x000f0f00
> +				>;
> +			};
>  		};
>  		edma0: edma at 0 {
>  			compatible = "ti,edma3-tpcc";
> @@ -399,7 +410,32 @@
>  				<&edma0 0 1>;
>  			dma-names = "tx", "rx";
>  		};
> +
> +		vpif: video at 217000 {
> +			compatible = "ti,da850-vpif";
> +			reg = <0x217000 0x1000>;
> +			interrupts = <92>;
> +			status = "disabled";
> +
> +			/* VPIF capture: input channels */
> +			port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				vpif_ch0: endpoint at 0 {
> +					  reg = <0>;
> +					  bus-width = <8>;
> +				};
> +
> +				vpif_ch1: endpoint at 1 {
> +					  reg = <1>;
> +					  bus-width = <8>;
> +					  data-shift = <8>;
> +				};

Given that the VPIF can also accept a single 16-bit input, I'd move the 
endpoints to board files.

> +			};
> +		};
>  	};
> +
>  	aemif: aemif at 68000000 {
>  		compatible = "ti,da850-aemif";
>  		#address-cells = <2>;

-- 
Regards,

Laurent Pinchart
