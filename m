From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 27 Nov 2018 16:23:08 -0800
Subject: Adding a Basic DT for the Linksys ea6500 v2 wireless home router
In-Reply-To: <CACE8ZKYCyDx_E+3sLpjQSV6xrFxGyrYwEfhEO=QZPGpm3jsBrQ@mail.gmail.com>
References: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
 <CACE8ZKZEpQjOW6CSvUuM9xhjtkSCF0bYxcfQ3htSabC=rVJcTA@mail.gmail.com>
 <86f391e5-9e38-c8b0-4753-4646c322c9bc@hauke-m.de>
 <CACE8ZKb5CxEBAdCdGAhwaQHC9_nHBjTTVwxdDOXRayqgz0FK5g@mail.gmail.com>
 <CACE8ZKYCyDx_E+3sLpjQSV6xrFxGyrYwEfhEO=QZPGpm3jsBrQ@mail.gmail.com>
Message-ID: <5a6a30cf-1d93-7232-e607-3919b86bbdff@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/26/18 4:49 PM, Ren? Kjellerup wrote:
> To the broadcom kernel maintainers, (for BCM4708 CPUs)
> 
> I just want to add a little attention to this patch again...
> let me know if there's any concerns and I will try to address highlighted issues
> as soon as possible.
> 
> I've been running the development builds of OpenWrt kernels, where
> this patch has
> been included, on my Linksys EA6500v2 router for the past months,
> updating as new
> builds are available. With only the on board BCM4360 chip (5GHz WiFi) is being
> disabled, has so far been stable for my use case.

(Please no top posting). Your submission did make it through patchwork
and looks okay, I will run build tests and queue it up for 4.21 if
everything looks good. Thanks.

> 
> thank you for the consideration
> Rene (aka Katana_Steel)
> 
> On Mon, Oct 8, 2018 at 9:34 AM Ren? Kjellerup <rk.katana.steel@gmail.com> wrote:
>>
>> Hi Hauke,
>>
>> Updated the file header per your suggestion.
>>
>> From e97c15ef78d2535c23f32ebbec43bced72b5eaf7 Mon Sep 17 00:00:00 2001
>> From: Rene Kjellerup <rk.katana.steel@gmail.com>
>> Date: Mon, 1 Oct 2018 14:11:56 -0700
>> Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2
>>
>> It's wireless home router based on BCM4708A0 with BCM4360 + BCM4331
>> wireless chipsets. The 5GHz chip currently isn't supported only due
>> to missing compatible firmware.
>>
>> the DTS here was based on the Linksys EA6300 V1 DTS, only changing
>> the model strings
>>
>> Signed-off-by: Rene Kjellerup <rk.katana.steel@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                      |  1 +
>>  arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts | 47 +++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b5bd3de87c33..adf8f28f5e44 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -88,6 +88,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
>>      bcm4708-asus-rt-ac68u.dtb \
>>      bcm4708-buffalo-wzr-1750dhp.dtb \
>>      bcm4708-linksys-ea6300-v1.dtb \
>> +    bcm4708-linksys-ea6500-v2.dtb \
>>      bcm4708-luxul-xap-1510.dtb \
>>      bcm4708-luxul-xwc-1000.dtb \
>>      bcm4708-netgear-r6250.dtb \
>> diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>> b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>> new file mode 100644
>> index 000000000000..8a434d2a4b72
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Copyright (C) 2017 Rafa? Mi?ecki <rafal@milecki.pl>
>> + * Copyright (C) 2018 Rene Kjellerup <rk.katana.steel@gmail.com>
>> + *
>> + * this DTS was originally based on bcm4708-linksys-ea6300-v1.dts
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "bcm4708.dtsi"
>> +#include "bcm5301x-nand-cs0-bch8.dtsi"
>> +
>> +/ {
>> +    compatible = "linksys,ea6500-v2", "brcm,bcm4708";
>> +    model = "Linksys EA6500 V2";
>> +
>> +    chosen {
>> +        bootargs = "console=ttyS0,115200";
>> +    };
>> +
>> +    memory {
>> +        reg = <0x00000000 0x08000000>;
>> +    };
>> +
>> +    gpio-keys {
>> +        compatible = "gpio-keys";
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        wps {
>> +            label = "WPS";
>> +            linux,code = <KEY_WPS_BUTTON>;
>> +            gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>> +        restart {
>> +            label = "Reset";
>> +            linux,code = <KEY_RESTART>;
>> +            gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
>> +        };
>> +    };
>> +};
>> +
>> +&usb3_phy {
>> +    status = "okay";
>> +};
>> --
>> 2.16.4
>>
>> On Sun, Oct 7, 2018 at 2:08 PM Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>>
>>> On 10/04/2018 11:08 PM, Ren? Kjellerup wrote:
>>>> Hi Hauke,
>>>>
>>>> thank you for suggesting adding the dts patch to mainline kernel,
>>>> so here it is.
>>>> I feel Rafal technically still have the copyrights, this is pretty
>>>> much just a few string updates for the ea6500v2. However with this
>>>> dts in latest OpenWrt 18.06 loads and installs on my device.
>>>>
>>>> I will be available to do more testing should it be required.
>>>>
>>>> Regrads
>>>> Rene Kjellerup
>>>> --
>>>> -- as life grows older, I gain experience.
>>>> -- http://www.alchemiestick.net/
>>>>
>>>
>>> Hi Rene,
>>>
>>> Please send you patch inline in the mail and not as an attachment, I
>>> would suggest to use "git send-email" for sending the patch.
>>>
>>> Adding Rafal as copyright owner is ok, like you did it now. You could
>>> mention in the file header on which dts file this is based.
>>>
>>> Hauke
>>>
>>
>>
>> --
>> -- as life grows older, I gain experience.
>> -- http://www.alchemiestick.net/apps/

-- 
Florian
