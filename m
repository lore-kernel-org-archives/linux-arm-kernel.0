From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Dec 2013 11:20:39 +0000
Subject: [PATCH v6 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <1386153615-25456-4-git-send-email-k.kozlowski@samsung.com>
References: <1386153615-25456-1-git-send-email-k.kozlowski@samsung.com>
 <1386153615-25456-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131204112039.GC907@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add document describing device tree bindings for MAX14577 MFD driver.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  Documentation/devicetree/bindings/mfd/max14577.txt |   48 ++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
> new file mode 100644
> index 000000000000..f4fd16360b6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max14577.txt
> @@ -0,0 +1,48 @@
> +MAXIM MAX14577 multi-function device

Why is Maxim capitalised in such a way?

If you're going to use the term Multi-Function Device, please
capitalise it.

> +MAX14577 is a Multi-function device with Micro-USB Interface Circuit, Li+

Same here.

> +Battery Charger and SFOUT LDO output for powering USB devices. It is
> +interfaced to host controller using I2C.
> +
> +Required properties:
> +- compatible : Must be "maxim,max14577".
> +- reg : I2C slave address for the max14577 chip.
> +- interrupts : IRQ line for the max14577 chip.
> +- interrupt-parent :  The parent interrupt controller.
> +
> +Optional nodes:
> +- regulators :
> +  Required child node properties:
> +  - compatible : "maxim,max14577-regulator"
> +
> +  Optional child nodes:
> +    Each child node representing a regulator, following standard regulator
> +    bindings. Valid names for a regulator are: "CHARGER" and "SAFEOUT".
> +    The SAFEOUT is a constant voltage regulator so there is no need

s/constant/fixed

> +    to specify voltages for it.

The whole of the "Optional nodes" explaination isn't as clear as it
could otherwise be. 

> +	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +Example:
> +	max14577 at 25 {
> +		compatible = "maxim,max14577";
> +		reg = <0x25>;
> +		interrupt-parent = <&gpx1>;
> +		interrupts = <5 0>;

I'm gussing this is IRQ5 and the 0 is flags? If so, please use
#defines for the flags.

> +		regulators {
> +			compatible = "maxim,max14577-regulator";
> +
> +			safeout_reg: safeout at 1 {

The name of the node (not the label:safeout_reg) usually depicts the
type of device, so 'regulator at 0' and 'regulator at 1'. However, I'm
unsure how this works when these nodes are encapsulated by an
overarching 'regulators' parent node.

Perhaps Mark can answer this?

> +				regulator-compatible = "SAFEOUT";
> +				regulator-name = "SAFEOUT";
> +			};
> +			charger_reg: charger at 0 {
> +				regulator-compatible = "CHARGER";
> +				regulator-name = "CHARGER";
> +				regulator-min-microamp = <90000>;
> +				regulator-max-microamp = <950000>;
> +				regulator-boot-on;
> +			};
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
