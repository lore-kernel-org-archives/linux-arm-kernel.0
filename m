From: david@lechnology.com (David Lechner)
Date: Tue, 22 Nov 2016 14:00:29 -0600
Subject: [PATCH 2/4] ARM: dts: davinci: da850: add VPIF
In-Reply-To: <20161122194551.3420-3-khilman@baylibre.com>
References: <20161122194551.3420-1-khilman@baylibre.com>
 <20161122194551.3420-3-khilman@baylibre.com>
Message-ID: <51071aa1-50c5-1121-3e64-018edaf544bf@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2016 01:45 PM, Kevin Hilman wrote:
> Add VPIF and VPIF capture nodes to da850.  VPIF capture has two input
> channels describe using the standard DT ports and enpoints.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 6205917b4f59..e05e2bb834e8 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -453,7 +453,35 @@
>  			interrupts = <52>;
>  			status = "disabled";
>  		};
> +
> +		vpif: video at 0x00217000 {

Should be @217000

> +			compatible = "ti,da850-vpif";
> +			reg = <0x00217000 0x1000>;

Could omit leading 0's to be consistent with existing entries.

	reg = <0x217000 0x1000>;

> +			status = "disabled";
> +		};
> +
> +		vpif_capture: video-capture at 0x00217000 {

Again, @217000. But it seems odd to have two device nodes with the same 
address. Is enabling these mutually exclusive?


> +			compatible = "ti,da850-vpif-capture";
> +			reg = <0x00217000 0x1000>;

Ditto on the leading 0's.

> +			interrupts = <92>;
> +			status = "disabled";
> +
> +			/* VPIF capture: input channels */
> +			port {
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
> +			};
> +		};
>  	};
> +
>  	aemif: aemif at 68000000 {
>  		compatible = "ti,da850-aemif";
>  		#address-cells = <2>;
>
