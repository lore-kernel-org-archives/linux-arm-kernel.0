From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 18 Jun 2014 16:25:01 +0200
Subject: [RFC PATCH 4/6] arm/arm64: KVM: vgic: Improve handling of
 GICD_I{CS}PENDRn
In-Reply-To: <1402779067-34478-5-git-send-email-christoffer.dall@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
 <1402779067-34478-5-git-send-email-christoffer.dall@linaro.org>
Message-ID: <53A1A13D.9000404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2014 10:51 PM, Christoffer Dall wrote:
> The handling of writes to the GICD_ISPENDRn and GICD_ICPENDRn is
> currently not handled correctly for level-triggered interrupts.
Hi Christoffer,

Thanks for this patch serie. I can confirm it fixes my QEMU/VFIO issue
where all IRQs were pending cleared at guest OS boot while IRQ wires
were set. Now those IRQs are left pending which is compliant with the
GIC spec. You will find few comments/questions below.

Best Regards

Eric
> spec states that for level-triggered interrupts, writes to the
> GICD_ISPENDRn activates the output of a flip-flop which is in turn or'ed
> with the actual input interrupt signal.  Correspondingly, writes to
> GICD_ICPENDRn simply deactives the output of that flip-flop, but does
deactivates
> not (of course) affect the external input signal.  Reads from GICC_IAR
> will also deactivate the flip-flop output.
> 
> This requires us to track the state of the level-input separately from
> the state in the flip-flop.  Introduce two new variables on the
> distributor struct to track these two exact states.  Astute readers
> may notice that this is introducing more state than required (because an
> OR of the two states give you the pending state), but the remainding
remaining
> vgic code uses the pending bitmap for optimized operations to figure
> out, at the end of the day, if an interrupt is pending or not on the
> distributor side.  Changing all the to consider the two state variables
sentence
> did not look pretty.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  include/kvm/arm_vgic.h |  16 ++++++-
>  virt/kvm/arm/vgic.c    | 118 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 122 insertions(+), 12 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 10fa64b..f678d5c 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -86,9 +86,23 @@ struct vgic_dist {
>  	/* Interrupt enabled (one bit per IRQ) */
>  	struct vgic_bitmap	irq_enabled;
>  
> -	/* Interrupt state is pending on the distributor */
> +	/* Level-triggered interrupt external input is asserted */
> +	struct vgic_bitmap	irq_level;
was a bit confused by the name. I now understand this is the wire
(interrupt signal to GIC), relevant in case of level-sensitive IRQ.
~ wire_level.
> +
> +	/*
> +	 * Interrupt state is pending on the distributor
> +	 */
>  	struct vgic_bitmap	irq_pending;
~ status_includes_pending
>  
> +	/*
> +	 * Tracks writes to GICD_ISPENDRn and GICD_ICPENDRn for level-triggered
> +	 * interrupts.  Essentially holds the state of the flip-flop in
> +	 * Figure 4-10 on page 4-101 in ARM IHI 0048B.b.
> +	 * Once set, it is only cleared for level-triggered interrupts on
> +	 * guest ACKs (when we queue it) or writes to GICD_ICPENDRn.
> +	 */
> +	struct vgic_bitmap	irq_soft_pend;
> +
>  	/* Level-triggered interrupt queued on VCPU interface */
>  	struct vgic_bitmap	irq_queued;
>  
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 87c977c..0b41875 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -67,6 +67,11 @@
>   * - When the interrupt is EOIed, the maintenance interrupt fires,
>   *   and clears the corresponding bit in irq_queued. This allow the
>   *   interrupt line to be sampled again.
> + * - Note that level-triggered interrupts can also be set to pending from
> + *   writes to GICD_ISPENDRn and lowering the external input line does not
> + *   cause the interrupt to become inactive in such a situation.
> + *   Conversely, writes to GICD_ICPENDRn do not cause the interrupt to become
> + *   inactive as long as the external input line is held high.
>   */
>  
>  #define VGIC_ADDR_UNDEF		(-1)
> @@ -200,6 +205,41 @@ static void vgic_irq_clear_queued(struct kvm_vcpu *vcpu, int irq)
>  	vgic_bitmap_set_irq_val(&dist->irq_queued, vcpu->vcpu_id, irq, 0);
>  }
>  
> +static int vgic_dist_irq_get_level(struct kvm_vcpu *vcpu, int irq)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	return vgic_bitmap_get_irq_val(&dist->irq_level, vcpu->vcpu_id, irq);
> +}
> +
> +static void vgic_dist_irq_set_level(struct kvm_vcpu *vcpu, int irq)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	vgic_bitmap_set_irq_val(&dist->irq_level, vcpu->vcpu_id, irq, 1);
> +}
> +
> +static void vgic_dist_irq_clear_level(struct kvm_vcpu *vcpu, int irq)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	vgic_bitmap_set_irq_val(&dist->irq_level, vcpu->vcpu_id, irq, 0);
> +}
> +
> +static int vgic_dist_irq_soft_pend(struct kvm_vcpu *vcpu, int irq)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	return vgic_bitmap_get_irq_val(&dist->irq_soft_pend, vcpu->vcpu_id, irq);
> +}
> +
> +static void vgic_dist_irq_clear_soft_pend(struct kvm_vcpu *vcpu, int irq)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	vgic_bitmap_set_irq_val(&dist->irq_soft_pend, vcpu->vcpu_id, irq, 0);
> +}
> +
>  static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
>  {
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> @@ -392,11 +432,26 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
>  					struct kvm_exit_mmio *mmio,
>  					phys_addr_t offset)
>  {
> -	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_pending,
> -				       vcpu->vcpu_id, offset);
> +	u32 *reg;
> +	u32 level_mask;
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	reg = vgic_bitmap_get_reg(&dist->irq_cfg, vcpu->vcpu_id, offset);
> +	level_mask = (~(*reg));
> +
> +	/* Mark both level and edge triggered irqs as pending */
OK, includes pending status latched on a write to the GICD_ISPENDRn
> +	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
>  	vgic_reg_access(mmio, reg, offset,
>  			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
> +
>  	if (mmio->is_write) {
> +		/* Set the soft-pending flag only for level-triggered irqs */
> +		reg = vgic_bitmap_get_reg(&dist->irq_soft_pend,
> +					  vcpu->vcpu_id, offset);
> +		vgic_reg_access(mmio, reg, offset,
> +				ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
> +		*reg &= level_mask;
OK, for level-sensitive IRQs, ISPENDR write updates the output of flip flop
> +
>  		vgic_update_state(vcpu->kvm);
>  		return true;
>  	}
> @@ -408,11 +463,27 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
>  					  struct kvm_exit_mmio *mmio,
>  					  phys_addr_t offset)
>  {
> -	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_pending,
> -				       vcpu->vcpu_id, offset);
> +	u32 *level_active;
> +	u32 *reg;
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
>  	vgic_reg_access(mmio, reg, offset,
>  			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
>  	if (mmio->is_write) {
> +		/* Re-set level triggered level-active interrupts */
I was confused by this comment ;-)
compute new status_includes_pending taking into account wire state and
GICD_ICPENDR?
> +		level_active = vgic_bitmap_get_reg(&dist->irq_level,
> +					  vcpu->vcpu_id, offset);
> +		reg = vgic_bitmap_get_reg(&dist->irq_pending,
> +					  vcpu->vcpu_id, offset);
> +		*reg |= *level_active;
OK, or between the wire and the GICD_ICPENDR
> +
> +		/* Clear soft-pending flags */
> +		reg = vgic_bitmap_get_reg(&dist->irq_soft_pend,
> +					  vcpu->vcpu_id, offset);
> +		vgic_reg_access(mmio, reg, offset,
> +				ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
only relevant for level-triggered IRQ but OK
> +
>  		vgic_update_state(vcpu->kvm);
>  		return true;
>  	}
> @@ -1187,15 +1258,29 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_eisr,
>  				 vgic_cpu->nr_lr) {
>  			irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
> +			BUG_ON(vgic_irq_is_edge(vcpu, irq));
>  
>  			vgic_irq_clear_queued(vcpu, irq);
>  			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_EOI;
>  
> +			/*
> +			 * If the IRQ was EOIed it was most certainly also
> +			 * ACKed and we can therefore always clear the soft
> +			 * pending state (should it had been set) of this
> +			 * interrupt.
> +			 */
> +			vgic_dist_irq_clear_soft_pend(vcpu, irq);
what if the virq was Acked and ISPENDR was set after? Can't it happen?
Anyway since we do not trap the ACK, I guess we can't do better?
> +
>  			/* Any additional pending interrupt? */
> -			if (vgic_dist_irq_is_pending(vcpu, irq)) {
> +			if (vgic_dist_irq_get_level(vcpu, irq)) {
> +				/*
> +				 * XXX: vgic_cpu_irq_set not always be true in
> +				 * this case?
> +				 */
>  				vgic_cpu_irq_set(vcpu, irq);
>  				level_pending = true;
>  			} else {
> +				vgic_dist_irq_clear_pending(vcpu, irq);
>  				vgic_cpu_irq_clear(vcpu, irq);
>  			}
>  
> @@ -1300,17 +1385,19 @@ static void vgic_kick_vcpus(struct kvm *kvm)
>  static int vgic_validate_injection(struct kvm_vcpu *vcpu, int irq, int level)
>  {
>  	int edge_triggered = vgic_irq_is_edge(vcpu, irq);
> -	int state = vgic_dist_irq_is_pending(vcpu, irq);
>  
>  	/*
>  	 * Only inject an interrupt if:
>  	 * - edge triggered and we have a rising edge
>  	 * - level triggered and we change level
>  	 */
> -	if (edge_triggered)
> +	if (edge_triggered) {
> +		int state = vgic_dist_irq_is_pending(vcpu, irq);
>  		return level > state;
> -	else
> +	} else {
> +		int state = vgic_dist_irq_get_level(vcpu, irq);
shouldn't we still compare against pending? What if soft pending happened?
>  		return level != state;
> +	}
>  }
>  
>  static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
> @@ -1340,10 +1427,19 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
>  
>  	kvm_debug("Inject IRQ%d level %d CPU%d\n", irq_num, level, cpuid);
>  
> -	if (level)
> +	if (level) {
> +		if (level_triggered)
> +			vgic_dist_irq_set_level(vcpu, irq_num);
>  		vgic_dist_irq_set_pending(vcpu, irq_num);
> -	else
> -		vgic_dist_irq_clear_pending(vcpu, irq_num);
> +	} else {
> +		if (level_triggered) {
> +			vgic_dist_irq_clear_level(vcpu, irq_num);
> +			if (!vgic_dist_irq_soft_pend(vcpu, irq_num))
> +				vgic_dist_irq_clear_pending(vcpu, irq_num);
OK wire toggled down cannot clear a soft pending IRQ
> +		} else {
> +			vgic_dist_irq_clear_pending(vcpu, irq_num);
> +		}
> +	}
>  
>  	enabled = vgic_irq_is_enabled(vcpu, irq_num);
>  
> 
