From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 12:24:04 +0200
Subject: [RFC v2 PATCH 7/7] arm64: KVM: Enable selective trapping of TLB
 instructions
In-Reply-To: <1473093097-30932-8-git-send-email-punit.agrawal@arm.com>
References: <1473093097-30932-1-git-send-email-punit.agrawal@arm.com>
 <1473093097-30932-8-git-send-email-punit.agrawal@arm.com>
Message-ID: <20160906102404.GF30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 05:31:37PM +0100, Punit Agrawal wrote:
> The TTLB bit of Hypervisor Control Register (HCR_EL2) controls the
> trapping of guest TLB maintenance instructions. Taking the trap requires
> a switch to the hypervisor and is an expensive operation.
> 
> Enable selective trapping of guest TLB instructions when the associated
> perf trace event is enabled for a specific virtual machine.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/perf_trace.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/kvm/perf_trace.c b/arch/arm64/kvm/perf_trace.c
> index 8bacd18..f26da1d 100644
> --- a/arch/arm64/kvm/perf_trace.c
> +++ b/arch/arm64/kvm/perf_trace.c
> @@ -17,6 +17,8 @@
>  #include <linux/kvm_host.h>
>  #include <linux/trace_events.h>
>  
> +#include <asm/kvm_emulate.h>
> +
>  typedef int (*perf_trace_callback_fn)(struct kvm *kvm, bool enable);
>  
>  struct kvm_trace_hook {
> @@ -24,7 +26,37 @@ struct kvm_trace_hook {
>  	perf_trace_callback_fn setup_fn;
>  };
>  
> +static int tlb_invalidate_trap(struct kvm *kvm, bool enable)
> +{
> +	int i;
> +	struct kvm_vcpu *vcpu;
> +
> +	/*
> +	 * Halt the VM to ensure atomic update across all vcpus (this
> +	 * avoids racy behaviour against other modifications of
> +	 * HCR_EL2 such as kvm_toggle_cache/kvm_set_way_flush).
> +	 */
> +	kvm_arm_halt_guest(kvm);
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		unsigned long hcr = vcpu_get_hcr(vcpu);
> +
> +		if (enable)
> +			hcr |= HCR_TTLB;
> +		else
> +			hcr &= ~HCR_TTLB;
> +
> +		vcpu_set_hcr(vcpu, hcr);
> +	}
> +	kvm_arm_resume_guest(kvm);
> +
> +	return 0;
> +}
> +
>  static struct kvm_trace_hook trace_hook[] = {
> +	{
> +		.key = "kvm_tlb_invalidate",

is this key defined elsewhere?  If not, I think the name is ambiguous,
because it's unclear if this means 'kvm the subsystem' or 'a kvm guest',
by looking purely at the string.

> +		.setup_fn = tlb_invalidate_trap,
> +	},
>  	{ },
>  };
>  
> -- 
> 2.8.1
> 

Otherwise looks ok to me.

-Christoffer
