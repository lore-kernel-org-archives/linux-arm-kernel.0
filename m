From: wei@redhat.com (Wei Huang)
Date: Fri, 16 Oct 2015 10:28:36 -0500
Subject: [PATCH v3 18/20] KVM: ARM64: Reset PMU state when resetting vcpu
In-Reply-To: <1443133885-3366-19-git-send-email-shannon.zhao@linaro.org>
References: <1443133885-3366-1-git-send-email-shannon.zhao@linaro.org>
 <1443133885-3366-19-git-send-email-shannon.zhao@linaro.org>
Message-ID: <562117A4.5010400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/24/2015 05:31 PM, Shannon Zhao wrote:
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Missing commit message here.

> ---
>  arch/arm64/kvm/reset.c |  3 +++
>  include/kvm/arm_pmu.h  |  2 ++
>  virt/kvm/arm/pmu.c     | 18 ++++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 91cf535..4da7f6c 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -120,6 +120,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	/* Reset system registers */
>  	kvm_reset_sys_regs(vcpu);
>  
> +	/* Reset PMU */
> +	kvm_pmu_vcpu_reset(vcpu);
> +
>  	/* Reset timer */
>  	return kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
>  }
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 953c400..8dacfd3 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -38,6 +38,7 @@ struct kvm_pmu {
>  };
>  
>  #ifdef CONFIG_KVM_ARM_PMU
> +void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
>  void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
>  unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u32 select_idx);
>  void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u32 val);
> @@ -46,6 +47,7 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u32 val);
>  void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u32 data,
>  				    u32 select_idx);
>  #else
> +void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
>  void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
>  unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u32 select_idx)
>  {
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index ca7e849..faa2b76 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -63,6 +63,24 @@ static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, u32 select_idx)
>  }
>  
>  /**
> + * kvm_pmu_vcpu_reset - reset pmu state for cpu
> + * @vcpu: The vcpu pointer
> + *
> + */
> +void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
> +{
> +	int i;
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +
> +	for (i = 0; i < ARMV8_MAX_COUNTERS; i++) {
> +		kvm_pmu_stop_counter(vcpu, i);
> +		pmu->pmc[i].idx = i;
> +		pmu->pmc[i].vcpu = vcpu;
> +	}
> +	pmu->irq_pending = false;
> +}
> +
> +/**
>   * kvm_pmu_sync_hwstate - sync pmu state for cpu
>   * @vcpu: The vcpu pointer
>   *
> 
