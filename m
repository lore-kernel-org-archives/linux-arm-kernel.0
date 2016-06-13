From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 13 Jun 2016 11:32:32 +0200
Subject: [PATCH 4/6] ARM: dts: sun8i-a?3-q8-tablet.dts: Add full otg
 support
In-Reply-To: <CAGb2v67+56hd6b+mZLNpMHPRGu3Fp9j-zJLNS2MkUmy2N_Lmdw@mail.gmail.com>
References: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
 <1465653186-953-5-git-send-email-hdegoede@redhat.com>
 <CAGb2v67+56hd6b+mZLNpMHPRGu3Fp9j-zJLNS2MkUmy2N_Lmdw@mail.gmail.com>
Message-ID: <4b407a13-0c65-10ca-6379-b66125ac89e7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13-06-16 05:19, Chen-Yu Tsai wrote:
> Hi,
>
> On Sat, Jun 11, 2016 at 9:53 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Now that we've all the necessary bits in place we can enable
>> full otg support on these tablets.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun8i-a23-q8-tablet.dts | 15 ---------------
>>  arch/arm/boot/dts/sun8i-a33-q8-tablet.dts | 15 ---------------
>>  arch/arm/boot/dts/sun8i-q8-common.dtsi    | 31 +++++++++++++++++++++++++++++++
>>  3 files changed, 31 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
>> index 6062ea7..956320a 100644
>> --- a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
>> +++ b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
>> @@ -48,18 +48,3 @@
>>         model = "Q8 A23 Tablet";
>>         compatible = "allwinner,q8-a23", "allwinner,sun8i-a23";
>>  };
>> -
>> -/*
>> - * FIXME for now we only support host mode and rely on u-boot to have
>> - * turned on Vbus which is controlled by the axp223 pmic on the board.
>> - *
>> - * Once we have axp223 support we should switch to fully supporting otg.
>> - */
>> -&usb_otg {
>> -       dr_mode = "host";
>> -       status = "okay";
>> -};
>> -
>> -&usbphy {
>> -       status = "okay";
>> -};
>> diff --git a/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts b/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
>> index 44b3229..b0bc236 100644
>> --- a/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
>> +++ b/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
>> @@ -48,18 +48,3 @@
>>         model = "Q8 A33 Tablet";
>>         compatible = "allwinner,q8-a33", "allwinner,sun8i-a33";
>>  };
>> -
>> -/*
>> - * FIXME for now we only support host mode and rely on u-boot to have
>> - * turned on Vbus which is controlled by the axp223 pmic on the board.
>> - *
>> - * Once we have axp223 support we should switch to fully supporting otg.
>> - */
>> -&usb_otg {
>> -       dr_mode = "host";
>> -       status = "okay";
>> -};
>> -
>> -&usbphy {
>> -       status = "okay";
>> -};
>> diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
>> index 346a49d..991087f 100644
>> --- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
>> @@ -87,6 +87,13 @@
>>                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>                 allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>>         };
>> +
>> +       usb0_id_detect_pin: usb0_id_detect_pin at 0 {
>> +               allwinner,pins = "PH8";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +       };
>>  };
>>
>>  &r_rsb {
>> @@ -98,6 +105,7 @@
>>                 interrupt-parent = <&nmi_intc>;
>>                 interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>                 eldoin-supply = <&reg_dcdc1>;
>> +               x-powers,drive-vbus-en;
>>         };
>>  };
>>
>> @@ -163,6 +171,11 @@
>>         regulator-name = "vcc-dram";
>>  };
>>
>> +&reg_drivevbus {
>> +       regulator-name = "usb0-vbus";
>> +       status = "okay";
>
> Adding a drivevbus-supply referencing vcc_5v0 (in the axp node) so
> it doesn't show 0V would be nice.

Ack, given that you've just asked for this with a number of boards,
I think that this belongs in axp22x.dtsi. I'll prepare a follow-up patch for
this.

Regards,

Hans



>
> Sorry for the late reply. I was out on vacation for a few days.
>
> ChenYu
>
>> +};
>> +
>>  &reg_rtc_ldo {
>>         regulator-name = "vcc-rtc";
>>  };
>> @@ -176,3 +189,21 @@
>>  &simplefb_lcd {
>>         vcc-lcd-supply = <&reg_dc1sw>;
>>  };
>> +
>> +&usb_otg {
>> +       dr_mode = "otg";
>> +       status = "okay";
>> +};
>> +
>> +&usb_power_supply {
>> +       status = "okay";
>> +};
>> +
>> +&usbphy {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&usb0_id_detect_pin>;
>> +       usb0_id_det-gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
>> +       usb0_vbus_power-supply = <&usb_power_supply>;
>> +       usb0_vbus-supply = <&reg_drivevbus>;
>> +       status = "okay";
>> +};
>> --
>> 2.7.4
>>
