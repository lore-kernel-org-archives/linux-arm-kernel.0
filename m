From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Dec 2012 15:24:50 +0000
Subject: [PATCH v4 07/13] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <20121203143443.GH20074@mudshark.cambridge.arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154504.3061.23122.stgit@chazy-air>
 <20121203132337.GC20074@mudshark.cambridge.arm.com>
 <50BCB2F7.7010303@arm.com>
 <20121203143443.GH20074@mudshark.cambridge.arm.com>
Message-ID: <50BCC442.3050500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/12 14:34, Will Deacon wrote:
> On Mon, Dec 03, 2012 at 02:11:03PM +0000, Marc Zyngier wrote:
>> On 03/12/12 13:23, Will Deacon wrote:
>>>>
>>>> +#define VGIC_HCR_EN            (1 << 0)
>>>> +#define VGIC_HCR_UIE           (1 << 1)
>>>> +
>>>> +#define VGIC_LR_VIRTUALID      (0x3ff << 0)
>>>> +#define VGIC_LR_PHYSID_CPUID   (7 << 10)
>>>> +#define VGIC_LR_STATE          (3 << 28)
>>>> +#define VGIC_LR_PENDING_BIT    (1 << 28)
>>>> +#define VGIC_LR_ACTIVE_BIT     (1 << 29)
>>>> +#define VGIC_LR_EOI            (1 << 19)
>>>> +
>>>> +#define VGIC_MISR_EOI          (1 << 0)
>>>> +#define VGIC_MISR_U            (1 << 1)
>>>> +
>>>> +#define LR_EMPTY       0xff
>>>> +
>>>
>>> Could stick these in asm/hardware/gic.h. I know they're not used by the gic
>>> driver, but they're the same piece of architecture so it's probably worth
>>> keeping in one place.
>>
>> This is on my list of things to do once the GIC code is shared between
>> arm and arm64. Could do it earlier if that makes more sense.
> 
> Might as well as I found some others in a later patch too.
> 
>>>>  static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
>>>>  {
>>>> -       return 0;
>>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>>> +       unsigned long *pending, *enabled, *pend;
>>>> +       int vcpu_id;
>>>> +
>>>> +       vcpu_id = vcpu->vcpu_id;
>>>> +       pend = vcpu->arch.vgic_cpu.pending;
>>>> +
>>>> +       pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
>>>> +       enabled = vgic_bitmap_get_cpu_map(&dist->irq_enabled, vcpu_id);
>>>> +       bitmap_and(pend, pending, enabled, 32);
>>>
>>> pend and pending! vcpu_pending and dist_pending?
>>
>> A lot of that code has already been reworked. See:
>> https://lists.cs.columbia.edu/pipermail/kvmarm/2012-November/004138.html
> 
> Argh, too much code! Ok, as long as it's being looked at.
> 
>>>> +
>>>> +       pending = vgic_bitmap_get_shared_map(&dist->irq_state);
>>>> +       enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
>>>> +       bitmap_and(pend + 1, pending, enabled, VGIC_NR_SHARED_IRQS);
>>>> +       bitmap_and(pend + 1, pend + 1,
>>>> +                  vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
>>>> +                  VGIC_NR_SHARED_IRQS);
>>>> +
>>>> +       return (find_first_bit(pend, VGIC_NR_IRQS) < VGIC_NR_IRQS);
>>>>  }
>>>>
>>>>  /*
>>>> @@ -613,6 +631,212 @@ static void vgic_update_state(struct kvm *kvm)
>>>>         }
>>>>  }
>>>>
>>>> +#define LR_PHYSID(lr)          (((lr) & VGIC_LR_PHYSID_CPUID) >> 10)
>>>
>>> Is VGIC_LR_PHYSID_CPUID wide enough for this? The CPUID is only 3 bits, but
>>> the interrupt ID could be larger. Or do you not supported hardware interrupt
>>> forwarding? (in which case, LR_PHYSID is a misleading name).
>>
>> Hardware interrupt forwarding is not supported. PHYSID is the name of
>> the actual field in the spec, hence the name of the macro. LR_CPUID?
> 
> Sure.
> 
>>>> +               kvm_debug("LR%d piggyback for IRQ%d %x\n", lr, irq, vgic_cpu->vgic_lr[lr]);
>>>> +               BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
>>>> +               vgic_cpu->vgic_lr[lr] |= VGIC_LR_PENDING_BIT;
>>>> +               if (is_level)
>>>> +                       vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
>>>> +               return true;
>>>> +       }
>>>> +
>>>> +       /* Try to use another LR for this interrupt */
>>>> +       lr = find_first_bit((unsigned long *)vgic_cpu->vgic_elrsr,
>>>> +                              vgic_cpu->nr_lr);
>>>> +       if (lr >= vgic_cpu->nr_lr)
>>>> +               return false;
>>>> +
>>>> +       kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
>>>> +       vgic_cpu->vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
>>>> +       if (is_level)
>>>> +               vgic_cpu->vgic_lr[lr] |= VGIC_LR_EOI;
>>>> +
>>>> +       vgic_cpu->vgic_irq_lr_map[irq] = lr;
>>>> +       clear_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
>>>> +       set_bit(lr, vgic_cpu->lr_used);
>>>> +
>>>> +       return true;
>>>> +}
>>>
>>> I can't help but feel that this could be made cleaner by moving the
>>> level-specific EOI handling out into a separate function.
>>
>> Do you mean having two functions, one for edge and the other for level?
>> Seems overkill to me. I could move the "if (is_level) ..." to a common
>> spot though.
> 
> Indeed, you could just have something like vgic_eoi_irq and call that
> in one place, letting that function do the level check.
> 
>>>> +
>>>> +/*
>>>> + * Fill the list registers with pending interrupts before running the
>>>> + * guest.
>>>> + */
>>>> +static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>>> +       unsigned long *pending;
>>>> +       int i, c, vcpu_id;
>>>> +       int overflow = 0;
>>>> +
>>>> +       vcpu_id = vcpu->vcpu_id;
>>>> +
>>>> +       /*
>>>> +        * We may not have any pending interrupt, or the interrupts
>>>> +        * may have been serviced from another vcpu. In all cases,
>>>> +        * move along.
>>>> +        */
>>>> +       if (!kvm_vgic_vcpu_pending_irq(vcpu)) {
>>>> +               pr_debug("CPU%d has no pending interrupt\n", vcpu_id);
>>>> +               goto epilog;
>>>> +       }
>>>> +
>>>> +       /* SGIs */
>>>> +       pending = vgic_bitmap_get_cpu_map(&dist->irq_state, vcpu_id);
>>>> +       for_each_set_bit(i, vgic_cpu->pending, 16) {
>>>> +               unsigned long sources;
>>>> +
>>>> +               sources = dist->irq_sgi_sources[vcpu_id][i];
>>>> +               for_each_set_bit(c, &sources, 8) {
>>>> +                       if (!vgic_queue_irq(vcpu, c, i)) {
>>>> +                               overflow = 1;
>>>> +                               continue;
>>>> +                       }
>>>
>>> If there are multiple sources, why do you need to queue the interrupt
>>> multiple times? I would have thought it could be collapsed into one.
>>
>> Because SGIs from different sources *are* different interrupts. In an
>> n-CPU system (with n > 2), you could have some message passing system
>> based on interrupts, and you'd need to know which CPU is pinging you.
> 
> Ok, fair point.
> 
>>>> +
>>>> +                       clear_bit(c, &sources);
>>>> +               }
>>>> +
>>>> +               if (!sources)
>>>> +                       clear_bit(i, pending);
>>>
>>> What does this signify and how does it happen? An SGI without a source
>>> sounds pretty weird...
>>
>> See the clear_bit() just above. Once all the sources for this SGI are
>> cleared, we can make the interrupt not pending anymore.
> 
> Yup, missed that.
> 
>>>> +/*
>>>> + * Sync back the VGIC state after a guest run. We do not really touch
>>>> + * the distributor here (the irq_pending_on_cpu bit is safe to set),
>>>> + * so there is no need for taking its lock.
>>>> + */
>>>> +static void __kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>>> +       struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>>>> +       int lr, pending;
>>>> +
>>>> +       /* Clear mappings for empty LRs */
>>>> +       for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr,
>>>> +                        vgic_cpu->nr_lr) {
>>>> +               int irq;
>>>> +
>>>> +               if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
>>>> +                       continue;
>>>> +
>>>> +               irq = vgic_cpu->vgic_lr[lr] & VGIC_LR_VIRTUALID;
>>>> +
>>>> +               BUG_ON(irq >= VGIC_NR_IRQS);
>>>> +               vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
>>>> +       }
>>>> +
>>>> +       /* Check if we still have something up our sleeve... */
>>>> +       pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_elrsr,
>>>> +                                     vgic_cpu->nr_lr);
>>>
>>> Does this rely on timeliness of maintenance interrupts with respect to
>>> EOIs in the guest? i.e. if a maintenance interrupt is delayed (I can't
>>> see anything in the spec stating that they're synchronous) and you end up
>>> taking one here, will you accidentally re-pend the interrupt?
>>
>> I don't think so. ELRSR only indicates that the list register is empty.
>> If we find a zero bit there, we flag that this vcpu has at least one
>> pending interrupt (in its list registers). A delayed maintenance
>> interrupt may race with this by also setting this bit if an interrupt is
>> still in the active state after being EOIed, but that's not a problem
>> (we just set_bit twice). A race between clear and set would be
>> problematic though.
> 
> Hmm, yes, the EOI maintenance handler only sets pending IRQs. So, to turn it
> around, how about __kvm_vgic_sync_to_cpu? There is a comment in the
> maintenance handler about it:
> 
> 
> 	 * level interrupt.  There is a potential race with
> 	 * the queuing of an interrupt in __kvm_sync_to_cpu(), where we check
> 	 * if the interrupt is already active. Two possibilities:
> 	 *
> 	 * - The queuing is occuring on the same vcpu: cannot happen, as we're
> 	 *   already in the context of this vcpu, and executing the handler
> 
> 
> Does this still apply if the maintenance interrupt comes in late? It will
> then look like the stopped vcpu just EOId an interrupt...

Gniiii... Yup, there is a race at the end of __kvm_vgic_sync_to_cpu(),
when we decide we've injected all non-active pending interrupts. The
maintenance interrupt could fire just before the clear_bit, and we'd
loose the now pending interrupt for a round. Probably not fatal, but still.

I think I'll use spin_lock_irqsave() in kvm_vgic_sync_to_cpu(), it will
save me a lot of headache.

But the ugliest thing with the maintenance interrupt is that if it is
delayed for long enough, you could end up messing with the wrong vcpu,
or no vcpu at all. But I don't think there is much you can do about
this. If your hardware is broken enough to deliver late VGIC interrupt,
we're screwed.

>>>> +       if (pending < vgic_cpu->nr_lr) {
>>>> +               set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
>>>> +               smp_mb();
>>>
>>> What's this barrier for?
>>
>> It is strategically placed to entertain the reviewer. And it does its
>> job! I'll nuke it, now that you found it. ;-)
> 
> Excellent! I think there may be another one on the horizon when I get into
> the maintenance interrupt handler proper too. Looking forward to it.

Enjoy!

	M.
-- 
Jazz is not dead. It just smells funny...
