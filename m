From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Mar 2014 15:01:54 +0900
Subject: [PATCH 5/5] ARM: dts: exynos4412-trats2: Add ADC's dt data to get
 temperature of SoC/battery
In-Reply-To: <531F0AEC.7010606@samsung.com>
References: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
 <1394524494-30641-6-git-send-email-cw00.choi@samsung.com>
 <531F0AEC.7010606@samsung.com>
Message-ID: <531FF852.8090502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 03/11/2014 10:09 PM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 11.03.2014 08:54, Chanwoo Choi wrote:
>> This patch use ADC to get the temperature of SoC/battery by using NTC thermistor
>> driver in hwmon. NTC thermistor driver covnvert ADC's raw data to temperature
>> by using following variables:
>>
>> - pullup-uv    : Voltage
>> - pullup-ohm   : Pull-up resistance
>> - pulldown-ohm : Pull-down resistance
>> - io-channels  : It means ADC channel.
>>
> 
> Those properties are well-defined in "ntc,ncp15wb473" DT bindings documentation. There is no need to repeat them here.
> 
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4412-trats2.dts | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
>> index 4f851cc..fc517c3 100644
>> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
>> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
>> @@ -106,6 +106,27 @@
>>           };
>>       };
>>
>> +    adc: adc at 126C0000 {
>> +        vdd-supply = <&ldo3_reg>;
>> +        status = "okay";
>> +
>> +        ncp15wb473 at 0 {
> 
> style: Nodes should have generic names, e.g. thermistor at 0.
> 
> Also if node name is suffixed with @unit-address, then the node should have a reg property with its first entry corresponding to the unit-address. Now there is no physical unit-address definition for those thermistors, so they shouldn't use this naming pattern, but rather something like "thermistor-0" or "thermistor-ap".

OK I'll rename thermistor dt name.
> 
>> +            compatible = "ntc,ncp15wb473";
>> +            pullup-uv = <1800000>;     /* VCC_1.8V_AP */
>> +            pullup-ohm = <100000>;     /* 100K */
>> +            pulldown-ohm = <100000>; /* 100K */
>> +            io-channels = <&adc 1>;  /* AP temperature */
>> +        };
>> +
>> +        ncp15wb473 at 1 {
>> +            compatible = "ntc,ncp15wb473";
>> +            pullup-uv = <1800000>;     /* VCC_1.8V_AP */
>> +            pullup-ohm = <100000>;     /* 100K */
>> +            pulldown-ohm = <100000>; /* 100K */
>> +            io-channels = <&adc 2>;  /* Battery temperature */
>> +        };
> 
> Anyway, I don't think it is correct to place IIO consumers under IIO provider node, because IIO is not a control bus, but rather a resource provider, like GPIO, clock, etc. So both thermistor nodes should be placed outside the adc node. (They might be grouped in a simple-bus subnode, though, to improve readability.)

OK, I'll move ntc_thermistor node outside of ADC dt node.

Best Regards,
Chanwoo Choi
