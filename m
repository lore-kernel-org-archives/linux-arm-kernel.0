From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 11:29:46 -0500
Subject: [PATCH v5 1/4] dt-bindings: pinctrl: qcom: add gpio-ranges,
 gpio-reserved-ranges
In-Reply-To: <910e5a85a6a8020069996e2ff397c93e9c5fe18c.1526935804.git.chunkeey@gmail.com>
References: <910e5a85a6a8020069996e2ff397c93e9c5fe18c.1526935804.git.chunkeey@gmail.com>
Message-ID: <20180522162946.GA25556@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 10:57:36PM +0200, Christian Lamparter wrote:
> This patch adds the gpio-ranges and gpio-reserved-ranges property
> definitions to the binding text files supported by the pinctrl-msm
> driver framework.
> 
> gpio-ranges:
> For DT-based platforms the pinctrl-msm framework currently relies
> on the deprecated-for-DT gpiochip_add_pin_range() function to add
> the range of GPIOs to be handled by the pin controller. Due to
> interactions within gpiolib code, this causes the pinctrl-msm
> driver to bail out (-517) during boot when a gpio-hog is declared.
> This can be fatal and cause the system to not boot or reset
> (for a detailed explanation and call-trace, refer to patch:
> "pinctrl: msm: fix gpio-hog related boot issues" in this series).
> 
> gpio-reserved-ranges:
> The binding has been added as a precaution since the TrustZone
> firmware (aka QSEE), which is running as the hypervisor, might
> have reserved certain, but undisclosed pins. Hence reading or
> writing to the registers for those pins will cause an
> XPU violation and this subsequently crashes the kernel.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  .../bindings/pinctrl/qcom,apq8064-pinctrl.txt         |  6 ++++++
>  .../bindings/pinctrl/qcom,apq8084-pinctrl.txt         | 11 +++++++++++
>  .../bindings/pinctrl/qcom,ipq4019-pinctrl.txt         |  6 ++++++
>  .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt         |  6 ++++++
>  .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt         | 10 ++++++++++
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt         | 11 +++++++++++
>  .../bindings/pinctrl/qcom,msm8660-pinctrl.txt         |  6 ++++++
>  .../bindings/pinctrl/qcom,msm8916-pinctrl.txt         | 11 +++++++++++
>  .../bindings/pinctrl/qcom,msm8960-pinctrl.txt         | 11 +++++++++++
>  .../bindings/pinctrl/qcom,msm8974-pinctrl.txt         |  6 ++++++
>  .../bindings/pinctrl/qcom,msm8994-pinctrl.txt         | 11 +++++++++++
>  .../bindings/pinctrl/qcom,msm8996-pinctrl.txt         | 11 +++++++++++
>  12 files changed, 106 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
> index a752a4716486..7f78c6bb4e35 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
> @@ -10,6 +10,11 @@ Required properties:
>  - #gpio-cells : Should be two.
>                  The first cell is the gpio pin number and the
>                  second cell is used for optional parameters.
> +- gpio-ranges: Range of pins managed by the GPIO controller.

Just 'see gpio.txt' is sufficient unless you can say how many entries.

> +
> +Optional properties:
> +
> +- gpio-reserved-ranges: Range of pins reserved by the TrustZone TEE.

ditto.

>  
>  Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
>  a general description of GPIO and interrupt bindings.
> @@ -67,6 +72,7 @@ Example:
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gsbi5_uart_default>;
> +		gpio-ranges = <&msmgpio 0 0 90>;
>  
>  		gsbi5_uart_default: gsbi5_uart_default {
>  			mux {
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
> index c4ea61ac56f2..362f32b945af 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
> @@ -40,6 +40,16 @@ MSM8960 platform.
>  	Definition: must be 2. Specifying the pin number and flags, as defined
>  		    in <dt-bindings/gpio/gpio.h>
>  
> +- gpio-ranges:
> +	Usage: required
> +	Value type: <prop-encoded-array>

But this is phandle with 3 cells.

Still, you don't need to redefine standard properties here. Just need to 
know optional vs. required and any constraints you can define (e.g. 
allowed values, number of values, etc.)


Same comments apply to the rest.

Rob
