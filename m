From: j-keerthy@ti.com (Keerthy)
Date: Wed, 26 Jul 2017 12:11:55 +0530
Subject: [PATCH v2 1/2] gpio: davinci: Add keystone-k2g compatible
In-Reply-To: <1501048228-3492-1-git-send-email-j-keerthy@ti.com>
References: <1501048228-3492-1-git-send-email-j-keerthy@ti.com>
Message-ID: <17cfbd91-105d-cdb9-472d-d4e83925418b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 26 July 2017 11:20 AM, Keerthy wrote:
> The patch adds keystone-k2g compatible, specific properties and
> an example.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../devicetree/bindings/gpio/gpio-davinci.txt      | 39 +++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> index 5079ba7..9f4f612 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> @@ -1,7 +1,9 @@
>  Davinci/Keystone GPIO controller bindings
>  
>  Required Properties:
> -- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"
> +- compatible: should be "ti,dm6441-gpio",
> +			 "ti,keystone-gpio",
> +			 "ti,keystone-k2g-gpio"

My bad i have not added the SoCs related to corresponding compatibles. I
will send v3 fixing that.

>  
>  - reg: Physical base address of the controller and the size of memory mapped
>         registers.
> @@ -26,6 +28,17 @@ The GPIO controller also acts as an interrupt controller. It uses the default
>  two cells specifier as described in Documentation/devicetree/bindings/
>  interrupt-controller/interrupts.txt.
>  
> +Required Properties specific to keystone-k2g
> +
> +- clocks: Should contain devices input clock. The first parameter
> +           is a handle to k2g_clks. The second parameter is the
> +           device ID and the third parameter is the clock ID. One can
> +           refer: http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data
> +
> +           Example: <&k2g_clks 0x001c 0x0>;
> +
> +- clock-names: The driver expects the clock name to be "gpio";
> +
>  Example:
>  
>  gpio: gpio at 1e26000 {
> @@ -60,3 +73,27 @@ leds {
>  		...
>  	};
>  };
> +
> +Example for keystone-k2g:
> +
> +gpio0: gpio at 2603000 {
> +	compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
> +	reg = <0x02603000 0x100>;
> +	gpio-controller;
> +	#gpio-cells = <2>;
> +	interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 434 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 437 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 439 IRQ_TYPE_EDGE_RISING>,
> +			<GIC_SPI 440 IRQ_TYPE_EDGE_RISING>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	ti,ngpio = <144>;
> +	ti,davinci-gpio-unbanked = <0>;
> +	clocks = <&k2g_clks 0x001b 0x0>;
> +	clock-names = "gpio";
> +};
> 
