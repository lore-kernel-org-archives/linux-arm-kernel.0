From: wanghaibin.wang@huawei.com (wanghaibin)
Date: Fri, 5 Sep 2014 11:28:11 +0800
Subject: [PATCH v2 12/15] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <1408626416-11326-13-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-13-git-send-email-andre.przywara@arm.com>
Message-ID: <54092DCB.3010107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/8/21 21:06, Andre Przywara wrote:


> +void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_vcpu *c_vcpu;
> +	struct vgic_dist *dist = &kvm->arch.vgic;
> +	u16 target_cpus;
> +	u64 mpidr, mpidr_h, mpidr_l;
> +	int sgi, mode, c, vcpu_id;
> +	int updated = 0;
> +
> +	vcpu_id = vcpu->vcpu_id;
> +
> +	sgi = (reg >> 24) & 0xf;
> +	mode = (reg >> 40) & 0x1;
> +	target_cpus = reg & 0xffff;
> +	mpidr = ((reg >> 48) & 0xff) << MPIDR_LEVEL_SHIFT(3);
> +	mpidr |= ((reg >> 32) & 0xff) << MPIDR_LEVEL_SHIFT(2);
> +	mpidr |= ((reg >> 16) & 0xff) << MPIDR_LEVEL_SHIFT(1);
> +	mpidr &= ~MPIDR_LEVEL_MASK;
> +

> +	/*
> +	 * We take the dist lock here, because we come from the sysregs
> +	 * code path and not from MMIO (where this is already done)
> +	 */
> +	spin_lock(&dist->lock);
> +	kvm_for_each_vcpu(c, c_vcpu, kvm) {


Hi, Andre, there is a suggestion. Move the

> +		if (target_cpus == 0)
> +			break;

code, out the  kvm_for_each_vcpu loop, Like :


	if (!mode && target_cpus == 0)   /* the judgement do not need judge in kvm_for_each_vcpu loop */
		return;

	spin_lock(&dist->lock);
	kvm_for_each_vcpu(c, c_vcpu, kvm) {

> +		if (mode && c == vcpu_id)       /* not to myself */
> +			continue;
> +		if (!mode) {
> +			mpidr_h = kvm_vcpu_get_mpidr(c_vcpu);
> +			mpidr_l = MPIDR_AFFINITY_LEVEL(mpidr_h, 0);
> +			mpidr_h &= ~MPIDR_LEVEL_MASK;
> +			if (mpidr != mpidr_h)
> +				continue;
> +			if (!(target_cpus & BIT(mpidr_l)))
> +				continue;
> +			target_cpus &= ~BIT(mpidr_l);
> +		}
> +		/* Flag the SGI as pending */
> +		vgic_dist_irq_set(c_vcpu, sgi);
> +		updated = 1;
> +		kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
> +	}
> +	if (updated)
> +		vgic_update_state(vcpu->kvm);
> +	spin_unlock(&dist->lock);
> +	if (updated)
> +		vgic_kick_vcpus(vcpu->kvm);
> +}
> +
> +
