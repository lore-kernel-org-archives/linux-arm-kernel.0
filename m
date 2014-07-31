From: vpalatin@chromium.org (Vincent Palatin)
Date: Thu, 31 Jul 2014 11:51:57 -0700
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DA7993.1000800@suse.de>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <CAP_ceTz+KRJzF9XV=_aLE+6sV6d5GqCtQ_daKtpFJfCZQ1erpA@mail.gmail.com>
 <53DA7993.1000800@suse.de>
Message-ID: <CAP_ceTx3uTS=CVP0qpB5u8Dk69kZvWwPBVTCBPX8+cz0uTOXFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 10:14 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi,
>
> Am 31.07.2014 19:00, schrieb Vincent Palatin:
>> Always a bit late to the game.
>> One small comment inline.
>>
>> Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
>
> Thanks,
>
>>
>> On Thu, Jul 31, 2014 at 9:08 AM, Andreas F?rber <afaerber@suse.de> wrote:
>>> +       usb3_vbus_reg: regulator-usb3 {
>>> +               compatible = "regulator-fixed";
>>> +               regulator-name = "P5.0V_USB3CON";
>>> +               regulator-min-microvolt = <5000000>;
>>> +               regulator-max-microvolt = <5000000>;
>>> +               gpio = <&gpe1 0 GPIO_ACTIVE_LOW>;
>>> +               enable-active-high;
>>> +       };
>>
>> GPE1_0 GPIO is the HSIC hub (SMSC 3503) reset# line (already defined
>> below afaik).
>
> Yes, that was a suggestion you made on v1.
>
>> On this design there is no external USB3 port, so no VBUS reg/load
>> switch for USB3.
>
> Could you be a little clearer? Are you suggesting to drop the gpio
> property? I just re-tested that without the regulator node plus the
> vbus-supply below I don't get any USB2 (so maybe rename the regulator?).

The 3503 PHY driver is not fully correct, so we probably need to keep
this to get the right init timings when the bootloader has initiliazed
it before.
but yes renaming the regulator to mention that's actually the hsic hub
reset would make it clearer.


>>> +
>>> +       usb at 12110000 {
>>> +               samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
>>> +       };
>>> +
>>> +       usb-hub {
>>> +               compatible = "smsc,usb3503a";
>>> +               reset-gpios = <&hsic_reset>;
>>> +       };
> [...]
>>> +&usbdrd_phy {
>>> +       vbus-supply = <&usb3_vbus_reg>;
>>> +};
>>> +
>>> +#include "cros-ec-keyboard.dtsi"
>>> --
>>> 1.9.3
>
> --
> SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
