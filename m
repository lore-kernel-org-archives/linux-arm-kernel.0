From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 15:16:39 +0200
Subject: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
In-Reply-To: <57DBEBC8.7000209@arm.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
 <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
 <1474023805.17258.10.camel@gmail.com> <57DBEBC8.7000209@arm.com>
Message-ID: <CAJKOXPfwk43hVmC8=2gt9ke6Az5bWAsV4AierWiYscKo6_aj3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 2:55 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> +Krzystof, Kukjin,
>
> On 16/09/16 12:03, Alban Browaeys wrote:
>> Le vendredi 16 septembre 2016 ? 08:51 +0100, Marc Zyngier a ?crit :
>>> Hi Alban,
>>>
>>> On 16/09/16 00:02, Alban Browaeys wrote:
>>>> I am seeing this on arm odroid u2 devicetree :
>>>> genirq: Setting trigger mode 0 for irq 16 failed
>>>> (gic_set_type+0x0/0x64)
>>>
>>> Passing IRQ_TYPE_NONE to a cascading interrupt is risky at best...
>>> Can you point me to the various DTs and their failing interrupts?
>>
>> mine is:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidu3.dts
>>
>> I got a report of this issue to another odroid :
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidx2.dts
>>
>>
>>
>> they both get their settings from :
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412.dtsi
>>
>> relevant in the chain are:
>> - combiner modified:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4x12.dtsi#n460
>
> How wonderful. This section is an utter pile of crap. Really.
> Having 0 as the trigger is illegal, and the valid values are fully
> documented in the GIC binding. No wonder things start breaking.


+CC Marek Szyprowski,

Yes, that is interesting pile. Lately we stomped into it as well... I
started fixing this today but didn't finish it yet.

> And that's from the following stuff:
>
>         &pinctrl_0 {
>                 compatible = "samsung,exynos4x12-pinctrl";
>                 reg = <0x11400000 0x1000>;
>                 interrupts = <0 47 0>;
>         };
>
>         &pinctrl_1 {
>                 compatible = "samsung,exynos4x12-pinctrl";
>                 reg = <0x11000000 0x1000>;
>                 interrupts = <0 46 0>;
>
>                 wakup_eint: wakeup-interrupt-controller {
>                         compatible = "samsung,exynos4210-wakeup-eint";
>                         interrupt-parent = <&gic>;
>                         interrupts = <0 32 0>;
>                 };
>         };
>
>         [...]
>
>         &pinctrl_3 {
>                 compatible = "samsung,exynos4x12-pinctrl";
>                 reg = <0x106E0000 0x1000>;
>                 interrupts = <0 72 0>;
>         };
>
> which perpetuates this fine tradition...
>
> At that stage, I'm not sure I should care. Does the workaround make your
> platform usable? The Samsung maintainers should really try and fix their
> DT, because it is a miracle this has made it that far.

Miracle or coincidence. :)

Thanks Geert and Alban for bringing this up, I'll add also yours reported-by.

Best regards,
Krzysztof
