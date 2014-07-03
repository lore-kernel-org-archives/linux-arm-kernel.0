From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 3 Jul 2014 08:04:01 -0700
Subject: [RESEND PATCH v7 3/4] arm: dirty log write protect management
 support
In-Reply-To: <53A0EE60.6030508@samsung.com>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1402076021-9425-1-git-send-email-m.smarduch@samsung.com>
 <20140608120522.GG3279@lvm> <539663A0.9080507@samsung.com>
 <20140610092240.GF1388@lvm> <53974998.70001@samsung.com>
 <20140611070352.GC24286@lvm> <53A0EE60.6030508@samsung.com>
Message-ID: <20140703150401.GE20104@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 06:41:52PM -0700, Mario Smarduch wrote:
> On 06/11/2014 12:03 AM, Christoffer Dall wrote:
> 
> >>
> >> There is also the issue of kvm_flush_remote_tlbs(), that's also weak,
> >> the generic one is using IPIs. Since it's only used in mmu.c maybe make 
> >> this one static.
> >>
> > So I don't see a lot of use of weak symbols in kvm_main.c (actually on
> > kvmarm/next I don't see any), but we do want to share code when more
> > than one architecture implements something in the exact same way, like
> > it seems x86 and ARM is doing here for this particular function.
> > 
> > I think the KVM scheme is usually to check for some define, like:
> > 
> > #ifdef KVM_ARCH_HAVE_GET_DIRTY_LOG
> > 	ret = kvm_arch_get_dirty_log(...);
> > #else
> > 	ret = kvm_get_dirty_log(...);
> > #endif
> > 
> > but Paolo may have a more informed oppinion of how to deal with these.
> > 
> > Thanks,
> > -Christoffer
> >
> 
>  
> One approach I'm trying looking at the code in kvm_main().
> This approach applies more to selecting features as opposed to
> selecting generic vs architecture specific functions.
> 
> 1.-------------------------------------------------
>  - add to 'virt/kvm/Kconfig'
> config HAVE_KVM_ARCH_TLB_FLUSH_ALL
>        bool
> 
> config HAVE_KVM_ARCH_DIRTY_LOG
>        bool
> 2.--------------------------------------------------
> For ARM and later ARM64 add to 'arch/arm[64]/kvm/Kconfig'
> config KVM
>         bool "Kernel-based Virtual Machine (KVM) support"
> ...
> select HAVE_KVM_ARCH_TLB_FLUSH_ALL
> ..
> 
> Not for HAVE_KVM_ARCH_DIRTY_LOG given it's shared with x86,
> but would need to do it for every other architecture that
> does not share it (except initially for arm64 since it
> will use the variant that returns -EINVAL until feature
> is supported)
> 
> 3------------------------------------------------------
> In kvm_main.c would have something like
> 
> void kvm_flush_remote_tlbs(struct kvm *kvm)
> {
> #ifdef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
>         kvm_arch_flush_remote_tlbs(kvm);
> #else
>         long dirty_count = kvm->tlbs_dirty;
> 
>         smp_mb();
>         if (make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
>                 ++kvm->stat.remote_tlb_flush;
>         cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
> #endif
> }
> 
> Then add void kvm_flush_remote_tlbs(struct kvm *kvm) definition
> to arm kvm_host.h. Define the function in this case mmu.c
> 
> For the dirty log function
> int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
>                                                 struct kvm_dirty_log *log)
> {
> #ifdef CONFIG_HAVE_KVM_ARCH_DIRTY_LOG
>         kvm_arch_vm_ioctl_get_dirty_log(kvm, log);
> #else
>         int r;
>         struct kvm_memory_slot *memslot;
>         unsigned long n, i;
>         unsigned long *dirty_bitmap;
>         unsigned long *dirty_bitmap_buffer;
>         bool is_dirty = false;
> 	...
> 
> But then you have to go into every architecture and define the
> kvm_arch_vm_...() variant.
> 
> Is this the right way to go? Or is there a simpler way?
> 
Hmmm, I'm really not an expert in the 'established procedures' for what
to put in config files etc., but here's my basic take:

a) you wouldn't put a config option in Kconfig unless it's comething
that's actually configurable or some generic feature/subsystem that
should only be enabled if hardware has certain capabilities or other
config options enabled.

b) this seems entirely an implementation issue and not depending on
anything users should select.

c) therefore, I think it's either a question of always having an
arch-specific implementation that you probe for its return value or you
have some sort of define in the header files for the
arch/X/include/asm/kvm_host.h to control what you need.

-Christoffer
