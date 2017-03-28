From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 28 Mar 2017 17:53:38 +0800
Subject: [PATCH V13 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <1490136425-4324-11-git-send-email-tbaicar@codeaurora.org>
References: <1490136425-4324-1-git-send-email-tbaicar@codeaurora.org>
 <1490136425-4324-11-git-send-email-tbaicar@codeaurora.org>
Message-ID: <5c7f6092-9358-08ac-5341-2364637c2008@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017/3/22 6:47, Tyler Baicar wrote:
> +	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
> +
> +	/* The host kernel will handle the synchronous external abort. There
> +	 * is no need to pass the error into the guest.
> +	 */
> +	if (is_abort_synchronous(fault_status))
> +		sea_status = handle_guest_sea((unsigned long)fault_ipa,
> +				    kvm_vcpu_get_hsr(vcpu));
>  
>  	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
> -	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu))) {
> +	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu)) && sea_status) {
>  		kvm_inject_vabt(vcpu);
>  		return 1;
>  	}
       After the host kernel correctly handle the synchronous external abort, the sea_status
       will return 0, so the code logical will be continue go-no, whether it is better directly return
       after correctly handle the SEA? such as below.

	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu)) && sea_status) {
  		kvm_inject_vabt(vcpu);
  		return 1;
  	} else
                return 1;

>  
> -	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
> -
>  	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
>  			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
>  
> -	/* Check the stage-2 fault is trans. fault or write fault */
> -	fault_status = kvm_vcpu_trap_get_fault_type(vcpu);
>  	if (fault_status != FSC_FAULT && fault_status != FSC_PERM &&
