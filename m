From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 19 May 2017 09:55:32 +0100
Subject: [linux-sunxi] [PATCH v6 8/9] arm64: allwinner: a64: enable AXP803
 regulators for Pine64
In-Reply-To: <4B129FD0-4AEB-4DC3-AF33-C279468BD197@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-9-icenowy@aosc.io>
 <98ae1ea8-ef08-8859-63d8-57c56a6348a6@arm.com>
 <4B129FD0-4AEB-4DC3-AF33-C279468BD197@aosc.io>
Message-ID: <77045320-c19a-6c18-ed68-108fa5416c2a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/05/17 09:29, Icenowy Zheng wrote:
> 
> 
> ? 2017?5?19? GMT+08:00 ??4:27:21, Andre Przywara <andre.przywara@arm.com> ??:
>> Hi,
>>
>> On 18/05/17 08:16, Icenowy Zheng wrote:
>>> Add support of AXP803 regulators in the Pine64 device tree, in order
>> to
>>> enable many future functionalities, e.g. Wi-Fi.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>> Changes in v6:
>>> - Rebased on next-20170517.
>>>
>>>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 109
>> +++++++++++++++++++++
>>>  1 file changed, 109 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> index 36001884ed33..40921bacb39c 100644
>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> @@ -118,6 +118,115 @@
>>>  	};
>>>  };
>>>  
>>> +#include "axp803.dtsi"
>>> +
>>> +&reg_aldo1 {
>>> +	regulator-min-microvolt = <2800000>;
>>> +	regulator-max-microvolt = <2800000>;
>>> +	regulator-name = "vcc-csi";
>>> +};
>>> +
>>> +&reg_aldo2 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-pl";
>>> +};
>>> +
>>> +&reg_aldo3 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <2700000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-pll-avcc";
>>> +};

The schematic puts this at a fixed 3.0V, so why the range here? Are we
expected to tune the voltage of the PLLs?

>>> +
>>> +&reg_dc1sw {
>>> +	regulator-name = "vcc-phy";
>>> +};
>>> +
>>> +&reg_dcdc1 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-3v3";
>>> +};
>>> +
>>> +&reg_dcdc2 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1000000>;
>>> +	regulator-max-microvolt = <1300000>;
>>> +	regulator-name = "vdd-cpux";
>>> +};
>>> +
>>> +/* DCDC3 is polyphased with DCDC2 */
>>> +
>>> +&reg_dcdc5 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1500000>;
>>> +	regulator-max-microvolt = <1500000>;
>>> +	regulator-name = "vcc-dram";
>>> +};
>>
>> I think I mentioned this before, but the Pine64 has DDR3L DRAM, which
>> is
>> specified to run at 1.35V (1.36V with the 20mV granularity of the AXP).
>> The reset value is even (wrongly?) configured to 1.24V.
>>
>> So is there any reason you set the voltage to 1.5V? Is that what the
>> BSP
>> does? Or did you see any problems with 1.36V?
> 
> I just set it based on the schematics.

I wouldn't trust the schematics too much. They are rather generic, see
the Ethernet page, for instance, showing *different* PHYs, not just the
ones used.
For the DRAM the Pine64 schematic does not even tell the DRAM chip used,
the name under the chip is just describing the package.

> And 1.35v cannot be accurately achieved by dcdc5 and it's a problem whether to use 1.34v or 1.36v ;-)

Well, as I wrote above, 1.36V is the voltage to go with. I think 10mV
more is well within the tolerance ;-)

>>> +&reg_dcdc6 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1100000>;
>>> +	regulator-max-microvolt = <1100000>;
>>> +	regulator-name = "vdd-sys";
>>> +};
>>> +
>>> +&reg_dldo1 {
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-hdmi";
>>> +};
>>> +
>>> +&reg_dldo2 {
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-mipi";
>>> +};
>>> +
>>> +&reg_dldo3 {
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "avdd-csi";
>>> +};

If you stick to the schematic, this should be 2.8V.

>>> +
>>> +&reg_dldo4 {
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-wifi";
>>> +};
>>> +
>>> +&reg_eldo1 {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "cpvdd";
>>> +};
>>> +
>>> +&reg_eldo3 {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "vdd-1v8-csi";
>>> +};

The schematic lists 1.2V/1.5V/1.8V here, so should we have a range?

>>> +
>>> +&reg_fldo1 {
>>> +	regulator-min-microvolt = <1200000>;
>>> +	regulator-max-microvolt = <1200000>;
>>> +	regulator-name = "vcc-1v2-hsic";
>>> +};
>>> +
>>> +&reg_fldo2 {
>>> +	regulator-always-on;

Why do we need to turn this on? Upstream firmware does not use the
arisc, so it can stay off.
Also in general I think Linux should not tinker with the management
processor at all.

Cheers,
Andre.

>>> +	regulator-min-microvolt = <1100000>;
>>> +	regulator-max-microvolt = <1100000>;
>>> +	regulator-name = "vdd-cpus";
>>> +};
>>> +
>>> +&reg_rtc_ldo {
>>> +	regulator-name = "vcc-rtc";
>>> +};
>>> +
>>>  /* On Exp and Euler connectors */
>>>  &uart0 {
>>>  	pinctrl-names = "default";
>>>
