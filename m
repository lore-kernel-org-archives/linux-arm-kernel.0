From: radoslaw.pietrzyk@gmail.com (=?UTF-8?Q?Rados=C5=82aw_Pietrzyk?=)
Date: Fri, 23 Feb 2018 10:05:35 +0100
Subject: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
In-Reply-To: <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
Message-ID: <CAFvLkMQzj51vgQrFvqDkTtGgT2mrXf4xekLewZ71owWai-_nMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think the HW is fairly simple and straightforward comparing to other
irq chips so it's rather a logic that concerned me the most i.e. why
gpio irqs were handled in a "simple" manner whereas the rest of
interrupts in "edge" manner. According to specification all interrupts
are edge driven and that's how are they treated in set_type callback.
First I thought that all can be handled as simple but then I realized
it makes more sense in handling all of them as edge as they should
according to specification. I will prepare a v3 series with more
detailed explanation in it.

2018-02-23 9:42 GMT+01:00 Thomas Gleixner <tglx@linutronix.de>:
> Radoslaw,
>
> On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:
>
>> - discards setting handle_simple_irq handler for hierarchy interrupts
>> - removes acking in chained irq handler as this is done by
>> irq_chip itself inside handle_edge_irq
>> - removes unneeded irq_domain_ops.xlate callback
>
> if that's all functionally correct, then this is a nice cleanup. Though
> from the above changelog its hard to tell because it merily tells WHAT the
> patch does, but not WHY. The WHY is the important information for a
> reviewer who is not familiar with the particular piece of code/hardware.
>
> Can you please amend the changelog with proper explanations why a
> particular piece of code is not needed or has to be changed to something
> else?
>
> Thanks,
>
>         tglx
