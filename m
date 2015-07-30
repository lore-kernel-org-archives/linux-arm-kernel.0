From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 29 Jul 2015 17:12:30 -0700
Subject: [PATCH v1 1/7] ARM: dts: ifc6410: Add pwrseq support for WLAN
In-Reply-To: <1438088022-17350-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088022-17350-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150730001230.GD6519@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 28 Jul 05:53 PDT 2015, Srinivas Kandagatla wrote:

> This patch adds pwrseq for WLAN which resets the WLAN just before the
> SDIO bus is up.
> 

Does this mean that we have the !power-of-2 patch in mmc on the way?

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> index 88d6655..df560cf 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> @@ -1,5 +1,6 @@
>  #include "qcom-apq8064-v2.0.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  
>  / {
>  	model = "Qualcomm APQ8064/IFC6410";
> @@ -206,6 +207,28 @@
>  			status = "okay";
>  		};
>  
> +		qcom,ssbi at 500000 {
> +			pmicintc: pmic at 0 {
> +				pm8921_gpio: gpio at 150 {

These should already be labeled in the apq8064 dtsi (or in a
qcom-pm8921.dtsi).

> +					pinctrl-names = "default";
> +					pinctrl-0 = <&wlan_default_gpios>;

Please move these to the pwrseq node, as that's the consumer of this.

> +					wlan_default_gpios: wlan-gpios {
> +						pios {
> +							pins = "gpio43";
> +							function = "normal";
> +							bias-disable;
> +							power-source = <PM8921_GPIO_S4>;
> +						};
> +					};
> +				};
> +			};
> +		};

Regards,
Bjorn
