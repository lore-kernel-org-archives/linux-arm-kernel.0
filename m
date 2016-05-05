From: thomas.hanson@linaro.org (Tom Hanson)
Date: Thu, 5 May 2016 11:04:01 -0600
Subject: [PATCH v2 18/54] KVM: arm/arm64: vgic-new: Add GICv3 world switch
 backend
In-Reply-To: <1461861973-26464-19-git-send-email-andre.przywara@arm.com>
References: <1461861973-26464-1-git-send-email-andre.przywara@arm.com>
 <1461861973-26464-19-git-send-email-andre.przywara@arm.com>
Message-ID: <572B7D01.50202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2016 10:45 AM, Andre Przywara wrote:

...

> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> new file mode 100644
> index 0000000..461229b
> --- /dev/null
> +++ b/virt/kvm/arm/vgic/vgic-v3.c

...

> +void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
> +{
> + struct vgic_v3_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v3;
> + u32 model = vcpu->kvm->arch.vgic.vgic_model;
> + int lr;
> +
> + /* Assumes ap_list_lock held */

If truly required that ap_list_lock already be locked, then the code should enforce it. At least in dev mode. Maybe:
         DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vcpu->ap_list_lock));

...

> +/* Requires the irq to be locked already */
> +void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
> +{
> +	u32 model = vcpu->kvm->arch.vgic.vgic_model;
> +	u64 val = irq->intid;
> +

Similarly, if required then the code should enforce it.
         DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));

...
