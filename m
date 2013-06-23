From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 23 Jun 2013 12:12:42 +0200
Subject: [PATCH 1/8] ARM: dts: Correct camera pinctrl nodes for Exynos4x12
 SoCs
In-Reply-To: <1371819024-12596-2-git-send-email-s.nawrocki@samsung.com>
References: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
 <1371819024-12596-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <7538808.XQjIcFgyeQ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Friday 21 of June 2013 14:50:17 Sylwester Nawrocki wrote:
> Add separate nodes for the CAMCLK pin and turn off pull-up on camera
> ports A, B. The video bus pins and the clock output (CAMCLK) pin need
> separate nodes since full camera port is not used in some
> configurations, e.g. for MIPI CSI-2 bus only CAMCLK is required and
> data/clock signal use separate dedicated pins.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |   40
> ++++++++++++++++++++++++----- 1 file changed, 33 insertions(+), 7
> deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi index 704290f..50eaa95
> 100644
> --- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> @@ -401,13 +401,26 @@
>  			samsung,pin-drv = <0>;
>  		};
> 
> -		cam_port_a: cam-port-a {
> +		cam_port_a_io: cam-port-a-io {
>  			samsung,pins = "gpj0-0", "gpj0-1", "gpj0-2", 
"gpj0-3",
>  					"gpj0-4", "gpj0-5", "gpj0-6", 
"gpj0-7",
> -					"gpj1-0", "gpj1-1", "gpj1-2", 
"gpj1-3",
> -					"gpj1-4";
> +					"gpj1-0", "gpj1-1", "gpj1-2", 
"gpj1-4";
>  			samsung,pin-function = <2>;
> -			samsung,pin-pud = <3>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <0>;
> +		};
> +
> +		cam_port_a_clk_active: cam-port-a-clk-active {
> +			samsung,pins = "gpj1-3";
> +			samsung,pin-function = <2>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <3>;
> +		};
> +
> +		cam_port_a_clk_idle: cam-port-a-clk-idle {
> +			samsung,pins = "gpj1-3";
> +			samsung,pin-function = <0>;
> +			samsung,pin-pud = <0>;
>  			samsung,pin-drv = <0>;

Who is driving the clock line in this configuration? Idle would suggest 
that neither the camera nor the camif, so I think some pull should be 
enabled to avoid floating pin. (Or is there an external pulling resistor 
for this line in most common setups?)

>  		};
>  	};
> @@ -778,16 +791,29 @@
>  			samsung,pin-drv = <3>;
>  		};
> 
> -		cam_port_b: cam-port-b {
> +		cam_port_b_io: cam-port-b-io {
>  			samsung,pins = "gpm0-0", "gpm0-1", "gpm0-2", 
"gpm0-3",
>  					"gpm0-4", "gpm0-5", "gpm0-6", 
"gpm0-7",
> -					"gpm1-0", "gpm1-1", "gpm2-0", 
"gpm2-1",
> -					"gpm2-2";
> +					"gpm1-0", "gpm1-1", "gpm2-0", 
"gpm2-1";
>  			samsung,pin-function = <3>;
>  			samsung,pin-pud = <3>;
>  			samsung,pin-drv = <0>;
>  		};
> 
> +		cam_port_b_clk_active: cam-port-b-clk-active {
> +			samsung,pins = "gpm2-2";
> +			samsung,pin-function = <3>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <3>;
> +		};
> +
> +		cam_port_b_clk_idle: cam-port-b-clk-idle {
> +			samsung,pins = "gpm2-2";
> +			samsung,pin-function = <0>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <0>;
> +		};

Same here.

Otherwise looks fine to me.

Best regards,
Tomasz

> +
>  		eint0: ext-int0 {
>  			samsung,pins = "gpx0-0";
>  			samsung,pin-function = <0xf>;
