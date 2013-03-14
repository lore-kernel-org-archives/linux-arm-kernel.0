From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Mar 2013 15:59:11 +0900
Subject: [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support
In-Reply-To: <201303121231.29869.arnd@arndb.de>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045628.19701.58216.sendpatchset@w520>
 <201303121231.29869.arnd@arndb.de>
Message-ID: <CANqRtoSok=0CuLyMGD8-SoKezX54WfacnNnx8FhxCJzs_ggcXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for your feedback, please see below for my reply.

On Tue, Mar 12, 2013 at 9:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add IRQC interrupt controller support to r8a73a4 by
>> hooking up two IRQC instances to handle 58 external
>> IRQ signals. There IRQC controllers are tied to SPIs
>> of the GIC. On r8a73a4 exact IRQ pin routing is handled
>> by the PFC which is excluded from this patch.
>>
>> Both platform devices and DT devices are added in this
>> patch. The platform device versions are used to provide
>> a static interrupt map configuration for board code
>> written in C.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> What is the status of the IRQC DT support? I remember that I wasn't
> happy with a prior version, but I did not follow up on some of the
> questions that came up, sorry about that.

Uhm, perhaps I misunderstand, but I wonder if you refer to INTC instead of IRQC?

This particular driver is for the IRQC hardware block. It is not
compatible with INTC. A while ago I posted an incremental DT support
patch for IRQC -  "[PATCH] irqchip: irqc: Add DT support", please see
https://lkml.org/lkml/2013/3/6/50

> Did the patches end up getting merged anyway, or should we resume the
> discussion about those patches? I understand that lack of INTC bindings
> would make new SoC support particularly hard, and I don't want to
> be responsible for holding you up here.

Thanks. I don't think the INTC patches went anywhere.

To zoom out a bit let me list different interrupt controllers:

A) INTC (drivers/sh/intc) [no DT yet]
B) GIC (drivers/irqchip/irq-gic.c) [DT]
C) INTC External IRQ Pin (drivers/irqchip/irq-renesas-intc-irqpin.c) [DT]
D) IRQC (drivers/irqchip/irq-renesas-irqc.c) [DT]

Simple use cases are:
- Legacy SH SoCs or ARM SoCs with Cortex-A8 or older make use of A).
- More recent ARM SoCs with Cortex-A9 or newer use B) and C) or B) and D).

On top of this we now and then have GPIO controllers that have
built-in interrupt controllers.

Hope this helps,

/ magnus
