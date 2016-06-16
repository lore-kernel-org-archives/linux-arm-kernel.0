From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Jun 2016 11:44:32 +0200
Subject: [PATCH 2/5] clk: Combine DT binding doc for max77686 and max77802
In-Reply-To: <1466000018-16784-3-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-3-git-send-email-ldewangan@nvidia.com>
Message-ID: <57627500.30209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 04:13 PM, Laxman Dewangan wrote:
> The clock driver for Maxim PMICs max77686 and max77802 are
> combined into single file to extend the support for same clock
> IP for different PMICs.
> 
> Remove the separate DT binding document file for maxim,max77802 and
> move all information to maxim,max77686 DT binding document.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  .../devicetree/bindings/clock/maxim,max77686.txt   | 78 ++++++++++++++++------
>  .../devicetree/bindings/clock/maxim,max77802.txt   | 44 ------------
>  2 files changed, 58 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/maxim,max77802.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/maxim,max77686.txt b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
> index 9c40739..354e5ab 100644
> --- a/Documentation/devicetree/bindings/clock/maxim,max77686.txt
> +++ b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
> @@ -1,11 +1,15 @@
> -Binding for Maxim MAX77686 32k clock generator block
> +Binding for Maxim MAX77686/MAX77802 32k clock generator block
>  
> -This is a part of device tree bindings of MAX77686 multi-function device.
> -More information can be found in bindings/mfd/max77686.txt file.
> +This is a part of device tree bindings of MAX77686/MAX77802 multi-function
> +device. More information can be found in bindings/mfd/max77686.txt file for
> +MAX77686 and bindings/mfd/max77802.txt for MAX77802.
>  
>  The MAX77686 contains three 32.768khz clock outputs that can be controlled
>  (gated/ungated) over I2C.
>  
> +The MAX77802 contains two 32.768khz clock outputs that can be controlled
> +(gated/ungated) over I2C.
> +
>  Following properties should be presend in main device node of the MFD chip.
>  
>  Required properties:
> @@ -21,26 +25,60 @@ to specify the clock which they consume. Following indices are allowed:
>      - 1: 32khz_cp clock,
>      - 2: 32khz_pmic clock.
>  
> +For MAX77802, 32khz_pmic is not valid.

It is easier to find for which device which ID is allowed, so maybe:
      - 1: 32khz_cp clock (max77686, max77802),
      - 2: 32khz_pmic clock. (max77686)


> +
>  Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max77686.h
> -header and can be used in device tree sources.
> +header for MAX77686 and dt-bindings/clock/maxim,max77802.h for MAX77802 and can
> +be used in device tree sources.
> +
> +Example:
> +
> +1. With MAX77686:
> +
> +#include <dt-bindings/clock/maxim,max77686.h>
> +:::

I am not sure what the ":::" means here...

Best regards,
Krzysztof

> +
> +	Node of the MFD chip
> +		max77686: max77686 at 09 {
> +			compatible = "maxim,max77686";
> +			interrupt-parent = <&wakeup_eint>;
> +			interrupts = <26 0>;
> +			reg = <0x09>;
> +			#clock-cells = <1>;
> +
> +			/* ... */
> +		};
> +
> +	Clock consumer node
> +
> +		foo at 0 {
> +			compatible = "bar,foo";
> +			/* ... */
> +			clock-names = "my-clock";
> +			clocks = <&max77686 MAX77686_CLK_PMIC>;
> +		};
> +
> +2. With MAX77802:
>  
> -Example: Node of the MFD chip
> +#include <dt-bindings/clock/maxim,max77802.h>
> +:::
>  
> -	max77686: max77686 at 09 {
> -		compatible = "maxim,max77686";
> -		interrupt-parent = <&wakeup_eint>;
> -		interrupts = <26 0>;
> -		reg = <0x09>;
> -		#clock-cells = <1>;
> +	Node of the MFD chip
> +		max77802: max77802 at 09 {
> +			compatible = "maxim,max77802";
> +			interrupt-parent = <&wakeup_eint>;
> +			interrupts = <26 0>;
> +			reg = <0x09>;
> +			#clock-cells = <1>;
>  
> -		/* ... */
> -	};
> +			/* ... */
> +		};
>  
> -Example: Clock consumer node
> +	Clock consumer node
>  
> -	foo at 0 {
> -		compatible = "bar,foo";
> -		/* ... */
> -		clock-names = "my-clock";
> -		clocks = <&max77686 MAX77686_CLK_PMIC>;
> -	};
> +		foo at 0 {
> +			compatible = "bar,foo";
> +			/* ... */
> +			clock-names = "my-clock";
> +			clocks = <&max77802 MAX77802_CLK_32K_AP>;
> +		};
> diff --git a/Documentation/devicetree/bindings/clock/maxim,max77802.txt b/Documentation/devicetree/bindings/clock/maxim,max77802.txt
> deleted file mode 100644
> index c6dc783..0000000
> --- a/Documentation/devicetree/bindings/clock/maxim,max77802.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -Binding for Maxim MAX77802 32k clock generator block
> -
> -This is a part of device tree bindings of MAX77802 multi-function device.
> -More information can be found in bindings/mfd/max77802.txt file.
> -
> -The MAX77802 contains two 32.768khz clock outputs that can be controlled
> -(gated/ungated) over I2C.
> -
> -Following properties should be present in main device node of the MFD chip.
> -
> -Required properties:
> -- #clock-cells: From common clock binding; shall be set to 1.
> -
> -Optional properties:
> -- clock-output-names: From common clock binding.
> -
> -Each clock is assigned an identifier and client nodes can use this identifier
> -to specify the clock which they consume. Following indices are allowed:
> -     - 0: 32khz_ap clock,
> -     - 1: 32khz_cp clock.
> -
> -Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max77802.h
> -header and can be used in device tree sources.
> -
> -Example: Node of the MFD chip
> -
> -	max77802: max77802 at 09 {
> -		compatible = "maxim,max77802";
> -		interrupt-parent = <&wakeup_eint>;
> -		interrupts = <26 0>;
> -		reg = <0x09>;
> -		#clock-cells = <1>;
> -
> -		/* ... */
> -	};
> -
> -Example: Clock consumer node
> -
> -	foo at 0 {
> -		compatible = "bar,foo";
> -		/* ... */
> -		clock-names = "my-clock";
> -		clocks = <&max77802 MAX77802_CLK_32K_AP>;
> -	};
> 
