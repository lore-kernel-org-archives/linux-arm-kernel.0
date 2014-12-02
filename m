From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 Dec 2014 14:12:03 +0000
Subject: [PATCH v8 1/4] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <CAMuHMdVkH_qshTfpXBcHx1FiEzL8055s1TiJqayWLXeFUf97NQ@mail.gmail.com>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>	<1416902662-19281-2-git-send-email-yingjoe.chen@mediatek.com>	<CAMuHMdWj0Z66fya=7oN=ZUoz0TQOHFxBe0wyHmkDDVzU8Lafog@mail.gmail.com>	<547DC0B7.6050600@arm.com>
 <CAMuHMdVkH_qshTfpXBcHx1FiEzL8055s1TiJqayWLXeFUf97NQ@mail.gmail.com>
Message-ID: <547DC8B3.1000200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/14 13:55, Geert Uytterhoeven wrote:
> Hi Marc,
> 
> On Tue, Dec 2, 2014 at 2:37 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 02/12/14 13:27, Geert Uytterhoeven wrote:
>>> On Tue, Nov 25, 2014 at 9:04 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>>>> Add support to use gic as a parent for stacked irq domain.
>>>>
>>>> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
>>>
>>> This change (which is now in -next as commit 9a1091ef0017c40a) breaks
>>> booting on r8a7740/armadillo-legacy.
>>>
>>> It hangs because the timers cannot get their interrupts:
>>>
>>> console [tty0] enabled
>>>  sh-tmu.0: ch0: used for clock events
>>>  sh-tmu.0: ch0: used for periodic clock events
>>>  sh-tmu.0: ch0: failed to request irq 230
>>>  sh-tmu.0: ch1: used as clock source
>>>  sh-cmt-48.1: ch0: failed to request irq 90
>>>  sh-cmt-48.1: ch0: registration failed
>>> earlytimer: unable to probe sh-cmt-48 early.
>>> Calibrating delay loop...
>>
>> Grmbl... Are you, by any (lack of) chance, using a setup where the GIC
>> is probed via DT, but the timers have their IRQs hardcoded?
> 
> Yes, the GIC is declared in arch/arm/boot/dts/r8a7740.dtsi:
> 
>         gic: interrupt-controller at c2800000 {
>                 compatible = "arm,cortex-a9-gic";
>                 #interrupt-cells = <3>;
>                 interrupt-controller;
>                 reg = <0xc2800000 0x1000>,
>                       <0xc2000000 0x1000>;
>         };
> 
> The timers come from legacy C board code in
> arch/arm/mach-shmobile/setup-r8a7740.c:
> 
> /* CMT */
> static struct sh_timer_config cmt1_platform_data = {
>         .channels_mask = 0x3f,
> };
> 
> static struct resource cmt1_resources[] = {
>         DEFINE_RES_MEM(0xe6138000, 0x170),
>         DEFINE_RES_IRQ(gic_spi(58)),
> };

Yup. This gic_spi() macro is completely doomed, as it computes a
hardware interrupt where the kernel expects a virtual one. The only way
to fix this is to init the GIC outside of DT, so that we stick to a
legacy irqdomain. You can still use information from DT, but you can't
rely on irqchip_init() to produce something that a legacy platform can use.

> The corresponding r8a7740/armadillo-multiplatform works fine.

OK, that's indeed the expected result.

> Still, I'm wondering why sh73a0/kzm9g-legacy is not impacted by this
> change...

I'm a bit lost looking at the shmobile code. But I agree, kzm9g should
die a painful death, as it has the same level of breakage as armadillo.

	M.
-- 
Jazz is not dead. It just smells funny...
