From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 18 Sep 2015 00:04:06 +0200 (CEST)
Subject: [RFC PATCH v4 2/4] genirq: add move_irqs() for cpu hotplug
In-Reply-To: <55FAEDF6.6060000@arm.com>
References: <1442467166-1460-1-git-send-email-yangyingliang@huawei.com>
 <1442467166-1460-3-git-send-email-yangyingliang@huawei.com>
 <55FAEDF6.6060000@arm.com>
Message-ID: <alpine.DEB.2.11.1509172355260.3951@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2015, Marc Zyngier wrote:
> On 17/09/15 06:19, Yang Yingliang wrote:
> > Add move_irqs() into kernel/irq/migration.c.
> > So we can use it to migrate interrupts, when
> > cpu is offline.
> > 
> > Cc: Jiang Liu <jiang.liu@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  include/linux/irq.h    |  4 +++
> >  kernel/irq/migration.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> > 
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index 6f8b340..64e3a02 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -446,6 +446,10 @@ static inline void irq_move_irq(struct irq_data *data) { }
> >  static inline void irq_move_masked_irq(struct irq_data *data) { }
> >  #endif
> >  
> > +#if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_IRQ_MIGRATION) && defined(CONFIG_HOTPLUG_CPU)
> > +void move_irqs(void);
> > +#endif
> > +
> 
> I don't think having this prototype guarded by this #if is very useful.
> You can probably leave it standalone.

Yes, there is no point if the function name is unique. Though
move_irqs() is rather undescriptive. irq_break_affinities() might
describe it quite well, but feel free to come up with soemthing better.

Thanks,

	tglx
