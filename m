From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 09 Apr 2015 22:18:27 +0100
Subject: [PATCH 01/10] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <20150409201616.GJ19186@sonymobile.com>
References: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1428567761-10765-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150409201616.GJ19186@sonymobile.com>
Message-ID: <5526ECA3.9060605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Bjorn for comments

On 09/04/15 21:16, Bjorn Andersson wrote:
> On Thu 09 Apr 01:22 PDT 2015, Srinivas Kandagatla wrote:
>
>> This patch adds rpm node to apq8064 dt as rpm would be used by other
>> devices for regulator support. Also adds all the regulators in the rpm.
>>
>> Most content of this patch was originally posted by Stephen Boyd on the
>> list.
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064.dtsi | 272 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 272 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> index 6c15112..d9166eb 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> @@ -3,6 +3,7 @@
>>   #include "skeleton.dtsi"
>>   #include <dt-bindings/clock/qcom,gcc-msm8960.h>
>>   #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
>> +#include <dt-bindings/mfd/qcom-rpm.h>
>>   #include <dt-bindings/soc/qcom,gsbi.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>
>> @@ -276,6 +277,277 @@
>>   			#reset-cells = <1>;
>>   		};
>>
>> +		l2cc: clock-controller at 2011000 {
>> +			compatible	= "syscon";
>> +			reg		= <0x2011000 0x1000>;
>> +		};
>> +
>> +		rpm at 108000 {
>> +			compatible	= "qcom,rpm-apq8064";
>> +			reg		= <0x108000 0x1000>;
>> +			qcom,ipc	= <&l2cc 0x8 2>;
>> +
>> +			interrupts	= <GIC_SPI 19 IRQ_TYPE_NONE>,
>> +					  <GIC_SPI 21 IRQ_TYPE_NONE>,
>> +					  <GIC_SPI 22 IRQ_TYPE_NONE>;
>
> All three interrupts should be IRQ_TYPE_EDGE_RISING, currently the
> driver overrides this with IRQF_TRIGGER_RISING but it should just obey
> the dt.

Yes, I will change the type to IRQF_TRIGGER_RISING in next version.
>
>> +			interrupt-names	= "ack", "err", "wakeup";
>> +
>> +			regulators {
>> +				compatible = "qcom,rpm-pm8921-regulators";
>> +				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
>> +				vin_lvs1_3_6-supply = <&pm8921_s4>;
>> +				vin_lvs2-supply = <&pm8921_s4>;
>> +				vin_lvs4_5_7-supply = <&pm8921_s4>;
>> +				vdd_ncp-supply = <&pm8921_l6>;
>> +				vdd_l24-supply = <&pm8921_s1>;
>> +				vdd_l25-supply = <&pm8921_s1>;
>> +				vdd_l27-supply = <&pm8921_s7>;
>> +				vdd_l28-supply = <&pm8921_s7>;
>
> These are actually possible to change when designing a device, but
> it's not unlikely that everyone have these values so they are reasonable
> to have here.
Ok.
>
> But for several of the regulators we're running our 8064 devices with
> different configuration, especially voltage, so I don't think they
> should be specified here.
>
Yep it makes sense, I will move the voltage ranges to the board specific 
dts files.
> Having the phandles listed here are sane though, so that we can address
> them from the platform files.
	>
>> +
>> +				/* Buck SMPS */
>> +				pm8921_s1: s1 {
>> +					regulator-always-on;
>> +					regulator-min-microvolt = <1225000>;
>> +					regulator-max-microvolt = <1225000>;
>> +					qcom,switch-mode-frequency = <3200000>;
>> +					bias-pull-down;
>> +				};
>> +
> [..]
>
> Regards,
> Bjorn
>
