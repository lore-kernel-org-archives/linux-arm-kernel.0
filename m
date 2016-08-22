From: horms@verge.net.au (Simon Horman)
Date: Mon, 22 Aug 2016 09:33:06 +0200
Subject: [PATCH] ARM: dts: blanche: add SDHI0 support
In-Reply-To: <3029697.f9plKzFKet@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
 <3029697.f9plKzFKet@wasted.cogentembedded.com>
Message-ID: <20160822073305.GD28034@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Aug 18, 2016 at 09:31:54PM +0300, Sergei Shtylyov wrote:
> Define the Blanche board dependent part of the SDHI0 (connected to the
> micro-SD slot) device node along with  the necessary voltage regulator.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-20160817-v4.8-rc2' of Simon Horman's
> 'renesas.git' repo plus the general purpose switches patch  posted yesterday.
> 
>  arch/arm/boot/dts/r8a7792-blanche.dts |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
> @@ -103,6 +103,17 @@
>  			gpios = <&gpio11 2 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	vcc_sdhi0: regulator-vcc-sdhi0 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "SDHI0 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&gpio11 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  };

Is it intentional that there is no vccq_sdhi0 ?

>  
>  &extal_clk {
> @@ -139,6 +150,11 @@
>  		groups = "can0_data", "can_clk";
>  		function = "can0";
>  	};
> +
> +	sdhi0_pins: sdhi0 {
> +		groups = "sdhi0_data4", "sdhi0_ctrl";
> +		function = "sdhi0";
> +	};
>  };
>  
>  &scif0 {
> @@ -161,3 +177,12 @@
>  
>  	status = "okay";
>  };
> +
> +&sdhi0 {
> +	pinctrl-0 = <&sdhi0_pins>;
> +	pinctrl-names = "default";
> +
> +	vmmc-supply = <&vcc_sdhi0>;
> +	cd-gpios = <&gpio11 11 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> 
