From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 28 Aug 2013 19:53:03 +0800
Subject: [PATCH v7 08/11] ARM: hi3xxx: add smp support
In-Reply-To: <20130828021211.GF22852@quad.lixom.net>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-9-git-send-email-haojian.zhuang@linaro.org>
 <20130828021211.GF22852@quad.lixom.net>
Message-ID: <CAMj5BkjJXeYd4Gh2+DKiJo60ftTSf0vnAiApH86+-zdsoVqXog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Olof, will update with your comments.

>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> index 3be60c8..4cc5c57 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -8,3 +8,50 @@ Required root node properties:
>>  Hi4511 Board
>>  Required root node properties:
>>       - compatible = "hisilicon,hi3620-hi4511";
>> +
>> +
>> +Hisilicon sctrl resiter
>
> Resiter seems like odd naming here.
>
>> +
>> +Required properties:
>> +- compatible : "hisilicon,sctrl"
>> +- reg : Address and size of sysctrl.
>
> sysctrl or sctrl? sysctrl isn't really too long, might as well use that.
>
>> +
>> +Optional properties:
>> +- smp_reg : offset in sysctrl for notifying slave cpu booting
>> +             cpu 1, reg;
>> +             cpu 2, reg + 0x4;
>> +             cpu 3, reg + 0x8;
>> +             If reg value is not zero, cpun exit wfi and go
>> +- resume_reg : offset in sysctrl for notifying cpu0 when resume
>> +- reset_reg : offset in sysctrl for system reset
>
> Underscores are usually not used in properties, you use dashes instead.
>
> Anyway, I suggest defining those as the different cells in a regular 'reg'
> property instead.

Will update with

Required properties:
- compatible : "hisilicon,sysctrl"
- reg : Register address and size

Optional properties:
- smp-off : offset in sysctrl for notifying slave cpu booting
                cpu 1, reg;
                cpu 2, reg + 0x4;
                cpu 3, reg + 0x8;
                If reg value is not zero, cpun exit wfi and go
- resume-off : offset in sysctrl for notifying cpu0 when resume
- reboot-off : offset in sysctrl for system reboot

>
>> +
>> +Example:
>> +     hi3716:
>> +     sctrl at f8000000 {
>
> Labels are usually not done on a separate line before.
>
> Common node names would be more clear-text than this. Maybe "system-controller"
> in this case.

will update with
   sysctrl: system-controller at f8000000 {
                compatible = "hisilicon,sysctrl";
                reg = <0xf8000000 0x1000>;
                smp-off = <0xc0>;
                reboot-off = <0x4>;
        };


>
>
>> +             compatible = "hisilicon,sctrl";
>> +             reg = <0xf8000000 0x1000>;
>> +             smp_reg = <0xc0>;
>> +             reboot_reg = <0x4>;
>> +     };
>> +
>> +     hi3620:
>> +     sctrl at fc802000 {
>> +             compatible = "hisilicon,sctrl";
>> +             reg = <0xfc802000 0x1000>;
>> +             smp_reg = <0x31c>;
>> +             resume_reg = <0x308>;
>> +             reboot_reg = <0x4>;
>> +     };
>> +
>> +Hi3716 cpuctrl register
>> +Required properties:
>> +- compatible : "hisilicon,cpuctrl"
>> +- reg : Address and size of cpuctrl.
>> +
>> +Hi3716 specific cpuctrl register, control hotplug info etc.
>
> Controlling hotplug _info_? Seems like odd wording here.
Update to
Hi3716 cpuctrl register
Hi3716 specific cpuctrl register, control power & clock of cpu and module.

>
>> +Example:
>> +     hi3716:
>> +     cpuctrl at f8a22000 {
>> +             compatible = "hisilicon,cpuctrl";
>> +             reg = <0xf8a22000 0x2000>;
>> +     };
>> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
>> index 39fa37f..ee81192 100644
>> --- a/arch/arm/boot/dts/hi3620.dtsi
>> +++ b/arch/arm/boot/dts/hi3620.dtsi
>> @@ -32,6 +32,24 @@
>>                       reg = <0x0>;
>>                       next-level-cache = <&L2>;
>>               };
>> +             cpu1: cpu at 1 {
>
> Do you need labels here? I don't think these are referred to as phandles
> anywhere?
>
>> +                     compatible = "arm,cortex-a9";
>> +                     device_type = "cpu";
>> +                     reg = <1>;
>> +                     next-level-cache = <&L2>;
>> +             };
>> +             cpu2: cpu at 2 {
>> +                     compatible = "arm,cortex-a9";
>> +                     device_type = "cpu";
>> +                     reg = <2>;
>> +                     next-level-cache = <&L2>;
>> +             };
>> +             cpu3: cpu at 3 {
>> +                     compatible = "arm,cortex-a9";
>> +                     device_type = "cpu";
>> +                     reg = <3>;
>> +                     next-level-cache = <&L2>;
>> +             };
>>       };
>>
>>       osc32k: osc32k {
>> @@ -130,7 +148,9 @@
>>                       reg = <0xfc802000 0x1000>;
>>                       #address-cells = <1>;
>>                       #size-cells = <0>;
>> -
>> +                     smp_reg = <0x31c>;
>> +                     resume_reg = <0x308>;
>> +                     reboot_reg = <0x4>;
>>
>>                       timer0_mux: timer0_mux {
>>                               compatible = "hisilicon,clk-mux";
>> @@ -1242,6 +1262,12 @@
>>                       status = "disabled";
>>               };
>>
>> +             timer5: timer at fc000600 {
>> +                     compatible = "arm,cortex-a9-twd-timer";
>> +                     reg = <0xfc000600 0x20>;
>> +                     interrupts = <1 13 0xf01>;
>> +             };
>> +
>>               uart0: uart at fcb00000 {
>>                       compatible = "arm,pl011", "arm,primecell";
>>                       reg = <0xfcb00000 0x1000>;
>> diff --git a/arch/arm/boot/dts/hi4511.dts b/arch/arm/boot/dts/hi4511.dts
>> index 7e67564..c9fd329 100644
>> --- a/arch/arm/boot/dts/hi4511.dts
>> +++ b/arch/arm/boot/dts/hi4511.dts
>> @@ -15,7 +15,7 @@
>>       compatible = "hisilicon,hi3620-hi4511";
>>
>>       chosen {
>> -             bootargs = "console=ttyAMA0,115200 root=/dev/ram0 earlyprintk";
>> +             bootargs = "console=ttyAMA0,115200 root=/dev/ram0 nr_cpus=4 earlyprintk";
>
> nr_cpus should not be needed on the command line.
>
>>       };
>>
>>       memory {
>> diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
>> index 68bd26c..d2e7d57 100644
>> --- a/arch/arm/mach-hi3xxx/Kconfig
>> +++ b/arch/arm/mach-hi3xxx/Kconfig
>> @@ -6,6 +6,8 @@ config ARCH_HI3xxx
>>       select CACHE_L2X0
>>       select CLKSRC_OF
>>       select GENERIC_CLOCKEVENTS
>> +     select HAVE_ARM_SCU
>> +     select HAVE_SMP
>>       select PINCTRL
>>       select PINCTRL_SINGLE
>>       help
>> diff --git a/arch/arm/mach-hi3xxx/Makefile b/arch/arm/mach-hi3xxx/Makefile
>> index d68ebb3..0917f1c 100644
>> --- a/arch/arm/mach-hi3xxx/Makefile
>> +++ b/arch/arm/mach-hi3xxx/Makefile
>> @@ -2,4 +2,5 @@
>>  # Makefile for Hisilicon Hi36xx/Hi37xx processors line
>>  #
>>
>> -obj-y        += hi3xxx.o
>> +obj-y        += hi3xxx.o system.o
>> +obj-$(CONFIG_SMP)            += platsmp.o
>> diff --git a/arch/arm/mach-hi3xxx/core.h b/arch/arm/mach-hi3xxx/core.h
>> new file mode 100644
>> index 0000000..2cfd643
>> --- /dev/null
>> +++ b/arch/arm/mach-hi3xxx/core.h
>> @@ -0,0 +1,14 @@
>> +#ifndef __HISILICON_CORE_H
>> +#define __HISILICON_CORE_H
>> +
>> +#include <linux/init.h>
>
> I don't think you need linux/init.h here?
>
Thanks, definitely true.
