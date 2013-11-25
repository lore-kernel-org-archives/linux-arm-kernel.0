From: olof@lixom.net (Olof Johansson)
Date: Sun, 24 Nov 2013 20:00:39 -0800
Subject: [PATCH v11 5/6] ARM: hi3xxx: add smp support
In-Reply-To: <CAD6h2NRTc42YAKr6zLdMpiYbpBLatA9HNpZeFa3pZZpvJXBuCg@mail.gmail.com>
References: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>
 <1383813691-31587-6-git-send-email-haojian.zhuang@linaro.org>
 <527B6BCA.2010606@gmail.com>
 <CAD6h2NRTc42YAKr6zLdMpiYbpBLatA9HNpZeFa3pZZpvJXBuCg@mail.gmail.com>
Message-ID: <CAOesGMiL_Ev647aVTDnwLVM7b_uOA3Qwd6TUXaOTC5b9H2w02w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 12:49 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> On 7 November 2013 18:30, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>>
>> On 11/7/13 2:41 AM, Haojian Zhuang wrote:
>>> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>
>>> Enable SMP support on hi3xxx platform
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
>>> Tested-by: Li Xin <li.xin@linaro.org>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>> ---
>>>  .../bindings/arm/hisilicon/hisilicon.txt           | 30 ++++++--
>>>  arch/arm/boot/dts/hi3620.dtsi                      | 38 ++++++++++
>>>  arch/arm/mach-hi3xxx/Kconfig                       |  3 +
>>>  arch/arm/mach-hi3xxx/Makefile                      |  1 +
>>>  arch/arm/mach-hi3xxx/core.h                        | 11 +++
>>>  arch/arm/mach-hi3xxx/hi3xxx.c                      | 34 +++++++++
>>>  arch/arm/mach-hi3xxx/platsmp.c                     | 84 ++++++++++++++++++++++
>>>  7 files changed, 197 insertions(+), 4 deletions(-)
>>>  create mode 100644 arch/arm/mach-hi3xxx/core.h
>>>  create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>> index 3be60c8..8c7a465 100644
>>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>> @@ -1,10 +1,32 @@
>>>  Hisilicon Platforms Device Tree Bindings
>>>  ----------------------------------------------------
>>>
>>> -Hi3716 Development Board
>>> -Required root node properties:
>>> -     - compatible = "hisilicon,hi3716-dkb";
>>> -
>>>  Hi4511 Board
>>>  Required root node properties:
>>>       - compatible = "hisilicon,hi3620-hi4511";
>>> +
>>> +Hisilicon system controller
>>> +
>>> +Required properties:
>>> +- compatible : "hisilicon,sysctrl"
>>> +- reg : Register address and size
>>> +
>>> +Optional properties:
>>> +- smp-offset : offset in sysctrl for notifying slave cpu booting
>>> +             cpu 1, reg;
>>> +             cpu 2, reg + 0x4;
>>> +             cpu 3, reg + 0x8;
>>> +             If reg value is not zero, cpun exit wfi and go
>>> +- resume-offset : offset in sysctrl for notifying cpu0 when resume
>>> +- reboot-offset : offset in sysctrl for system reboot
>>> +
>>> +Example:
>>> +
>>> +     /* for Hi3620 */
>>> +     sysctrl: system-controller at fc802000 {
>>> +             compatible = "hisilicon,sysctrl";
>>> +             reg = <0xfc802000 0x1000>;
>>> +             smp-offset = <0x31c>;
>>> +             resume-offset = <0x308>;
>>> +             reboot-offset = <0x4>;
>>> +     };
>>> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
>>> index b9d8679..e311937 100644
>>> --- a/arch/arm/boot/dts/hi3620.dtsi
>>> +++ b/arch/arm/boot/dts/hi3620.dtsi
>>> @@ -39,6 +39,27 @@
>>>                       reg = <0x0>;
>>>                       next-level-cache = <&L2>;
>>>               };
>>> +
>>> +             cpu at 1 {
>>> +                     compatible = "arm,cortex-a9";
>>> +                     device_type = "cpu";
>>> +                     reg = <1>;
>>> +                     next-level-cache = <&L2>;
>>> +             };
>>> +
>>> +             cpu at 2 {
>>> +                     compatible = "arm,cortex-a9";
>>> +                     device_type = "cpu";
>>> +                     reg = <2>;
>>> +                     next-level-cache = <&L2>;
>>> +             };
>>> +
>>> +             cpu at 3 {
>>> +                     compatible = "arm,cortex-a9";
>>> +                     device_type = "cpu";
>>> +                     reg = <3>;
>>> +                     next-level-cache = <&L2>;
>>> +             };
>>>       };
>>>
>>>       amba {
>>> @@ -65,6 +86,17 @@
>>>                       reg = <0x1000 0x1000>, <0x100 0x100>;
>>>               };
>>>
>>> +             sysctrl: system-controller at 802000 {
>>> +                     compatible = "hisilicon,sysctrl";
>>> +                     reg = <0x802000 0x1000>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <0>;
>>> +
>>> +                     smp-offset = <0x31c>;
>>> +                     resume-offset = <0x308>;
>>> +                     reboot-offset = <0x4>;
>>> +             };
>>> +
>>>               dual_timer0: dual_timer at 800000 {
>>>                       compatible = "arm,sp804", "arm,primecell";
>>>                       reg = <0x800000 0x1000>;
>>> @@ -115,6 +147,12 @@
>>>                       status = "disabled";
>>>               };
>>>
>>> +             timer5: timer at 600 {
>>> +                     compatible = "arm,cortex-a9-twd-timer";
>>> +                     reg = <0x600 0x20>;
>>> +                     interrupts = <1 13 0xf01>;
>>> +             };
>> Do you have a clocks node for this timer?
>
> As I mentioned in the 0th patch, clock binding are totally removed
> in this patch. And clock driver will be append in another patch set.
>
>>> +
>>>               uart0: uart at b00000 {
>>>                       compatible = "arm,pl011", "arm,primecell";
>>>                       reg = <0xb00000 0x1000>;
>>> diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
>>> index 68bd26c..d0f298a 100644
>>> --- a/arch/arm/mach-hi3xxx/Kconfig
>>> +++ b/arch/arm/mach-hi3xxx/Kconfig
>>> @@ -6,6 +6,9 @@ config ARCH_HI3xxx
>>>       select CACHE_L2X0
>>>       select CLKSRC_OF
>>>       select GENERIC_CLOCKEVENTS
>>> +     select HAVE_ARM_SCU
>>> +     select HAVE_ARM_TWD
>> Need "if SMP" to avoid a build failure for a non-smp kernel.
>>
>
> ARCH_HI3xxx always need SMP configuration. HAVE_SMP is already
> required. So it's impossible to build a non-smp kernel with this kernel
> configuration.

Then you need to have appropriate dependencies in Kconfig.

Right now, someone can do:

make hi3xxx_defconfig
edit .config, disable CONFIG_SMP
make

and get errors both from Kconfig:

warning: (ARCH_HI3xxx && SOC_OMAP5 && ARCH_SHMOBILE_MULTI) selects
HAVE_ARM_TWD which has unmet direct dependencies (SMP)

and from the make:

arch/arm/kernel/smp_twd.c: In function 'twd_local_timer_of_register':
arch/arm/kernel/smp_twd.c:391:20: error: 'setup_max_cpus' undeclared
(first use in this function)
  if (!is_smp() || !setup_max_cpus)

... etc.

I.e. omap and shmobile have similar issues but we'll sort them out in
separate patches. You should still fix the hisilicon one.

>>>  /*
>>>   * This table is only for optimization. Since ioremap() could always share
>>>   * the same mapping if it's defined as static IO mapping.
>>> @@ -29,6 +34,7 @@
>>>   */
>>>  static struct map_desc hi3620_io_desc[] __initdata = {
>>>       {
>>> +             /* sysctrl */
>> What's this comment for?
>>>               .pfn            = __phys_to_pfn(0xfc802000),
>>>               .virtual        = 0xfe802000,
>>>               .length         = 0x1000,
>>> @@ -48,6 +54,32 @@ static void __init hi3xxx_timer_init(void)
>>>       clocksource_of_init();
>>>  }

I know the code was added in a different patch, but I don't like the
lack of using constants here.



>>> +static void hi3xxx_restart(enum reboot_mode mode, const char *cmd)
>>> +{
>>> +     struct device_node *np;
>>> +     void __iomem *base;
>>> +     int offset;
>>> +
>>> +     np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>>> +     if (!np) {
>>> +             pr_err("failed to find hisilicon,sysctrl node\n");
>>> +             return;
>>> +     }
>>> +     base = of_iomap(np, 0);


You can't do this ioremap at restart time, since you can't rely on
things being up enough for that when you're panicking, for example.
Please set up the ioremap beforehand so you can just do the
writel_relaxed, etc.


>>> diff --git a/arch/arm/mach-hi3xxx/platsmp.c b/arch/arm/mach-hi3xxx/platsmp.c
>>> new file mode 100644
>>> index 0000000..a4d04c0
>>> --- /dev/null
>>> +++ b/arch/arm/mach-hi3xxx/platsmp.c
>>> @@ -0,0 +1,84 @@
>>> +/*
>>> + * Copyright (c) 2013 Linaro Ltd.
>>> + * Copyright (c) 2013 Hisilicon Limited.
>>> + * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.

Based on what platsmp? There are a lot of them under arch/arm. :)


-Olof
