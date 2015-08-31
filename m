From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Aug 2015 13:20:31 +0100
Subject: [PATCH] arm64: fix a migrating irq bug when hotplug cpu
In-Reply-To: <55E3020C.8020303@linaro.org>
References: <55E1AD09.7020701@huawei.com> <55E1CBE9.6080705@linux.intel.com>
 <66e158e6da958d355d54543ef69e5e94@www.loen.fr>
 <55E3020C.8020303@linaro.org>
Message-ID: <20150831132031.2a017df1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 30 Aug 2015 21:15:56 +0800
Hanjun Guo <hanjun.guo@linaro.org> wrote:

> On 08/30/2015 02:12 AM, Marc Zyngier wrote:
> > On 2015-08-29 16:12, Jiang Liu wrote:
> >> On 2015/8/29 21:00, Yang Yingliang wrote:
> >>> From: Yang Yingliang <yangyingliang@huawei.com>
> >>>
> >>> When cpu is disabled, all irqs will be migratged to another cpu.
> >>> In some cases, a new affinity is different, it needed to be coppied
> >>> to irq's affinity. But if the type of irq is LPI, it's affinity will
> >>> not be coppied because of irq_set_affinity's return value.
> >>> So copy the affinity, when the return value is IRQ_SET_MASK_OK_DONE.
> >> Hi Yingliang,
> >>     If irq_set_affinity callback returns IRQ_SET_MASK_OK_DONE,
> >> it means that irq_set_affinity has copied the new CPU mask to irq
> >> affinity mask. It would be better to change irq_set_affinity for LPI
> >> to follow this rule.
> >
> > The main issue here seems to be that we do not call irq_set_affinity, but
> > that we directly call into the top-level irqchip method, which relies on
> > the core code to do the copy (see irq_do_set_affinity). Too bad.
> >
> > It feels like the arm/arm64 code would probably be better consolidated into
> > kernel/irq/migration.c, which already deals with some of this for x86
> > and ia64. It would save us the duplication and will make sure we don't
> > miss things next time we add a new return code, as irq_do_set_affinity
> > would handle this properly.
> >
> > Thoughts?
> 
> I agree. In arch/arm64/kernel/irq.c the irq migrate code is the same
> as ARM32, and it's duplicate. But this is a bugfix, can we fix it in
> a simple way, and refactor the code later?

I'm not buying this.

I really can't see how adding more duplication can be beneficial. It is
not so much that there is duplication between arm and arm64 that
bothers me (as if that was the only thing...). The real issue is that
there is duplication between the arch code and the core code.

Migrating interrupts is a core code matter, and that's were it should
be handled IMHO. Plus, we're in the merge window, and there is plenty
of time to get this fixed the proper way.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
