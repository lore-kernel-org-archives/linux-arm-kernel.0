From: agraf@suse.de (Alexander Graf)
Date: Wed, 15 Oct 2014 13:17:25 +0200
Subject: [PATCH v11 1/6] KVM: Add architecture-specific TLB flush
 implementations
In-Reply-To: <1411433690-8104-2-git-send-email-m.smarduch@samsung.com>
References: <1411433690-8104-1-git-send-email-m.smarduch@samsung.com>
 <1411433690-8104-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <543E57C5.5070205@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23.09.14 02:54, Mario Smarduch wrote:
> Add support to declare architecture specific TLB flush function, for now ARMv7.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  include/linux/kvm_host.h |    1 +
>  virt/kvm/Kconfig         |    3 +++
>  virt/kvm/kvm_main.c      |    4 ++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ec4e3bd..a49a6df 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -592,6 +592,7 @@ void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
>  void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
>  
>  void kvm_flush_remote_tlbs(struct kvm *kvm);
> +void kvm_arch_flush_remote_tlbs(struct kvm *kvm);
>  void kvm_reload_remote_mmus(struct kvm *kvm);
>  void kvm_make_mclock_inprogress_request(struct kvm *kvm);
>  void kvm_make_scan_ioapic_request(struct kvm *kvm);
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 13f2d19..f1efaa5 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -34,3 +34,6 @@ config HAVE_KVM_CPU_RELAX_INTERCEPT
>  
>  config KVM_VFIO
>         bool
> +
> +config HAVE_KVM_ARCH_TLB_FLUSH_ALL
> +       bool
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4b6c01b..d0a24f5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -186,12 +186,16 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
>  
>  void kvm_flush_remote_tlbs(struct kvm *kvm)
>  {
> +#ifdef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL

Please make this an #ifndef on the outer definition and just define your
own copy of this function inside of arch/arm/kvm :).


Alex

> +	kvm_arch_flush_remote_tlbs(kvm);
> +#else
>  	long dirty_count = kvm->tlbs_dirty;
>  
>  	smp_mb();
>  	if (make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
>  		++kvm->stat.remote_tlb_flush;
>  	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
>  
> 
