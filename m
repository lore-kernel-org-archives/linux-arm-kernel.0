From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Sep 2014 13:46:51 +0100
Subject: [PATCH 2/2] arm/arm64: KVM: Ensure memslots are within
 KVM_PHYS_SIZE
In-Reply-To: <1411674174-30672-3-git-send-email-christoffer.dall@linaro.org>
References: <1411674174-30672-1-git-send-email-christoffer.dall@linaro.org>
 <1411674174-30672-3-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20140930124651.GC12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 08:42:54PM +0100, Christoffer Dall wrote:
> When creating or moving a memslot, make sure the IPA space is within the
> addressable range of the guest.  Otherwise, user space can create too
> large a memslot and KVM would try to access potentially unallocated page
> table entries when inserting entries in the Stage-2 page tables.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 4532f5f..52a311a 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -975,6 +975,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		goto out_unlock;
>  	}
>  
> +	/* Userspace should not be able to register out-of-bounds IPAs */

I think "userspace" is a bit misleading (should be "guests").

> +	VM_BUG_ON(fault_ipa >= KVM_PHYS_SIZE);

Can guests not generate IPA addresses higher than KVM_PHYS_SIZE? I don't
see why this wouldn't be possible when PARange > 40.

-- 
Catalin
