From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 24 Feb 2014 14:07:46 +0800
Subject: [patch 09/26] arm: mmp: Remove pointless fiddling with irq
 internals
In-Reply-To: <20140223231755.GA27579@pengutronix.de>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.214342433@linutronix.de>
 <20140223231755.GA27579@pengutronix.de>
Message-ID: <CADApbeiyGoSAF9n5-+Ys1H4VDgN+d727E6ARWFGj4EixqeP79w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 7:17 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hi Thomas,
>
> On Sun, Feb 23, 2014 at 09:40:13PM -0000, Thomas Gleixner wrote:
>> The pm-mmp2 and pm-pxa910 power management related irq_set_wake
>> callbacks fiddle pointlessly with the irq actions for no reason except
>> for lack of understanding how the wakeup mechanism works.
>>
>> On supsend the core disables all interrupts lazily, i.e. it does not
>> mask them at the irq controller level. So any interrupt which is
>> firing during supsend will mark the corresponding interrupt line as
> s/supsend/suspend/ twice
>> pending. Just before the core powers down it checks whether there are
>> interrupts pending from interrupt lines which are marked as wakeup
>> sources and if so it aborts the resume and resends the interrupts.
> It's the suspend that is aborted, not the resume.
>
> Other than that your change looks fine.
>
For pxa910 and MMP2, wake up source only wake up the AP subsystem.
The AP subsystem includes the APMU(AP Power Mangament Unit) and cores.
Now the core is still powered down. APMU will check the interrupt
lines, and find
that there are interrupt pending, it will power on the cores.
So if the irq is disabled, even wake up source can wake up AP subsystem, but the
core is still powered down. It will not be powered up by APMU.


> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
