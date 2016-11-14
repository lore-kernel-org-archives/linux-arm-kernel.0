From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Nov 2016 17:32:51 +0000
Subject: [PATCH 2/2] ARM: dts: apq8064: add support to pm8821
In-Reply-To: <20161108191343.GP25787@tuxbot>
References: <1478622577-20699-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1478622577-20699-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20161108191343.GP25787@tuxbot>
Message-ID: <10ef1c9d-60d5-f719-11a5-81135ba0bec3@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Bjorn for review comments.


On 08/11/16 19:13, Bjorn Andersson wrote:
> On Tue 08 Nov 08:29 PST 2016, Srinivas Kandagatla wrote:
>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom-apq8064.dtsi | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> index 1dbe697..fde006c 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> @@ -627,6 +627,34 @@
>>  			clock-names = "core";
>>  		};
>>
>> +		qcom,ssbi at c00000 {
>
> No "qcom," in the node name.
Will fix it in next version,  I agree with rest of the comments too.
All of them will be fixed in next version.
>
>> +			compatible = "qcom,ssbi";
>> +			reg = <0x00c00000 0x1000>;
>> +			qcom,controller-type = "pmic-arbiter";
>> +
>> +			pmicintc2: pmic at 1 {
>
> I think we should follow Linus' lead and label this "pm8821".
>
>> +				compatible = "qcom,pm8821";
>> +				interrupt-parent = <&tlmm_pinmux>;
>> +				interrupts = <76 8>;
>
> Please spell out IRQ_TYPE_LEVEL_LOW.
>
> And interrupts-extended = <&tlmm_pinmux 76 IRQ_TYPE_LEVEL_LOW> combines
> the two lines nicely.
>
>> +				#interrupt-cells = <2>;
>> +				interrupt-controller;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				pm8821_mpps: mpps at 50 {
>> +
>
> Extra newline.
>
>> +					compatible = "qcom,pm8821-mpp", "qcom,ssbi-mpp";
>> +					reg = <0x50>;
>> +
>> +					interrupts = <24 1>, <25 1>, <26 1>,
>> +						     <27 1>;
>
> I think these should be IRQ_TYPE_NONE per the discussion on how to share
> interrupts between the gpio/mpp driver and other clients.
>
> On the other hand, per the pm8821 driver we only support LEVEL_LOW
> (high?).
>
>> +
>> +					gpio-controller;
>> +					#gpio-cells = <2>;
>> +		                };
>> +			};
>> +		};
>> +
>
> Regards,
> Bjorn
>
