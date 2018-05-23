From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 May 2018 18:11:44 +0100
Subject: [PATCH v4 2/3] arm64: KVM: Enable Common Not Private translations
In-Reply-To: <1526638022-4137-3-git-send-email-vladimir.murzin@arm.com>
References: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
 <1526638022-4137-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20180523171144.wiijmioqn4zl3ccx@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 11:07:01AM +0100, Vladimir Murzin wrote:
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a4c1b76..9a651a2 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -472,7 +472,7 @@ static bool need_new_vmid_gen(struct kvm *kvm)
>  static void update_vttbr(struct kvm *kvm)
>  {
>  	phys_addr_t pgd_phys;
> -	u64 vmid;
> +	u64 vmid, cnp = kvm_cpu_has_cnp() ? 1 : 0;

Please define a VTTBR_CNP_BIT here instead of a hard-coded value.

>  	bool new_gen;
>  
>  	read_lock(&kvm_vmid_lock);
> @@ -522,7 +522,7 @@ static void update_vttbr(struct kvm *kvm)
>  	pgd_phys = virt_to_phys(kvm->arch.pgd);
>  	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
>  	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
> -	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid;
> +	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
>  
>  	write_unlock(&kvm_vmid_lock);
>  }

-- 
Catalin
