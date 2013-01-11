From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 17:12:32 +0000
Subject: [PATCH v2 2/2] ARM: KVM: Power State Coordination Interface
 implementation
In-Reply-To: <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
 <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130111171232.GH23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 04:06:45PM +0000, Marc Zyngier wrote:
> +int kvm_psci_call(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
> +	unsigned long val;
> +
> +	switch (psci_fn) {
> +	case KVM_PSCI_FN_CPU_OFF:
> +		kvm_psci_vcpu_off(vcpu);
> +		val = KVM_PSCI_RET_SUCCESS;
> +		break;
> +	case KVM_PSCI_FN_CPU_ON:
> +		val = kvm_psci_vcpu_on(vcpu);
> +		break;
> +	case KVM_PSCI_FN_CPU_SUSPEND:
> +	case KVM_PSCI_FN_MIGRATE:
> +		val = KVM_PSCI_RET_NI;
> +		break;
> +
> +	default:
> +		return -1;
> +	}
> +
> +	*vcpu_reg(vcpu, 0) = val;
> +	return 0;
> +}

We were discussing recently on #kernel about kernel APIs and the way that
our integer-returning functions pretty much use 0 for success, and -errno
for failures, whereas our pointer-returning functions are a mess.

And above we have something returning -1 to some other chunk of code outside
this compilation unit.  That doesn't sound particularly clever to me.
