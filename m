From: youlin.pei@mediatek.com (Youlin Pei)
Date: Tue, 15 Nov 2016 10:49:39 +0800
Subject: [PATCH v2 2/3] irqchip: mtk-cirq: Add mediatek mtk-cirq implement
In-Reply-To: <1f8f7b9f-7788-18c4-19c5-3c9a7623c188@arm.com>
References: <1478001122-8664-1-git-send-email-youlin.pei@mediatek.com>
 <1478001122-8664-3-git-send-email-youlin.pei@mediatek.com>
 <86twbrj586.fsf@arm.com> <1478234577.7975.29.camel@mtksdaap41>
 <867f8ilwcl.fsf@arm.com> <1478573833.32099.11.camel@mtksdaap41>
 <1f8f7b9f-7788-18c4-19c5-3c9a7623c188@arm.com>
Message-ID: <1479178179.10566.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-11-10 at 18:24 +0000, Marc Zyngier wrote:
> On 08/11/16 02:57, Youlin Pei wrote:
> > On Fri, 2016-11-04 at 22:21 +0000, Marc Zyngier wrote:
> >> On Fri, Nov 04 2016 at 04:42:57 AM, Youlin Pei <youlin.pei@mediatek.com> wrote:
> >>> On Tue, 2016-11-01 at 20:49 +0000, Marc Zyngier wrote:
> >>>> On Tue, Nov 01 2016 at 11:52:01 AM, Youlin Pei <youlin.pei@mediatek.com> wrote:
> >>>>> In Mediatek SOCs, the CIRQ is a low power interrupt controller
> >>>>> designed to works outside MCUSYS which comprises with Cortex-Ax
> >>>>> cores,CCI and GIC.
> >>>>>
> >>>>> The CIRQ controller is integrated in between MCUSYS( include
> >>>>> Cortex-Ax, CCI and GIC ) and interrupt sources as the second
> >>>>> level interrupt controller. The external interrupts which outside
> >>>>> MCUSYS will feed through CIRQ then bypass to GIC. CIRQ can monitors
> >>>>> all edge trigger interupts. When an edge interrupt is triggered,
> >>>>> CIRQ can record the status and generate a pulse signal to GIC when
> >>>>> flush command executed.
> >>>>>
> >>>>> When system enters sleep mode, MCUSYS will be turned off to improve
> >>>>> power consumption, also GIC is power down. The edge trigger interrupts
> >>>>> will be lost in this scenario without CIRQ.
> >>>>>
> >>>>> This commit provides the CIRQ irqchip implement.
> >>>>>
> >>>>> Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>
> >>>>> ---
> >>>>>  drivers/irqchip/Makefile       |    2 +-
> >>>>>  drivers/irqchip/irq-mtk-cirq.c |  262 ++++++++++++++++++++++++++++++++++++++++
> >>>>>  2 files changed, 263 insertions(+), 1 deletion(-)
> >>>>>  create mode 100644 drivers/irqchip/irq-mtk-cirq.c
> >>>>>
> >>>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >>>>> index e4dbfc8..8f33580 100644
> >>>>> --- a/drivers/irqchip/Makefile
> >>>>> +++ b/drivers/irqchip/Makefile
> >>>>> @@ -60,7 +60,7 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
> >>>>>  obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
> >>>>>  obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
> >>>>>  obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
> >>>>> -obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
> >>>>> +obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
> >>>>>  obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
> >>>>>  obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
> >>>>>  obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
> >>>>> diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
> >>>>> new file mode 100644
> >>>>> index 0000000..fc43ef3
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/irqchip/irq-mtk-cirq.c
> >>>>> @@ -0,0 +1,262 @@
> >>>>> +/*
> >>>>> + * Copyright (c) 2016 MediaTek Inc.
> >>>>> + * Author: Youlin.Pei <youlin.pei@mediatek.com>
> >>>>> + *
> >>>>> + * This program is free software; you can redistribute it and/or modify
> >>>>> + * it under the terms of the GNU General Public License version 2 as
> >>>>> + * published by the Free Software Foundation.
> >>>>> + *
> >>>>> + * This program is distributed in the hope that it will be useful,
> >>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>>> + * GNU General Public License for more details.
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/irq.h>
> >>>>> +#include <linux/irqchip.h>
> >>>>> +#include <linux/irqdomain.h>
> >>>>> +#include <linux/of.h>
> >>>>> +#include <linux/of_irq.h>
> >>>>> +#include <linux/of_address.h>
> >>>>> +#include <linux/io.h>
> >>>>> +#include <linux/slab.h>
> >>>>> +#include <linux/syscore_ops.h>
> >>>>> +
> >>>>> +#define CIRQ_ACK	0x40
> >>>>> +#define CIRQ_MASK_SET	0xc0
> >>>>> +#define CIRQ_MASK_CLR	0x100
> >>>>> +#define CIRQ_SENS_SET	0x180
> >>>>> +#define CIRQ_SENS_CLR	0x1c0
> >>>>> +#define CIRQ_POL_SET	0x240
> >>>>> +#define CIRQ_POL_CLR	0x280
> >>>>> +#define CIRQ_CONTROL	0x300
> >>>>> +
> >>>>> +#define CIRQ_EN	0x1
> >>>>> +#define CIRQ_EDGE	0x2
> >>>>> +#define CIRQ_FLUSH	0x4
> >>>>> +
> >>>>> +#define CIRQ_IRQ_NUM    0x200
> >>>>> +
> >>>>> +struct mtk_cirq_chip_data {
> >>>>> +	void __iomem *base;
> >>>>> +	unsigned int ext_irq_start;
> >>>>> +};
> >>>>> +
> >>>>> +static struct mtk_cirq_chip_data *cirq_data;
> >>>>
> >>>> Are you guaranteed that you'll only ever have a single CIRQ in any
> >>>> system?
> >>>
> >>> In Mediatek's SOC, only hace a single CIRQ.
> >>>
> >>>>
> >>>>> +
> >>>>> +static void mtk_cirq_write_mask(struct irq_data *data, unsigned int offset)
> >>>>> +{
> >>>>> +	struct mtk_cirq_chip_data *chip_data = data->chip_data;
> >>>>> +	unsigned int cirq_num = data->hwirq;
> >>>>> +	u32 mask = 1 << (cirq_num % 32);
> >>>>> +
> >>>>> +	writel(mask, chip_data->base + offset + (cirq_num / 32) * 4);
> >>>>
> >>>> Why can't you use the relaxed accessors?
> >>>
> >>> It seems that i use wrong function, i will change the writel to
> >>> writel_relaxed in next ve
> >>>
> >>>>
> >>>>> +}
> >>>>> +
> >>>>> +static void mtk_cirq_mask(struct irq_data *data)
> >>>>> +{
> >>>>> +	mtk_cirq_write_mask(data, CIRQ_MASK_SET);
> >>>>> +	irq_chip_mask_parent(data);
> >>>>> +}
> >>>>> +
> >>>>> +static void mtk_cirq_unmask(struct irq_data *data)
> >>>>> +{
> >>>>> +	mtk_cirq_write_mask(data, CIRQ_MASK_CLR);
> >>>>> +	irq_chip_unmask_parent(data);
> >>>>> +}
> >>>>> +
> >>>>> +static void mtk_cirq_eoi(struct irq_data *data)
> >>>>> +{
> >>>>> +	mtk_cirq_write_mask(data, CIRQ_ACK);
> >>>>
> >>>> EOI and ACK have very different semantics. What is this write actually
> >>>> doing? Also, you're now doing an additional MMIO write on each interrupt
> >>>> EOI, doubling its cost. Do you really need to do actually signal the HW
> >>>> that we've EOIed an interrupt? I would have hoped that you'd be able to
> >>>> put it in "bypass" mode as long as you're not suspending...
> >>>>
> >>>
> >>> When external interrupt happened, CIRQ status register record the status
> >>> even CIRQ is not enabled. when execute the flush command, CIRQ will
> >>> resend the signals according to the status. So if don't clear the
> >>> status, CIRQ will resend the wrong signals. the ACK write operation will
> >>> clear the status.
> >>
> >> But at this time, we haven't suspended yet, and there is nothing to
> >> replay. Also, you only enable the edge capture when suspending. So what
> >> are you ACKing here? Can't you simply clear everything right when
> >> suspending and not do it at all on the fast path?
> > 
> > I had planned to ACK the status in cirq suspend callback, but
> > encountered a problem.
> > following is a piece of code from
> > http://lxr.free-electrons.com/source/kernel/power/suspend.c#L361
> > 
> > arch_suspend_disable_irqs(); ---step1
> > BUG_ON(!irqs_disabled());
> > 
> > error = syscore_suspend();
> >            |
> >            ---cirq suspend(); ---step2
> > 
> > if ack the status in cirq suspend, the interrupts will be lost which
> > happened during step1 to step2.
> > 
> > So would you mind give me some suggestions about this?
> > Thanks a lot!
> 
> Right. So maybe there is a way:
> - On suspend you can iterate over all the cirq interrupts that have been
> recorded
> - For each of those, you inspect if it is pending at the GIC level
> (using the irq_get_irqchip_state helper)
> - if not pending, you Ack it, because it cannot be delivered anymore
> - If it is pending, then you know it happened between step 1 and step 2.
> - You then have the choice of either going into suspend and waking up
> immediately, or failing the suspend.
> 
> Thoughts?

Will use this solution in next version.
Thanks a lot!

> 
> 	M.
