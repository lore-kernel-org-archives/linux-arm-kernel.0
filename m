From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 May 2013 10:08:12 +0100
Subject: [PATCH] ARM: KVM: Handle loads from I/O addresses to PC
In-Reply-To: <1368385135-60584-1-git-send-email-cdall@cs.columbia.edu>
References: <1368385135-60584-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <5190AD7C.2000501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/13 19:58, Christoffer Dall wrote:
> If a VM does something like this:
> 
> ldr     pc, [r0]        @ r0 is an I/O address
> 
> Then simply let that value load into the PC on kvm_handle_mmio_return
> overwriting the PC value set from kvm_skip_instr.
> 
> Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>

I've had a slightly more complete patch in my tree for a while (look at
bef0ef01ae75 on the kvm-arm64/kvm-3.10-rc0 branch).

> ---
>  arch/arm/kvm/mmio.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> index 72a12f2..b8e06b7 100644
> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -86,12 +86,6 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	sign_extend = kvm_vcpu_dabt_issext(vcpu);
>  	rt = kvm_vcpu_dabt_get_rd(vcpu);
>  
> -	if (kvm_vcpu_reg_is_pc(vcpu, rt)) {
> -		/* IO memory trying to read/write pc */
> -		kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> -		return 1;
> -	}
> -
>  	mmio->is_write = is_write;
>  	mmio->phys_addr = fault_ipa;
>  	mmio->len = len;
> 

Otherwise looks good to me.

	M.
-- 
Jazz is not dead. It just smells funny...
