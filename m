From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 7 Jul 2014 07:39:38 -0700
Subject: [RFC PATCH 4/6] arm/arm64: KVM: vgic: Improve handling of
 GICD_I{CS}PENDRn
In-Reply-To: <53A1A13D.9000404@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
 <1402779067-34478-5-git-send-email-christoffer.dall@linaro.org>
 <53A1A13D.9000404@linaro.org>
Message-ID: <20140707143938.GA32497@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 04:25:01PM +0200, Eric Auger wrote:
> On 06/14/2014 10:51 PM, Christoffer Dall wrote:
> > The handling of writes to the GICD_ISPENDRn and GICD_ICPENDRn is
> > currently not handled correctly for level-triggered interrupts.
> Hi Christoffer,
> 
> Thanks for this patch serie. I can confirm it fixes my QEMU/VFIO issue
> where all IRQs were pending cleared at guest OS boot while IRQ wires
> were set. Now those IRQs are left pending which is compliant with the
> GIC spec. You will find few comments/questions below.
> 
> Best Regards
> 
> Eric
> > spec states that for level-triggered interrupts, writes to the
> > GICD_ISPENDRn activates the output of a flip-flop which is in turn or'ed
> > with the actual input interrupt signal.  Correspondingly, writes to
> > GICD_ICPENDRn simply deactives the output of that flip-flop, but does
> deactivates
> > not (of course) affect the external input signal.  Reads from GICC_IAR
> > will also deactivate the flip-flop output.
> > 
> > This requires us to track the state of the level-input separately from
> > the state in the flip-flop.  Introduce two new variables on the
> > distributor struct to track these two exact states.  Astute readers
> > may notice that this is introducing more state than required (because an
> > OR of the two states give you the pending state), but the remainding
> remaining
> > vgic code uses the pending bitmap for optimized operations to figure
> > out, at the end of the day, if an interrupt is pending or not on the
> > distributor side.  Changing all the to consider the two state variables
> sentence
> > did not look pretty.

all fixed.

> > 
> > ---

[...]

> >  	}
> > @@ -408,11 +463,27 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
> >  					  struct kvm_exit_mmio *mmio,
> >  					  phys_addr_t offset)
> >  {
> > -	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_pending,
> > -				       vcpu->vcpu_id, offset);
> > +	u32 *level_active;
> > +	u32 *reg;
> > +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> > +
> > +	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
> >  	vgic_reg_access(mmio, reg, offset,
> >  			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
> >  	if (mmio->is_write) {
> > +		/* Re-set level triggered level-active interrupts */
> I was confused by this comment ;-)
> compute new status_includes_pending taking into account wire state and
> GICD_ICPENDR?

so instead of modifying the register value that the guest writes
(because we'd have to consider byte-stores, halfword-stores, and
word-stores and such that vgic_bitmap_get_reg already handles for us),
we just clear the pending state regardless, but if it's a
level-triggered interrupt with the external input active, then the
interrupt needs to stay pending, so we just set those.  All this is
under a lock and happening atomically, so it should have the same effect
as an actual or-gate in hw.

> > +		level_active = vgic_bitmap_get_reg(&dist->irq_level,
> > +					  vcpu->vcpu_id, offset);
> > +		reg = vgic_bitmap_get_reg(&dist->irq_pending,
> > +					  vcpu->vcpu_id, offset);
> > +		*reg |= *level_active;
> OK, or between the wire and the GICD_ICPENDR
> > +
> > +		/* Clear soft-pending flags */
> > +		reg = vgic_bitmap_get_reg(&dist->irq_soft_pend,
> > +					  vcpu->vcpu_id, offset);
> > +		vgic_reg_access(mmio, reg, offset,
> > +				ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
> only relevant for level-triggered IRQ but OK

in that case we're clearing already cleared bits, I thought the extra
logic would simply be confusing.

> > +
> >  		vgic_update_state(vcpu->kvm);
> >  		return true;
> >  	}
> > @@ -1187,15 +1258,29 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
> >  		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_eisr,
> >  				 vgic_cpu->nr_lr) {
> >  			irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
> > +			BUG_ON(vgic_irq_is_edge(vcpu, irq));
> >  
> >  			vgic_irq_clear_queued(vcpu, irq);
> >  			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_EOI;
> >  
> > +			/*
> > +			 * If the IRQ was EOIed it was most certainly also
> > +			 * ACKed and we can therefore always clear the soft
> > +			 * pending state (should it had been set) of this
> > +			 * interrupt.
> > +			 */
> > +			vgic_dist_irq_clear_soft_pend(vcpu, irq);
> what if the virq was Acked and ISPENDR was set after? Can't it happen?

hmm, yeah, I guess.

> Anyway since we do not trap the ACK, I guess we can't do better?

Right, basically the soft pending state would be set before or after the
ack, there is no way for us to know unless we start trapping ack's when
the soft pending flag is set (which would be the most architecturally
correct thing to do I suppose), but in practice I don't expect this to
be a problem.

I've added a note in the comments for v2.

> > +
> >  			/* Any additional pending interrupt? */
> > -			if (vgic_dist_irq_is_pending(vcpu, irq)) {
> > +			if (vgic_dist_irq_get_level(vcpu, irq)) {
> > +				/*
> > +				 * XXX: vgic_cpu_irq_set not always be true in
> > +				 * this case?
> > +				 */
> >  				vgic_cpu_irq_set(vcpu, irq);
> >  				level_pending = true;
> >  			} else {
> > +				vgic_dist_irq_clear_pending(vcpu, irq);
> >  				vgic_cpu_irq_clear(vcpu, irq);
> >  			}
> >  
> > @@ -1300,17 +1385,19 @@ static void vgic_kick_vcpus(struct kvm *kvm)
> >  static int vgic_validate_injection(struct kvm_vcpu *vcpu, int irq, int level)
> >  {
> >  	int edge_triggered = vgic_irq_is_edge(vcpu, irq);
> > -	int state = vgic_dist_irq_is_pending(vcpu, irq);
> >  
> >  	/*
> >  	 * Only inject an interrupt if:
> >  	 * - edge triggered and we have a rising edge
> >  	 * - level triggered and we change level
> >  	 */
> > -	if (edge_triggered)
> > +	if (edge_triggered) {
> > +		int state = vgic_dist_irq_is_pending(vcpu, irq);
> >  		return level > state;
> > -	else
> > +	} else {
> > +		int state = vgic_dist_irq_get_level(vcpu, irq);
> shouldn't we still compare against pending? What if soft pending happened?

we have to track all *updates* to the level state for
level-triggered interrupts, so this is basically just a shortcut-out if
nothing changed, which is why we only check against the existing level.

For example, consider state=0, soft_pend=1, pend=1, level=0, you don't
have to do anything, despite pend != level.

Do you have any counterexamples?

> >  		return level != state;
> > +	}
> >  }
> >  

Thanks,
-Christoffer
