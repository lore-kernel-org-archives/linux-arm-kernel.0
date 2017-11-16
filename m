From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 16 Nov 2017 17:44:02 +0000
Subject: [PATCH v3 3/3] kvm: arm64: handle single-step of userspace mmio
 instructions
In-Reply-To: <20171116153921.21991-4-alex.bennee@linaro.org>
References: <20171116153921.21991-1-alex.bennee@linaro.org>
 <20171116153921.21991-4-alex.bennee@linaro.org>
Message-ID: <91f89786-5fb9-ce5d-a7c2-2addb1ab4983@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/11/17 15:39, Alex Benn?e wrote:
> The system state of KVM when using userspace emulation is not complete
> until we return into KVM_RUN. To handle mmio related updates we wait
> until they have been committed and then schedule our KVM_EXIT_DEBUG.
> 
> The kvm_arm_handle_step_debug() helper tells us if we need to return
> and sets up the exit_reason for us.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> ---
> v2
>    - call helper directly from kvm_arch_vcpu_ioctl_run
> v3
>    - return 0 (ioctl success) instead of 1
> ---
>   virt/kvm/arm/arm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 95cba0799828..b40440defca1 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -625,6 +625,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>   		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
>   		if (ret)
>   			return ret;
> +		if (kvm_arm_handle_step_debug(vcpu, vcpu->run))
> +			return 0;
> +
>   	}
>   
>   	if (run->immediate_exit)
> 

-- 
Julien Thierry
