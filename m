From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Mon, 16 Mar 2015 11:27:57 +0100
Subject: [PATCH v4 2/5] ARM: dts: Prepare exynos5410-odroidxu device tree
In-Reply-To: <CABxcv==cnFQ75qaykfkOcFo8FNqkzVswu8iYOB3riZJT9=4U_Q@mail.gmail.com>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>	<1426456834-6308-3-git-send-email-afaerber@suse.de>
 <CABxcv==cnFQ75qaykfkOcFo8FNqkzVswu8iYOB3riZJT9=4U_Q@mail.gmail.com>
Message-ID: <5506B02D.3000400@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Am 16.03.2015 um 08:56 schrieb Javier Martinez Canillas:
> On Sun, Mar 15, 2015 at 11:00 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Derived from exynos5410-smdk5410.dts.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v1 -> v2 -> v3: Unchanged

Forgot to update the in-patch changelogs: v4 is unchanged as well

>>
>>  arch/arm/boot/dts/Makefile                |  1 +
>>  arch/arm/boot/dts/exynos5410-odroidxu.dts | 78 +++++++++++++++++++++++++++++++
>>  2 files changed, 79 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index a1c776b8dcec..b040737edcbc 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -103,6 +103,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>>         exynos5250-snow.dtb \
>>         exynos5250-spring.dtb \
>>         exynos5260-xyref5260.dtb \
>> +       exynos5410-odroidxu.dtb \
>>         exynos5410-smdk5410.dtb \
>>         exynos5420-arndale-octa.dtb \
>>         exynos5420-peach-pit.dtb \
>> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
>> new file mode 100644
>> index 000000000000..97310bb727e2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
>> @@ -0,0 +1,78 @@
>> +/*
>> + * Hardkernel ODROID-XU device tree source
>> + *
>> + * Copyright (c) 2014 SUSE LINUX Products GmbH
>> + *
>> + * Based on exynos5410-smdk5410.dts:
>> + *
>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>> + *             http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/dts-v1/;
>> +#include "exynos5410.dtsi"
>> +/ {
>> +       model = "ODROID-XU based on EXYNOS5410";
>> +       compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
>> +
>> +       memory {
>> +               reg = <0x40000000 0x80000000>;
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "console=ttySAC2,115200";
>> +       };
>> +
> 
> After commit a208ffd251d0 ("of: Enable console on serial ports
> specified by /chosen/stdout-path") the kernel is able to know what
> serial console to use if the DT defined an stdout-path property so
> should be preferred instead of using a console= parameter.
> 
> I'll post today a series to change that on all exynos5 boards so you
> can base on that.

Okay, if no one else does, I could update smdk5410 before splitting.

>> +       fin_pll: xxti {
>> +               compatible = "fixed-clock";
>> +               clock-frequency = <24000000>;
>> +               clock-output-names = "fin_pll";
>> +               #clock-cells = <0>;
>> +       };
>> +
> 
> I think this should be defined in exynos5410.dtsi instead since is an
> IP block in the SoC and referenced in the .dts using a label to change
> the clock-frequency in the board.

I hope you understood that this is a literal copy of smdk5410, so I'm
not going to make random changes here. If the Samsung guys want to make
this change for smdk5410, then fine, but otherwise - like for Snow and
Spring - I want to keep the diff -u low between the two.

>> +       firmware at 02037000 {
>> +               compatible = "samsung,secure-firmware";
>> +               reg = <0x02037000 0x1000>;
>> +       };
>> +
>> +};
>> +
>> +&mmc_0 {
>> +       status = "okay";
>> +       num-slots = <1>;
>> +       cap-mmc-highspeed;
>> +       broken-cd;
>> +       card-detect-delay = <200>;
>> +       samsung,dw-mshc-ciu-div = <3>;
>> +       samsung,dw-mshc-sdr-timing = <2 3>;
>> +       samsung,dw-mshc-ddr-timing = <1 2>;
>> +       bus-width = <8>;
>> +};
>> +
>> +&mmc_2 {
>> +       status = "okay";
>> +       num-slots = <1>;
>> +       cap-sd-highspeed;
>> +       card-detect-delay = <200>;
>> +       samsung,dw-mshc-ciu-div = <3>;
>> +       samsung,dw-mshc-sdr-timing = <2 3>;
>> +       samsung,dw-mshc-ddr-timing = <1 2>;
>> +       bus-width = <4>;
>> +       disable-wp;
>> +};
>> +
>> +&uart0 {
>> +       status = "okay";
>> +};
>> +
>> +&uart1 {
>> +       status = "okay";
>> +};
>> +
>> +&uart2 {
>> +       status = "okay";
>> +};
>> --
> 
> With those two changes:
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks, first review after posting for the third time... ;)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
