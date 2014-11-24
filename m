From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 24 Nov 2014 10:47:58 -0800
Subject: [PATCH v14 6/7] KVM: arm: dirty logging write protect support
In-Reply-To: <20141122194059.GO3401@cbox>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
 <1415930268-7674-7-git-send-email-m.smarduch@samsung.com>
 <20141122194059.GO3401@cbox>
Message-ID: <54737D5E.9050808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2014 11:40 AM, Christoffer Dall wrote:
> On Thu, Nov 13, 2014 at 05:57:47PM -0800, Mario Smarduch wrote:
>> Add support to track dirty pages between user space KVM_GET_DIRTY_LOG ioctl
>> calls. We call kvm_get_dirty_log_protect() function to do most of the work.
>>
>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/kvm/Kconfig |    1 +
>>  arch/arm/kvm/arm.c   |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/kvm/mmu.c   |   22 ++++++++++++++++++++++
>>  3 files changed, 69 insertions(+)
>>
>> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
>> index f27f336..a8d1ace 100644
>> --- a/arch/arm/kvm/Kconfig
>> +++ b/arch/arm/kvm/Kconfig
>> @@ -24,6 +24,7 @@ config KVM
>>  	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
>>  	select KVM_MMIO
>>  	select KVM_ARM_HOST
>> +	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>>  	depends on ARM_VIRT_EXT && ARM_LPAE
>>  	---help---
>>  	  Support hosting virtualized guest machines. You will also
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index a99e0cd..040c0f3 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -737,9 +737,55 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  	}
>>  }
>>  
>> +/**
>> + * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
>> + * @kvm:	kvm instance
>> + * @log:	slot id and address to which we copy the log
>> + *
>> + * We need to keep it in mind that VCPU threads can write to the bitmap
>> + * concurrently.  So, to avoid losing data, we keep the following order for
>> + * each bit:
>> + *
>> + *   1. Take a snapshot of the bit and clear it if needed.
>> + *   2. Write protect the corresponding page.
>> + *   3. Copy the snapshot to the userspace.
>> + *   4. Flush TLB's if needed.
>> + *
>> + * Steps 1,2,3 are handled by kvm_get_dirty_log_protect().
>> + * Between 2 and 4, the guest may write to the page using the remaining TLB
>> + * entry.  This is not a problem because the page is reported dirty using
>> + * the snapshot taken before and step 4 ensures that writes done after
>> + * exiting to userspace will be logged for the next call.
>> + */
>>  int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>  {
>> +#ifdef CONFIG_ARM
>> +	int r;
>> +	bool is_dirty = false;
>> +
>> +	mutex_lock(&kvm->slots_lock);
>> +
>> +	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
>> +	if (r)
>> +		goto out;
>> +
>> +	/*
>> +	 * kvm_get_dirty_log_protect() may fail and we may skip TLB flush
>> +	 * leaving few stale spte TLB entries which is harmless, given we're
>> +	 * just write protecting spte's, so few stale TLB's will be left in
>> +	 * original R/W state. And since the bitmap is corrupt userspace will
>> +	 * error out anyway (i.e. during migration or dirty page loging for
> 
> s/loging/logging/
> 
> Hmmm, where is this behavior specified in the ABI?  If you call
> KVM_GET_DIRTY_LOG subsequently, you will now potentially have unreported
> dirty pages, which can be completely avoided by removing the
> if-statement and the goto above.  Why not simply do that and get rid of
> this comment?
Yeah that makes sense, the comment is an overkill for these few lines.
> 
>> +	 * other reasons) terminating dirty page logging.
>> +	 */
>> +	if (is_dirty)
>> +		kvm_flush_remote_tlbs(kvm);
>> +out:
>> +	mutex_unlock(&kvm->slots_lock);
>> +
>> +	return r;
>> +#else /* ARM64 */
>>  	return -EINVAL;
>> +#endif
>>  }
>>  
>>  static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 1e8b6a9..8137455 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -870,6 +870,28 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
>>  	spin_unlock(&kvm->mmu_lock);
>>  	kvm_flush_remote_tlbs(kvm);
>>  }
>> +
>> +/**
>> + * kvm_arch_mmu_write_protect_pt_masked() - write protect dirty pages
>> + * @kvm:	The KVM pointer
>> + * @slot:	The memory slot associated with mask
>> + * @gfn_offset:	The gfn offset in memory slot
>> + * @mask:	The mask of dirty pages at offset 'gfn_offset' in this memory
>> + *              slot to be write protected
>> + *
>> + * Walks bits set in mask write protects the associated pte's. Caller must
>> + * acquire kvm_mmu_lock.
>> + */
>> +void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
>> +		struct kvm_memory_slot *slot,
>> +		gfn_t gfn_offset, unsigned long mask)
>> +{
>> +	phys_addr_t base_gfn = slot->base_gfn + gfn_offset;
>> +	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
>> +	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>> +
>> +	stage2_wp_range(kvm, start, end);
>> +}
>>  #endif
>>  
>>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>> -- 
>> 1.7.9.5
>>
