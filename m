From: codekipper@gmail.com (Code Kipper)
Date: Mon, 8 Feb 2016 17:56:06 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Enable USB DRC on Itead Ibox
In-Reply-To: <56B8BED7.9030704@redhat.com>
References: <1454947167-12236-1-git-send-email-codekipper@gmail.com>
 <56B8BED7.9030704@redhat.com>
Message-ID: <CAEKpxBkXp9hx6KWpWyRBvYBFi7Sr0FgFHrD6M0nSBuJ1bV++1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2016 at 17:14, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 08-02-16 16:59, codekipper at gmail.com wrote:
>>
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Enable the otg/drc usb controller on the Itead Ibox device.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
>
> Same remark as with your Olimex A20 EVB board patch, please
> also provide a vbus detect pin setting. If for some reason the
> VBus detect is not wired up, or not working properly, please mention
> this explicitly in the commit message.
Hi Hans,
I've added vbus detect and it no longer works. It's mentioned that the
Itead Ibox is similar to the Cubieboard 2 which also doesn't include
the detect. I can see now in the commit that it states "Note this
board has the otg-vbus connected directly to the 5v-dcc of the board,
so there is no vbus0 regulator, nor vbus0-det.", I will add this to
the commit message and try and dig out a schematic to confirm.
Thanks,
CK
>
> Note that in some cases the axp209 is used for vbus detect,
> rather then a gpio, see e.g. :
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/sun7i-a20-bananapi.dts?id=dcfd8443d89f593e0c667a988ab017e716b33061
>
> Regards,
>
> Hans
>
>
>
>
>> ---
>>   arch/arm/boot/dts/sun7i-a20-itead-ibox.dts     | 14 ++++++++++++++
>>   arch/arm/boot/dts/sunxi-itead-core-common.dtsi |  9 +++++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>> b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>> index 661c21d..a512581 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>> @@ -118,8 +118,22 @@
>>                 allwinner,drive = <SUN4I_PINCTRL_20_MA>;
>>                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>         };
>> +
>> +       usb0_id_detect_pin: usb0_id_detect_pin at 0 {
>> +               allwinner,pins = "PH4";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +       };
>>   };
>>
>>   &reg_ahci_5v {
>>         status = "okay";
>>   };
>> +
>> +&usbphy {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&usb0_id_detect_pin>;
>> +       usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>> b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>> index 2565d51..d22eea3 100644
>> --- a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>> +++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>> @@ -88,6 +88,10 @@
>>         status = "okay";
>>   };
>>
>> +&otg_sram {
>> +       status = "okay";
>> +};
>> +
>>   #include "axp209.dtsi"
>>
>>   &reg_dcdc2 {
>> @@ -129,6 +133,11 @@
>>         status = "okay";
>>   };
>>
>> +&usb_otg {
>> +       dr_mode = "otg";
>> +       status = "okay";
>> +};
>> +
>>   &usbphy {
>>         usb1_vbus-supply = <&reg_usb1_vbus>;
>>         usb2_vbus-supply = <&reg_usb2_vbus>;
>>
>
