From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Apr 2017 10:08:46 +0100
Subject: kvm/arm64: use-after-free in
 kvm_unmap_hva_handler/unmap_stage2_pmds
In-Reply-To: <20170418083230.GA17866@leverpostej>
References: <CAAeHK+yjKm3mO2h9M30t-V_PnMhXEM887_zESCSg6gkbzivPsQ@mail.gmail.com>
 <20f6c994-d83e-7a6f-9f13-f10287211a6c@arm.com>
 <9f473bb9-d0eb-6803-1263-75ffef0301fe@redhat.com>
 <CAAeHK+x8udHKq9xa1zkTO6ax5E8Dk32HYWfaT05FMchL2cr48g@mail.gmail.com>
 <1050c9d8-5813-5df9-29e5-3ab6e61b5de6@arm.com>
 <88715300-ef58-e7bd-81f5-95e0b9c9c533@arm.com>
 <20170413155045.GA8387@e107814-lin.cambridge.arm.com>
 <20170418083230.GA17866@leverpostej>
Message-ID: <20170418090845.GC17866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 09:32:31AM +0100, Mark Rutland wrote:
> Hi Suzuki,
> 
> On Thu, Apr 13, 2017 at 04:50:46PM +0100, Suzuki K. Poulose wrote:
> > kvm: Hold reference to the user address space
> > 
> > The core KVM code, uses mmgrab/mmdrop to pin the mm struct of the user
> > application. mmgrab only guarantees that the mm struct is available,
> > while the "real address space" (see Documentation/vm/active_mm.txt) may
> > be destroyed. Since the KVM depends on the user space page tables for
> > the Guest pages, we should instead do an mmget/mmput. Even though
> > mmget/mmput is not encouraged for uses with unbounded time, the KVM
> > is fine to do so, as we are doing it from the context of the same process.
> > 
> > This also prevents the race condition where mmu_notifier_release() could
> > be called in parallel and one instance could end up using a free'd kvm
> > instance.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Paolo Bonzin <pbonzini@redhat.com>
> > Cc: Radim Kr?m?? <rkrcmar@redhat.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: andreyknvl at google.com
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  virt/kvm/kvm_main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 88257b3..555712e 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -613,7 +613,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	spin_lock_init(&kvm->mmu_lock);
> > -	mmgrab(current->mm);
> > +	mmget(current->mm);
> >  	kvm->mm = current->mm;
> >  	kvm_eventfd_init(kvm);
> >  	mutex_init(&kvm->lock);
> > @@ -685,7 +685,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
> >  	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
> >  		kvm_free_memslots(kvm, kvm->memslots[i]);
> >  	kvm_arch_free_vm(kvm);
> > -	mmdrop(current->mm);
> > +	mmput(current->mm);
> >  	return ERR_PTR(r);
> >  }
> >  
> > @@ -747,7 +747,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
> >  	kvm_arch_free_vm(kvm);
> >  	preempt_notifier_dec();
> >  	hardware_disable_all();
> > -	mmdrop(mm);
> > +	mmput(mm);
> >  }
> 
> 
> As a heads-up, I'm seeing what looks to be a KVM memory leak with this
> patch applied atop of next-20170411.
> 
> I don't yet know if this is a problem with next-20170411 or this patch
> in particular -- I will try to track that down. In the mean time, info
> dump below.
> 
> I left syzkaller running over the weekend using this kernel on the host,
> and OOM kicked in after it had been running for a short while. Almost
> all of my memory is in use, but judging by top, almost none of this is
> associated with processes.

FWIW, it seems easy enough to trigger this leak with kvmtool. Start a
guest that'll allocate a tonne of memory:

$ lkvm run --console virtio -m 4096 --kernel Image \
  -p "memtest=1 console=hvc0,38400 earlycon=uart,mmio,0x3f8"

... then kill this with a SIGKILL from your favourite process management
tool.

Also, if the guest exits normally, everything appears to be cleaned up
correctly. So it looks like this is in some way related to our fatal
signal handling.

Thanks,
Mark.
