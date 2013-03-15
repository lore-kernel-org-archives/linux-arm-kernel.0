From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 15 Mar 2013 14:32:39 +0900
Subject: [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support
In-Reply-To: <201303141343.04328.arnd@arndb.de>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <201303121231.29869.arnd@arndb.de>
 <CANqRtoSok=0CuLyMGD8-SoKezX54WfacnNnx8FhxCJzs_ggcXg@mail.gmail.com>
 <201303141343.04328.arnd@arndb.de>
Message-ID: <CANqRtoTQhbk0sjZfvCY3qR2-x5p1gvZ0F+o3ZkAddufddYUk+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 10:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 14 March 2013, Magnus Damm wrote:
>> Hi Arnd,
>>
>> Thanks for your feedback, please see below for my reply.
>>
>> On Tue, Mar 12, 2013 at 9:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 12 March 2013, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> Add IRQC interrupt controller support to r8a73a4 by
>> >> hooking up two IRQC instances to handle 58 external
>> >> IRQ signals. There IRQC controllers are tied to SPIs
>> >> of the GIC. On r8a73a4 exact IRQ pin routing is handled
>> >> by the PFC which is excluded from this patch.
>> >>
>> >> Both platform devices and DT devices are added in this
>> >> patch. The platform device versions are used to provide
>> >> a static interrupt map configuration for board code
>> >> written in C.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >
>> > What is the status of the IRQC DT support? I remember that I wasn't
>> > happy with a prior version, but I did not follow up on some of the
>> > questions that came up, sorry about that.
>>
>> Uhm, perhaps I misunderstand, but I wonder if you refer to INTC instead of IRQC?
>
> Yes, you are right.

I don't blame you for the misunderstanding - as you see there are a
couple of interrupt controllers just from Renesas SoC division, and
you probably get to see similar situations with every SoC vendor.
Quite a few different interrupt controllers to keep track of! =)

>> This particular driver is for the IRQC hardware block. It is not
>> compatible with INTC. A while ago I posted an incremental DT support
>> patch for IRQC -  "[PATCH] irqchip: irqc: Add DT support", please see
>> https://lkml.org/lkml/2013/3/6/50
>
> Ok, I had missed that, but the driver certainly looks good to me.

Thanks.

>> > Did the patches end up getting merged anyway, or should we resume the
>> > discussion about those patches? I understand that lack of INTC bindings
>> > would make new SoC support particularly hard, and I don't want to
>> > be responsible for holding you up here.
>>
>> Thanks. I don't think the INTC patches went anywhere.
>>
>> To zoom out a bit let me list different interrupt controllers:
>>
>> A) INTC (drivers/sh/intc) [no DT yet]
>> B) GIC (drivers/irqchip/irq-gic.c) [DT]
>> C) INTC External IRQ Pin (drivers/irqchip/irq-renesas-intc-irqpin.c) [DT]
>> D) IRQC (drivers/irqchip/irq-renesas-irqc.c) [DT]
>>
>> Simple use cases are:
>> - Legacy SH SoCs or ARM SoCs with Cortex-A8 or older make use of A).
>> - More recent ARM SoCs with Cortex-A9 or newer use B) and C) or B) and D).
>
> Ok. And I guess the EMMA EV2 uses only GIC but not IRQC or INTC, right?

Yes, correct. GIC and per-GPIO interrupts provided by gpio-em.c.

>> On top of this we now and then have GPIO controllers that have
>> built-in interrupt controllers.
>
> Yes, obviously.

What may not be so obvious is the GPIO interface provided by the PFC
code that is now located in drivers/pinctrl/sh-pfc/. There used to be
a function-only GPIOs in the PFC code but we're now moving over to
PINCTRL thanks to great effort by Laurent. So besides the old
function-only GPIOs provided by PFC there are also regular GPIOs
exported by the PFC code. Those regular GPIOs exported by the PFC do
not have any built-in interrupt controller - instead the external IRQs
handled by C) and D) above are used.

Other GPIO blocks like gpio-em.c and gpio-rcar.c have built-in
interrupt controllers and can do per-GPIO interrupts.

> Coming back to INTC, are you planning to use the same binding for A and C?

I was not planning on that, no. To be honest, at this point I am not
sure which way forward is best for A).

> Which of them the binding you posted earlier for?

Regarding A), I wrote some local DT prototype patches for INTC a year
or two ago, showing how things could be done and how we can start
using DT. Then I handed the job over to other people. However, from
there my advice of incremental development was ignored and instead
more complete bindings were developed directly without much review. So
I wouldn't say that I posted the bindings myself. Right now I'm very
hands-off in that area.

As for C), those DT bindings were done by me. They are however not
compatible with A). The hardware is different. C) is basically a
special case subset of A).

> When I looked at the existing code, I had the impression that doing a
> binding for just the SH-Mobile SoCs that have an ARM core in them
> (including those that also have an SH core) would be much easier than
> doing a binding that also covers the older SH SoCs, since those are
> much less uniform.

I agree that in some cases it may make sense to split the SH bits from
ARM, but I wonder how much we would win for the INTC.

Right now I'm considering converting r8a7740 to use B) and C) (if
possible), and if so then the only ARM SoC using A) for main interrupt
controller left is sh7372.

For sh7372 we could simply try to use C) for board-level interrupts
(and board level DT) but keep the SoC portion in C with A) until the
SoC is being phased out. Or we could have a simple compatible
"renesas,intc-sh7372" with tables in C using irq domain to support DT,
but that would be exactly as my first incremental development task
that wasn't followed...

What would you do?

Thanks for your help,

/ magnus
