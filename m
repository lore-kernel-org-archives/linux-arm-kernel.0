From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 15 Mar 2017 12:05:14 +0100
Subject: [PATCH 1/3] kvm: arm/arm64: Take mmap_sem in stage2_unmap_vm
In-Reply-To: <e005fa59-053f-caa6-17bd-0b57f5ba0670@arm.com>
References: <1489503154-20705-1-git-send-email-suzuki.poulose@arm.com>
 <1489503154-20705-2-git-send-email-suzuki.poulose@arm.com>
 <20170315091755.GL1277@cbox>
 <e005fa59-053f-caa6-17bd-0b57f5ba0670@arm.com>
Message-ID: <20170315110514.GB31974@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 09:34:53AM +0000, Marc Zyngier wrote:
> On 15/03/17 09:17, Christoffer Dall wrote:
> > On Tue, Mar 14, 2017 at 02:52:32PM +0000, Suzuki K Poulose wrote:
> >> From: Marc Zyngier <marc.zyngier@arm.com>
> >>
> >> We don't hold the mmap_sem while searching for the VMAs when
> >> we try to unmap each memslot for a VM. Fix this properly to
> >> avoid unexpected results.
> >>
> >> Fixes: commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
> >> Cc: stable at vger.kernel.org # v3.19+
> >> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>  arch/arm/kvm/mmu.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index 962616f..f2e2e0c 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -803,6 +803,7 @@ void stage2_unmap_vm(struct kvm *kvm)
> >>  	int idx;
> >>  
> >>  	idx = srcu_read_lock(&kvm->srcu);
> >> +	down_read(&current->mm->mmap_sem);
> >>  	spin_lock(&kvm->mmu_lock);
> >>  
> >>  	slots = kvm_memslots(kvm);
> >> @@ -810,6 +811,7 @@ void stage2_unmap_vm(struct kvm *kvm)
> >>  		stage2_unmap_memslot(kvm, memslot);
> >>  
> >>  	spin_unlock(&kvm->mmu_lock);
> >> +	up_read(&current->mm->mmap_sem);
> >>  	srcu_read_unlock(&kvm->srcu, idx);
> >>  }
> >>  
> >> -- 
> >> 2.7.4
> >>
> > 
> > Are we sure that holding mmu_lock is valid while holding the mmap_sem?
> 
> Maybe I'm just confused by the many levels of locking, Here's my rational:
> 
> - kvm->srcu protects the memslot list
> - mmap_sem protects the kernel VMA list
> - mmu_lock protects the stage2 page tables (at least here)
> 
> I don't immediately see any issue with holding the mmap_sem mutex here
> (unless there is a path that would retrigger a down operation on the
> mmap_sem?).
> 
> Or am I missing something obvious?

I was worried that someone else could hold the mmu_lock and take the
mmap_sem, but that wouldn't be allowed of course, because the semaphore
can sleep, so I agree, you should be good.

I just needed this conversation to feel good about this patch ;)

Reviewed-by: Christoffer Dall <cdall@linaro.org>
