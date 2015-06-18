From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 18 Jun 2015 18:16:01 +0200
Subject: [PATCH 09/20] ARM: dts: sun4i: Enable USB DRC on the Cubieboard
In-Reply-To: <20150618155935.GR11732@lukather>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
 <1433530943-12599-10-git-send-email-hdegoede@redhat.com>
 <20150618155935.GR11732@lukather>
Message-ID: <5582EEC1.80505@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18-06-15 17:59, Maxime Ripard wrote:
> Hi Hans,
>
> On Fri, Jun 05, 2015 at 09:02:12PM +0200, Hans de Goede wrote:
>> Enable the otg/drc usb controller on the Cubieboard. Note that the
>> 5V of the otg is directly connected to the general 5V, so we only use
>> the id pin.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> index 9afb4e0..046a84d 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> @@ -155,6 +155,10 @@
>>   	status = "okay";
>>   };
>>
>> +&otg_sram {
>> +	status = "okay";
>> +};
>> +
>>   &pio {
>>   	led_pins_cubieboard: led_pins at 0 {
>>   		allwinner,pins = "PH20", "PH21";
>> @@ -162,6 +166,13 @@
>>   		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
>>   		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>   	};
>> +
>> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
>> +		allwinner,pins = "PH4";
>> +		allwinner,function = "gpio_in";
>> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +	};
>>   };
>>
>>   &reg_ahci_5v {
>> @@ -216,7 +227,15 @@
>>   	status = "okay";
>>   };
>>
>> +&usb_otg {
>> +	dr_mode = "otg";
>> +	status = "okay";
>> +};
>> +
>>   &usbphy {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb0_id_detect_pin>;
>> +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>
> Does that work?

Yes :)

> Your phy driver seem to actively check at probe time for both the ID
> detect and VBUS detect pins to be set in the DT, which is not the case
> here.

My initial version did, later on I added a patch adding special handling
for boards which have Vusb hardwired to the 5V of the board such as the
cubieboard (the schematics show both a current regulator and an optional
0 ohm resistor to short-circuit that, it seems that the boards are
shipped with short-circuiting resistor, at least all mine are (both a10
and a20 variants).

See here for the patch:
https://github.com/jwrdegoede/linux-sunxi/commit/b73922986cab2bad9d54a2a1223583008e155bc4

This is part of the v5 phy-sun4i-usb series I send to Kishon a week ago.

> I don't really get either why VBUS detect has to be set. Can't it work
> just fine if you have a regulator that you can control and the ID pin
> alone ?

Not really, we can work around it as done in the above commit, but it
is not ideal.

Vbus detect going low is used by the musb silicon to determine that the
current session has ended, and without this happening it will not
switch from host to device mode or vice versa no matter what the id pin
does.

Vbus detect is also used to not provide power to the port if external
power is present as doing so is not a good idea.

Last vbus-detect is used to detect that the devices connected to the
port are using too much power.

Regards,

Hans
