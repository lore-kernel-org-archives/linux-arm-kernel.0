From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 27 Jan 2015 16:12:08 +0000
Subject: [PATCH v7 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <54B92245.6080306@arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-14-git-send-email-hanjun.guo@linaro.org>
 <54B8F2E3.80306@arm.com>
 <CACxGe6tBb8L8upS3zenZbrOc_c0E=MA=DqLjkSezEbregaAaaA@mail.gmail.com>
 <54B92245.6080306@arm.com>
Message-ID: <CACxGe6vb8au6sc0gDMDu4kuzmYBCuOrcObWkbj1mDoCGTgVLVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 2:37 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> @@ -78,6 +79,10 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>>>>  void __init init_IRQ(void)
>>>>  {
>>>>     irqchip_init();
>>>> +
>>>> +   if (!handle_arch_irq)
>>>> +           acpi_gic_init();
>>>> +
>>>
>>> Why isn't this called from irqchip_init? It would seem like the logical
>>> spot to probe an interrupt controller.
>>
>> What has been done here isn't an unusual choice. We've got stuff all
>> over the kernel that may or may not be implemented depending on what
>> the architecture supports. If the function call is renamed to
>> acpi_init_irq(), are you content?
>
> My (full) suggestion was to do it like we've done it for DT, and I don't
> think I varied much from this point of view. Yes, calling it
> acpi_irq_init() would be a good start, and having the ACPI-compatible
> irqchips to be self-probable even better.
>
> <lack-of-sleep-rant>
>
> Hell, if nobody beats me to it, maybe I'll just write that code, with
> proper entry points in the various GIC drivers. Yes, this is
> infrastructure. Maybe it is grossly overdesigned. But I really spend too
> much time dealing with the crap that people are happy to pile on top of
> the GIC code to be madly enthusiastic about the general "good enough"
> attitude.
>
> </lack-of-sleep-rant>
>
> Or to put it in a slightly more diplomatic way: If ACPI is to be our
> future, can we please make the future look a bit better?

Hi Marc,

As per our off-list discussion, I completely agree. We don't want to
be adding hack upon hack, and I will be first in line to NAK any
patches taking that approach. However, for this initial series, it
only supports exactly one GIC that can be set up by ACPI. Can we agree
to leave it as is in this series, with the agreement that it will be
replaced for v2m and v3 support with a proper pluggable initializer?
Tomasz is currently working on getting that change ready, but the
logistics are simpler if this series isn't blocked on that change.

g.
