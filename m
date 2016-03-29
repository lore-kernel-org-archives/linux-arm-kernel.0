From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 29 Mar 2016 16:02:14 +0100
Subject: [PATCH 05/12] ARM: dts: dragonboard-600c: add pmic regulator
 supplies
In-Reply-To: <20160329143711.GI8929@tuxbot>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762450-9538-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160329143711.GI8929@tuxbot>
Message-ID: <56FA98F6.9020702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/03/16 15:37, Bjorn Andersson wrote:
> On Wed 23 Mar 12:47 PDT 2016, Srinivas Kandagatla wrote:
>
>> This patch adds pmic regulator supplies connected on the board.
>> Rest of the invidual regulators would be added as and when required by
>> the devices.
>>
>
> I do think we should try to fill them all out, before they are needed.
> Especially so that people don't take the easy path of just copying
> pieces from some other 8064 dts to get going...

I agree, But I want to make sure that all the regulators entires are 
tested before we actually see them in mainline. This would also deter 
someone adding nodes without any regulator dependencies.
>
> But we can do that in a follow up if you prefer.
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
thanks for the Ack.

--srini
>
> Regards,
> Bjorn
>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../arm/boot/dts/qcom-apq8064-dragonboard-600c.dts | 55 ++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>> index e96aab6..0a0bcfe 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>> @@ -9,7 +9,62 @@
>>   		serial1 = &gsbi1_serial;
>>   	};
>>
>> +	regulators {
>> +		compatible = "simple-bus";
>> +		vph: regulator-fixed at 1 {
>> +			compatible = "regulator-fixed";
>> +			regulator-min-microvolt = <4500000>;
>> +			regulator-max-microvolt = <4500000>;
>> +			regulator-name = "VPH";
>> +			regulator-type = "voltage";
>> +			regulator-boot-on;
>> +		};
>> +	};
>> +
>>   	soc {
>> +		rpm at 108000 {
>> +			regulators {
>> +				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
>> +				vdd_l3_15_17-supply = <&vph>;
>> +				vdd_l4_14-supply = <&vph>;
>> +				vdd_l5_8_16-supply = <&vph>;
>> +				vdd_l6_7-supply = <&vph>;
>> +				vdd_l9_11-supply = <&vph>;
>> +				vdd_l10_22-supply = <&vph>;
>> +				vdd_l21_23_29-supply = <&vph>;
>> +				vdd_l24-supply = <&pm8921_s1>;
>> +				vdd_l25-supply = <&pm8921_s1>;
>> +				vdd_l26-supply = <&pm8921_s7>;
>> +				vdd_l27-supply = <&pm8921_s7>;
>> +				vdd_l28-supply = <&pm8921_s7>;
>> +				vin_lvs1_3_6-supply = <&pm8921_s4>;
>> +				vin_lvs2-supply = <&pm8921_s1>;
>> +				vin_lvs4_5_7-supply = <&pm8921_s4>;
>> +
>> +				s1 {
>> +					regulator-always-on;
>> +					regulator-min-microvolt = <1225000>;
>> +					regulator-max-microvolt = <1225000>;
>> +					qcom,switch-mode-frequency = <3200000>;
>> +					bias-pull-down;
>> +				};
>> +
>> +				s4 {
>> +					regulator-min-microvolt	= <1800000>;
>> +					regulator-max-microvolt	= <1800000>;
>> +					qcom,switch-mode-frequency = <3200000>;
>> +					bias-pull-down;
>> +					regulator-always-on;
>> +				};
>> +
>> +				s7 {
>> +					regulator-min-microvolt = <1300000>;
>> +					regulator-max-microvolt = <1300000>;
>> +					qcom,switch-mode-frequency = <3200000>;
>> +				 };
>> +			};
>> +		};
>> +
>>   		gsbi at 12440000 {
>>   			status = "okay";
>>   			qcom,mode = <GSBI_PROT_UART_W_FC>;
>> --
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
