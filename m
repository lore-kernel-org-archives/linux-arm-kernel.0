From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 21 Mar 2014 13:13:20 +0100
Subject: [PATCH 4/5] ARM: berlin/dt: add cpupll and syspll support to BG2CD
In-Reply-To: <1395402220-23503-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395402220-23503-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <532C2CE0.4000205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 12:43 PM, Alexandre Belloni wrote:
> This also moves the clocks from the clocks container node to the root.

Please leave a word on the original intention of the patch here, too.

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2cd.dtsi | 56 ++++++++++++++++++++++++++++------------
>   1 file changed, 39 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
> index 094968c27533..c84013c1597c 100644
> --- a/arch/arm/boot/dts/berlin2cd.dtsi
> +++ b/arch/arm/boot/dts/berlin2cd.dtsi
> @@ -30,24 +30,46 @@
>   		};
>   	};
>
> -	clocks {
> -		smclk: sysmgr-clock {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <25000000>;
> -		};
> +	smclk: sysmgr-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
>
> -		cfgclk: cfg-clock {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <75000000>;
> -		};
> +	cfgclk: cfg-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <75000000>;
> +	};
>
> -		sysclk: system-clock {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <300000000>;
> -		};
> +	syspll: syspll {

syspll: pll at ea0014 and sort it in SoC nodes.

> +		compatible = "marvell,berlin2-pll";
> +		clocks = <&smclk>;
> +		#clock-cells = <0>;
> +		reg = <0xf7ea0014 8>;
> +	};
> +
> +	cpupll: cpupll {

ditto.

> +		compatible = "marvell,berlin2-pll";
> +		clocks = <&smclk>;
> +		#clock-cells = <0>;
> +		reg = <0xf7ea003c 8>;
> +	};
> +
> +	cpuclk: cpu-clock {
> +		compatible = "fixed-factor-clock";
> +		clocks = <&cpupll>;
> +		#clock-cells = <0>;
> +		clock-div = <1>;
> +		clock-mult = <1>;

Same comment about cpuclk to cpupll relation.

> +	};
> +
> +	twdclk: twdclk {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&cpuclk>;
> +		clock-mult = <1>;
> +		clock-div = <3>;
>   	};
>
>   	soc {
> @@ -76,7 +98,7 @@
>   			compatible = "arm,cortex-a9-twd-timer";
>   			reg = <0xad0600 0x20>;
>   			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&sysclk>;
> +			clocks = <&twdclk>;
>   		};
>
>   		apb at e80000 {
>
