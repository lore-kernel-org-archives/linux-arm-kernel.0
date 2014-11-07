From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 07 Nov 2014 11:47:10 -0800
Subject: [PATCH v13 6/7] arm: KVM: dirty log read write protect support
In-Reply-To: <545C76E9.5090700@redhat.com>
References: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
 <1415320848-13813-7-git-send-email-m.smarduch@samsung.com>
 <545C76E9.5090700@redhat.com>
Message-ID: <545D21BE.2020203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 11:38 PM, Paolo Bonzini wrote:
> 
> 
> On 07/11/2014 01:40, Mario Smarduch wrote:
>> Add support to track dirty pages between user space KVM_GET_DIRTY_LOG ioctl
>> calls. We call kvm_get_dirty_log_protect() function to do most of the work.
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/kvm/arm.c  |   37 +++++++++++++++++++++++++++++++++++++
>>  arch/arm/kvm/mmu.c  |   22 ++++++++++++++++++++++
>>  virt/kvm/kvm_main.c |    3 +--
>>  3 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index a99e0cd..212d835 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -737,9 +737,46 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
>> +	if (is_dirty)
>> +		kvm_flush_remote_tlbs(kvm);
> 
> Should the caller should always flush TLBs if is_dirty is true, even if
> kvm_get_dirty_log_protect reported an error?  That can happen if the
> error occurred in the final copy to userspace, after page tables have
> been modified.

Upon error return userspace should terminate logging, error out whether
used
for migration or other use cases, with some stale spte TLBs cached
read/write,
which doesn't appear to be harmful.

But you mention 'final copy' which makes me think I'm missing something?

> 
> Of course, in this case userspace cannot use the dirty log anymore since
> it has been irrimediably trashed.
> 
> Paolo
> 
