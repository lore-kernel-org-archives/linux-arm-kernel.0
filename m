From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Mar 2015 16:55:06 +0000
Subject: [PATCH v6 0/4] irqchip: move away from gic_arch_extn.irq_set_wake
In-Reply-To: <CAMuHMdXQZGSE7JdBsy=-ERp7wjTpkN63RNcDcRkYriyn+O4pyw@mail.gmail.com>
References: <1426088737-15817-1-git-send-email-marc.zyngier@arm.com>
 <CAMuHMdXQZGSE7JdBsy=-ERp7wjTpkN63RNcDcRkYriyn+O4pyw@mail.gmail.com>
Message-ID: <5509ADEA.1090604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/15 15:30, Geert Uytterhoeven wrote:
> Hi Marc,
> 
> On Wed, Mar 11, 2015 at 4:45 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> This series is extracted from [4], which is trying to remove all
>> traces of gic_arch_extn from the tree. As some maintainers are more
>> responsive than others (understatement of the year...), I've decided
>> to split it per sub-arch, and get it moving, at least partially.
>>
>> This small set of patches slightly modifies some of the least
>> offending platforms, by providing a much limited hook into the GIC
>> driver.
> 
>> Marc Zyngier (4):
>>   irqchip: gic: add an entry point to set up irqchip flags
>>   ARM: shmobile: remove use of gic_arch_extn.irq_set_wake
>>   ARM: ux500: switch from gic_arch_extn to gic_set_irqchip_flags
>>   ARM: zynq: switch from gic_arch_extn to gic_set_irqchip_flags
> 
> As I'm feeling the need to add gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE)
> for more shmobile SoCs (which implies populating mach_desc.init_irq()
> again, and also calling irqchip_init() explicitly), I'm wondering if it
> wouldn't be better to just initialize "gic_chip.flags = IRQCHIP_SKIP_SET_WAKE"
> unconditionally?
> Currently the GIC driver doesn't have to do anything special to support
> wake-up, but support for that may be added one day.

It is unlikely we'll ever add this support, because the GIC doesn't not
have that capability in HW (wake-up is not even part of the
architecture). This is why wake up is always left to some other
interrupt controller.

> Every driver that wants to implements wake-up properly should call
> irq_set_irq_wake() or {en,dis}able_irq_wake() to inform the upstream interrupt
> controller. However, with GIC, that gives (except on sh73a0, r8a7779,
> ux500, and zynq) annoying warning messages during resume:
> 
>     WARNING: CPU: 1 PID: 1341 at kernel/irq/manage.c:540
> irq_set_irq_wake+0x9c/0xf8()
>     Unbalanced IRQ 26 wake disable
> 
> I guess I could just leave out the call to irq_set_irq_wake() in my GPIO driver,
> as it works fine without, but that doesn't look correct to me.
> 
> What do you think?

At the moment, your approach will work, but only because we have another
bug, as described here:

http://lkml.iu.edu/hypermail/linux/kernel/1501.1/04757.html

Fixing this bug means we will propagate the flag to be visible at the
top level of the controller hierarchy, which will cause any
irq_set_irq_wake() request to be ignored. Probably not what people have
mind.

Only the platform code knows the topology of the system, unfortunately.

When it comes to the message you describe above, I'd blame the driver:
irq_set_irq_wake() does return -ENXIO when there is no irq_set_wake
method. The driver should definitely test this, avoid doing a wake
disable if the enable has failed.

Thanks,

	M.

> Thanks!
> 
> See also "[PATCH resend 2/2] [RFC] genirq: Set IRQCHIP_SKIP_SET_WAKE for
> no_irq_chip and dummy_irq_chip" (https://lkml.org/lkml/2015/1/12/506).
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Jazz is not dead. It just smells funny...
