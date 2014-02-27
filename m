From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 27 Feb 2014 09:37:03 +0800
Subject: [patch 09/26] arm: mmp: Remove pointless fiddling with irq
 internals
In-Reply-To: <alpine.DEB.2.02.1402241227400.21251@ionos.tec.linutronix.de>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.214342433@linutronix.de>
 <20140223231755.GA27579@pengutronix.de>
 <CADApbeiyGoSAF9n5-+Ys1H4VDgN+d727E6ARWFGj4EixqeP79w@mail.gmail.com>
 <CAN1soZy_TfzNigfn4y6kF2qe4K+AQsagd-1KWYrz1VEavMO4bA@mail.gmail.com>
 <alpine.DEB.2.02.1402241227400.21251@ionos.tec.linutronix.de>
Message-ID: <CADApbeiJ2ESEuBxGNXLe+sbKEox02Vr0hhO-rW7dosc_4A+TEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 7:31 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 24 Feb 2014, Haojian Zhuang wrote:
>
>> On Mon, Feb 24, 2014 at 2:07 PM, Chao Xie <xiechao.mail@gmail.com> wrote:
>> > On Mon, Feb 24, 2014 at 7:17 AM, Uwe Kleine-K?nig
>> > <u.kleine-koenig@pengutronix.de> wrote:
>> >> Hi Thomas,
>> >>
>> >> On Sun, Feb 23, 2014 at 09:40:13PM -0000, Thomas Gleixner wrote:
>> >>> The pm-mmp2 and pm-pxa910 power management related irq_set_wake
>> >>> callbacks fiddle pointlessly with the irq actions for no reason except
>> >>> for lack of understanding how the wakeup mechanism works.
>> >>>
>> >>> On supsend the core disables all interrupts lazily, i.e. it does not
>> >>> mask them at the irq controller level. So any interrupt which is
>> >>> firing during supsend will mark the corresponding interrupt line as
>> >> s/supsend/suspend/ twice
>> >>> pending. Just before the core powers down it checks whether there are
>> >>> interrupts pending from interrupt lines which are marked as wakeup
>> >>> sources and if so it aborts the resume and resends the interrupts.
>> >> It's the suspend that is aborted, not the resume.
>> >>
>> >> Other than that your change looks fine.
>> >>
>> > For pxa910 and MMP2, wake up source only wake up the AP subsystem.
>> > The AP subsystem includes the APMU(AP Power Mangament Unit) and cores.
>> > Now the core is still powered down. APMU will check the interrupt
>> > lines, and find
>> > that there are interrupt pending, it will power on the cores.
>> > So if the irq is disabled, even wake up source can wake up AP subsystem, but the
>> > core is still powered down. It will not be powered up by APMU.
>> >
>>
>> Yes, suspend/resume can't work if the above code is removed.
>>
>> Interrupt source (logic AND with interrupt mask register) is connected
>> to MPMU as
>> wakeup source. If the interrupt is disabled, there's no wakeup source event.
>>
>> And APMU is waken up by MPMU.
>>
>> So please don't remove the above code. We must keep these interrupt lines active
>> to wake up the whole system.
>
> They are kept active at the interrupt controller level. You just
> refuse to understand how the internals of the interrupt subsystem
> work.
>
If no irq_disable callback is hooked, when do irq_disable, it will not
actually disable
the interrupt, it will depend on next time when the irq happens, the
handler will first mask
the interrupt as this interrupt never happens.
So after system suspended, the interrupt happens, but the device
driver will not recieve this interrupt
because it is masked.
It results in that the device driver miss a important interrupt which
related to something need to be
handled. If user application for example android has power managment
daemon. It will find that nothing
to handle, it will make the system enter suspend again.

> And even if you would need this flag, then fiddling with the irq desc
> internals is a big NONO. There is a proper way to hand that in.
>

So can you suggest the proper way to handle it? Thanks.

> Thanks,
>
>         tglx
>
