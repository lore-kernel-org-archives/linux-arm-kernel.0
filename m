From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 11 Aug 2014 17:24:46 -0700
Subject: [PATCH v9 3/4] arm: dirty log write protect mgmt. Moved x86,
 armv7 to generic, set armv8 ia64 mips powerpc s390 arch specific
In-Reply-To: <20140811191307.GH10550@cbox>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-4-git-send-email-m.smarduch@samsung.com>
 <20140811191307.GH10550@cbox>
Message-ID: <53E95ECE.5030303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2014 12:13 PM, Christoffer Dall wrote:
> On Thu, Jul 24, 2014 at 05:56:07PM -0700, Mario Smarduch wrote:
>> This patch adds support for keeping track of VM dirty pages. As dirty page log
>> is retrieved, the pages that have been written are write protected again for
>> next write and log read.
>>
>> The dirty log read function is generic for armv7 and x86, and arch specific
>> for arm64, ia64, mips, powerpc, s390.
> 
> So I would also split up this patch.  One that only modifies the
> existing functionality, but does not introduce any new functionality for
> ARM.  Put this first patch in the beginning of the patch series with the
> other prepatory patch, so that you get something like this:
> 
> [PATCH 1/X] KVM: Add architecture-specific TLB flush implementations
> [PATCH 2/X] KVM: Add generic implementation of kvm_vm_ioctl_get_dirty_log
> [PATCH 3/X] arm: KVM: Add ARMv7 API to flush TLBs
> [PATCH 4/X] arm: KVM: Add initial dirty page locking infrastructure
> ...

Yes definitely, thanks for the advice makes the patch series easier to
review.

> 
> That will make it easier to get the patches accepted and for us to
> review...
> 
> 
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/kvm/arm.c                  |    8 +++-
>>  arch/arm/kvm/mmu.c                  |   22 +++++++++
>>  arch/arm64/include/asm/kvm_host.h   |    2 +
>>  arch/arm64/kvm/Kconfig              |    1 +
>>  arch/ia64/include/asm/kvm_host.h    |    1 +
>>  arch/ia64/kvm/Kconfig               |    1 +
>>  arch/ia64/kvm/kvm-ia64.c            |    2 +-
>>  arch/mips/include/asm/kvm_host.h    |    2 +-
>>  arch/mips/kvm/Kconfig               |    1 +
>>  arch/mips/kvm/kvm_mips.c            |    2 +-
>>  arch/powerpc/include/asm/kvm_host.h |    2 +
>>  arch/powerpc/kvm/Kconfig            |    1 +
>>  arch/powerpc/kvm/book3s.c           |    2 +-
>>  arch/powerpc/kvm/booke.c            |    2 +-
>>  arch/s390/include/asm/kvm_host.h    |    2 +
>>  arch/s390/kvm/Kconfig               |    1 +
>>  arch/s390/kvm/kvm-s390.c            |    2 +-
>>  arch/x86/kvm/x86.c                  |   86 ---------------------------------
>>  include/linux/kvm_host.h            |    3 ++
>>  virt/kvm/Kconfig                    |    3 ++
>>  virt/kvm/kvm_main.c                 |   90 +++++++++++++++++++++++++++++++++++
>>  21 files changed, 143 insertions(+), 93 deletions(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index e11c2dd..f7739a0 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -783,10 +783,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  	}
>>  }
>>  
>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>> +#ifdef CONFIG_ARM64
>> +/*
>> + * For now features not supported on ARM64, the #ifdef is added to make that
>> + * clear but not needed since ARM64 Kconfig selects function in generic code.
>> + */
> 
> I don't think this comment is needed, but if you really want it, it
> should be something like:
> 
> /*
>  * ARM64 does not support dirty logging and therefore selects
>  * CONFIG_HAVE_KVM_ARCH_DIRTY_LOG.  Provide a -EINVAL stub.
>  */

I think it could go since I'm doing arm64 now.

> 
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>  {
>>  	return -EINVAL;
>>  }
>> +#endif
>>  
>>  static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
>>  					struct kvm_arm_device_addr *dev_addr)
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 7bfc792..ca84331 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -889,6 +889,28 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
>>  	kvm_flush_remote_tlbs(kvm);
>>  	spin_unlock(&kvm->mmu_lock);
>>  }
>> +
>> +/**
>> + * kvm_mmu_write_protected_pt_masked() - write protect dirty pages set in mask
>> + * @kvm:	The KVM pointer
>> + * @slot:	The memory slot associated with mask
>> + * @gfn_offset:	The gfn offset in memory slot
>> + * @mask:	The mask of dirty pages at offset 'gfn_offset' in this memory
>> + *		slot to be write protected
>> + *
>> + * Walks bits set in mask write protects the associated pte's. Caller must
>> + * acquire kvm_mmu_lock.
>> + */
>> +void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
>> +		struct kvm_memory_slot *slot,
>> +		gfn_t gfn_offset, unsigned long mask)
>> +{
>> +	phys_addr_t base_gfn = slot->base_gfn + gfn_offset;
>> +	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
>> +	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
> 
> __fls(x) + 1 is the same as fls(x)

For me the __fls(x) + 1 is easier to see the covered range. Unless
it really breaks the convention I'd prefer to keep the '+1'. Either
way no problem.

>> +
>> +	stage2_wp_range(kvm, start, end);
>> +}
>>  #endif
>>  
>>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 92242ce..b4a280b 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -200,4 +200,6 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>>  		     hyp_stack_ptr, vector_ptr);
>>  }
>>  
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log);
>> +
>>  #endif /* __ARM64_KVM_HOST_H__ */
>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>> index 8ba85e9..9e21a8a 100644
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -22,6 +22,7 @@ config KVM
>>  	select PREEMPT_NOTIFIERS
>>  	select ANON_INODES
>>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>> +	select HAVE_KVM_ARCH_DIRTY_LOG
>>  	select KVM_MMIO
>>  	select KVM_ARM_HOST
>>  	select KVM_ARM_VGIC
>> diff --git a/arch/ia64/include/asm/kvm_host.h b/arch/ia64/include/asm/kvm_host.h
>> index db95f57..d79f520 100644
>> --- a/arch/ia64/include/asm/kvm_host.h
>> +++ b/arch/ia64/include/asm/kvm_host.h
>> @@ -594,6 +594,7 @@ void kvm_sal_emul(struct kvm_vcpu *vcpu);
>>  #define __KVM_HAVE_ARCH_VM_ALLOC 1
>>  struct kvm *kvm_arch_alloc_vm(void);
>>  void kvm_arch_free_vm(struct kvm *kvm);
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log);
>>  
>>  #endif /* __ASSEMBLY__*/
>>  
>> diff --git a/arch/ia64/kvm/Kconfig b/arch/ia64/kvm/Kconfig
>> index 990b864..32dd6c8 100644
>> --- a/arch/ia64/kvm/Kconfig
>> +++ b/arch/ia64/kvm/Kconfig
>> @@ -24,6 +24,7 @@ config KVM
>>  	depends on BROKEN
>>  	select PREEMPT_NOTIFIERS
>>  	select ANON_INODES
>> +	select HAVE_KVM_ARCH_DIRTY_LOG
>>  	select HAVE_KVM_IRQCHIP
>>  	select HAVE_KVM_IRQ_ROUTING
>>  	select KVM_APIC_ARCHITECTURE
>> diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
>> index 6a4309b..3166df5 100644
>> --- a/arch/ia64/kvm/kvm-ia64.c
>> +++ b/arch/ia64/kvm/kvm-ia64.c
>> @@ -1812,7 +1812,7 @@ static void kvm_ia64_sync_dirty_log(struct kvm *kvm,
>>  	spin_unlock(&kvm->arch.dirty_log_lock);
>>  }
>>  
>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm,
>>  		struct kvm_dirty_log *log)
>>  {
>>  	int r;
>> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
>> index 060aaa6..f7e2262 100644
>> --- a/arch/mips/include/asm/kvm_host.h
>> +++ b/arch/mips/include/asm/kvm_host.h
>> @@ -649,6 +649,6 @@ extern int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc,
>>  extern void mips32_SyncICache(unsigned long addr, unsigned long size);
>>  extern int kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
>>  extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
>> -
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log);
>>  
>>  #endif /* __MIPS_KVM_HOST_H__ */
>> diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
>> index 30e334e..b57f49e 100644
>> --- a/arch/mips/kvm/Kconfig
>> +++ b/arch/mips/kvm/Kconfig
>> @@ -20,6 +20,7 @@ config KVM
>>  	select PREEMPT_NOTIFIERS
>>  	select ANON_INODES
>>  	select KVM_MMIO
>> +	select HAVE_KVM_ARCH_DIRTY_LOG
>>  	---help---
>>  	  Support for hosting Guest kernels.
>>  	  Currently supported on MIPS32 processors.
>> diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
>> index da5186f..f9a1e62 100644
>> --- a/arch/mips/kvm/kvm_mips.c
>> +++ b/arch/mips/kvm/kvm_mips.c
>> @@ -790,7 +790,7 @@ out:
>>  /*
>>   * Get (and clear) the dirty memory log for a memory slot.
>>   */
>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>  {
>>  	struct kvm_memory_slot *memslot;
>>  	unsigned long ga, ga_end;
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 1eaea2d..fb31595 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -676,4 +676,6 @@ struct kvm_vcpu_arch {
>>  #define __KVM_HAVE_ARCH_WQP
>>  #define __KVM_HAVE_CREATE_DEVICE
>>  
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log);
>> +
>>  #endif /* __POWERPC_KVM_HOST_H__ */
>> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
>> index 141b202..c1fa061 100644
>> --- a/arch/powerpc/kvm/Kconfig
>> +++ b/arch/powerpc/kvm/Kconfig
>> @@ -22,6 +22,7 @@ config KVM
>>  	select PREEMPT_NOTIFIERS
>>  	select ANON_INODES
>>  	select HAVE_KVM_EVENTFD
>> +	select HAVE_KVM_ARCH_DIRTY_LOG
>>  
>>  config KVM_BOOK3S_HANDLER
>>  	bool
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index 94e597e..3835936 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -781,7 +781,7 @@ int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
>>  	return vcpu->kvm->arch.kvm_ops->check_requests(vcpu);
>>  }
>>  
>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>  {
>>  	return kvm->arch.kvm_ops->get_dirty_log(kvm, log);
>>  }
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index ab62109..50dd33d 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -1624,7 +1624,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>>  	return r;
>>  }
>>  
>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>  {
>>  	return -ENOTSUPP;
>>  }
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 0d45f6f..8afbe12 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -422,6 +422,7 @@ static inline bool kvm_is_error_hva(unsigned long addr)
>>  }
>>  
>>  #define ASYNC_PF_PER_VCPU	64
>> +struct kvm;
>>  struct kvm_vcpu;
>>  struct kvm_async_pf;
>>  struct kvm_arch_async_pf {
>> @@ -441,4 +442,5 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>>  
>>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>>  extern char sie_exit;
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log);
>>  #endif
>> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
>> index 10d529a..3ba07a7 100644
>> --- a/arch/s390/kvm/Kconfig
>> +++ b/arch/s390/kvm/Kconfig
>> @@ -21,6 +21,7 @@ config KVM
>>  	depends on HAVE_KVM
>>  	select PREEMPT_NOTIFIERS
>>  	select ANON_INODES
>> +	select HAVE_KVM_ARCH_DIRTY_LOG
>>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>>  	select HAVE_KVM_EVENTFD
>>  	select KVM_ASYNC_PF
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index b32c42c..95164e7 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -207,7 +207,7 @@ static void kvm_s390_sync_dirty_log(struct kvm *kvm,
>>  /*
>>   * Get (and clear) the dirty memory log for a memory slot.
>>   */
>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
>> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm,
>>  			       struct kvm_dirty_log *log)
>>  {
>>  	int r;
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index c5582c3..a603ca3 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -3569,92 +3569,6 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
>>  	return 0;
>>  }
>>  
>> -/**
>> - * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
>> - * @kvm: kvm instance
>> - * @log: slot id and address to which we copy the log
>> - *
>> - * We need to keep it in mind that VCPU threads can write to the bitmap
>> - * concurrently.  So, to avoid losing data, we keep the following order for
>> - * each bit:
>> - *
>> - *   1. Take a snapshot of the bit and clear it if needed.
>> - *   2. Write protect the corresponding page.
>> - *   3. Flush TLB's if needed.
>> - *   4. Copy the snapshot to the userspace.
>> - *
>> - * Between 2 and 3, the guest may write to the page using the remaining TLB
>> - * entry.  This is not a problem because the page will be reported dirty at
>> - * step 4 using the snapshot taken before and step 3 ensures that successive
>> - * writes will be logged for the next call.
>> - */
>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>> -{
>> -	int r;
>> -	struct kvm_memory_slot *memslot;
>> -	unsigned long n, i;
>> -	unsigned long *dirty_bitmap;
>> -	unsigned long *dirty_bitmap_buffer;
>> -	bool is_dirty = false;
>> -
>> -	mutex_lock(&kvm->slots_lock);
>> -
>> -	r = -EINVAL;
>> -	if (log->slot >= KVM_USER_MEM_SLOTS)
>> -		goto out;
>> -
>> -	memslot = id_to_memslot(kvm->memslots, log->slot);
>> -
>> -	dirty_bitmap = memslot->dirty_bitmap;
>> -	r = -ENOENT;
>> -	if (!dirty_bitmap)
>> -		goto out;
>> -
>> -	n = kvm_dirty_bitmap_bytes(memslot);
>> -
>> -	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
>> -	memset(dirty_bitmap_buffer, 0, n);
>> -
>> -	spin_lock(&kvm->mmu_lock);
>> -
>> -	for (i = 0; i < n / sizeof(long); i++) {
>> -		unsigned long mask;
>> -		gfn_t offset;
>> -
>> -		if (!dirty_bitmap[i])
>> -			continue;
>> -
>> -		is_dirty = true;
>> -
>> -		mask = xchg(&dirty_bitmap[i], 0);
>> -		dirty_bitmap_buffer[i] = mask;
>> -
>> -		offset = i * BITS_PER_LONG;
>> -		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
>> -	}
>> -
>> -	spin_unlock(&kvm->mmu_lock);
>> -
>> -	/* See the comments in kvm_mmu_slot_remove_write_access(). */
>> -	lockdep_assert_held(&kvm->slots_lock);
>> -
>> -	/*
>> -	 * All the TLBs can be flushed out of mmu lock, see the comments in
>> -	 * kvm_mmu_slot_remove_write_access().
>> -	 */
>> -	if (is_dirty)
>> -		kvm_flush_remote_tlbs(kvm);
>> -
>> -	r = -EFAULT;
>> -	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
>> -		goto out;
>> -
>> -	r = 0;
>> -out:
>> -	mutex_unlock(&kvm->slots_lock);
>> -	return r;
>> -}
>> -
>>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
>>  			bool line_status)
>>  {
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 820fc2e..2f3822b 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -606,6 +606,9 @@ int kvm_get_dirty_log(struct kvm *kvm,
>>  int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
>>  				struct kvm_dirty_log *log);
>>  
>> +void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
>> +	struct kvm_memory_slot *slot, gfn_t gfn_offset, unsigned long mask);
>> +
>>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
>>  			bool line_status);
>>  long kvm_arch_vm_ioctl(struct file *filp,
>> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
>> index f1efaa5..975733f 100644
>> --- a/virt/kvm/Kconfig
>> +++ b/virt/kvm/Kconfig
>> @@ -37,3 +37,6 @@ config KVM_VFIO
>>  
>>  config HAVE_KVM_ARCH_TLB_FLUSH_ALL
>>         bool
>> +
>> +config HAVE_KVM_ARCH_DIRTY_LOG
>> +       bool
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 258f3d9..51b90ca 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -442,6 +442,96 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>>  
>>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>>  
>> +/**
>> + * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
>> + * @kvm: kvm instance
>> + * @log: slot id and address to which we copy the log
>> + *
>> + * We need to keep it in mind that VCPU threads can write to the bitmap
>> + * concurrently.  So, to avoid losing data, we keep the following order for
>> + * each bit:
>> + *
>> + *   1. Take a snapshot of the bit and clear it if needed.
>> + *   2. Write protect the corresponding page.
>> + *   3. Flush TLB's if needed.
>> + *   4. Copy the snapshot to the userspace.
>> + *
>> + * Between 2 and 3, the guest may write to the page using the remaining TLB
>> + * entry.  This is not a problem because the page will be reported dirty at
>> + * step 4 using the snapshot taken before and step 3 ensures that successive
>> + * writes will be logged for the next call.
>> + */
>> +int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>> +{
>> +#ifdef CONFIG_HAVE_KVM_ARCH_DIRTY_LOG
>> +	return kvm_arch_vm_ioctl_get_dirty_log(kvm, log);
>> +#else
>> +	int r;
>> +	struct kvm_memory_slot *memslot;
>> +	unsigned long n, i;
>> +	unsigned long *dirty_bitmap;
>> +	unsigned long *dirty_bitmap_buffer;
>> +	bool is_dirty = false;
>> +
>> +	mutex_lock(&kvm->slots_lock);
>> +
>> +	r = -EINVAL;
>> +	if (log->slot >= KVM_USER_MEM_SLOTS)
>> +		goto out;
>> +
>> +	memslot = id_to_memslot(kvm->memslots, log->slot);
>> +
>> +	dirty_bitmap = memslot->dirty_bitmap;
>> +	r = -ENOENT;
>> +	if (!dirty_bitmap)
>> +		goto out;
>> +
>> +	n = kvm_dirty_bitmap_bytes(memslot);
>> +
>> +	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
>> +	memset(dirty_bitmap_buffer, 0, n);
>> +
>> +	spin_lock(&kvm->mmu_lock);
>> +
>> +	for (i = 0; i < n / sizeof(long); i++) {
>> +		unsigned long mask;
>> +		gfn_t offset;
>> +
>> +		if (!dirty_bitmap[i])
>> +			continue;
>> +
>> +		is_dirty = true;
>> +
>> +		mask = xchg(&dirty_bitmap[i], 0);
>> +		dirty_bitmap_buffer[i] = mask;
>> +
>> +		offset = i * BITS_PER_LONG;
>> +		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
>> +	}
>> +
>> +	spin_unlock(&kvm->mmu_lock);
>> +
>> +	/* See the comments in kvm_mmu_slot_remove_write_access(). */
>> +	lockdep_assert_held(&kvm->slots_lock);
>> +
>> +	/*
>> +	 * All the TLBs can be flushed out of mmu lock, see the comments in
>> +	 * kvm_mmu_slot_remove_write_access().
>> +	 */
>> +	if (is_dirty)
>> +		kvm_flush_remote_tlbs(kvm);
>> +
>> +	r = -EFAULT;
>> +	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
>> +		goto out;
>> +
>> +	r = 0;
>> +out:
>> +	mutex_unlock(&kvm->slots_lock);
>> +	return r;
>> +#endif
>> +}
>> +
>>  static void kvm_init_memslots_id(struct kvm *kvm)
>>  {
>>  	int i;
>> -- 
>> 1.7.9.5
>>
> 
> Thanks,
> -Christoffer
> 
