From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 07 Jan 2015 17:51:15 -0800
Subject: [PATCH v15 10/11] KVM: arm/arm64: Enable Dirty Page logging for
 ARMv8
In-Reply-To: <20150107124744.GC21092@cbox>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418628488-3696-11-git-send-email-m.smarduch@samsung.com>
 <20150107124744.GC21092@cbox>
Message-ID: <54ADE293.1040901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2015 04:47 AM, Christoffer Dall wrote:
> On Sun, Dec 14, 2014 at 11:28:07PM -0800, Mario Smarduch wrote:
>> This patch enables ARMv8 ditry page logging support. Plugs ARMv8 into generic
> 
>                            dirty
yeah.
> 
>> layer through Kconfig symbol, and drops earlier ARM64 constraints to enable
>> logging at architecture layer.
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h | 12 ------------
>>  arch/arm/kvm/arm.c              |  4 ----
>>  arch/arm/kvm/mmu.c              | 19 +++++++++++--------
>>  arch/arm64/kvm/Kconfig          |  2 ++
>>  4 files changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index b138431..088ea87 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -223,18 +223,6 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>>  	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
>>  }
>>  
>> -/**
>> - * kvm_flush_remote_tlbs() - flush all VM TLB entries
>> - * @kvm:	pointer to kvm structure.
>> - *
>> - * Interface to HYP function to flush all VM TLB entries without address
>> - * parameter.
>> - */
>> -static inline void kvm_flush_remote_tlbs(struct kvm *kvm)
>> -{
>> -	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
>> -}
>> -
>>  static inline int kvm_arch_dev_ioctl_check_extension(long ext)
>>  {
>>  	return 0;
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 6e4290c..1b6577c 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -740,7 +740,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>   */
>>  int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>  {
>> -#ifdef CONFIG_ARM
>>  	bool is_dirty = false;
>>  	int r;
>>  
>> @@ -753,9 +752,6 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>  
>>  	mutex_unlock(&kvm->slots_lock);
>>  	return r;
>> -#else /* arm64 */
>> -	return -EINVAL;
>> -#endif
>>  }
>>  
>>  static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index dc763bb..59003df 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -52,11 +52,18 @@ static phys_addr_t hyp_idmap_vector;
>>  
>>  static bool kvm_get_logging_state(struct kvm_memory_slot *memslot)
>>  {
>> -#ifdef CONFIG_ARM
>>  	return !!memslot->dirty_bitmap;
>> -#else
>> -	return false;
>> -#endif
>> +}
>> +
>> +/**
>> + * kvm_flush_remote_tlbs() - flush all VM TLB entries for v7/8
>> + * @kvm:	pointer to kvm structure.
>> + *
>> + * Interface to HYP function to flush all VM TLB entries
>> + */
>> +inline void kvm_flush_remote_tlbs(struct kvm *kvm)
> 
> did you intend for a non-staic inline here?

Yes it's used in arm.c and mmu.c
> 
>> +{
>> +	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
>>  }
>>  
>>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>> @@ -895,7 +902,6 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>>  	return !pfn_valid(pfn);
>>  }
>>  
>> -#ifdef CONFIG_ARM
>>  /**
>>   * stage2_wp_ptes - write protect PMD range
>>   * @pmd:	pointer to pmd entry
>> @@ -1040,7 +1046,6 @@ void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
>>  
>>  	stage2_wp_range(kvm, start, end);
>>  }
>> -#endif
>>  
>>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  			  struct kvm_memory_slot *memslot, unsigned long hva,
>> @@ -1445,7 +1450,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>  				   const struct kvm_memory_slot *old,
>>  				   enum kvm_mr_change change)
>>  {
>> -#ifdef CONFIG_ARM
>>  	/*
>>  	 * At this point memslot has been committed and there is an
>>  	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
>> @@ -1453,7 +1457,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>  	 */
>>  	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES)
>>  		kvm_mmu_wp_memory_region(kvm, mem->slot);
>> -#endif
>>  }
>>  
>>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>> index 8ba85e9..3ce389b 100644
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -22,10 +22,12 @@ config KVM
>>  	select PREEMPT_NOTIFIERS
>>  	select ANON_INODES
>>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>> +	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
>>  	select KVM_MMIO
>>  	select KVM_ARM_HOST
>>  	select KVM_ARM_VGIC
>>  	select KVM_ARM_TIMER
>> +	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>>  	---help---
>>  	  Support hosting virtualized guest machines.
>>  
>> -- 
>> 1.9.1
>>
