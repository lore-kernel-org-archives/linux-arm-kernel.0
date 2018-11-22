From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 22 Nov 2018 15:29:47 +0000
Subject: [RFC PATCH v2 21/23] KVM: arm64/sve: allow
 KVM_ARM_SVE_CONFIG_QUERY on vm fd
In-Reply-To: <1538141967-15375-22-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-22-git-send-email-Dave.Martin@arm.com>
Message-ID: <878t1li104.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> Since userspace may need to decide on the set of vector lengths for
> the guest before setting up a vm, it is onerous to require a vcpu
> fd to be available first.  KVM_ARM_SVE_CONFIG_QUERY is not
> vcpu-dependent anyway, so this patch wires up KVM_ARM_SVE_CONFIG to
> be usable on a vm fd where appropriate.
>
> Subcommands that are vcpu-dependent (currently
> KVM_ARM_SVE_CONFIG_SET, KVM_ARM_SVE_CONFIG_GET) will return -EINVAL
> if invoked on a vm fd.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Apropos comments on last patch, this could go away if we went with just
reporting the max VL via the SVE capability probe which works on the
vmfd.

> ---
>  arch/arm64/kvm/guest.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index f066b17..2313c22 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -574,6 +574,9 @@ static int kvm_vcpu_set_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls,
>  	unsigned int vq, max_vq;
>  	int ret;
>
> +	if (!vcpu)
> +		return -EINVAL; /* per-vcpu operation on vm fd */
> +
>  	if (vcpu->arch.has_run_once || vcpu_has_sve(vcpu))
>  		return -EBADFD; /* too late, or already configured */
>
> @@ -659,6 +662,9 @@ static int kvm_vcpu_query_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls
>  static int kvm_vcpu_get_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls,
>  		struct kvm_sve_vls __user *userp)
>  {
> +	if (!vcpu)
> +		return -EINVAL; /* per-vcpu operation on vm fd */
> +
>  	if (!vcpu_has_sve(vcpu))
>  		return -EBADFD; /* not configured yet */
>
> @@ -668,6 +674,7 @@ static int kvm_vcpu_get_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls,
>  			sve_vq_from_vl(vcpu->arch.sve_max_vl), userp);
>  }
>
> +/* vcpu may be NULL if this is called via a vm fd */
>  static int kvm_vcpu_sve_config(struct kvm_vcpu *vcpu,
>  			       struct kvm_sve_vls __user *userp)
>  {
> @@ -717,7 +724,15 @@ int kvm_arm_arch_vcpu_ioctl(struct kvm_vcpu *vcpu,
>  int kvm_arm_arch_vm_ioctl(struct kvm *kvm,
>  			  unsigned int ioctl, unsigned long arg)
>  {
> -	return -EINVAL;
> +	void __user *userp = (void __user *)arg;
> +
> +	switch (ioctl) {
> +	case KVM_ARM_SVE_CONFIG:
> +		return kvm_vcpu_sve_config(NULL, userp);
> +
> +	default:
> +		return -EINVAL;
> +	}
>  }
>
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)


--
Alex Benn?e
