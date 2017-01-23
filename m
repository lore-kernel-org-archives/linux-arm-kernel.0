From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 23 Jan 2017 16:30:52 +0000
Subject: [PATCH] KVM: arm/arm64: Remove struct vgic_irq pending field
In-Reply-To: <20170123133951.10329-1-christoffer.dall@linaro.org>
References: <20170123133951.10329-1-christoffer.dall@linaro.org>
Message-ID: <CAFEAcA8yde+mkOac_Zu2CRpWeiuOL3veVhpRwze50pykQSj0-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 January 2017 at 13:39, Christoffer Dall
<christoffer.dall@linaro.org> wrote:

I don't think this is wrong, but maybe it's a revealed cleanup
that this patch permits:

> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index e6b03fd..76d7d75 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -94,7 +94,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
>                 /* Edge is the only case where we preserve the pending bit */
>                 if (irq->config == VGIC_CONFIG_EDGE &&
>                     (val & ICH_LR_PENDING_BIT)) {
> -                       irq->pending = true;
> +                       irq_set_pending_latch(irq, true);
>
>                         if (vgic_irq_is_sgi(intid) &&
>                             model == KVM_DEV_TYPE_ARM_VGIC_V2) {
> @@ -111,9 +111,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
>                  */
>                 if (irq->config == VGIC_CONFIG_LEVEL) {
>                         if (!(val & ICH_LR_PENDING_BIT))
> -                               irq->soft_pending = false;
> -
> -                       irq->pending = irq->line_level || irq->soft_pending;
> +                               irq_set_pending_latch(irq, false);
>                 }
>
>                 spin_unlock(&irq->irq_lock);
> @@ -127,11 +125,11 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>         u32 model = vcpu->kvm->arch.vgic.vgic_model;
>         u64 val = irq->intid;
>
> -       if (irq->pending) {
> +       if (irq_is_pending(irq)) {
>                 val |= ICH_LR_PENDING_BIT;
>
>                 if (irq->config == VGIC_CONFIG_EDGE)
> -                       irq->pending = false;
> +                       irq_set_pending_latch(irq, false);
>
>                 if (vgic_irq_is_sgi(irq->intid) &&
>                     model == KVM_DEV_TYPE_ARM_VGIC_V2) {
> @@ -141,7 +139,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>                         val |= (src - 1) << GICH_LR_PHYSID_CPUID_SHIFT;
>                         irq->source &= ~(1 << (src - 1));
>                         if (irq->source)
> -                               irq->pending = true;
> +                               irq_set_pending_latch(irq, true);
>                 }
>         }

For edge-triggered irqs:
 * when we populate the LR we clear the pending latch
 * when we extract the info from the LRs we set the
   pending latch again if the LR pending bit is still set
For level-triggered irqs:
 * we don't clear the pending latch on populate, but
 * when we extract the info from the LRs we clear
   the pending latch if the LR pending bit isn't set

These seem to be pretty much the same effect except
for the value of the pending-latch while the interrupt
is in the LR. Do they actually need to be different
now we've cleaned up the handling of the latch state?

(Architecturally the pending_latch state should be
cleared when the interrupt is acknowledged, but I
don't know which of the populate and fold steps is
the right place for that.)

thanks
-- PMM
