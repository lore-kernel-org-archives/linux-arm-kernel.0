From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 15 Nov 2018 14:00:39 +0000
Subject: [PATCH 4/4] arm64: KVM: Enable support for :G/:H perf event
 modifiers
In-Reply-To: <1542286549-4501-5-git-send-email-andrew.murray@arm.com>
References: <1542286549-4501-1-git-send-email-andrew.murray@arm.com>
 <1542286549-4501-5-git-send-email-andrew.murray@arm.com>
Message-ID: <79000795-971d-22fa-6264-f85f2d528477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 15/11/18 12:55, Andrew Murray wrote:
> Enable/disable event counters as appropriate when entering and exiting
> the guest to enable support for guest or host only event counting.
> 
> For both VHE and non-VHE we switch the counters between host/guest at
> EL2. EL2 is filtered out by the PMU when we are using the :G modifier.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/arm64/kvm/hyp/switch.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index d496ef5..ebf0aac 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -373,6 +373,32 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
>   	return true;
>   }
>   
> +static bool __hyp_text __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +	u32 host_only = host_ctxt->events_host_only;
> +	u32 guest_only = host_ctxt->events_guest_only;
> +
> +	if (host_only)
> +		write_sysreg(host_only, pmcntenclr_el0);
> +
> +	if (guest_only)
> +		write_sysreg(guest_only, pmcntenset_el0);
> +
> +	return (host_only || guest_only);
> +}
> +
> +static void __hyp_text __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
> +{
> +	u32 host_only = host_ctxt->events_host_only;
> +	u32 guest_only = host_ctxt->events_guest_only;
> +
> +	if (guest_only)
> +		write_sysreg(guest_only, pmcntenclr_el0);
> +
> +	if (host_only)
> +		write_sysreg(host_only, pmcntenset_el0);

In the perf_event code, there is an ISB after enabling an event. I guess 
we don't need it when setting the guest events since I believe the eret 
to the guess give us the context synchronization. But don't we need one 
here when restoring host only events?

Thanks,

-- 
Julien Thierry
