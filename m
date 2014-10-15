From: agraf@suse.de (Alexander Graf)
Date: Wed, 15 Oct 2014 13:21:36 +0200
Subject: [PATCH v11 2/6] KVM: Add generic implementation of
 kvm_vm_ioctl_get_dirty_log
In-Reply-To: <1411433690-8104-3-git-send-email-m.smarduch@samsung.com>
References: <1411433690-8104-1-git-send-email-m.smarduch@samsung.com>
 <1411433690-8104-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <543E58C0.90204@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23.09.14 02:54, Mario Smarduch wrote:
> Add support for generic implementation of dirty log read function. For now
> x86_64 and ARMv7 share generic dirty log read. Other architectures call
> their architecture specific functions.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/kvm/Kconfig      |    1 +
>  arch/arm/kvm/arm.c        |    2 +-
>  arch/arm64/kvm/Kconfig    |    1 +
>  arch/ia64/kvm/Kconfig     |    1 +
>  arch/ia64/kvm/kvm-ia64.c  |    2 +-
>  arch/mips/kvm/Kconfig     |    1 +
>  arch/mips/kvm/mips.c      |    2 +-
>  arch/powerpc/kvm/Kconfig  |    1 +
>  arch/powerpc/kvm/book3s.c |    2 +-
>  arch/powerpc/kvm/booke.c  |    2 +-
>  arch/s390/kvm/Kconfig     |    1 +
>  arch/s390/kvm/kvm-s390.c  |    2 +-
>  arch/x86/kvm/x86.c        |   86 ------------------------------------------
>  include/linux/kvm_host.h  |    6 +++
>  virt/kvm/Kconfig          |    3 ++
>  virt/kvm/kvm_main.c       |   91 +++++++++++++++++++++++++++++++++++++++++++++
>  16 files changed, 112 insertions(+), 92 deletions(-)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 4be5bb1..cd9bb1c 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -23,6 +23,7 @@ config KVM
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select KVM_MMIO
>  	select KVM_ARM_HOST
> +	select HAVE_KVM_ARCH_DIRTY_LOG

I think we're better off treating the "common dirty log" option as the
odd case. So instead of adding this option for every arch, just set it
on x86 and later on arm. Then you can ...

>  	depends on ARM_VIRT_EXT && ARM_LPAE && !CPU_BIG_ENDIAN
>  	---help---
>  	  Support hosting virtualized guest machines. You will also
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 3c82b37..c52b2bd 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -774,7 +774,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	}
>  }
>  
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>  {
>  	return -EINVAL;
>  }
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 8ba85e9..40a8d19 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -26,6 +26,7 @@ config KVM
>  	select KVM_ARM_HOST
>  	select KVM_ARM_VGIC
>  	select KVM_ARM_TIMER
> +	select HAVE_KVM_ARCH_DIRTY_LOG
>  	---help---
>  	  Support hosting virtualized guest machines.
>  
> diff --git a/arch/ia64/kvm/Kconfig b/arch/ia64/kvm/Kconfig
> index 990b864..217f10a 100644
> --- a/arch/ia64/kvm/Kconfig
> +++ b/arch/ia64/kvm/Kconfig
> @@ -28,6 +28,7 @@ config KVM
>  	select HAVE_KVM_IRQ_ROUTING
>  	select KVM_APIC_ARCHITECTURE
>  	select KVM_MMIO
> +	select HAVE_KVM_ARCH_DIRTY_LOG
>  	---help---
>  	  Support hosting fully virtualized guest machines using hardware
>  	  virtualization extensions.  You will need a fairly recent
> diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
> index 6a4309b..3166df5 100644
> --- a/arch/ia64/kvm/kvm-ia64.c
> +++ b/arch/ia64/kvm/kvm-ia64.c
> @@ -1812,7 +1812,7 @@ static void kvm_ia64_sync_dirty_log(struct kvm *kvm,
>  	spin_unlock(&kvm->arch.dirty_log_lock);
>  }
>  
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm,
>  		struct kvm_dirty_log *log)
>  {
>  	int r;
> diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
> index 30e334e..b57f49e 100644
> --- a/arch/mips/kvm/Kconfig
> +++ b/arch/mips/kvm/Kconfig
> @@ -20,6 +20,7 @@ config KVM
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
>  	select KVM_MMIO
> +	select HAVE_KVM_ARCH_DIRTY_LOG
>  	---help---
>  	  Support for hosting Guest kernels.
>  	  Currently supported on MIPS32 processors.
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index d687c6e..885fdfe 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -791,7 +791,7 @@ out:
>  }
>  
>  /* Get (and clear) the dirty memory log for a memory slot. */
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>  {
>  	struct kvm_memory_slot *memslot;
>  	unsigned long ga, ga_end;
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index d6a53b9..4f28a82 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -21,6 +21,7 @@ config KVM
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
>  	select HAVE_KVM_EVENTFD
> +	select HAVE_KVM_ARCH_DIRTY_LOG
>  
>  config KVM_BOOK3S_HANDLER
>  	bool
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index c254c27..304faa1 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -815,7 +815,7 @@ int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
>  	return vcpu->kvm->arch.kvm_ops->check_requests(vcpu);
>  }
>  
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>  {
>  	return kvm->arch.kvm_ops->get_dirty_log(kvm, log);
>  }
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index ab62109..50dd33d 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1624,7 +1624,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>  {
>  	return -ENOTSUPP;
>  }
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index 10d529a..6306bb6 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -27,6 +27,7 @@ config KVM
>  	select KVM_ASYNC_PF_SYNC
>  	select HAVE_KVM_IRQCHIP
>  	select HAVE_KVM_IRQ_ROUTING
> +	select HAVE_KVM_ARCH_DIRTY_LOG
>  	---help---
>  	  Support hosting paravirtualized guest machines using the SIE
>  	  virtualization capability on the mainframe. This should work
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2f3e14f..7712cf6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -208,7 +208,7 @@ static void kvm_s390_sync_dirty_log(struct kvm *kvm,
>  /*
>   * Get (and clear) the dirty memory log for a memory slot.
>   */
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm,
>  			       struct kvm_dirty_log *log)
>  {
>  	int r;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5a8691b..652bd28 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3577,92 +3577,6 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
>  	return 0;
>  }
>  
> -/**
> - * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
> - * @kvm: kvm instance
> - * @log: slot id and address to which we copy the log
> - *
> - * We need to keep it in mind that VCPU threads can write to the bitmap
> - * concurrently.  So, to avoid losing data, we keep the following order for
> - * each bit:
> - *
> - *   1. Take a snapshot of the bit and clear it if needed.
> - *   2. Write protect the corresponding page.
> - *   3. Flush TLB's if needed.
> - *   4. Copy the snapshot to the userspace.
> - *
> - * Between 2 and 3, the guest may write to the page using the remaining TLB
> - * entry.  This is not a problem because the page will be reported dirty at
> - * step 4 using the snapshot taken before and step 3 ensures that successive
> - * writes will be logged for the next call.
> - */
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> -{
> -	int r;
> -	struct kvm_memory_slot *memslot;
> -	unsigned long n, i;
> -	unsigned long *dirty_bitmap;
> -	unsigned long *dirty_bitmap_buffer;
> -	bool is_dirty = false;
> -
> -	mutex_lock(&kvm->slots_lock);
> -
> -	r = -EINVAL;
> -	if (log->slot >= KVM_USER_MEM_SLOTS)
> -		goto out;
> -
> -	memslot = id_to_memslot(kvm->memslots, log->slot);
> -
> -	dirty_bitmap = memslot->dirty_bitmap;
> -	r = -ENOENT;
> -	if (!dirty_bitmap)
> -		goto out;
> -
> -	n = kvm_dirty_bitmap_bytes(memslot);
> -
> -	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
> -	memset(dirty_bitmap_buffer, 0, n);
> -
> -	spin_lock(&kvm->mmu_lock);
> -
> -	for (i = 0; i < n / sizeof(long); i++) {
> -		unsigned long mask;
> -		gfn_t offset;
> -
> -		if (!dirty_bitmap[i])
> -			continue;
> -
> -		is_dirty = true;
> -
> -		mask = xchg(&dirty_bitmap[i], 0);
> -		dirty_bitmap_buffer[i] = mask;
> -
> -		offset = i * BITS_PER_LONG;
> -		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
> -	}
> -
> -	spin_unlock(&kvm->mmu_lock);
> -
> -	/* See the comments in kvm_mmu_slot_remove_write_access(). */
> -	lockdep_assert_held(&kvm->slots_lock);
> -
> -	/*
> -	 * All the TLBs can be flushed out of mmu lock, see the comments in
> -	 * kvm_mmu_slot_remove_write_access().
> -	 */
> -	if (is_dirty)
> -		kvm_flush_remote_tlbs(kvm);
> -
> -	r = -EFAULT;
> -	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
> -		goto out;
> -
> -	r = 0;
> -out:
> -	mutex_unlock(&kvm->slots_lock);
> -	return r;
> -}
> -
>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
>  			bool line_status)
>  {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index a49a6df..c0a5cec 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -609,6 +609,12 @@ int kvm_get_dirty_log(struct kvm *kvm,
>  			struct kvm_dirty_log *log, int *is_dirty);
>  int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
>  				struct kvm_dirty_log *log);
> +int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm,
> +					struct kvm_dirty_log *log);
> +void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
> +					struct kvm_memory_slot *slot,
> +					gfn_t gfn_offset,
> +					unsigned long mask);
>  
>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
>  			bool line_status);
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index f1efaa5..975733f 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -37,3 +37,6 @@ config KVM_VFIO
>  
>  config HAVE_KVM_ARCH_TLB_FLUSH_ALL
>         bool
> +
> +config HAVE_KVM_ARCH_DIRTY_LOG
> +       bool
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c

... move this code to a new file in virt/kvm. dirty.c maybe. Then you
can build include that file with obj-$CONFIG_foo in the Makefile on
virt/kvm.


Alex
