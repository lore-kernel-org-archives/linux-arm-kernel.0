From: s-anna@ti.com (Suman Anna)
Date: Tue, 18 Jul 2017 14:13:42 -0500
Subject: [PATCH 4/4] ARM: dts: keystone-k2g-evm: Add gpio nodes
In-Reply-To: <1500375436-9435-5-git-send-email-j-keerthy@ti.com>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-5-git-send-email-j-keerthy@ti.com>
Message-ID: <1cd6ef99-a98e-7cdb-5c2a-f5cd057eef41@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Keerthy,

On 07/18/2017 05:57 AM, Keerthy wrote:
> keystone-k2g has 2 instances of gpio. The first one has all the 144 GPIOs

Please use 66AK2G for keystone-k2g.

> functional( 9 banks with 16 gpios = 144). The second instance has
> only the GPIO0:GPIO67 functional and rest are marked reserved.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/keystone-k2g.dtsi | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
> index bf4d1fa..58ac3db 100644
> --- a/arch/arm/boot/dts/keystone-k2g.dtsi
> +++ b/arch/arm/boot/dts/keystone-k2g.dtsi
> @@ -15,6 +15,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/keystone.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	compatible = "ti,k2g","ti,keystone";
> @@ -168,5 +169,46 @@
>  				#reset-cells = <2>;
>  			};
>  		};
> +
> +		gpio0: gpio at 2603000 {
> +			compatible = "ti,keystone-k2g-gpio";
> +			reg = <0x02603000 0x100>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 434 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 437 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 439 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 440 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			ti,ngpio = <144>;
> +			ti,davinci-gpio-unbanked = <0>;
> +			clocks = <&k2g_clks 0x001b 0x0>;
> +			clock-names = "gpio";

I don't see the clocks and clock-names documented in the binding.
Looking at davinci_gpio_irq_setup(), these are required, and a specific
clock name is what the driver is looking for. And you have different
semantics for this on K2G and non-K2G SoCs. Davinci platforms are using
non-DT clocks, so their DT nodes didn't have them.

regards
Suman

> +		};
> +
> +		gpio1: gpio at 260a000 {
> +			compatible = "ti,keystone-k2g-gpio";
> +			reg = <0x0260a000 0x100>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 442 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 443 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 444 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 445 IRQ_TYPE_EDGE_RISING>,
> +					<GIC_SPI 446 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			ti,ngpio = <68>;
> +			ti,davinci-gpio-unbanked = <0>;
> +			clocks = <&k2g_clks 0x001c 0x0>;
> +			clock-names = "gpio";
> +		};
>  	};
>  };
> 
