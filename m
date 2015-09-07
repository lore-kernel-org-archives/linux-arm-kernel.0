From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 7 Sep 2015 15:24:01 +0200 (CEST)
Subject: [RFC PATCH v1 2/4] irqchip: GICv3: set non-percpu irqs status
 with _IRQ_MOVE_PCNTXT
In-Reply-To: <55ED83D2.90809@arm.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
 <1441513421-8092-3-git-send-email-yangyingliang@huawei.com>
 <55EBD59B.4030405@linux.intel.com> <55ED83D2.90809@arm.com>
Message-ID: <alpine.DEB.2.11.1509071502080.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Sep 2015, Marc Zyngier wrote:
> On 06/09/15 06:56, Jiang Liu wrote:
> > On 2015/9/6 12:23, Yang Yingliang wrote:
> >> Use irq_settings_set_move_pcntxt() helper irqs status with
> >> _IRQ_MOVE_PCNTXT. So that it can do set affinity when calling
> >> irq_set_affinity_locked().
> > Hi Yingliang,
> > 	We could only set _IRQ_MOVE_PCNTCT flag to enable migrating
> > IRQ in process context if your hardware platform supports atomically
> > change IRQ configuration. Not sure whether that's true for GICv3.
> > If GICv3 doesn't support atomically change irq configuration, this
> > change may cause trouble.
> 
> I think it boils down to what exactly "process context" means here. If
> this means "we do not need to mask the interrupt" while moving it, then
> it should be fine (the GIC architecture guarantees that a pending
> interrupt will be migrated).
> 
> Is there any other requirement for this flag?

The history of this flag is as follows:

On x86 interrupts can only be safely migrated while the interrupt is
handled. With the introduction of IRQ remapping this requirement
changed. Remapped interrupts can be migrated in any context.

If you look at irq_set_affinity_locked()

   if (irq_can_move_pcntxt(data) {
      irq_do_set_affinity(data,...)
        chip->irq_set_affinity(data,...);
   } else {
      irqd_set_move_pending(data);
   }

So if IRQ_MOVE_PCNTXT is not set, we handle the migration of the
interrupt from next the interrupt. If it's set set_affinity() is
called right away.

All architectures which do not select GENERIC_PENDING_IRQ are using
the direct method.

Thanks,

	tglx
