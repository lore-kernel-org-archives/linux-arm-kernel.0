From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 07 Oct 2015 11:39:30 +0300
Subject: [PATCH v2 11/15] KVM: arm64: handle pending bit for LPIs in ITS
 emulation
In-Reply-To: <1436538111-4294-12-git-send-email-andre.przywara@arm.com>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-12-git-send-email-andre.przywara@arm.com>
Message-ID: <017701d100db$b003c550$100b4ff0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> +/* Called with the distributor lock held by the caller. */
> +void vits_unqueue_lpi(struct kvm_vcpu *vcpu, int lpi)
> +{
> +	struct vgic_its *its = &vcpu->kvm->arch.vgic.its;
> +	struct its_itte *itte;
> +
> +	spin_lock(&its->lock);
> +
> +	/* Find the right ITTE and put the pending state back in there */
> +	itte = find_itte_by_lpi(vcpu->kvm, lpi);
> +	if (itte)
> +		__set_bit(vcpu->vcpu_id, itte->pending);
> +
> +	spin_unlock(&its->lock);
> +}

 I am working on implementing live migration for the ITS. And here i have one fundamental problem.
vits_unqueue_lpi() processes only PENDING state. And looks like this corresponds to the HW
implementation, which has only bitwise pending table. But, in terms of migration, we can actually
have LPI in active state, while it's being processed.
 The question is - how can we handle it? Should we have one more bitwise table for active LPIs, or
is it enough to remember only a single, currently active LPI? Can LPIs be preempted on a real
hardware, or not?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
