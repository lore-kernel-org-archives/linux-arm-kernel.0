From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Nov 2018 16:04:03 +0000
Subject: [PATCH v2 2/4] arm64: KVM: add accessors to track guest/host only
 counters
In-Reply-To: <1542723322-42536-3-git-send-email-andrew.murray@arm.com>
References: <1542723322-42536-1-git-send-email-andrew.murray@arm.com>
 <1542723322-42536-3-git-send-email-andrew.murray@arm.com>
Message-ID: <da549a51-9b85-f94c-07d6-91140c542ec7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2018 14:15, Andrew Murray wrote:
> In order to effeciently enable/disable guest/host only perf counters
> at guest entry/exit we add bitfields to kvm_cpu_context for guest and
> host only events as well as accessors for updating them.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1550192..b6f998b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -203,6 +203,8 @@ struct kvm_cpu_context {
>  	};
>  
>  	struct kvm_vcpu *__hyp_running_vcpu;
> +	u32 events_host_only;
> +	u32 events_guest_only;
>  };
>  
>  typedef struct kvm_cpu_context kvm_cpu_context_t;
> @@ -472,6 +474,24 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_arch_vcpu_run_map_fp(vcpu);
>  }
> +static inline void kvm_set_clr_host_pmu_events(u32 clr, u32 set)

nit: keep the arguments in an order that match the function name (saves
a lot of brain power...)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
