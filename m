From: thomas.hanson@linaro.org (Tom Hanson)
Date: Thu, 5 May 2016 10:23:32 -0600
Subject: [PATCH v2 16/54] KVM: arm/arm64: vgic-new: Add IRQ sync/flush
 framework
In-Reply-To: <1461861973-26464-17-git-send-email-andre.przywara@arm.com>
References: <1461861973-26464-1-git-send-email-andre.przywara@arm.com>
 <1461861973-26464-17-git-send-email-andre.przywara@arm.com>
Message-ID: <572B7384.2050405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2016 10:45 AM, Andre Przywara wrote:

...

> diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> index 4fb20fd..a656a12e5 100644
> --- a/virt/kvm/arm/vgic/vgic.c
> +++ b/virt/kvm/arm/vgic/vgic.c

...
> +static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
> +{

...

> +		/* This interrupt looks like it has to be migrated. */
> +
> +		spin_unlock(&irq->irq_lock);
> +		spin_unlock(&vgic_cpu->ap_list_lock);

If using the suggested (but not provided) higher level function from patch 14 this could be:
                 vgic_unlock_aplist_irq(, spinlock_t irq);
> +
> +		/*
> +		 * Ensure locking order by always locking the smallest
> +		 * ID first.
> +		 */
> +		if (vcpu->vcpu_id < target_vcpu->vcpu_id) {
> +			vcpuA = vcpu;
> +			vcpuB = target_vcpu;
> +		} else {
> +			vcpuA = target_vcpu;
> +			vcpuB = vcpu;
> +		}
> +
> +		spin_lock(&vcpuA->arch.vgic_cpu.ap_list_lock);
> +		spin_lock(&vcpuB->arch.vgic_cpu.ap_list_lock);

And this whole block could be replaced by:
                 vgic_lock_cpu_aplist_pair(vcpuA, vcpuB)

> +             spin_lock(&irq->irq_lock);

...

> +		spin_unlock(&irq->irq_lock);
> +		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
> +		spin_unlock(&vcpuA->arch.vgic_cpu.ap_list_lock);
And this could be:
                 vgic_unlock_cpu_aplist_pair(vcpuA, vcpuB)

> +		goto retry;
> +	}
> +
> +	spin_unlock(&vgic_cpu->ap_list_lock);
> +}
