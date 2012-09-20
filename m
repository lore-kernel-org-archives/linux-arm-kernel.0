From: mingyu84.kim@samsung.com (Min-gyu Kim)
Date: Thu, 20 Sep 2012 21:53:33 +0900
Subject: [PATCH 01/10] ARM: KVM: Keep track of currently running vcpus
In-Reply-To: <20120915153657.21545.3972.stgit@ubuntu>
References: <20120915153657.21545.3972.stgit@ubuntu>
Message-ID: <001401cd972e$f18cd1c0$d4a67540$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On
> Behalf Of Christoffer Dall
> Sent: Sunday, September 16, 2012 12:37 AM
> To: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> kvmarm at lists.cs.columbia.edu
> Subject: [PATCH 01/10] ARM: KVM: Keep track of currently running vcpus
> 
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> When an interrupt occurs for the guest, it is sometimes necessary to find
> out which vcpu was running at that point.
> 
> Keep track of which vcpu is being tun in kvm_arch_vcpu_ioctl_run(), and
> allow the data to be retrived using either:
> - kvm_arm_get_running_vcpu(): returns the vcpu running at this point
>   on the current CPU. Can only be used in a non-preemptable context.

What's the purpose of kvm_arm_get_running_vcpu?
It seems to be enough to pass vcpu struct through function argument, 
and there is no caller by now.


> - kvm_arm_get_running_vcpus(): returns the per-CPU variable holding
>   the the running vcpus, useable for per-CPU interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/kvm_host.h |    9 +++++++++
>  arch/arm/kvm/arm.c              |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h
> b/arch/arm/include/asm/kvm_host.h index 3fec9ad..2e3ac1c 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -208,4 +208,13 @@ static inline int kvm_test_age_hva(struct kvm *kvm,
> unsigned long hva)  {
>  	return 0;
>  }
> +
> +struct kvm_vcpu *kvm_arm_get_running_vcpu(void); struct kvm_vcpu
> +__percpu **kvm_get_running_vcpus(void);
> +
> +int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user
> +*uindices); unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu
> +*vcpu); struct kvm_one_reg; int kvm_arm_coproc_get_reg(struct kvm_vcpu
> +*vcpu, const struct kvm_one_reg *); int kvm_arm_coproc_set_reg(struct
> +kvm_vcpu *vcpu, const struct kvm_one_reg *);
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c index
> 64fbec7..e6c3743 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -54,11 +54,38 @@ static DEFINE_PER_CPU(unsigned long,
> kvm_arm_hyp_stack_page);  static struct vfp_hard_struct __percpu
> *kvm_host_vfp_state;  static unsigned long hyp_default_vectors;
> 
> +/* Per-CPU variable containing the currently running vcpu. */ static
> +DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_vcpu);
> +
>  /* The VMID used in the VTTBR */
>  static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);  static u8
> kvm_next_vmid;  static DEFINE_SPINLOCK(kvm_vmid_lock);
> 
> +static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu) {
> +	BUG_ON(preemptible());
> +	__get_cpu_var(kvm_arm_running_vcpu) = vcpu; }
> +
> +/**
> + * kvm_arm_get_running_vcpu - get the vcpu running on the current CPU.
> + * Must be called from non-preemptible context  */ struct kvm_vcpu
> +*kvm_arm_get_running_vcpu(void) {
> +	BUG_ON(preemptible());
> +	return __get_cpu_var(kvm_arm_running_vcpu);
> +}
> +
> +/**
> + * kvm_arm_get_running_vcpus - get the per-CPU array on currently running
> vcpus.
> + */
> +struct kvm_vcpu __percpu **kvm_get_running_vcpus(void) {
> +	return &kvm_arm_running_vcpu;
> +}
> +
>  int kvm_arch_hardware_enable(void *garbage)  {
>  	return 0;
> @@ -293,10 +320,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int
> cpu)
>  		cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
>  		flush_cache_all(); /* We'd really want v7_flush_dcache_all()
> */
>  	}
> +
> +	kvm_arm_set_running_vcpu(vcpu);
>  }
> 
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)  {
> +	kvm_arm_set_running_vcpu(NULL);
>  }
> 
>  int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
