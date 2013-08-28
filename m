From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 28 Aug 2013 19:45:03 +0800
Subject: [PATCH v7 09/11] ARM: hi3xxx: add hotplug support
In-Reply-To: <20130828022100.GG22852@quad.lixom.net>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-10-git-send-email-haojian.zhuang@linaro.org>
 <20130828022100.GG22852@quad.lixom.net>
Message-ID: <CAMj5Bkh170sr-Bs28LExtYcVoAUOCVTG8H60Kaoj3S2Een=JDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Olof

Thanks for the good suggestion.
All the comments make sense, will update in new version.

>> +void hs_set_cpu(int cpu, bool enable)
>> +{
>> +     u32 val = 0;
>> +
>> +     if (!ctrl_base)
>> +             return;
>> +
>> +     if (id == HI3620_CTRL) {
>> +             if (enable) {
>> +                     /* MTCMOS */
>> +                     writel_relaxed((0x01 << (cpu + 3)), ctrl_base + 0xD0);
>
> 0xD0 should be 0xd0 (we usually don't use all-caps hex)
>
>> +                     writel_relaxed((0x1011 << cpu), ctrl_base + 0x414);
>> +                     writel_relaxed((0x401011 << cpu), ctrl_base + 0x410);
>
> You can skip the outermost parens here.
>
> These numbers look pretty magic. Can you make it slightly easier for someone
> reading the code to figure out what's going on?
>
>> +                     /* ISO disable */
>> +                     writel((0x01 << (cpu + 3)), ctrl_base + 0x0C4);
>
> 0x0C4 should be 0xc4. Also, it's clearer if you use 0x8 << cpu  instead.
>
>
>> +
>> +                     /* WFI Mask */
>> +                     val = readl(ctrl_base + 0x200);
>> +                     val &= ~(0x1 << (cpu+28));
>
> Same here, don't use cpu + 28, modify the constant instead. Same for the other
> occurrances below.
>
>> +                     writel(val, ctrl_base + 0x200);
>> +
>> +                     /* Enable core */
>> +                     writel_relaxed((0x01 << cpu), ctrl_base + 0xf4);
>> +                     /* Unreset */
>> +                     writel_relaxed((0x401011 << cpu), ctrl_base + 0x414);
>> +             } else {
>> +                     /* iso enable */
>> +                     writel_relaxed((0x01 << (cpu + 3)), ctrl_base + 0xC0);
>> +
>> +                     /* MTCMOS */
>> +                     writel_relaxed((0x01 << (cpu + 3)), ctrl_base + 0xD4);
>> +
>> +                     /* wfi mask */
>> +                     val = readl_relaxed(ctrl_base + 0x200);
>> +                     val |= (0x1 << (cpu+28));
>> +                     writel_relaxed(val, ctrl_base + 0x200);
>> +
>> +                     /* disable core*/
>> +                     writel_relaxed((0x01 << cpu), ctrl_base + 0xf8);
>> +                     /* Reset */
>> +                     writel_relaxed((0x401011 << cpu), ctrl_base + 0x410);
>> +             }
>> +     } else if (id == HI3716_CTRL) {
>> +             if (enable) {
>> +                     /* power on cpu1 */
>> +                     val = readl_relaxed(ctrl_base + 0x1000);
>> +                     val &=  ~(0x1 << 8);
>> +                     val |= (0x1 << 7);
>> +                     val &= ~(0x1 << 3);
>> +                     writel_relaxed(val, ctrl_base + 0x1000);
>> +
>> +                     /* unreset */
>> +                     val = readl_relaxed(ctrl_base + 0x50);
>> +                     val &= ~(0x1 << 17);
>> +                     writel_relaxed(val, ctrl_base + 0x50);
>> +             } else {
>> +                     /* power down cpu1 */
>> +                     val = readl_relaxed(ctrl_base + 0x1000);
>> +                     val &=  ~(0x1 << 8);
>> +                     val |= (0x1 << 7);
>> +                     val |= (0x1 << 3);
>> +                     writel_relaxed(val, ctrl_base + 0x1000);
>> +
>> +                     /* reset */
>> +                     val = readl_relaxed(ctrl_base + 0x50);
>> +                     val |= (0x1 << 17);
>> +                     writel_relaxed(val, ctrl_base + 0x50);
>> +             }
>> +     }
>
> So the function above really shares no code path between the different SoCs.
> Instead of doing it all in nested if/else bodies, please split it up in two
> functions, one for each SoC. You can still keep the enable/disable paths under
> if/else though.
>
>> +}
>> +
>> +void __init hs_hotplug_init(void)
>> +{
>> +     struct device_node *node;
>> +
>> +     node = of_find_compatible_node(NULL, NULL, "hisilicon,cpuctrl");
>> +     if (node) {
>> +             ctrl_base = of_iomap(node, 0);
>> +             id = HI3716_CTRL;
>
> You should use something more specific than just hisilicon,cpuctrl here, if
> it's truly tied to the SoC (i.e. this ID here).
>
> hisilicon,hi3716-cpuctrl seems appropriate. Note that the bindings need
> to be revised for this.
>
>> +             return;
>> +     }
>> +     node = of_find_compatible_node(NULL, NULL, "hisilicon,sctrl");
>> +     if (node) {
>> +             ctrl_base = of_iomap(node, 0);
>> +             id = HI3620_CTRL;
>
> Same here.

Will use "hisilicon,hi3716-cpuctrl", which is specific to hi3716,
and we use this as flag to indicate hi3716 soc

Will use "hisilicon,sysctrl", however, it exists on both hi3620 and hi3716.
So use as a flag of hi3620 after check hi3716.

>
>> +             return;
>> +     }
>> +}
>> +
>> +static inline void cpu_enter_lowpower(void)
>> +{
>> +     unsigned int v;
>> +
>> +     flush_cache_all();
>> +     asm volatile(
>> +     /*
>> +      * Turn off coherency and L1 D-cache
>> +      */
>
> Move the comment up above the asm volatile
>

Thanks
