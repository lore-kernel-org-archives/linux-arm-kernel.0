From: fugang.duan@freescale.com (Duan Andy)
Date: Thu, 16 Jul 2015 08:14:57 +0000
Subject: [PATCH 3.19.y-ckt 173/251] clocksource: exynos_mct: Avoid
 blocking calls in the cpu hotplug notifier
In-Reply-To: <CAJKOXPf3ik5XahaK-fv0EOFhPHpO1aQ7PGxbAMrGiSrK4j1EYA@mail.gmail.com>
References: <1437008972-9140-1-git-send-email-kamal@canonical.com>
 <1437008972-9140-174-git-send-email-kamal@canonical.com>
 <BLUPR03MB373DFDE70DADB28EC1666A0F5990@BLUPR03MB373.namprd03.prod.outlook.com>
 <CAJKOXPf3ik5XahaK-fv0EOFhPHpO1aQ7PGxbAMrGiSrK4j1EYA@mail.gmail.com>
Message-ID: <BLUPR03MB373D7ABAC272AD28D656A40F5990@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com> Sent: Thursday, July 16, 2015 2:56 PM
> To: Duan Fugang-B38611
> Cc: Kamal Mostafa; linux-kernel at vger.kernel.org; stable at vger.kernel.org;
> kernel-team at lists.ubuntu.com; daniel.lezcano at linaro.org; Damian Eppel;
> kyungmin.park at samsung.com; kgene at kernel.org; Thomas Gleixner; linux-arm-
> kernel at lists.infradead.org; m.szyprowski at samsung.com
> Subject: Re: [PATCH 3.19.y-ckt 173/251] clocksource: exynos_mct: Avoid
> blocking calls in the cpu hotplug notifier
> 
> 2015-07-16 15:37 GMT+09:00 Duan Andy <fugang.duan@freescale.com>:
> > From: Kamal Mostafa <kamal@canonical.com> Sent: Thursday, July 16,
> > 2015 9:08 AM
> >> To: linux-kernel at vger.kernel.org; stable at vger.kernel.org; kernel-
> >> team at lists.ubuntu.com
> >> Cc: Kamal Mostafa; daniel.lezcano at linaro.org;
> >> kyungmin.park at samsung.com; Damian Eppel; kgene at kernel.org; Thomas
> >> Gleixner; linux-arm- kernel at lists.infradead.org;
> >> m.szyprowski at samsung.com
> >> Subject: [PATCH 3.19.y-ckt 173/251] clocksource: exynos_mct: Avoid
> >> blocking calls in the cpu hotplug notifier
> >>
> >> 3.19.8-ckt4 -stable review patch.  If anyone has any objections,
> >> please let me know.
> >>
> >> ------------------
> >>
> >> From: Damian Eppel <d.eppel@samsung.com>
> >>
> >> commit 56a94f13919c0db5958611b388e1581b4852f3c9 upstream.
> >>
> >> Whilst testing cpu hotplug events on kernel configured with
> >> DEBUG_PREEMPT and DEBUG_ATOMIC_SLEEP we get following BUG message,
> >> caused by calling
> >> request_irq() and free_irq() in the context of hotplug notification
> >> (which is in this case atomic context).
> >>
> >> [   40.785859] CPU1: Software reset
> >> [   40.786660] BUG: sleeping function called from invalid context at
> >> mm/slub.c:1241
> >> [   40.786668] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name:
> >> swapper/1
> >> [   40.786678] Preemption disabled at:[<  (null)>]   (null)
> >> [   40.786681]
> >> [   40.786692] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0-rc4-
> >> 00024-g7dca860 #36
> >> [   40.786698] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> >> [   40.786728] [<c0014a00>] (unwind_backtrace) from [<c0011980>]
> >> (show_stack+0x10/0x14)
> >> [   40.786747] [<c0011980>] (show_stack) from [<c0449ba0>]
> >> (dump_stack+0x70/0xbc)
> >> [   40.786767] [<c0449ba0>] (dump_stack) from [<c00c6124>]
> >> (kmem_cache_alloc+0xd8/0x170)
> >> [   40.786785] [<c00c6124>] (kmem_cache_alloc) from [<c005d6f8>]
> >> (request_threaded_irq+0x64/0x128)
> >> [   40.786804] [<c005d6f8>] (request_threaded_irq) from [<c0350b8c>]
> >> (exynos4_local_timer_setup+0xc0/0x13c)
> >> [   40.786820] [<c0350b8c>] (exynos4_local_timer_setup) from
> [<c0350ca8>]
> >> (exynos4_mct_cpu_notify+0x30/0xa8)
> >> [   40.786838] [<c0350ca8>] (exynos4_mct_cpu_notify) from [<c003b330>]
> >> (notifier_call_chain+0x44/0x84)
> >> [   40.786857] [<c003b330>] (notifier_call_chain) from [<c0022fd4>]
> >> (__cpu_notify+0x28/0x44)
> >> [   40.786873] [<c0022fd4>] (__cpu_notify) from [<c0013714>]
> >> (secondary_start_kernel+0xec/0x150)
> >> [   40.786886] [<c0013714>] (secondary_start_kernel) from [<40008764>]
> >> (0x40008764)
> >>
> >> Interrupts cannot be requested/freed in the CPU_STARTING/CPU_DYING
> >> notifications which run on the hotplugged cpu with interrupts and
> >> preemption disabled.
> >>
> >> To avoid the issue, request the interrupts for all possible cpus in
> >> the boot code. The interrupts are marked NO_AUTOENABLE to avoid a
> >> racy
> >> request_irq/disable_irq() sequence. The flag prevents the
> >> request_irq() code from enabling the interrupt immediately.
> >>
> >> The interrupt is then enabled in the CPU_STARTING notifier of the
> >> hotplugged cpu and again disabled with disable_irq_nosync() in the
> >> CPU_DYING notifier.
> >>
> >> [ tglx: Massaged changelog to match the patch ]
> >>
> >> Fixes: 7114cd749a12 ("clocksource: exynos_mct: use (request/free)_irq
> >> calls for local timer registration")
> >> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Tested-by: Marcin Jabrzyk <m.jabrzyk@samsung.com>
> >> Signed-off-by: Damian Eppel <d.eppel@samsung.com>
> >> Cc: m.szyprowski at samsung.com
> >> Cc: kyungmin.park at samsung.com
> >> Cc: daniel.lezcano at linaro.org
> >> Cc: kgene at kernel.org
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Link: http://lkml.kernel.org/r/1435324984-7328-1-git-send-email-
> >> d.eppel at samsung.com
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> >> ---
> >>  drivers/clocksource/exynos_mct.c | 43
> >> ++++++++++++++++++++++++++++------
> >> ------
> >>  1 file changed, 30 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/clocksource/exynos_mct.c
> >> b/drivers/clocksource/exynos_mct.c
> >> index 83564c9..c844616 100644
> >> --- a/drivers/clocksource/exynos_mct.c
> >> +++ b/drivers/clocksource/exynos_mct.c
> >> @@ -466,15 +466,12 @@ static int exynos4_local_timer_setup(struct
> >> clock_event_device *evt)
> >>       exynos4_mct_write(TICK_BASE_CNT, mevt->base +
> >> MCT_L_TCNTB_OFFSET);
> >>
> >>       if (mct_int_type == MCT_INT_SPI) {
> >> -             evt->irq = mct_irqs[MCT_L0_IRQ + cpu];
> >> -             if (request_irq(evt->irq, exynos4_mct_tick_isr,
> >> -                             IRQF_TIMER | IRQF_NOBALANCING,
> >> -                             evt->name, mevt)) {
> >> -                     pr_err("exynos-mct: cannot register IRQ %d\n",
> >> -                             evt->irq);
> >> +
> >> +             if (evt->irq == -1)
> >>                       return -EIO;
> >> -             }
> >> -             irq_force_affinity(mct_irqs[MCT_L0_IRQ + cpu],
> >> cpumask_of(cpu));
> >> +
> >> +             irq_force_affinity(evt->irq, cpumask_of(cpu));
> >> +             enable_irq(evt->irq);
> >>       } else {
> >>               enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
> >
> > In here, why not use enable_percpu_irq(evt->irq) ?
> >
> >>       }
> >> @@ -487,10 +484,12 @@ static int exynos4_local_timer_setup(struct
> >> clock_event_device *evt)  static void exynos4_local_timer_stop(struct
> >> clock_event_device *evt)  {
> >>       evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
> >> -     if (mct_int_type == MCT_INT_SPI)
> >> -             free_irq(evt->irq, this_cpu_ptr(&percpu_mct_tick));
> >> -     else
> >> +     if (mct_int_type == MCT_INT_SPI) {
> >> +             if (evt->irq != -1)
> >> +                     disable_irq_nosync(evt->irq);
> >> +     } else {
> >>               disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
> >
> > In here, why not use disable_percpu_irq(evt->irq) ?
> 
> You know this is just a semi-automatic stable backport and this was
> already merged to mainline?
> 
> Best regards,
> Krzysztof

Yes, I know. Do you know the reason why not enable other cpus irq ?
I want to confirm whether it is right after below change ?
enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0); -> enable_percpu_irq(evt->irq, 0);
disable_percpu_irq(mct_irqs[MCT_L0_IRQ]) -> disable_percpu_irq(evt->irq)

Regards,
Andy
