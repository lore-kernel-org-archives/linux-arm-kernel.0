From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 29 Mar 2016 16:02:19 +0100
Subject: [PATCH 06/12] ARM: dts: dragonboard-600c: Add eMMC and SD card
 support
In-Reply-To: <20160329143829.GJ8929@tuxbot>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762458-9584-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160329143829.GJ8929@tuxbot>
Message-ID: <56FA98FB.4070203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/03/16 15:38, Bjorn Andersson wrote:
> On Wed 23 Mar 12:47 PDT 2016, Srinivas Kandagatla wrote:
>
>> This patch adds eMMC and SD card support with card detect and adding
>> required regulators.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../arm/boot/dts/qcom-apq8064-dragonboard-600c.dts | 41 ++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>> index 0a0bcfe..a977314 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>> @@ -1,4 +1,5 @@
>>   #include "qcom-apq8064-v2.0.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>>
>>   / {
>>   	model = "Qualcomm Technologies, Inc. APQ8064 DragonBoard600c";
>> @@ -22,6 +23,16 @@
>>   	};
>>
>>   	soc {
>> +		pinctrl at 800000 {
>> +			card_detect: card_detect {
>> +				mux {
>> +					pins = "gpio26";
>> +					function = "gpio";
>> +					bias-disable;
>> +				};
>> +			};
>> +		};
>> +
>>   		rpm at 108000 {
>>   			regulators {
>>   				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
>> @@ -62,6 +73,18 @@
>>   					regulator-max-microvolt = <1300000>;
>>   					qcom,switch-mode-frequency = <3200000>;
>>   				 };
>> +
>> +				l5 {
>> +					regulator-min-microvolt = <2750000>;
>> +					regulator-max-microvolt = <3000000>;
>> +					bias-pull-down;
>> +				};
>> +
>> +				l6 {
>> +					regulator-min-microvolt = <2950000>;
>> +					regulator-max-microvolt = <2950000>;
>> +					bias-pull-down;
>> +				};
>
> I would prefer if you folded these into the regulator patch.

OK, I will give it a go and see how it looks.

>
>>   			};
>>   		};
>>
>> @@ -87,5 +110,23 @@
>>   				pinctrl-0 = <&gsbi7_uart_2pins>;
>>   			};
>>   		};
>> +
>> +		amba {
>> +			/* eMMC */
>> +			sdcc at 12400000 {
>> +				status = "okay";
>> +				vmmc-supply = <&pm8921_l5>;
>> +				vqmmc-supply = <&pm8921_s4>;
>> +			};
>> +
>> +			/* External micro SD card */
>> +			sdcc at 12180000 {
>> +				status = "okay";
>> +				vmmc-supply = <&pm8921_l6>;
>> +				pinctrl-names	= "default";
>> +				pinctrl-0	= <&card_detect>;
>> +				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_HIGH>;
>> +			};
>> +		};
>
> Other than that,
>

> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

Thanks  for the Ack.
> Regards,
> Bjorn
>
