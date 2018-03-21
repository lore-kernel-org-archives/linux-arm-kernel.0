From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 21 Mar 2018 13:26:19 +0800
Subject: [PATCH] ARM: dts: db600c: add support to pcie refclk
In-Reply-To: <20180321033518.GB1403@tuxbook-pro>
References: <20180320092840.4600-1-srinivas.kandagatla@linaro.org>
 <20180321033518.GB1403@tuxbook-pro>
Message-ID: <831e8c3b-06e1-8653-df0b-2c1de05834be@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Bjorn for the review comments,

On 21/03/18 11:35, Bjorn Andersson wrote:
> On Tue 20 Mar 17:28 HKT 2018, Srinivas Kandagatla wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to external pcie refclk.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064-db600c.dts | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
>> index 50151ef6e912..7587088c122f 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-db600c.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
>> @@ -45,6 +45,18 @@
>>   
>>   	};
>>   
>> +	clocks {
>> +		compatible = "simple-bus";
>> +		pcie_refclk: pcie-refclk {
> 
> As the si53154 is used to acquire 3 different clocks (2 pcie and 1 sata)
> it would be nice to accurately represent this in the DT. That said,
> exposing this as a clock allow us to change the representation here
> later. (Both pcie_core_clk and pcie_eth_clk use the same gpio pin as
> enable pin, so I don't know how to represent this...)
> 
This is a refclk, which should be always same for both PCIe Controllers 
and connected PCIe endpoints.

For sata we should have one more refclk entry of its own.

> So for now, please name this "pcie_core_clk", per the schematics.

This is pcie refclk, if you follow the line in the schematics should see 
that it terminates to pcie refclk.

> 
>> +			pinctrl-0 = <&pcie_pins>;
>> +			pinctrl-names = "default";
>> +			compatible = "gpio-gate-clock";
>> +	                clocks = <&rpmcc 27>;
>> +			#clock-cells = <0>;
>> +			enable-gpios = <&pm8921_gpio 22 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +
>>   	hdmi-out {
>>   		compatible = "hdmi-connector";
>>   		type = "a";
>> @@ -140,6 +152,16 @@
>>   
>>   		qcom,ssbi at 500000 {
>>   			pmic at 0 {
>> +				gpio at 150 {
>> +					pcie_pins: pcie_pins {
> 
> Please label this "pcie_clk_en_pin" and don't use '_' in the name of the
> node.
> 
I agree, Will fix it.
>> +						pios {
> 
> You can omit this level and just put the properties in directly in the
> pcie-clk-en node.
Okay.

thanks,
srini
> 
>> +							pins = "gpio22";
>> +							function = "normal";
>> +							power-source = <PM8921_GPIO_VPH>;
>> +						};
>> +					};
>> +				};
>> +
> 
> Regards,
> Bjorn
> 
