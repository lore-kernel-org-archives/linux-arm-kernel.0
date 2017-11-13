From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 13 Nov 2017 09:32:27 +0000
Subject: [PATCH v2 1/3] kvm: arm debug: introduce helper for single-step
In-Reply-To: <20171109170021.2984-2-alex.bennee@linaro.org>
References: <20171109170021.2984-1-alex.bennee@linaro.org>
 <20171109170021.2984-2-alex.bennee@linaro.org>
Message-ID: <883136c1-1a22-6b19-e019-cd666ed53444@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/11/17 17:00, Alex Benn?e wrote:
> After emulating instructions we may want return to user-space to
> handle a single-step. If single-step is enabled the helper set the run
> structure for return and returns true.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

With the fixup:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> 
> ---
> v2
>    - kvm_arm_maybe_return_debug -> kvm_arm_handle_step_debug
>    - return bool, true if return to userspace is required
> ---
>   arch/arm/include/asm/kvm_host.h   |  2 ++
>   arch/arm64/include/asm/kvm_host.h |  1 +
>   arch/arm64/kvm/debug.c            | 22 ++++++++++++++++++++++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 4a879f6ff13b..a2e881d6108e 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -285,6 +285,8 @@ static inline void kvm_arm_init_debug(void) {}
>   static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
>   static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
>   static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
> +static inline bool kvm_arm_handle_step_debug(struct kvm_vcpu *vcpu,
> +					     struct kvm_run *run) {}
>   
>   int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
>   			       struct kvm_device_attr *attr);
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e923b58606e2..bbfd6a2adb2b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -369,6 +369,7 @@ void kvm_arm_init_debug(void);
>   void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
>   void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
>   void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
> +bool kvm_arm_handle_step_debug(struct kvm_vcpu *vcpu, struct kvm_run *run);
>   int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
>   			       struct kvm_device_attr *attr);
>   int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index dbadfaf850a7..95afd22a4634 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -221,3 +221,25 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
>   		}
>   	}
>   }
> +
> +
> +/*
> + * When KVM has successfully emulated the instruction we might want to
> + * return to user space with a KVM_EXIT_DEBUG. We can only do this
> + * once the emulation is complete though so for userspace emulations
> + * we have to wait until we have re-entered KVM before calling this
> + * helper.
> + *
> + * Return true (and set exit_reason) to return to userspace or false
> + * if no further action required.
> + */
> +
> +bool kvm_arm_handle_step_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +{
> +	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
> +		run->exit_reason = KVM_EXIT_DEBUG;
> +		run->debug.arch.hsr = ESR_ELx_EC_SOFTSTP_LOW << ESR_ELx_EC_SHIFT;
> +		return true;
> +	}
> +	return false;
> +}
> 

-- 
Julien Thierry
