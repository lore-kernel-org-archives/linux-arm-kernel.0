From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Wed, 11 Mar 2015 18:13:00 +0100
Subject: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150311164442.GA5264@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
Message-ID: <F7BA143D-5CF9-42E3-AFA8-B83B149EF77E@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 11.03.2015 um 17:44 schrieb Tony Lindgren <tony@atomide.com>:

> * Dr. H. Nikolaus Schaller <hns@goldelico.com> [150311 09:17]:
>> Hi,
>> 
>> Am 11.03.2015 um 16:24 schrieb Tony Lindgren <tony@atomide.com>:
>> 
>>> Hi,
>>> 
>>> * Marek Belisko <marek@goldelico.com> [150310 14:28]:
>>>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>>>> ---
>>>> .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++++++++++++++
>>>> 1 file changed, 43 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>>> 
>>>> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>>> new file mode 100644
>>>> index 0000000..d3dd9d8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>>> @@ -0,0 +1,43 @@
>>>> +twl4030_madc_battery
>>>> +
>>>> +Required properties:
>>>> + - compatible : "ti,twl4030-madc-battery"
>>>> + - capacity-uah : battery capacity in uAh
>>>> + - ti,volt-to-capacity-charging-map : list of voltage(mV):level(%) values
>>>> +	for charging calibration (see example)
>>>> + - ti,volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
>>>> +	for discharging calibration (see example)
>>>> + - io-channels: Should contain IIO channel specifiers
>>>> +	for each element in io-channel-names.
>>>> +- io-channel-names: Should contain the following values:
>>>> + * "temp" - The ADC channel for temperature reading
>>>> + * "ichg" - The ADC channel for battery charging status
>>>> + * "vbat" - The ADC channel to measure the battery voltage
>>>> +
>>>> +Example:
>>>> +	madc-battery {
>>>> +		compatible = "ti,twl4030-madc-battery";
>>>> +		capacity-uah = <1200000>;
>>>> +		ti,volt-to-capacity-charging-map = <4200 100>,
>>>> +					        <4100 75>,
>>>> +					        <4000 55>,
>>>> +					        <3900 25>,
>>>> +					        <3800 5>,
>>>> +					        <3700 2>,
>>>> +					        <3600 1>,
>>>> +					        <3300 0>;
>>>> +
>>>> +		ti,volt-to-capacity-discharging-map = <4200 100>
>>>> +						   <4100 95>,
>>>> +						   <4000 70>,
>>>> +						   <3800 50>,
>>>> +						   <3700 10>,
>>>> +						   <3600 5>,
>>>> +						   <3300 0>;
>>>> +		io-channels = <&twl_madc 1>,
>>>> +	                      <&twl_madc 10>,
>>>> +			      <&twl_madc 12>;
>>>> +		io-channel-names = "temp",
>>>> +		                   "ichg",
>>>> +		                   "vbat";
>>>> +	};
>>> 
>>> Rather than just making platform_data into device tree properties..
>>> 
>>> Can't you hide the these custom properties behind the compatible flag?
>>> 
>>> You can initialize that data in the driver based on the compatible
>>> flag and the match data.
>>> 
>>> This makes sense if you can group things to similar configurations.
>> 
>> Maybe I have not completely understood your proposal.
>> 
>> Do you mean to go back to have big parameter tables for each device/battery
>> combination in the driver code and the compatible flag (e.g. compatible = ?board17?)
>> chooses the right data set for the charging map and channels?
> 
> If you can somehow group them, then yes.

I don?t see how to group them. Could you make a proposal?

> Not for every board if there
> are many of them naturally.
> 
>> I thought this is what the DT was introduced for - to have the same driver 
>> code but adapt to different boards depending on hardware variations.
> 
> Yeah but you also need to consider the issues related to introducing
> new device tree properties. The device tree properties introduced
> should be generic where possible.

Yes, that was discussed for a while for this driver?s bindings leading to v4.

Which ones do you think are not generic enough?

> 
>> And batteries have very different characteristics and vary between devices?
> 
> Right. Maybe that has been already agreed on to use capacity-uah for
> batteries in general?

Ah, do you mean with generic/not generic the distinction between a ?ti,? prefix
and no prefix?

Well, I don?t know if there is such an agreement and I would have no argument
against calling it ?ti,capacity-uah?.

> In that case I have not problem with that as
> it?s a generic property :)

Well, many batteries and systems have a fuel gauge chip (e.g. bq27000). This
chip ?knows? the capacity. But therefore it is not needed to specify
it anywhere because it can be read out (usually in uAh).

This driver is to solve the issue that there is no such factory-programmed
battery or fuel gauge chip connected to a twl4030 driver. Nobody can program
that capacity value - except someone matching the device tree with real hardware.

And, by doing and averaging some charge-discharge cycles the fuel gauge
mapping is calibrated.

> 
>> The charging maps are depending on the battery type connected to the twl4030
>> and which madc channel is which value is also a little hardware dependent
>> (although the twl4030 doesn?t give much choice).
> 
> Just to consider alternatives before introducing driver specific
> property for the maps.. Maybe here you could have few different type
> of maps and select something safe by default? Of course it could be this
> is higly board specific, I think some devices may be able to run below
> 3.3V for example..

Every battery setup has a different map (which also might depend on the
series resistance of the battery and the wiring).

> 
>> And moving this information into the driver for each board that uses it
>> would blow up the code.
> 
> Right, I'm not saying we should build databases into the kernel drivers.
> Just trying to avoid introducing driver specific properties unless
> really needed :)

They are not really driver specific, they are battery specific. They
describe properties of the battery:

* capacity - depends on battery
* voltage depending on current charging level - depends on battery (and differs between charging and discharging)
* wiring of MADC inputs to the twl4030 is board dependent.

So all these properties are not driver specific, but describe hardware.
And therefore they had been introduced exactly this way into the old
platform_data driver.

So if you want to see a ?ti," prefix to the capacity property I would be
fine.

BR,
Nikolaus
