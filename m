From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 15:22:34 +0100
Subject: [PATCH 04/11] KVM: ARM/arm64: return -EFAULT if copy_from_user
 fails in set_timer_reg
In-Reply-To: <1409062410-25891-5-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-5-git-send-email-will.deacon@arm.com>
Message-ID: <53FC982A.3050600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 15:13, Will Deacon wrote:
> We currently return the number of bytes not copied if set_timer_reg
> fails, which is almost certainly not what userspace would like.
> 
> This patch returns -EFAULT instead.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> ---
>  arch/arm/kvm/guest.c   | 2 +-
>  arch/arm64/kvm/guest.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 813e49258690..cc0b78769bd8 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -163,7 +163,7 @@ static int set_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  
>  	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
>  	if (ret != 0)
> -		return ret;
> +		return -EFAULT;
>  
>  	return kvm_arm_timer_set_reg(vcpu, reg->id, val);
>  }
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 8d1ec2887a26..76794692c20b 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -174,7 +174,7 @@ static int set_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  
>  	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
>  	if (ret != 0)
> -		return ret;
> +		return -EFAULT;
>  
>  	return kvm_arm_timer_set_reg(vcpu, reg->id, val);
>  }
> 


-- 
Jazz is not dead. It just smells funny...
