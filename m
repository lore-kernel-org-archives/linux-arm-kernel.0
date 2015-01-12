From: wei@redhat.com (Wei Huang)
Date: Mon, 12 Jan 2015 12:08:16 -0600
Subject: [PATCH v2] ARM: KVM: extend WFI tracepoint to differentiate
 between wfi and wfe
In-Reply-To: <1421081776-2350-1-git-send-email-andre.przywara@arm.com>
References: <1421081776-2350-1-git-send-email-andre.przywara@arm.com>
Message-ID: <54B40D90.3080203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/12/2015 10:56 AM, Andre Przywara wrote:
> Currently the trace printk talks about "wfi" only, though the trace
> point triggers both on wfi and wfe traps.
> Add a parameter to differentiate between the two.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Given that this patch is related to arm64 counter-part:

Reviewed-by: Wei Huang <wei@redhat.com>

-Wei

> ---
> Hi,
> 
> this replaces the patch I sent earlier and now just contains the ARM
> parts of it. The arm64 part is now merged into Wei's patch (which
> isn't a prerequisite for this one anymore).
> 
> Cheers,
> Andre.
> 
>  arch/arm/kvm/handle_exit.c |    8 +++++---
>  arch/arm/kvm/trace.h       |   11 +++++++----
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
> index a96a804..95f12b2 100644
> --- a/arch/arm/kvm/handle_exit.c
> +++ b/arch/arm/kvm/handle_exit.c
> @@ -87,11 +87,13 @@ static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
>   */
>  static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	trace_kvm_wfi(*vcpu_pc(vcpu));
> -	if (kvm_vcpu_get_hsr(vcpu) & HSR_WFI_IS_WFE)
> +	if (kvm_vcpu_get_hsr(vcpu) & HSR_WFI_IS_WFE) {
> +		trace_kvm_wfx(*vcpu_pc(vcpu), true);
>  		kvm_vcpu_on_spin(vcpu);
> -	else
> +	} else {
> +		trace_kvm_wfx(*vcpu_pc(vcpu), false);
>  		kvm_vcpu_block(vcpu);
> +	}
>  
>  	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>  
> diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
> index b1d640f..f741449 100644
> --- a/arch/arm/kvm/trace.h
> +++ b/arch/arm/kvm/trace.h
> @@ -140,19 +140,22 @@ TRACE_EVENT(kvm_emulate_cp15_imp,
>  			__entry->CRm, __entry->Op2)
>  );
>  
> -TRACE_EVENT(kvm_wfi,
> -	TP_PROTO(unsigned long vcpu_pc),
> -	TP_ARGS(vcpu_pc),
> +TRACE_EVENT(kvm_wfx,
> +	TP_PROTO(unsigned long vcpu_pc, bool is_wfe),
> +	TP_ARGS(vcpu_pc, is_wfe),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	vcpu_pc		)
> +		__field(		 bool,	is_wfe		)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->vcpu_pc		= vcpu_pc;
> +		__entry->is_wfe			= is_wfe;
>  	),
>  
> -	TP_printk("guest executed wfi at: 0x%08lx", __entry->vcpu_pc)
> +	TP_printk("guest executed wf%c at: 0x%08lx",
> +		__entry->is_wfe ? 'e' : 'i', __entry->vcpu_pc)
>  );
>  
>  TRACE_EVENT(kvm_unmap_hva,
> 
