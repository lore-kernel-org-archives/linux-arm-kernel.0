From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 3 Aug 2015 15:11:41 +0200
Subject: [linux-sunxi] Re: [PATCH v2] ARM: dts: sunxi: Add regulators for
 LeMaker BananaPi
In-Reply-To: <20150803094723.GD2564@lukather>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
 <20150803094723.GD2564@lukather>
Message-ID: <55BF688D.5010905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03-08-15 11:47, Maxime Ripard wrote:
> On Sun, Aug 02, 2015 at 06:18:25PM +0200, Timo Sigurdsson wrote:
>> sun7i-a20-bananapi.dts doesn't contain regulator nodes for the AXP209 PMU
>> driver, so add them to allow for voltage-scaling with cpufreq-dt.
>>
>> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
>> ---
>> Changes since v1 (RFC):
>>
>> - Dropped the changes to the cpufreq operating points and renamed the patch
>> accordingly
>> - Limited the CPU voltage range so it doesn't exceed the SOC specifications
>> ---
>>   arch/arm/boot/dts/sun7i-a20-bananapi.dts | 35 ++++++++++++++++++++++++++++----
>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> index 9f7b472..74382f3 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> @@ -92,6 +92,10 @@
>>   	status = "okay";
>>   };
>>
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>>   &ehci0 {
>>   	status = "okay";
>>   };
>> @@ -119,13 +123,9 @@
>>   	status = "okay";
>>
>>   	axp209: pmic at 34 {
>> -		compatible = "x-powers,axp209";
>>   		reg = <0x34>;
>>   		interrupt-parent = <&nmi_intc>;
>>   		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> -
>> -		interrupt-controller;
>> -		#interrupt-cells = <1>;
>>   	};
>>   };
>>
>> @@ -182,6 +182,33 @@
>>   	};
>>   };
>>
>> +#include "axp209.dtsi"
>> +
>> +&reg_dcdc2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc3 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-int-dll";
>> +};
>> +
>> +&reg_ldo1 {
>> +	regulator-name = "vdd-rtc";
>> +};
>> +
>> +&reg_ldo2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <3000000>;
>> +	regulator-max-microvolt = <3000000>;
>> +	regulator-name = "avcc";
>> +};
>
> What regulator provides the 3.3V regulator used in the rest of this DT
> then (MMC, GMAC) ?

A separate fixed regulator, like most (all?) other axp209 using boards,
e.g. the cubieboard has a TCS4199 regulator for this, and the banana
boards use a XL8206/UP1746 for this, according to the schematics I
have.

Regards,

Hans

>
> Maxime
>
