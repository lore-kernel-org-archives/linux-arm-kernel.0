From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 14 May 2014 17:17:48 +0100
Subject: [PATCH v3 06/19] KVM: ARM: vgic: introduce vgic_ops and LR
 manipulation primitives
In-Reply-To: <87mwemj498.fsf@approximate.cambridge.arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-7-git-send-email-marc.zyngier@arm.com>
 <20140509140554.GG3362@lvm>
 <87mwemj498.fsf@approximate.cambridge.arm.com>
Message-ID: <CAMJs5B9zP5WpzBen_AeKc0zwLK=UkxBEaGRFvYybaaZ2Mvcunw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2014 18:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, May 09 2014 at  3:05:54 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> On Wed, Apr 16, 2014 at 02:39:38PM +0100, Marc Zyngier wrote:

[...]

>>> +static struct vgic_lr vgic_v2_get_lr(const struct kvm_vcpu *vcpu, int lr)
>>> +{
>>> +     struct vgic_lr lr_desc;
>>> +     u32 val = vcpu->arch.vgic_cpu.vgic_v2.vgic_lr[lr];
>>> +
>>> +     lr_desc.irq     = val & GICH_LR_VIRTUALID;
>>> +     lr_desc.source  = (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0xff;
>>
>> shouldn't the mask here be 0xf according to the GICv2 spec?
>
> Actually, looks like it should be 7 instead (bits [12:10], and only when
> lr_desc.irq is within 0..15). Well spotted anyway.
>

yes, 7, duh :)

>>
>>> +     lr_desc.state   = 0;
>>> +
>>> +     if (val & GICH_LR_PENDING_BIT)
>>> +             lr_desc.state |= LR_STATE_PENDING;
>>> +     if (val & GICH_LR_ACTIVE_BIT)
>>> +             lr_desc.state |= LR_STATE_ACTIVE;
>>> +     if (val & GICH_LR_EOI)
>>> +             lr_desc.state |= LR_EOI_INT;
>>> +
>>> +     return lr_desc;
>>> +}
>>> +
>>>  #define MK_LR_PEND(src, irq) \
>>>       (GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
>>>
>>> +static void vgic_v2_set_lr(struct kvm_vcpu *vcpu, int lr,
>>> +                        struct vgic_lr lr_desc)
>>> +{
>>> +     u32 lr_val = MK_LR_PEND(lr_desc.source, lr_desc.irq);
>>
>> this looks a bit weird, the check just below suggests that you can
>> convert a struct vgic_lr into an lr register for, for example, an lr
>> which is just active and not pending.
>
> Ah, this is probably a leftover from some previous implementation. I'll
> get rid of MR_LR_PEND altogether, and rely solely on lr_desc.state.
>

thanks


>>> +
>>> +     if (lr_desc.state & LR_STATE_PENDING)
>>> +             lr_val |= GICH_LR_PENDING_BIT;
>>> +     if (lr_desc.state & LR_STATE_ACTIVE)
>>> +             lr_val |= GICH_LR_ACTIVE_BIT;
>>> +     if (lr_desc.state & LR_EOI_INT)
>>> +             lr_val |= GICH_LR_EOI;
>>> +
>>> +     vcpu->arch.vgic_cpu.vgic_v2.vgic_lr[lr] = lr_val;
>>> +
>>> +     /*
>>> +      * Despite being EOIed, the LR may not have been marked as
>>> +      * empty.
>>> +      */
>>> +     if (!(lr_val & GICH_LR_STATE))
>>> +             set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
>>
>> This feels weird in vgic_v2_set_lr, the name/style suggests that these
>> get/set functions are just converters from a struct vgic_lr (that
>> presumably common code can deal with) and architecture-specific LR
>> register formats.
>>
>> If these functions have richer semantics than that (like maintaining the
>> elrsr register), please comment that on the function.
>
> Yeah, this is one of the corners I really dislike, but making this a
> separate vector makes things even more ugly than they already are.
>
> I'll add some comments, but feel free to suggest an alternative approach.
>

I think adding an api function called something like
vgic_sync_lr_elrsr() and calling that from vgic_process_maintenance()
- and move the comment about EOIed there - would be much nicer.

>>> +}
>>> +
>>> +static const struct vgic_ops vgic_ops = {
>>> +     .get_lr                 = vgic_v2_get_lr,
>>> +     .set_lr                 = vgic_v2_set_lr,
>>> +};
>>> +
>>> +static inline struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
>>> +{
>>> +     return vgic_ops.get_lr(vcpu, lr);
>>> +}
>>> +
>>> +static inline void vgic_set_lr(struct kvm_vcpu *vcpu, int lr,
>>> +                            struct vgic_lr vlr)
>>> +{
>>> +     vgic_ops.set_lr(vcpu, lr, vlr);
>>> +}
>>
>> inline statics in a C file?  Surely the compiler is smart enough to
>> inline this without any hints.
>
> Yup, brain fart here.
>
>>> +
>>> +static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
>>> +{
>>> +     struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>> +     struct vgic_lr vlr = vgic_get_lr(vcpu, lr_nr);
>>
>> seems like we're doing a lot of copying back and forward between the
>> struct vgic_lr and the LRs on the vgic_cpu struct, I wonder if it makes
>> more sense to only deal with it during the sync/flush functions, or
>> maybe we end up messing with more state than necessary then?
>
> We're doing a lot of them, but we actually don't have much copying. The
> structure is small enough to fit in a single register (even on AArch32),
> and we're passing it by value. So the whole state computation actually
> occurs in registers.
>
> But overall yes, I agree that we should probably try to do things in a
> more staged way. I'll have a look.
>

not too important, we can always clean it up, measure it etc., later.

>>> +
>>> +     vlr.state = 0;
>>> +     vgic_set_lr(vcpu, lr_nr, vlr);
>>> +     clear_bit(lr_nr, vgic_cpu->lr_used);
>>> +     vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
>>> +}
>>> +
>>>  /*
>>>   * An interrupt may have been disabled after being made pending on the
>>>   * CPU interface (the classic case is a timer running while we're
>>> @@ -1007,12 +1064,12 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
>>>       int lr;
>>>
>>>       for_each_set_bit(lr, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
>>> -             int irq = vgic_cpu->vgic_v2.vgic_lr[lr] & GICH_LR_VIRTUALID;
>>> +             struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
>>>
>>> -             if (!vgic_irq_is_enabled(vcpu, irq)) {
>>> -                     vgic_retire_lr(lr, irq, vgic_cpu);
>>> -                     if (vgic_irq_is_active(vcpu, irq))
>>> -                             vgic_irq_clear_active(vcpu, irq);
>>> +             if (!vgic_irq_is_enabled(vcpu, vlr.irq)) {
>>> +                     vgic_retire_lr(lr, vlr.irq, vcpu);
>>> +                     if (vgic_irq_is_active(vcpu, vlr.irq))
>>> +                             vgic_irq_clear_active(vcpu, vlr.irq);
>>>               }
>>>       }
>>>  }
>>> @@ -1024,6 +1081,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
>>>  static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>>>  {
>>>       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>> +     struct vgic_lr vlr;
>>>       int lr;
>>>
>>>       /* Sanitize the input... */
>>> @@ -1036,13 +1094,15 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>>>       lr = vgic_cpu->vgic_irq_lr_map[irq];
>>>
>>>       /* Do we have an active interrupt for the same CPUID? */
>>> -     if (lr != LR_EMPTY &&
>>> -         (LR_CPUID(vgic_cpu->vgic_v2.vgic_lr[lr]) == sgi_source_id)) {
>>> -             kvm_debug("LR%d piggyback for IRQ%d %x\n",
>>> -                       lr, irq, vgic_cpu->vgic_v2.vgic_lr[lr]);
>>> -             BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
>>> -             vgic_cpu->vgic_v2.vgic_lr[lr] |= GICH_LR_PENDING_BIT;
>>> -             return true;
>>> +     if (lr != LR_EMPTY) {
>>> +             vlr = vgic_get_lr(vcpu, lr);
>>> +             if (vlr.source == sgi_source_id) {
>>> +                     kvm_debug("LR%d piggyback for IRQ%d\n", lr, vlr.irq);
>>> +                     BUG_ON(!test_bit(lr, vgic_cpu->lr_used));
>>> +                     vlr.state |= LR_STATE_PENDING;
>>> +                     vgic_set_lr(vcpu, lr, vlr);
>>> +                     return true;
>>> +             }
>>>       }
>>>
>>>       /* Try to use another LR for this interrupt */
>>> @@ -1052,12 +1112,16 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>>>               return false;
>>>
>>>       kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
>>> -     vgic_cpu->vgic_v2.vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
>>>       vgic_cpu->vgic_irq_lr_map[irq] = lr;
>>>       set_bit(lr, vgic_cpu->lr_used);
>>>
>>> +     vlr.irq = irq;
>>> +     vlr.source = sgi_source_id;
>>> +     vlr.state = LR_STATE_PENDING;
>>>       if (!vgic_irq_is_edge(vcpu, irq))
>>> -             vgic_cpu->vgic_v2.vgic_lr[lr] |= GICH_LR_EOI;
>>> +             vlr.state |= LR_EOI_INT;
>>> +
>>> +     vgic_set_lr(vcpu, lr, vlr);
>>>
>>>       return true;
>>>  }
>>> @@ -1180,29 +1244,23 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>>>                * Some level interrupts have been EOIed. Clear their
>>>                * active bit.
>>>                */
>>> -             int lr, irq;
>>> +             int lr;
>>>
>>>               for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_v2.vgic_eisr,
>>>                                vgic_cpu->nr_lr) {
>>> -                     irq = vgic_cpu->vgic_v2.vgic_lr[lr] & GICH_LR_VIRTUALID;
>>> +                     struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
>>>
>>> -                     vgic_irq_clear_active(vcpu, irq);
>>> -                     vgic_cpu->vgic_v2.vgic_lr[lr] &= ~GICH_LR_EOI;
>>> +                     vgic_irq_clear_active(vcpu, vlr.irq);
>>> +                     vlr.state = 0;
>>
>> slight change of semantics here.  It is still correct, but only because
>> we never set the pending bit on an already active level interrupt, but I
>> guess this could technically be closer to real hardware by allowing
>> world-switching VMs that are processing active interrupts to pick up an
>> additional pending state, in which case just setting state = 0 would be
>> incorrect here, and you should instead lower the EOI mask like you did
>> before.
>>
>> That being said, it is a pseudo-theoretical point, and you can make me
>> more happy by adding:
>>
>> BUG_ON(vlr.state & LR_STATE_MASK);
>>
>> before clearing the state completely.
>
> Putting a BUG_ON() seems a bit harsh. WARN_ON()?
>

yeah, let's take it easy.

>>> +                     vgic_set_lr(vcpu, lr, vlr);
>>>
>>>                       /* Any additional pending interrupt? */
>>> -                     if (vgic_dist_irq_is_pending(vcpu, irq)) {
>>> -                             vgic_cpu_irq_set(vcpu, irq);
>>> +                     if (vgic_dist_irq_is_pending(vcpu, vlr.irq)) {
>>> +                             vgic_cpu_irq_set(vcpu, vlr.irq);
>>>                               level_pending = true;
>>>                       } else {
>>> -                             vgic_cpu_irq_clear(vcpu, irq);
>>> +                             vgic_cpu_irq_clear(vcpu, vlr.irq);
>>>                       }
>>> -
>>> -                     /*
>>> -                      * Despite being EOIed, the LR may not have
>>> -                      * been marked as empty.
>>> -                      */
>>> -                     set_bit(lr, (unsigned long *)vgic_cpu->vgic_v2.vgic_elrsr);
>>> -                     vgic_cpu->vgic_v2.vgic_lr[lr] &= ~GICH_LR_ACTIVE_BIT;
>>>               }
>>>       }
>>>
>>> @@ -1228,15 +1286,15 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>>>       /* Clear mappings for empty LRs */
>>>       for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_v2.vgic_elrsr,
>>>                        vgic_cpu->nr_lr) {
>>> -             int irq;
>>> +             struct vgic_lr vlr;
>>>
>>>               if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
>>>                       continue;
>>>
>>> -             irq = vgic_cpu->vgic_v2.vgic_lr[lr] & GICH_LR_VIRTUALID;
>>> +             vlr = vgic_get_lr(vcpu, lr);
>>>
>>> -             BUG_ON(irq >= VGIC_NR_IRQS);
>>> -             vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
>>> +             BUG_ON(vlr.irq >= VGIC_NR_IRQS);
>>> +             vgic_cpu->vgic_irq_lr_map[vlr.irq] = LR_EMPTY;
>>>       }
>>>
>>>       /* Check if we still have something up our sleeve... */
>>> --
>>> 1.8.3.4
>>>

-Christoffer
