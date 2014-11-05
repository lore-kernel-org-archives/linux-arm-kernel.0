From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 05 Nov 2014 17:09:50 +0100
Subject: [PATCH v12 2/6] KVM: Add generic support for dirty page logging
In-Reply-To: <20141101101208.GE12801@jhogan-linux.le.imgtec.org>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
 <1414017251-5772-3-git-send-email-m.smarduch@samsung.com>
 <20141101101208.GE12801@jhogan-linux.le.imgtec.org>
Message-ID: <545A4BCE.40504@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/11/2014 11:12, James Hogan wrote:
> AFAICT all of the arch implementations of kvm_vm_ioctl_get_dirty_log()
> except x86 and ppc hv (i.e. ia60, mips, ppc pv, s390) already make use
> of the existing generic function kvm_get_dirty_log() to help implement
> their kvm_vm_ioctl_get_dirty_log functions, which all look pretty
> similar now except for TLB flushing.
> 
> Would they not be a better base for a generic
> kvm_vm_ioctl_get_dirty_log()?
> 
> It feels a bit wrong to add a generic higher level function which
> doesn't make use of the existing generic lower level abstraction.
> 
> (Appologies if this has already been brought up in previous versions of
> the patchset, I haven't been tracking them).

I agree that we should make the interface look more like
kvm_get_dirty_log().  Here the steps are:

+ *   1. Take a snapshot of the bit and clear it if needed.
+ *   2. Write protect the corresponding page.
+ *   3. Flush TLB's if needed.
+ *   4. Copy the snapshot to the userspace.

and I believe we can swap 3 and 4, since (4) is just a copy of data and
it has no ordering relationship with the action of the guest.  Once we
do that, we can rewrite code to look a lot like kvm_get_dirty_log(),
let's call it kvm_get_dirty_log_protect():

	r = -EINVAL;
	if (log->slot >= KVM_USER_MEM_SLOTS)
		goto out;

	memslot = id_to_memslot(kvm->memslots, log->slot);

	dirty_bitmap = memslot->dirty_bitmap;
	r = -ENOENT;
	if (!dirty_bitmap)
		goto out;

	n = kvm_dirty_bitmap_bytes(memslot);

	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
	memset(dirty_bitmap_buffer, 0, n);

	spin_lock(&kvm->mmu_lock);

	*is_dirty = false;
	for (i = 0; i < n / sizeof(long); i++) {
		unsigned long mask;
		gfn_t offset;

		if (!dirty_bitmap[i])
			continue;

		*is_dirty = true;

		mask = xchg(&dirty_bitmap[i], 0);
		dirty_bitmap_buffer[i] = mask;

		offset = i * BITS_PER_LONG;
		kvm_arch_write_protect_pt_masked(kvm, memslot, offset,
						 mask);
	}

	spin_unlock(&kvm->mmu_lock);

	r = -EFAULT;
	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
		goto out;

	r = 0;
out:
	return r;

where the TLB flushing is moved to the caller as in kvm_get_dirty_log
callers.  Taking the slots lock would also be kept in the per-arch
kvm_vm_ioctl_get_dirty_log, again similar to PPC/MIPS/S390.

You can add a new Kconfig symbol, or define an implementation of
kvm_arch_write_protect_pt_masked that BUG()s for ia64/PPC/MIPS/S390.

BTW, you can leave the function in kvm_main.c.

Paolo
