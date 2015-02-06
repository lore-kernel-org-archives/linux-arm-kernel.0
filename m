From: wangbintian@gmail.com (Brent Wang)
Date: Fri, 6 Feb 2015 16:42:22 +0800
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <20150205193017.GF20735@leverpostej>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
 <20150205193017.GF20735@leverpostej>
Message-ID: <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

2015-02-06 3:30 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Feb 05, 2015 at 09:24:37AM +0000, Bintian Wang wrote:
>> Add initial dtsi file to support Hisilicon Hi6220 SoC with
>> support of Octal core CPUs in two clusters and each cluster
>> has quard Cortex-A53.
>>
>> We now use the "spin-table" method for SMP, and it will be
>> changed to PSCI later.
>
> If that's the case, please don't place the enable-method and related
> properties in this file. Get your bootloader to add the appropriate
> properties for its boot protocol.
>
> When is PSCI likely to appear?
PSCI is under development.

>
> Are we certain of the split between components the PSCI implementation
> must touch and those the kernel must touch?
>
>> Also add dts file to support HiKey development board which
>> based on Hi6220 SoC and document the devicetree bindings.
>>
>> These dts files will be changed later and more nodes will be
>> added to describe other devices.
>
> How is this going to be changed other than the addition of nodes?
>
> Will this DTB continue to work in future? Or do you intend to make
> changes that will break support?
My original idea is: use spin-table for SMP now, when firmware is OK to
support PSCI, we submit another patch to replace the spin-table with PSCI.

If DTB should continue to work in the future, we really need to remove
the spin-table
from current dts file, how about just enable one core now?

Which one do you favor or any other suggestion?

>
>> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
>> Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Reviewed-by: Yiping Xu <xuyiping@hisilicon.com>
>> ---
>>  .../bindings/arm/hisilicon/hisilicon.txt           |   33 ++++
>>  arch/arm64/boot/dts/Makefile                       |    1 +
>>  arch/arm64/boot/dts/hisilicon/Makefile             |    5 +
>>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   31 +++
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  204 ++++++++++++++++++++
>>  5 files changed, 274 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> index f717c7b..5eb6b41 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -9,6 +9,9 @@ HiP04 D01 Board
>>  Required root node properties:
>>       - compatible = "hisilicon,hip04-d01";
>>
>> +HiKey Board
>> +Required root node properties:
>> +     - compatible = "hisilicon,hi6220-hikey";
>>
>>  Hisilicon system controller
>>
>> @@ -62,6 +65,36 @@ Example:
>>       };
>>
>>  -----------------------------------------------------------------------
>> +Hisilicon Power Always ON domain controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,aoctrl"
>> +- reg : Register address and size
>> +
>> +Some clock registers are defined in power always on system controller,
>> +especially in Hi6220 SoC which is used for mobile platform.
>> +
>> +-----------------------------------------------------------------------
>> +Hisilicon Media domain controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,mediactrl"
>> +- reg : Register address and size
>> +
>> +Some clock registers of media module are defined in media system
>> +controller, especially in Hi6220 SoC which is used for mobile platform.
>> +
>> +-----------------------------------------------------------------------
>> +Hisilicon Power Management domain controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,pmctrl"
>> +- reg : Register address and size
>> +
>> +Some clock registers and PMU registers are defined in power management
>> +controller, especially in Hin6220 SoC which is used for mobile platform.
>> +
>> +-----------------------------------------------------------------------
>
> Looking at the dts below, none of these binding docs are sufficient.
>
> Define _all_ the properties and what they mean.
In fact, Hisilicon designs several system controllers for different
function domains,
we can control different functions(e.g. clk gate on or off /IP reset)
based on the base
address of controller + offset, I will give more description in next version.

> Please also split documentation into earlier patches.
OK, separate document and code in next version.

>
>>  Fabric:
>>
>>  Required Properties:
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index c62b0f4..bffd6b7 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -2,5 +2,6 @@ dts-dirs += amd
>>  dts-dirs += apm
>>  dts-dirs += arm
>>  dts-dirs += cavium
>> +dts-dirs += hisilicon
>>
>>  subdir-y     := $(dts-dirs)
>> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
>> new file mode 100644
>> index 0000000..fa81a6e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
>> @@ -0,0 +1,5 @@
>> +dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
>> +
>> +always               := $(dtb-y)
>> +subdir-y     := $(dts-dirs)
>> +clean-files  := *.dtb
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> new file mode 100644
>> index 0000000..a94da84
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> @@ -0,0 +1,31 @@
>> +/*
>> + * dts file for Hisilicon HiKey Development Board
>> + *
>> + * Copyright (C) 2015, Hisilicon Ltd.
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/memreserve/ 0x0740f000 0x1000;
>
> If you're going to use /memreserve/, please add a comment regarding what
> it is intended to protect, and why that's in memory given to the kernel
> to begin with.
>
>> +
>> +#include "hi6220.dtsi"
>> +
>> +/ {
>> +     model = "HiKey Development Board";
>> +     compatible = "hisilicon,hi6220-hikey";
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +     interrupt-parent = <&gic>;
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +     };
>> +
>> +     chosen { };
>
> You should use stdout-path here, ideally with the full UART
> configuration.
Add in next version.

>> +
>> +     memory at 7400000 {
>> +             device_type = "memory";
>> +             reg = <0x0 0x07400000 0x0 0x38c00000>;
>> +     };
>> +};
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> new file mode 100644
>> index 0000000..53ba9cf
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> @@ -0,0 +1,204 @@
>> +/*
>> + * dts file for Hisilicon Hi6220 SoC
>> + *
>> + * Copyright (C) 2015, Hisilicon Ltd.
>> + */
>> +
>> +#include <dt-bindings/clock/hi6220-clock.h>
>> +
>> +/ {
>> +     cpu-map {
>
> Per the binding, this must live under /cpus.
>
> Move this within the /cpus node.
>
>> +             cluster0 {
>> +                     core0 {
>> +                             cpu = <&cpu0>;
>> +                     };
>> +                     core1 {
>> +                             cpu = <&cpu1>;
>> +                     };
>> +                     core2 {
>> +                             cpu = <&cpu2>;
>> +                     };
>> +                     core3 {
>> +                             cpu = <&cpu3>;
>> +                     };
>> +             };
>> +             cluster1 {
>> +                     core0 {
>> +                             cpu = <&cpu4>;
>> +                     };
>> +                     core1 {
>> +                             cpu = <&cpu5>;
>> +                     };
>> +                     core2 {
>> +                             cpu = <&cpu6>;
>> +                     };
>> +                     core3 {
>> +                             cpu = <&cpu7>;
>> +                     };
>> +             };
>> +     };
>> +
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu0: cpu at 000 {
>> +                     compatible = "arm,cortex-a53", "arm,armv8";
>> +                     device_type = "cpu";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "spin-table";
>> +                     cpu-release-addr = <0x0 0x740fff8>;
>
> If you _must_ use spin-table, please give each CPU a unique release
> address. Using a shared address was a mistake, and we should learn from
> it.
>
> Which CPU does the system boot on?
>
>> +                     clock-latency = <0>;
>
> Why is this here?
>
> There is no reason for this to be on any CPU node.
Fix in next version.

>
>> +             };
>
> [...]
>
>> +     gic: interrupt-controller at f6800000 {
>> +             compatible = "arm,gic-400", "arm,cortex-a15-gic";
>
> Surely there's no need for the "arm,cortex-a15-gic" fallback entry? What
> am I missing?
Remove it in next version.

>
>> +             reg = <0x0 0xf6801000 0x0 0x1000>, /* GICD */
>
> This doesn't match the unit-address.
Do you mean change to "<0x0 0xf6801000 0 0x1000>" ?

>
>> +                   <0x0 0xf6802000 0x0 0x2000>, /* GICC */
>> +                   <0x0 0xf6804000 0x0 0x2000>, /* GICH */
>> +                   <0x0 0xf6806000 0x0 0x2000>; /* GICV */
>
> I guess no-one's bothered to consider 64k pages?
>
> Given GICH and GICV, I hope that this platform is booted at EL2?
Transfer from EL3 to EL1 directly, keep these two just for future use.

>
>> +             #interrupt-cells = <3>;
>> +             #address-cells = <0>;
>> +             interrupt-controller;
>> +     };
>> +
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <1 13 0xff08>,
>> +                          <1 14 0xff08>,
>> +                          <1 11 0xff08>,
>> +                          <1 10 0xff08>;
>> +             clock-frequency = <1200000>;
>> +     };
>
> NAK. Fix your firmware to configure CNTFRQ, on all CPUs.
Fix in next version, maybe it will take some time to change firmware.

>
> That frequency also looks a bit low; timekeeping isn't going to be very
> precise.
>
>> +     soc {
>> +             compatible = "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             interrupt-parent = <&gic>;
>> +             ranges;
>> +
>> +             ao_ctrl: ao_ctrl {
>> +                     compatible = "hisilicon,aoctrl", "syscon";
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     reg = <0x0 0xf7800000 0x0 0x2000>;
>> +                     ranges = <0 0x0 0xf7800000 0x2000>;
>> +
>> +                     clock_ao: clock0 at 0 {
>> +                             compatible = "hisilicon,hi6220-clock-ao";
>> +                             reg = <0 0x1000>;
>> +                             #clock-cells = <1>;
>> +                     };
>> +             };
>> +
>> +             sys_ctrl: sys_ctrl {
>> +                     compatible = "hisilicon,sysctrl", "syscon";
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     reg = <0x0 0xf7030000 0x0 0x2000>;
>> +                     ranges = <0 0x0 0xf7030000 0x2000>;
>> +
>> +                     clock_sys: clock1 at 0 {
>> +                             compatible = "hisilicon,hi6220-clock-sys";
>> +                             reg = <0 0x1000>;
>> +                             #clock-cells = <1>;
>> +                     };
>> +             };
>> +
>> +             media_ctrl: media_ctrl {
>> +                     compatible = "hisilicon,mediactrl", "syscon";
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     reg = <0x0 0xf4410000 0x0 0x1000>;
>> +                     ranges = <0 0x0 0xf4410000 0x1000>;
>> +
>> +                     clock_media: clock2 at 0 {
>> +                             compatible = "hisilicon,hi6220-clock-media";
>> +                             reg = <0 0x1000>;
>> +                             #clock-cells = <1>;
>> +                     };
>> +             };
>> +
>> +             pm_ctrl: pm_ctrl {
>> +                     compatible = "hisilicon,pmctrl", "syscon";
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     reg = <0x0 0xf7032000 0x0 0x1000>;
>> +                     ranges = <0 0x0 0xf7032000 0x1000>;
>> +
>> +                     clock_power: clock3 at 0 {
>> +                             compatible = "hisilicon,hi6220-clock-power";
>> +                             reg = <0 0x1000>;
>> +                             #clock-cells = <1>;
>> +                     };
>> +             };
>
> I really doesn't see the point in having a sub-device that covers the
> entirely of the register space of the containing node, and that being
> the case I am extremely concerned that the containers are marked as
> syscon compatible.
The SoC clocks are designed and placed under different system controllers,
so I define corresponding nodes under different controllers for clock operation.

>
> Why are these marked as being syscon devices? Per the dts _all_ their
> registers are clearly owned by their child nodes, and shouldn't be poked
> by anything else.
>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Best Regards,

Bintian
===========================
Don't be nervous, just be happy!
