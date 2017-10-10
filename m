From: robh@kernel.org (Rob Herring)
Date: Tue, 10 Oct 2017 13:15:22 -0500
Subject: [PATCH v3 02/12] pinctrl: axp209: add pinctrl features
In-Reply-To: <20171002120854.5212-3-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-3-quentin.schulz@free-electrons.com>
Message-ID: <20171010181522.y7moibamlghiw3lf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 02:08:44PM +0200, Quentin Schulz wrote:
> The X-Powers AXP209 has 3 GPIOs. GPIO0/1 can each act either as a GPIO,
> an ADC or a LDO regulator. GPIO2 can only act as a GPIO.
> 
> This adds the pinctrl features to the driver so GPIO0/1 can be used as
> ADC or LDO regulator.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-axp209.txt |  28 +-

In the future, please split bindings to separate patch.

>  drivers/pinctrl/pinctrl-axp209.c                   | 293 +++++++++++++++++++--
>  2 files changed, 300 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> index a6611304dd3c..388c04492afd 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> @@ -1,4 +1,4 @@
> -AXP209 GPIO controller
> +AXP209 GPIO & pinctrl controller
>  
>  This driver follows the usual GPIO bindings found in
>  Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -28,3 +28,29 @@ axp209: pmic at 34 {
>  		#gpio-cells = <2>;
>  	};
>  };
> +
> +The GPIOs can be muxed to other functions and therefore, must be a subnode of
> +axp_gpio.
> +
> +Example:
> +
> +&axp_gpio {
> +	gpio0_adc: gpio0_adc {

Use '-' rather than '_' for node names.

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		pins = "GPIO0";
> +		function = "adc";
> +	};
> +};
> +
> +&example_node {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpio0_adc>;
> +};
> +
> +GPIOs and their functions
> +-------------------------
> +
> +GPIO	|	Functions
> +------------------------
> +GPIO0	|	gpio_in, gpio_out, ldo, adc
> +GPIO1	|	gpio_in, gpio_out, ldo, adc
> +GPIO2	|	gpio_in, gpio_out
