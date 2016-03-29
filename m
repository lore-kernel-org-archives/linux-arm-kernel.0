From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 29 Mar 2016 16:02:08 +0100
Subject: [PATCH 01/12] ARM: dts: apq8064: fix the pinctrls for i2c and spi
In-Reply-To: <20160329142807.GF8929@tuxbot>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762421-9339-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160329142807.GF8929@tuxbot>
Message-ID: <56FA98F0.2000300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/03/16 15:28, Bjorn Andersson wrote:
> On Wed 23 Mar 12:47 PDT 2016, Srinivas Kandagatla wrote:
>
>> This patch fixes pinctrls for spi and i2c nodes whose default and sleep
>> states are together, which is incorrect.
>>
>> Without this patch i2c/spi would not be functional.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> The change in itself is sound, but I don't understand why i2c/spi fails
> to function if we don't bring them to a sleep state. Can you please
> update the commit message with an explanation?

Yes, with the existing code the device would endup configuring the 
default pinstate to sleep pinconf. So the i2c bus would not be functional.

If you try mainline on any 8064 based boards you would easily reproduce 
the bug. For example read the eeprom on IFC6410.
>
>
> PS. Whenever there's multiple states for a thing I do prefer prefixing
> them _a and _s to highlight that difference (not only suffixing the
> sleep state). And use abbreviations :)

If I search for _sleep in dts folder these are widely used, am not sure 
which is the prefered way to do this, as long as its readable by user am 
ok to do it either way.

>
> Regards,
> Bjorn
>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064.dtsi | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> index 65d0e8d..c6ff8fc 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> @@ -227,7 +227,8 @@
>>
>>   			gsbi1_i2c: i2c at 12460000 {
>>   				compatible = "qcom,i2c-qup-v1.1.1";
>> -				pinctrl-0 = <&i2c1_pins &i2c1_pins_sleep>;
>> +				pinctrl-0 = <&i2c1_pins>;
>> +				pinctrl-1 = <&i2c1_pins_sleep>;
>>   				pinctrl-names = "default", "sleep";
>>   				reg = <0x12460000 0x1000>;
>>   				interrupts = <0 194 IRQ_TYPE_NONE>;
>> @@ -255,7 +256,8 @@
>>   			gsbi2_i2c: i2c at 124a0000 {
>>   				compatible = "qcom,i2c-qup-v1.1.1";
>>   				reg = <0x124a0000 0x1000>;
>> -				pinctrl-0 = <&i2c2_pins &i2c2_pins_sleep>;
>> +				pinctrl-0 = <&i2c2_pins>;
>> +				pinctrl-1 = <&i2c2_pins_sleep>;
>>   				pinctrl-names = "default", "sleep";
>>   				interrupts = <0 196 IRQ_TYPE_NONE>;
>>   				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
>> @@ -277,7 +279,8 @@
>>   			ranges;
>>   			gsbi3_i2c: i2c at 16280000 {
>>   				compatible = "qcom,i2c-qup-v1.1.1";
>> -				pinctrl-0 = <&i2c3_pins &i2c3_pins_sleep>;
>> +				pinctrl-0 = <&i2c3_pins>;
>> +				pinctrl-1 = <&i2c3_pins_sleep>;
>>   				pinctrl-names = "default", "sleep";
>>   				reg = <0x16280000 0x1000>;
>>   				interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
>> @@ -302,7 +305,8 @@
>>
>>   			gsbi4_i2c: i2c at 16380000 {
>>   				compatible = "qcom,i2c-qup-v1.1.1";
>> -				pinctrl-0 = <&i2c4_pins &i2c4_pins_sleep>;
>> +				pinctrl-0 = <&i2c4_pins>;
>> +				pinctrl-1 = <&i2c4_pins_sleep>;
>>   				pinctrl-names = "default", "sleep";
>>   				reg = <0x16380000 0x1000>;
>>   				interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
>> @@ -337,7 +341,8 @@
>>   				compatible = "qcom,spi-qup-v1.1.1";
>>   				reg = <0x1a280000 0x1000>;
>>   				interrupts = <0 155 0>;
>> -				pinctrl-0 = <&spi5_default &spi5_sleep>;
>> +				pinctrl-0 = <&spi5_default>;
>> +				pinctrl-1 = <&spi5_sleep>;
>>   				pinctrl-names = "default", "sleep";
>>   				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
>>   				clock-names = "core", "iface";
>> @@ -370,7 +375,8 @@
>>
>>   			gsbi6_i2c: i2c at 16580000 {
>>   				compatible = "qcom,i2c-qup-v1.1.1";
>> -				pinctrl-0 = <&i2c6_pins &i2c6_pins_sleep>;
>> +				pinctrl-0 = <&i2c6_pins>;
>> +				pinctrl-1 = <&i2c6_pins_sleep>;
>>   				pinctrl-names = "default", "sleep";
>>   				reg = <0x16580000 0x1000>;
>>   				interrupts = <GIC_SPI 157 IRQ_TYPE_NONE>;
>> --
>> 2.5.0
>>
