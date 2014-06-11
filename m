From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 11 Jun 2014 13:18:03 +0200
Subject: [PATCH v7 5/7] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <20140605182138.GI31564@leverpostej>
References: <1401989181-4712-1-git-send-email-matthias.bgg@gmail.com>
 <1401989181-4712-6-git-send-email-matthias.bgg@gmail.com>
 <20140605182138.GI31564@leverpostej>
Message-ID: <CABuKBeJHUNEaGru=MG4S8wr+uxhtZxWM6fDd-of8-nhTnzTzLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-06-05 20:21 GMT+02:00 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Jun 05, 2014 at 06:26:19PM +0100, Matthias Brugger wrote:
>> This adds a generic devicetree board file and a dtsi for boards
>> based on MT6589 SoCs from Mediatek.
>>
>> Apart from the generic parts (gic, clocks) the only component
>> currently supported are the timers.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>  arch/arm/Kconfig                  |    2 +
>>  arch/arm/Makefile                 |    1 +
>>  arch/arm/boot/dts/mt6589.dtsi     |   94 +++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-mediatek/Kconfig    |    6 +++
>>  arch/arm/mach-mediatek/Makefile   |    1 +
>>  arch/arm/mach-mediatek/mediatek.c |   27 +++++++++++
>>  6 files changed, 131 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/mt6589.dtsi
>>  create mode 100644 arch/arm/mach-mediatek/Kconfig
>>  create mode 100644 arch/arm/mach-mediatek/Makefile
>>  create mode 100644 arch/arm/mach-mediatek/mediatek.c
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index db3c541..0fc8acd 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -997,6 +997,8 @@ source "arch/arm/mach-mv78xx0/Kconfig"
>>
>>  source "arch/arm/mach-imx/Kconfig"
>>
>> +source "arch/arm/mach-mediatek/Kconfig"
>> +
>>  source "arch/arm/mach-mxs/Kconfig"
>>
>>  source "arch/arm/mach-netx/Kconfig"
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 41c1931..8ce9774 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -170,6 +170,7 @@ machine-$(CONFIG_ARCH_MSM)                += msm
>>  machine-$(CONFIG_ARCH_MV78XX0)               += mv78xx0
>>  machine-$(CONFIG_ARCH_MVEBU)         += mvebu
>>  machine-$(CONFIG_ARCH_MXC)           += imx
>> +machine-$(CONFIG_ARCH_MEDIATEK)              += mediatek
>>  machine-$(CONFIG_ARCH_MXS)           += mxs
>>  machine-$(CONFIG_ARCH_NETX)          += netx
>>  machine-$(CONFIG_ARCH_NOMADIK)               += nomadik
>> diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
>> new file mode 100644
>> index 0000000..f1d8a8b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/mt6589.dtsi
>> @@ -0,0 +1,94 @@
>> +/*
>> + * Copyright (c) 2014 MundoReader S.L.
>> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include "skeleton.dtsi"
>> +
>> +/ {
>> +     compatible = "mediatek,mt6589";
>> +     interrupt-parent = <&gic>;
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu at 0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x0>;
>> +             };
>> +             cpu at 1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x1>;
>> +             };
>> +             cpu at 2 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x2>;
>> +             };
>> +             cpu at 3 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x3>;
>> +             };
>> +
>> +     };
>> +
>> +     clocks {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges;
>
> This is just nonsense. This /clocks node is in no way special -- /clocks
> was never reserved as a place to put clocks that we guarantee to probe.
> It's just an arbitrary containter node, and the fact we happen to probe
> clocks under it is an implementation detail (and arguably a bug).
>
> I argued in the past to at least have them as a simple-bus,
> necessitating ranges, #address-cells, and #size-cells you have here, but
> you'r missing the compatible = "simple-bus", rendering the exercise
> pointless.
>
>> +
>> +             system_clk: dummy13m {
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <13000000>;
>> +                     #clock-cells = <0>;
>> +             };
>> +
>> +             rtc_clk: dummy32k {
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <32000>;
>> +                     #clock-cells = <0>;
>> +             };
>> +     };
>> +
>> +     soc {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             compatible = "simple-bus";
>> +             clock-ranges;
>
> Why the clock-ranges? You refer to them explicitly below.
>
>> +             ranges;
>> +
>> +             timer: timer at 10008000 {
>> +                     compatible = "mediatek,mt6577-timer";
>> +                     reg = <0x10008000 0x80>;
>> +                     interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
>> +                     clocks = <&system_clk>, <&rtc_clk>;
>> +                     clock-names = "system-clk", "rtc-clk";
>> +             };
>> +
>> +             gic: interrupt-controller at 10212000 {
>> +                     compatible = "arm,cortex-a15-gic";
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <3>;
>> +                     reg = <0x10211000 0x1000>,
>> +                           <0x10212000 0x1000>,
>> +                           <0x10214000 0x2000>,
>> +                           <0x10216000 0x2000>;
>> +             };
>> +     };
>> +};
>
> No architected timers?

I was trying to get the arch timer working [0], but unfortunately with no luck.

[0] http://article.gmane.org/gmane.linux.ports.arm.kernel/321976

>
>
>> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
>> new file mode 100644
>> index 0000000..2c043a2
>> --- /dev/null
>> +++ b/arch/arm/mach-mediatek/Kconfig
>> @@ -0,0 +1,6 @@
>> +config ARCH_MEDIATEK
>> +     bool "Mediatek MT6589 SoC" if ARCH_MULTI_V7
>> +     select ARM_GIC
>> +     select MTK_TIMER
>> +     help
>> +       Support for Mediatek Cortex-A7 Quad-Core-SoC MT6589.
>> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
>> new file mode 100644
>> index 0000000..43e619f
>> --- /dev/null
>> +++ b/arch/arm/mach-mediatek/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_ARCH_MEDIATEK) += mediatek.o
>> diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
>> new file mode 100644
>> index 0000000..f2acf07
>> --- /dev/null
>> +++ b/arch/arm/mach-mediatek/mediatek.c
>> @@ -0,0 +1,27 @@
>> +/*
>> + * Device Tree support for Mediatek SoCs
>> + *
>> + * Copyright (c) 2014 MundoReader S.L.
>> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#include <linux/init.h>
>> +#include <asm/mach/arch.h>
>> +
>> +static const char * const mediatek_board_dt_compat[] = {
>> +     "mediatek,mt6589",
>> +     NULL,
>> +};
>> +
>> +DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
>> +     .dt_compat      = mediatek_board_dt_compat,
>> +MACHINE_END
>
> If this is all we have, surely we can get by with the defaults?

We reach to the point where the bootconsole gets disabled. Due to the
still missing console driver, we get stuck there.

Best regards,
Matthias

>
> Cheers,
> Mark.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
motzblog.wordpress.com
