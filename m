From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 19:38:58 +0100
Subject: [PATCH v5 3/3] ARM: dts: add dts files for xyref5260 board
In-Reply-To: <CAPdUM4PaXGceKyeO=kXaGy=VqapETg9m4RAMci_BD6=jsW-gNA@mail.gmail.com>
References: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
 <1394637394-3960-4-git-send-email-rahul.sharma@samsung.com>
 <5321008C.3090203@samsung.com>
 <CAPdUM4PaXGceKyeO=kXaGy=VqapETg9m4RAMci_BD6=jsW-gNA@mail.gmail.com>
Message-ID: <5321FB42.5090907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.03.2014 06:01, Rahul Sharma wrote:
> Thanks Pankaj,
>
> On 13 March 2014 06:19, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>> Hi Rahul,
>>
>>
>> On 03/13/2014 12:16 AM, Rahul Sharma wrote:
>>>
>>> The patch adds the dts files for xyref5260 board which
>>> is based on Exynos5260 Evt0 sample.
>>>
>>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>>> ---
>>>    arch/arm/boot/dts/Makefile                      |    1 +
>>>    arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts |  110
>>> +++++++++++++++++++++++
>>>    2 files changed, 111 insertions(+)
>>>    create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index b9d6a8b..5a391bf 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -72,6 +72,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>>>          exynos5250-arndale.dtb \
>>>          exynos5250-smdk5250.dtb \
>>>          exynos5250-snow.dtb \
>>> +       exynos5260-xyref5260-evt0.dtb \
>>>          exynos5420-arndale-octa.dtb \
>>>          exynos5420-smdk5420.dtb \
>>>          exynos5440-sd5v1.dtb \
>>> diff --git a/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
>>> b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
>>> new file mode 100644
>>> index 0000000..d7d0aeb
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
>>> @@ -0,0 +1,110 @@
>>> +/*
>>> + * SAMSUNG XYREF5260 EVT0 board device tree source
>>> + *
>>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>>> + *             http://www.samsung.com
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> +*/
>>> +
>>> +/dts-v1/;
>>> +#include "exynos5260.dtsi"
>>> +
>>> +/ {
>>> +       model = "SAMSUNG XYREF5260 EVT0 board based on EXYNOS5260";
>>> +       compatible = "samsung,xyref5260", "samsung,exynos5260";
>>> +
>>> +       memory {
>>> +               reg = <0x20000000 0x80000000>;
>>> +       };
>>> +
>>> +       chosen {
>>> +               bootargs = "console=ttySAC2,115200";
>>> +       };
>>> +
>>> +       clocks {
>>> +               fin_pll: xxti {
>>> +                       compatible = "fixed-clock";
>>> +                       clock-frequency = <24000000>;
>>> +                       clock-output-names = "fin_pll";
>>> +                       #clock-cells = <0>;
>>> +               };
>>> +
>>> +               xrtcxti: xrtcxti {
>>> +                       compatible = "fixed-clock";
>>> +                       clock-frequency = <32768>;
>>> +                       clock-output-names = "xrtcxti";
>>> +               };
>>
>>
>> clock-cells property is missing here.
>>
>
> I have added #clock-cells only for clocks which
> are supposed to be referred. IMO we need it otherwise.

The fixed-clock binding requires the #clock-cells property to be present 
with value of <0>. It is not a valid fixed-clock otherwise.

>>
>>> +
>>> +               spdif_extclk: ioclk_spdif_extclk {
>>> +                       compatible = "fixed-clock";
>>> +                       clock-frequency = <49152000>;
>>> +                       clock-output-names = "ioclk_spdif_extclk";
>>> +               };
>>
>>
>> ditto.
>>
>>> +       };
>>> +};
>>
>>
>> May I know why other phyclocks and ioclks have not been added?
>>
>
> Phyclocks should be added in SoC file. Please refer the other patch.
>
> Ioclocks have 2 dimensions. 1) A board may or may not have these.
> But if board doesn't have them, we may end up with orphans in clock
> tree. 2) Adding them in SoC is not meaningful because rate is board
> dependent and cannot be mentioned in SoC file. Without rate, probe
> will not be successful.
>
> What I followed here is adding IO clocks which are resulting into
> orphan clocks.

Only clocks with active parents set to missing ioclocks will be 
orphaned. If a mux has an ioclock as its default parent, it can be still 
reconfigured to another input normally.

>
> What we can do is to allow the registration of fixed-io-clocks in clock
> driver which are provided without RATE? If this looks good, I can post
> the respective patch for clock driver and dt correction.

I believe ioclocks should be registered properly using DT, only if 
present. It is important, because such ioclock might not be an always-on 
fixed rate clock, but instead a configurable external clock generator.

Best regards,
Tomasz
