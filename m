From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 6 Oct 2014 15:47:01 +0200
Subject: [PATCH 2/2] arm/arm64: KVM: Ensure memslots are within
 KVM_PHYS_SIZE
In-Reply-To: <20140930124651.GC12702@e104818-lin.cambridge.arm.com>
References: <1411674174-30672-1-git-send-email-christoffer.dall@linaro.org>
 <1411674174-30672-3-git-send-email-christoffer.dall@linaro.org>
 <20140930124651.GC12702@e104818-lin.cambridge.arm.com>
Message-ID: <20141006134701.GB3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 01:46:51PM +0100, Catalin Marinas wrote:
> On Thu, Sep 25, 2014 at 08:42:54PM +0100, Christoffer Dall wrote:
> > When creating or moving a memslot, make sure the IPA space is within the
> > addressable range of the guest.  Otherwise, user space can create too
> > large a memslot and KVM would try to access potentially unallocated page
> > table entries when inserting entries in the Stage-2 page tables.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/arm/kvm/mmu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> > index 4532f5f..52a311a 100644
> > --- a/arch/arm/kvm/mmu.c
> > +++ b/arch/arm/kvm/mmu.c
> > @@ -975,6 +975,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >  		goto out_unlock;
> >  	}
> >  
> > +	/* Userspace should not be able to register out-of-bounds IPAs */
> 
> I think "userspace" is a bit misleading (should be "guests").
> 

see below

> > +	VM_BUG_ON(fault_ipa >= KVM_PHYS_SIZE);
> 
> Can guests not generate IPA addresses higher than KVM_PHYS_SIZE? I don't
> see why this wouldn't be possible when PARange > 40.
> 
Guests can, but higher in this function we resolve the the gfn (IPA) to
a memslot (hva).  That only succeeds if userspace actually managed to
register a memslot with such an IPA, which we prevent in the other part
of this patch.  So if we get here, it's a bug, because we should have
entered the section above and taken the goto out_unlock.

Makes sense?

Thanks,
-Christoffer
