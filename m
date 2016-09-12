From: jun.nie@linaro.org (Jun Nie)
Date: Mon, 12 Sep 2016 15:13:58 +0800
Subject: [PATCH v4 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <20160908091103.GA16924@tiger>
References: <1473141861-5033-1-git-send-email-jun.nie@linaro.org>
 <1473141861-5033-3-git-send-email-jun.nie@linaro.org>
 <20160908091103.GA16924@tiger>
Message-ID: <CABymUCMQQ-nqGwGdNafCsBB10PB=4KAtW4Dij2YzVdfLHS4-WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-09-08 17:11 GMT+08:00 Shawn Guo <shawnguo@kernel.org>:
> This version looks pretty good to me.  Some nit-picks below though ...
>
> On Tue, Sep 06, 2016 at 02:04:20PM +0800, Jun Nie wrote:
>> Add device tree support for ZX296718 SoC and evaluation board based on it.
>
> Please wrap the commit log around column 70.
>
>> Also document new values.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/zte.txt |  24 +++
>>  arch/arm64/boot/dts/Makefile                  |   1 +
>>  arch/arm64/boot/dts/zte/Makefile              |   5 +
>>  arch/arm64/boot/dts/zte/zx296718-evb.dts      |  25 +++
>>  arch/arm64/boot/dts/zte/zx296718.dtsi         | 254 ++++++++++++++++++++++++++
>>  5 files changed, 309 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/zte/Makefile
>>  create mode 100644 arch/arm64/boot/dts/zte/zx296718-evb.dts
>>  create mode 100644 arch/arm64/boot/dts/zte/zx296718.dtsi
>
> <snip>
>
>> diff --git a/arch/arm64/boot/dts/zte/Makefile b/arch/arm64/boot/dts/zte/Makefile
>> new file mode 100644
>> index 0000000..6678066
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/zte/Makefile
>> @@ -0,0 +1,5 @@
>> +dtb-$(CONFIG_ARCH_ZX) += zx296718-evb.dtb
>> +
>> +always               := $(dtb-y)
>> +subdir-y     := $(dts-dirs)
>> +clean-files  := *.dtb
>> diff --git a/arch/arm64/boot/dts/zte/zx296718-evb.dts b/arch/arm64/boot/dts/zte/zx296718-evb.dts
>> new file mode 100644
>> index 0000000..d7cefb4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/zte/zx296718-evb.dts
>> @@ -0,0 +1,25 @@
>> +/*
>> + * ZTE Ltd. zx296718 Plaform
>> + *
>> + */
>
> We should probably consider to add a proper licence.  GPL/X11 dual is
> mostly used and recommended, and there are quite a lot examples in the
> DTS folder.
>
Will do.

>> +/dts-v1/;
>> +#include "zx296718.dtsi"
>> +
>> +/ {
>> +     model = "ZTE zx296718 evaluation board";
>> +     compatible = "zte,zx296718-evb", "zte,zx296718";
>> +
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +
>> +     memory at 40000000 {
>> +             device_type = "memory";
>> +             reg = <0x40000000 0x40000000>;
>> +     };
>> +
>> +};
>> +
>> +&uart0 {
>> +     status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
>> new file mode 100644
>> index 0000000..c75a819
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
>> @@ -0,0 +1,254 @@
>> +/*
>> + * DTS File for ZTE ZX296718 Plaform
>> + *
>> + * Copyright (c) 2016 ZTE Semiconductor Co., Ltd.
>> + */
>
> Ditto

Will do.

>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     compatible = "zte,zx296718";
>> +     #address-cells = <1>;
>> +     #size-cells = <1>;
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +     };
>> +
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu-map {
>> +                     cluster0 {
>> +                             core0 {
>> +                                     cpu = <&cpu0>;
>> +                             };
>> +                             core1 {
>> +                                     cpu = <&cpu1>;
>> +                             };
>> +                             core2 {
>> +                                     cpu = <&cpu2>;
>> +                             };
>> +                             core3 {
>> +                                     cpu = <&cpu3>;
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu0: cpu at 0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53","arm,armv8";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu1: cpu at 1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53","arm,armv8";
>> +                     reg = <0x0 0x1>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu2: cpu at 2 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53","arm,armv8";
>> +                     reg = <0x0 0x2>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu3: cpu at 3 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53","arm,armv8";
>> +                     reg = <0x0 0x3>;
>> +                     enable-method = "psci";
>> +             };
>> +     };
>> +
>> +     osc12m: osc12m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <12000000>;
>> +             clock-output-names = "osc12m";
>> +     };
>> +
>> +     osc24m: osc24m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <24000000>;
>> +             clock-output-names = "osc24m";
>> +     };
>> +
>> +     osc25m: osc25m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <25000000>;
>> +             clock-output-names = "osc25m";
>> +     };
>> +
>> +     clk24k: clk-24k {
>
> I would suggest we name node of fixed rate clock in an unified way like
> clock-xxx.
>
Will do.

>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <24000>;
>> +             clock-output-names = "rtcclk";
>> +     };
>> +
>> +     osc32k: osc32k-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <32000>;
>> +             clock-output-names = "osc32k";
>> +     };
>> +
>> +     osc60m: osc60m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <60000000>;
>> +             clock-output-names = "osc60m";
>> +     };
>> +
>> +     osc99m: osc99m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <99000000>;
>> +             clock-output-names = "osc99m";
>> +     };
>> +
>> +     osc125m: osc125m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <125000000>;
>> +             clock-output-names = "osc125m";
>> +     };
>> +
>> +     osc198m: osc198m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <198000000>;
>> +             clock-output-names = "osc198m";
>> +     };
>> +
>> +     pll_vga: pll-1073m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1073000000>;
>> +             clock-output-names = "pll_vga";
>> +     };
>> +
>> +     pll_ddr: pll-932m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <932000000>;
>> +             clock-output-names = "pll_ddr";
>> +     };
>> +
>> +     pll_mac: pll-1000m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1000000000>;
>> +             clock-output-names = "pll_mac";
>> +     };
>> +
>> +     pll_mm0: pll-1188m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1188000000>;
>> +             clock-output-names = "pll_mm0";
>> +     };
>> +
>> +     pll_mm1: pll-1296m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <1296000000>;
>> +             clock-output-names = "pll_mm1";
>> +     };
>> +
>> +     pll_audio: pll-884m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <884000000>;
>> +             clock-output-names = "pll_audio";
>> +     };
>> +
>> +     pll_hsic: pll-960m-clk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <960000000>;
>> +             clock-output-names = "pll_hsic";
>> +     };
>
> Do we really have so many uncontrolled clocks with fixed rate in the
> SoC?

PLL clocks can be configured actually according to register. But I
prefer to keep them as fixed clocks due to two reasons:
 1. ZTE do not want to expose too much information of PLL.
 2. All clients blocks, such as MMC and video codec, assume the
related input clock's frequency as a derivation from PLL default
frequency value in block clock control register description.

>
> Shawn
