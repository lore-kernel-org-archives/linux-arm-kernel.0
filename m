From: lyu@micile.com (Lawrence Yu)
Date: Thu, 22 Oct 2015 22:23:16 -0700
Subject: [linux-sunxi] [PATCH v2 1/1] dts: sun6i: yones toptech bs1078 v2:
 Add AXP221 support to dts
In-Reply-To: <CAGb2v66NvzMu-aJe1x2wTB0F9xLG_EPh3nd0k0Z8FS5UqTs5Vg@mail.gmail.com>
References: <1445191673-8869-1-git-send-email-lyu@micile.com>
 <CAGb2v65S9R=sLVRBdUKFUDXCbEFJWF9Sp8Yw__+Q6ncpgPp7kg@mail.gmail.com>
 <CAN0iSBp9vypyPnrwmSRQnB33kk84NZ=_1QAf4YYFtSA9R0CoTw@mail.gmail.com>
 <CAGb2v66NvzMu-aJe1x2wTB0F9xLG_EPh3nd0k0Z8FS5UqTs5Vg@mail.gmail.com>
Message-ID: <5629C444.1040203@micile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2015 6:18 AM, Chen-Yu Tsai wrote:
> On Thu, Oct 22, 2015 at 12:15 AM, Lawrence Yu <lyu@micile.com> wrote:
>> On Mon, Oct 19, 2015 at 2:59 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>>> On Mon, Oct 19, 2015 at 2:07 AM, Lawrence Yu <lyu@micile.com> wrote:
>>>> Enable the axp221 PMIC chip in the dts file.
>>>>
>>>> Allows board to power off correctly from the poweroff command
>>>>
>>>> This board requires dc1sw to be enabled in order to provide a power source
>>>> for the 5V DCDC converter that powers USB2 and the LCD backlight
>>>>
>>>> This board uses dldo1 for 3.3V wifi power
>>>>
>>>> This board requires dldo3 to be enabled at 2.8V in order to provide voltage
>>>> to the pullup resistors for the i2c0 bus.
>>>>
>>>> ---
>>>>
>>>> Changes since v1
>>>>
>>>> - Use axp22x.dtsi to standardize the register names
>>>> - Change wifi power regulator to dldo1 instead of incorrect aldo1
>>>> - Remove unnecessary gpio pin PH27 for wifi power, since this board uses
>>>>    the axp221 chip to control power to the wifi chip.
>>>>
>>>> Signed-off-by: Lawrence Yu <lyu@micile.com>
>>>> ---
>>>>   .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     | 98 +++++++++++++++++++---
>>>>   1 file changed, 88 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
>>>> index b199020..98d0a83 100644
>>>> --- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
>>>> +++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
>>>> @@ -113,22 +113,100 @@
>>>>          allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>>>>   };
>>>>
>>>> -&reg_usb1_vbus {
>>>> -       gpio = <&pio 7 27 GPIO_ACTIVE_HIGH>;
>>>> +&uart0 {
>>>> +       pinctrl-names = "default";
>>>> +       pinctrl-0 = <&uart0_pins_a>;
>>>>          status = "okay";
>>>>   };
>>>>
>>>> -&usb1_vbus_pin_a {
>>>> -       allwinner,pins = "PH27";
>>>> +&p2wi {
>>>> +       status = "okay";
>>>> +
>>>> +       axp22x: pmic at 68 {
>>>> +               compatible = "x-powers,axp221";
>>>> +               reg = <0x68>;
>>>> +               interrupt-parent = <&nmi_intc>;
>>>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>>> +       };
>>>>   };
>>>>
>>>> -&usbphy {
>>>> -       usb1_vbus-supply = <&reg_usb1_vbus>;
>>>> -       status = "okay";
>>>> +#include "axp22x.dtsi"
>>>> +
>>>> +&axp22x {
>>>> +       regulators {
>>>> +               /* Used by LCD backlight and USB2 */
>>>> +               reg_dc1sw: dc1sw {
>>>> +                       regulator-name = "dc1sw";
>>>> +                       regulator-min-microvolt = <3000000>;
>>>> +                       regulator-max-microvolt = <3000000>;
>>>> +                       regulator-name = "vcc-dc1sw";
>>>
>>> I would use "vcc-lcd-usb2". Or just "vcc-lcd" if it proves it has nothing
>>> to do with USB. Plus there's 2 "regulator-name" entries here.
>>>
>>
>> I will remove the extra regulator-name (not sure how I did not see
>> that) and use "vcc-lcd-usb2" as the regulator name.  I have an
>> explanation as to why I believe dc1sw also controls power to usb2
>> below.
>>
>>>> +               };
>>>> +       };
>>>>   };
>>>>
>>>> -&uart0 {
>>>> -       pinctrl-names = "default";
>>>> -       pinctrl-0 = <&uart0_pins_a>;
>>>> +&reg_aldo3 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <2700000>;
>>>> +       regulator-max-microvolt = <3300000>;
>>>> +       regulator-name = "avcc";
>>>> +};
>>>> +
>>>> +&reg_dc5ldo {
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-cpus";
>>>> +};
>>>> +
>>>> +&reg_dcdc1 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <3000000>;
>>>> +       regulator-max-microvolt = <3000000>;
>>>> +       regulator-name = "vcc-3v0";
>>>> +};
>>>> +
>>>> +&reg_dcdc2 {
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-gpu";
>>>> +};
>>>> +
>>>> +&reg_dcdc3 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-cpu";
>>>> +};
>>>> +
>>>> +&reg_dcdc4 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-sys-dll";
>>>> +};
>>>> +
>>>> +&reg_dcdc5 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <1500000>;
>>>> +       regulator-max-microvolt = <1500000>;
>>>> +       regulator-name = "vcc-dram";
>>>> +};
>>>> +
>>>> +&reg_dldo1 {
>>>> +       regulator-min-microvolt = <3300000>;
>>>> +       regulator-max-microvolt = <3300000>;
>>>> +       regulator-name = "vcc-wifi";
>>>> +};
>>>> +
>>>> +/* Voltage source for I2C pullup resistors for I2C Bus 0 */
>>>> +&reg_dldo3 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <2800000>;
>>>> +       regulator-max-microvolt = <2800000>;
>>>> +       regulator-name = "vcc-csi";
>>>
>>> This should probably be named "vddio-csi".
>>
>> I will change the name of the regulator to "vddio-csi".  I did not
>> realize that dldo3 was connected to the io vdd of the cameras until
>> you pointed it out, the A31 reference schematic also verifies this.
>
> The FEX file also says so.
>
>>>
>>> I think Maxime and Hans were still debating whether the camera VDDIO
>>> regulator should be defined independently as "always-on", instead of
>>> having the I2C subsystem do some kind of power sequencing.
>>>
>>
>> I propose to remove the regulator-always-on from dldo3 for now to
>> match Maxime and Hans' resolution for the protab2-ips9 tablet which
>> has similar behavior.  i2c0 is not defined yet for this board so not
>> turning on dldo3 should not cause any loss of functionality.
>>
>>> I wonder if the power domain stuff would work for this.
>>
>> I defer to Maxime's response about power domain since I have no
>> knowledge or experience pertaining to power domains.
>>
>>>
>>>> +};
>>>> +
>>>> +&usbphy {
>>>> +       usb1_vbus-supply = <&reg_dldo1>;
>>>> +       usb2_vbus-supply = <&reg_dc1sw>;
>>>
>>> This looks weird, though I cannot say it is impossible. There is likely
>>> a boost regulator after this so the output is proper 5V for USB.
>>>
>>
>> I believe that you are correct that there is a boost regulator to make
>> 5V for the USB2.  The power input and/or enable line to the boost
>> regulator appears to be connected to the output of dc1sw since if I
>> set dc1sw to regulator-always-on or as the usb2_vbus-supply, the USB2
>> will provide power to devices plugged into the USB port (LEDs on the
>> device light up).  If I do not, then devices attached to USB2 do not
>> appear to receive any power.
>>
>> Enabling or disabling dc1sw also determines whether the LCD backlight
>> turns on or not.  From my testing the backlight enable line is
>> connected to gpio PA25 so it seems most likely that the input of the
>> boost regulator for the LCD backlight is the output of dc1sw.
>
> In most designs, the LCD backlight is powered by a LED boost regulator,
> which is powered from IPSOUT of the PMIC. This regulator has its enable
> pin connected to a GPIO, PA25 in this case. Often the feedback pin is
> also connected to the PWM output (PH13) of the SoC, and there is also a
> pull-up from VCC-LCD. Hans speculates this is to prevent flickering.
>
> DC1SW only powers the LCD panel itself, not the backlight. You could
> play with the GPIOs and regulator, and see if can get just one of them
> to be on.
>

I experimented with the 8 possible value combinations of PH13 (PWM), 
PA25 (ENABLE), and DC1SW.  The only combination that would make the LCD 
backlight light up was DC1SW ON, PWM LOW, ENABLE HIGH.  The other 7 
combinations would make the LCD backlight stay dark.

I will remove the comment of "Used by LCD backlight and USB2" from 
reg_dc1sw in the dts to avoid any confusion until I can get a better 
understanding of what exactly is controlling the backlight.

> As for USB2, if the intention is to have the device available when the
> user is actively using the tablet, like for a storage or input device,
> it makes sense to tie it to the LCD power.
>
>> If there is a more conventional way to have dc1sw enabled for the
>> USB2, I can make the change to do that.
>
> I think this is fine, even though we are omitting the boost regulator.
> If that is of concern, you can just chain a fixed regulator in between.
>

>>> Also, we only have the FEX file for v1 of this board in sunxi-boards.
>>> Would it be possible for you to extract and submit it?
>>>
>>
>> I have the fex file extracted and I will submit a separate patch with
>> the fex file to sunxi-boards.
>
> Can you add your signed-off-by to that for the record? No need to resend,
> just reply to it.
>

Will do.

Thanks!

> Thanks
> ChenYu
>
>>> Having the FEX file makes reviewing the dts without schematics slightly
>>> easier.
>>>
>>> Thanks
>>> ChenYu
>>>
>>>>          status = "okay";
>>>>   };
>>>> --
>>>> 2.5.3
>>>>
>>>> --
>>>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>>>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>>>> For more options, visit https://groups.google.com/d/optout.
>>>
>>> --
>>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>>> For more options, visit https://groups.google.com/d/optout.
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
