From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 15 Mar 2017 11:56:39 +0100
Subject: [PATCH 3/3] kvm: arm/arm64: Fix locking for kvm_free_stage2_pgd
In-Reply-To: <314fbde3-17e6-414b-85e6-326de22bdc1c@arm.com>
References: <1489503154-20705-1-git-send-email-suzuki.poulose@arm.com>
 <1489503154-20705-4-git-send-email-suzuki.poulose@arm.com>
 <20170315092147.GM1277@cbox>
 <314fbde3-17e6-414b-85e6-326de22bdc1c@arm.com>
Message-ID: <20170315105639.GA31974@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 09:39:26AM +0000, Marc Zyngier wrote:
> On 15/03/17 09:21, Christoffer Dall wrote:
> > On Tue, Mar 14, 2017 at 02:52:34PM +0000, Suzuki K Poulose wrote:
> >> In kvm_free_stage2_pgd() we don't hold the kvm->mmu_lock while calling
> >> unmap_stage2_range() on the entire memory range for the guest. This could
> >> cause problems with other callers (e.g, munmap on a memslot) trying to
> >> unmap a range.
> >>
> >> Fixes: commit d5d8184d35c9 ("KVM: ARM: Memory virtualization setup")
> >> Cc: stable at vger.kernel.org # v3.10+
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>  arch/arm/kvm/mmu.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index 13b9c1f..b361f71 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -831,7 +831,10 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
> >>  	if (kvm->arch.pgd == NULL)
> >>  		return;
> >>  
> >> +	spin_lock(&kvm->mmu_lock);
> >>  	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
> >> +	spin_unlock(&kvm->mmu_lock);
> >> +
> > 
> > This ends up holding the spin lock for potentially quite a while, where
> > we can do things like __flush_dcache_area(), which I think can fault.
> 
> I believe we're always using the linear mapping (or kmap on 32bit) in
> order not to fault.
> 

ok, then there's just the concern that we may be holding a spinlock for
a very long time.  I seem to recall Mario once added something where he
unlocked and gave a chance to schedule something else for each PUD or
something like that, because he ran into the issue during migration.  Am
I confusing this with something else?

Thanks,
-Christoffer
