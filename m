From: james.hogan@imgtec.com (James Hogan)
Date: Sat, 1 Nov 2014 10:12:08 +0000
Subject: [PATCH v12 2/6] KVM: Add generic support for dirty page logging
In-Reply-To: <1414017251-5772-3-git-send-email-m.smarduch@samsung.com>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
 <1414017251-5772-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141101101208.GE12801@jhogan-linux.le.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mario,

On Wed, Oct 22, 2014 at 03:34:07PM -0700, Mario Smarduch wrote:
> +/**
> + * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
> + * @kvm: kvm instance
> + * @log: slot id and address to which we copy the log
> + *
> + * We need to keep it in mind that VCPU threads can write to the bitmap
> + * concurrently.  So, to avoid losing data, we keep the following order for
> + * each bit:
> + *
> + *   1. Take a snapshot of the bit and clear it if needed.
> + *   2. Write protect the corresponding page.
> + *   3. Flush TLB's if needed.
> + *   4. Copy the snapshot to the userspace.
> + *
> + * Between 2 and 3, the guest may write to the page using the remaining TLB
> + * entry.  This is not a problem because the page will be reported dirty at
> + * step 4 using the snapshot taken before and step 3 ensures that successive
> + * writes will be logged for the next call.
> + */
> +int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +{
> +	int r;
> +	struct kvm_memory_slot *memslot;
> +	unsigned long n, i;
> +	unsigned long *dirty_bitmap;
> +	unsigned long *dirty_bitmap_buffer;
> +	bool is_dirty = false;
> +
> +	mutex_lock(&kvm->slots_lock);
> +
> +	r = -EINVAL;
> +	if (log->slot >= KVM_USER_MEM_SLOTS)
> +		goto out;
> +
> +	memslot = id_to_memslot(kvm->memslots, log->slot);
> +
> +	dirty_bitmap = memslot->dirty_bitmap;
> +	r = -ENOENT;
> +	if (!dirty_bitmap)
> +		goto out;
> +
> +	n = kvm_dirty_bitmap_bytes(memslot);
> +
> +	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
> +	memset(dirty_bitmap_buffer, 0, n);
> +
> +	spin_lock(&kvm->mmu_lock);
> +
> +	for (i = 0; i < n / sizeof(long); i++) {
> +		unsigned long mask;
> +		gfn_t offset;
> +
> +		if (!dirty_bitmap[i])
> +			continue;
> +
> +		is_dirty = true;
> +
> +		mask = xchg(&dirty_bitmap[i], 0);
> +		dirty_bitmap_buffer[i] = mask;
> +
> +		offset = i * BITS_PER_LONG;
> +		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
> +	}
> +
> +	spin_unlock(&kvm->mmu_lock);
> +
> +	/* See the comments in kvm_mmu_slot_remove_write_access(). */
> +	lockdep_assert_held(&kvm->slots_lock);
> +
> +	/*
> +	 * All the TLBs can be flushed out of mmu lock, see the comments in
> +	 * kvm_mmu_slot_remove_write_access().
> +	 */
> +	if (is_dirty)
> +		kvm_flush_remote_tlbs(kvm);
> +
> +	r = -EFAULT;
> +	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
> +		goto out;

AFAICT all of the arch implementations of kvm_vm_ioctl_get_dirty_log()
except x86 and ppc hv (i.e. ia60, mips, ppc pv, s390) already make use
of the existing generic function kvm_get_dirty_log() to help implement
their kvm_vm_ioctl_get_dirty_log functions, which all look pretty
similar now except for TLB flushing.

Would they not be a better base for a generic
kvm_vm_ioctl_get_dirty_log()?

It feels a bit wrong to add a generic higher level function which
doesn't make use of the existing generic lower level abstraction.

(Appologies if this has already been brought up in previous versions of
the patchset, I haven't been tracking them).

Cheers
James

> +
> +	r = 0;
> +out:
> +	mutex_unlock(&kvm->slots_lock);
> +	return r;
> +}
