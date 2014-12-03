From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 03 Dec 2014 09:34:19 +0100
Subject: [PATCH 4/5] ARM: BCM5301X: Add DT for Asus RT-N18U
In-Reply-To: <CACna6rzNTd6dudWqbACsf+oZWacjUcFDAuzDZth=_WN1uBdccg@mail.gmail.com>
References: <1417368513-13808-1-git-send-email-zajec5@gmail.com>	<1417368513-13808-4-git-send-email-zajec5@gmail.com>	<547E48F0.6010600@hauke-m.de>
 <CACna6rzNTd6dudWqbACsf+oZWacjUcFDAuzDZth=_WN1uBdccg@mail.gmail.com>
Message-ID: <547ECB0B.2030305@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2014 06:40 AM, Rafa? Mi?ecki wrote:
> On 3 December 2014 at 00:19, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> On 11/30/2014 06:28 PM, Rafa? Mi?ecki wrote:
>>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/Makefile                  |  3 +-
>>>  arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts | 78 +++++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/bcm47081.dtsi             | 26 ++++++++++
>>>  arch/arm/mach-bcm/bcm_5301x.c               |  1 +
>>>  4 files changed, 107 insertions(+), 1 deletion(-)
>>>  create mode 100644 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
>>>  create mode 100644 arch/arm/boot/dts/bcm47081.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 18a21d9..db51a31 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -58,7 +58,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
>>>  dtb-$(CONFIG_ARCH_BCM_5301X) += \
>>>       bcm4708-buffalo-wzr-1750dhp.dtb \
>>>       bcm4708-netgear-r6250.dtb \
>>> -     bcm4708-netgear-r6300-v2.dtb
>>> +     bcm4708-netgear-r6300-v2.dtb \
>>> +     bcm47081-asus-rt-n18u.dtb
>>>  dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
>>>  dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
>>>       bcm911360k.dtb \
>>> diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
>>> new file mode 100644
>>> index 0000000..c40ad39
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
>>> @@ -0,0 +1,78 @@
>>> +/*
>>> + * Broadcom BCM470X / BCM5301X ARM platform code.
>>> + * DTS for Asus RT-N18U
>>> + *
>>> + * Copyright ? 2014 Rafa? Mi?ecki <zajec5@gmail.com>
>>> + *
>>> + * Licensed under the GNU/GPL. See COPYING for details.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "bcm47081.dtsi"
>>> +
>>> +/ {
>>> +     compatible = "asus,rt-n18u", "brcm,bcm47081";
>>
>> Instead of adding bcm47081 to the core code you can do this:
>>
>> compatible = "asus,rt-n18u", "brcm,bcm47081", "brcm,bcm4708";
>>
>> If we later need some special handling for bcm47081 we can add this but
>> the old dts file will still work. This is more relevant if the dts file
>> is in the boot loader.
> 
> I don't get it. How should I detect there is no second CPU?

In the SMP code we would check if (num CPUs > 1 ) then boot up other
CPUs end;
This num CPUs is fetched from the dts file and it would be checked if
that number is equal or smaller than some number in some register which
should contain the number of CPUs. We still need the stuff in the
bcm47081.dtsi file.

If you add a dts file for a device with a BCM4709 or some other SoC not
being BCM4708, you should use a similar compatible string.

Hauke
