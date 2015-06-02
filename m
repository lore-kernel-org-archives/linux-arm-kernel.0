From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 02 Jun 2015 21:43:16 +0900
Subject: [PATCH v4 2/5] ARM: dts: Prepare exynos5410-odroidxu device tree
In-Reply-To: <5506B02D.3000400@suse.de>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>	<1426456834-6308-3-git-send-email-afaerber@suse.de>
 <CABxcv==cnFQ75qaykfkOcFo8FNqkzVswu8iYOB3riZJT9=4U_Q@mail.gmail.com>
 <5506B02D.3000400@suse.de>
Message-ID: <556DA4E4.1060303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 16.03.2015 o 19:27, Andreas F?rber pisze:
> Hi Javier,
> 
> Am 16.03.2015 um 08:56 schrieb Javier Martinez Canillas:
>> On Sun, Mar 15, 2015 at 11:00 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>> Derived from exynos5410-smdk5410.dts.
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  v1 -> v2 -> v3: Unchanged
> 
> Forgot to update the in-patch changelogs: v4 is unchanged as well
> 
>>>
>>>  arch/arm/boot/dts/Makefile                |  1 +
>>>  arch/arm/boot/dts/exynos5410-odroidxu.dts | 78 +++++++++++++++++++++++++++++++
>>>  2 files changed, 79 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index a1c776b8dcec..b040737edcbc 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -103,6 +103,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>>>         exynos5250-snow.dtb \
>>>         exynos5250-spring.dtb \
>>>         exynos5260-xyref5260.dtb \
>>> +       exynos5410-odroidxu.dtb \
>>>         exynos5410-smdk5410.dtb \
>>>         exynos5420-arndale-octa.dtb \
>>>         exynos5420-peach-pit.dtb \
>>> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
>>> new file mode 100644
>>> index 000000000000..97310bb727e2
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
>>> @@ -0,0 +1,78 @@
>>> +/*
>>> + * Hardkernel ODROID-XU device tree source
>>> + *
>>> + * Copyright (c) 2014 SUSE LINUX Products GmbH
>>> + *
>>> + * Based on exynos5410-smdk5410.dts:
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
>>> +#include "exynos5410.dtsi"
>>> +/ {
>>> +       model = "ODROID-XU based on EXYNOS5410";
>>> +       compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
>>> +
>>> +       memory {
>>> +               reg = <0x40000000 0x80000000>;
>>> +       };
>>> +
>>> +       chosen {
>>> +               bootargs = "console=ttySAC2,115200";
>>> +       };
>>> +
>>
>> After commit a208ffd251d0 ("of: Enable console on serial ports
>> specified by /chosen/stdout-path") the kernel is able to know what
>> serial console to use if the DT defined an stdout-path property so
>> should be preferred instead of using a console= parameter.
>>
>> I'll post today a series to change that on all exynos5 boards so you
>> can base on that.
> 
> Okay, if no one else does, I could update smdk5410 before splitting.

Could you do this? At least for new board if you cannot test it on SMDK5410.

> 
>>> +       fin_pll: xxti {
>>> +               compatible = "fixed-clock";
>>> +               clock-frequency = <24000000>;
>>> +               clock-output-names = "fin_pll";
>>> +               #clock-cells = <0>;
>>> +       };
>>> +
>>
>> I think this should be defined in exynos5410.dtsi instead since is an
>> IP block in the SoC and referenced in the .dts using a label to change
>> the clock-frequency in the board.
> 
> I hope you understood that this is a literal copy of smdk5410, so I'm
> not going to make random changes here. If the Samsung guys want to make
> this change for smdk5410, then fine, but otherwise - like for Snow and
> Spring - I want to keep the diff -u low between the two.

Moving the node to DTSI won't change the DTB for boards so the change is
safe. However to me it looks unusual that exynos5410.dtsi references
fin_pll phandle which is defined in the board.

However Kukjin mentioned that it is fine so it is okay with me also.

The rest looks fine, so:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
