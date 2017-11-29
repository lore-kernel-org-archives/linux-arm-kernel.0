From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 29 Nov 2017 14:22:12 +0100
Subject: [PATCH] KVM: arm64: handle the translation table walk RAS error
In-Reply-To: <1511988524-30240-1-git-send-email-gengdongjiu@huawei.com>
References: <1511988524-30240-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <20171129132212.GA10563@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:48:44AM +0800, Dongjiu Geng wrote:
> For the RAS Synchronous External Abort, there are two types.
> One is memory access, it will be handled by host APEI driver.
> Another is translation table walk, in essence, it is hardware
> memory error on stage1 or stage2 page table.
> 
> For the guest stage1 translation table error, if host APEI
> driver handles it, APEI driver will unmap this page for the
> stage1 page table, then switch to guest, guest reused this
> page table and generate stage2 data abort, KVM deliver SIGBUS
> to user space. User space inject this error to guest, when
> guest handle this abort, it may also use this stage1 page
> table, but it already unmap by host APEI driver, then
> generate stage2 data abort again, so this will lead to dead
> loop.

Why does it lead to a loop? If the host has marked a page as unusable,
shouldn't the guest stage 1 page table be backed by a different page
when the fault happens on stage 2?

> 
> For the guest stage2 translation table error, if host APEI
> driver handles it, it will do nothing.
> 
> So for above reasons, we directly inject this Synchronous
> External Abort to guest and let guest handle it, for example,
> kill the guest application or panic guest OS.

I don't see why we need to distinguish between what caused a memory
access error, a direct access or a page table walk, in terms of how the
host/guest interaction works here.

What is the fundamental difference?

Thanks,
-Christoffer

> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |  2 ++
>  virt/kvm/arm/mmu.c               | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 1188272..b8cb67a 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -217,6 +217,8 @@
>  #define FSC_SECC_TTW2	(0x1e)
>  #define FSC_SECC_TTW3	(0x1f)
>  
> +#define FSC_SEA_TTW    FSC_SEA_TTW0
> +
>  /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
>  #define HPFAR_MASK	(~UL(0xf))
>  
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index b36945d..6eab82d 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1484,8 +1484,18 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	/* Synchronous External Abort? */
>  	if (kvm_vcpu_dabt_isextabt(vcpu)) {
>  		/*
> -		 * For RAS the host kernel may handle this abort.
> -		 * There is no need to pass the error into the guest.
> +		 * For RAS translation table walk abort, pass the error
> +		 * into the guest.
> +		 */
> +		if (fault_status == FSC_SEA_TTW) {
> +			kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> +			return 1;
> +		}
> +
> +		/*
> +		 * For RAS normal memory access abort, the host kernel may
> +		 * handle this abort. There is no need to pass the error into
> +		 * the guest.
>  		 */
>  		if (!handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
>  			return 1;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
