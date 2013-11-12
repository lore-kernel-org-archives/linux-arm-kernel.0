From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Nov 2013 07:39:32 +0800
Subject: [PATCH v11 5/6] ARM: hi3xxx: add smp support
In-Reply-To: <87txfhmdi3.fsf@linaro.org>
References: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>	<1383813691-31587-6-git-send-email-haojian.zhuang@linaro.org>	<527B6BCA.2010606@gmail.com>	<CAD6h2NRTc42YAKr6zLdMpiYbpBLatA9HNpZeFa3pZZpvJXBuCg@mail.gmail.com>
 <87txfhmdi3.fsf@linaro.org>
Message-ID: <5282BC34.8010008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/13/2013 07:00 AM, Kevin Hilman wrote:
> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
>
>> On 7 November 2013 18:30, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>>> On 11/7/13 2:41 AM, Haojian Zhuang wrote:
>>>> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>>
>>>> Enable SMP support on hi3xxx platform
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>> Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
>>>> Tested-by: Li Xin <li.xin@linaro.org>
>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>>> ---
>>>>   .../bindings/arm/hisilicon/hisilicon.txt           | 30 ++++++--
>>>>   arch/arm/boot/dts/hi3620.dtsi                      | 38 ++++++++++
>>>>   arch/arm/mach-hi3xxx/Kconfig                       |  3 +
>>>>   arch/arm/mach-hi3xxx/Makefile                      |  1 +
>>>>   arch/arm/mach-hi3xxx/core.h                        | 11 +++
>>>>   arch/arm/mach-hi3xxx/hi3xxx.c                      | 34 +++++++++
>>>>   arch/arm/mach-hi3xxx/platsmp.c                     | 84 ++++++++++++++++++++++
>>>>   7 files changed, 197 insertions(+), 4 deletions(-)
>>>>   create mode 100644 arch/arm/mach-hi3xxx/core.h
>>>>   create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> index 3be60c8..8c7a465 100644
>>>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> @@ -1,10 +1,32 @@
>>>>   Hisilicon Platforms Device Tree Bindings
>>>>   ----------------------------------------------------
>>>>
>>>> -Hi3716 Development Board
>>>> -Required root node properties:
>>>> -     - compatible = "hisilicon,hi3716-dkb";
>>>> -
>>>>   Hi4511 Board
>>>>   Required root node properties:
>>>>        - compatible = "hisilicon,hi3620-hi4511";
>>>> +
>>>> +Hisilicon system controller
>>>> +
>>>> +Required properties:
>>>> +- compatible : "hisilicon,sysctrl"
>>>> +- reg : Register address and size
>>>> +
>>>> +Optional properties:
>>>> +- smp-offset : offset in sysctrl for notifying slave cpu booting
>>>> +             cpu 1, reg;
>>>> +             cpu 2, reg + 0x4;
>>>> +             cpu 3, reg + 0x8;
>>>> +             If reg value is not zero, cpun exit wfi and go
>>>> +- resume-offset : offset in sysctrl for notifying cpu0 when resume
>>>> +- reboot-offset : offset in sysctrl for system reboot
>>>> +
>>>> +Example:
>>>> +
>>>> +     /* for Hi3620 */
>>>> +     sysctrl: system-controller at fc802000 {
>>>> +             compatible = "hisilicon,sysctrl";
>>>> +             reg = <0xfc802000 0x1000>;
>>>> +             smp-offset = <0x31c>;
>>>> +             resume-offset = <0x308>;
>>>> +             reboot-offset = <0x4>;
>>>> +     };
>>>> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
>>>> index b9d8679..e311937 100644
>>>> --- a/arch/arm/boot/dts/hi3620.dtsi
>>>> +++ b/arch/arm/boot/dts/hi3620.dtsi
>>>> @@ -39,6 +39,27 @@
>>>>                        reg = <0x0>;
>>>>                        next-level-cache = <&L2>;
>>>>                };
>>>> +
>>>> +             cpu at 1 {
>>>> +                     compatible = "arm,cortex-a9";
>>>> +                     device_type = "cpu";
>>>> +                     reg = <1>;
>>>> +                     next-level-cache = <&L2>;
>>>> +             };
>>>> +
>>>> +             cpu at 2 {
>>>> +                     compatible = "arm,cortex-a9";
>>>> +                     device_type = "cpu";
>>>> +                     reg = <2>;
>>>> +                     next-level-cache = <&L2>;
>>>> +             };
>>>> +
>>>> +             cpu at 3 {
>>>> +                     compatible = "arm,cortex-a9";
>>>> +                     device_type = "cpu";
>>>> +                     reg = <3>;
>>>> +                     next-level-cache = <&L2>;
>>>> +             };
>>>>        };
>>>>
>>>>        amba {
>>>> @@ -65,6 +86,17 @@
>>>>                        reg = <0x1000 0x1000>, <0x100 0x100>;
>>>>                };
>>>>
>>>> +             sysctrl: system-controller at 802000 {
>>>> +                     compatible = "hisilicon,sysctrl";
>>>> +                     reg = <0x802000 0x1000>;
>>>> +                     #address-cells = <1>;
>>>> +                     #size-cells = <0>;
>>>> +
>>>> +                     smp-offset = <0x31c>;
>>>> +                     resume-offset = <0x308>;
>>>> +                     reboot-offset = <0x4>;
>>>> +             };
>>>> +
>>>>                dual_timer0: dual_timer at 800000 {
>>>>                        compatible = "arm,sp804", "arm,primecell";
>>>>                        reg = <0x800000 0x1000>;
>>>> @@ -115,6 +147,12 @@
>>>>                        status = "disabled";
>>>>                };
>>>>
>>>> +             timer5: timer at 600 {
>>>> +                     compatible = "arm,cortex-a9-twd-timer";
>>>> +                     reg = <0x600 0x20>;
>>>> +                     interrupts = <1 13 0xf01>;
>>>> +             };
>>> Do you have a clocks node for this timer?
>> As I mentioned in the 0th patch, clock binding are totally removed
>> in this patch. And clock driver will be append in another patch set.
> Still, won't this timer still need a dummy fixed-rate clock until the
> real clocks are in place?  Otherwise it seems twd_get_clock() is going
> to fail.
>
> Kevin
sp804 is working. twd_get_clock() fails but it could calculate rate.
I tested on my platform. With this dummy fixed-rate clock, it could
work.

Regards
Haojian
