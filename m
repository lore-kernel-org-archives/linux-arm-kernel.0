From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 1 Sep 2016 13:56:16 +0200
Subject: [PATCH 1/5] arm/arm64: KVM: Don't BUG_ON if IT bits are set in
 ARM mode
In-Reply-To: <1471610295-1456-2-git-send-email-marc.zyngier@arm.com>
References: <1471610295-1456-1-git-send-email-marc.zyngier@arm.com>
 <1471610295-1456-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160901115616.GD10162@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 01:38:11PM +0100, Marc Zyngier wrote:
> The ARM ARM asserts that having the IT bits set in ARM mode is
> unpredictable. But should a CPU do that (and still be able to
> run correctly), we shouldn't kill the system.
> 
> So let's drop the BUG_ON that checks for this, as it is not
> very helpful.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

not sure how this relates to the series, but looks fine otherwise:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  arch/arm/kvm/emulate.c   | 4 +---
>  arch/arm64/kvm/emulate.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
> index af93e3f..eda9ddd 100644
> --- a/arch/arm/kvm/emulate.c
> +++ b/arch/arm/kvm/emulate.c
> @@ -221,9 +221,7 @@ static void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
>  	unsigned long cpsr = *vcpu_cpsr(vcpu);
>  	bool is_arm = !(cpsr & PSR_T_BIT);
>  
> -	BUG_ON(is_arm && (cpsr & PSR_IT_MASK));
> -
> -	if (!(cpsr & PSR_IT_MASK))
> +	if (is_arm || !(cpsr & PSR_IT_MASK))
>  		return;
>  
>  	cond = (cpsr & 0xe000) >> 13;
> diff --git a/arch/arm64/kvm/emulate.c b/arch/arm64/kvm/emulate.c
> index f87d8fb..df76590 100644
> --- a/arch/arm64/kvm/emulate.c
> +++ b/arch/arm64/kvm/emulate.c
> @@ -120,9 +120,7 @@ static void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
>  	unsigned long cpsr = *vcpu_cpsr(vcpu);
>  	bool is_arm = !(cpsr & COMPAT_PSR_T_BIT);
>  
> -	BUG_ON(is_arm && (cpsr & COMPAT_PSR_IT_MASK));
> -
> -	if (!(cpsr & COMPAT_PSR_IT_MASK))
> +	if (is_arm || !(cpsr & COMPAT_PSR_IT_MASK))
>  		return;
>  
>  	cond = (cpsr & 0xe000) >> 13;
> -- 
> 2.1.4
> 
