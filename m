From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 15:22:15 +0100
Subject: [PATCH 03/11] KVM: ARM/arm64: avoid returning negative error
 code as bool
In-Reply-To: <1409062410-25891-4-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-4-git-send-email-will.deacon@arm.com>
Message-ID: <53FC9817.6080106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 15:13, Will Deacon wrote:
> is_valid_cache returns true if the specified cache is valid.
> Unfortunately, if the parameter passed it out of range, we return
> -ENOENT, which ends up as true leading to potential hilarity.
> 
> This patch returns false on the failure path instead.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

With a brown paper bag on:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> ---
>  arch/arm/kvm/coproc.c     | 2 +-
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> index 37a0fe1bb9bb..7928dbdf2102 100644
> --- a/arch/arm/kvm/coproc.c
> +++ b/arch/arm/kvm/coproc.c
> @@ -791,7 +791,7 @@ static bool is_valid_cache(u32 val)
>  	u32 level, ctype;
>  
>  	if (val >= CSSELR_MAX)
> -		return -ENOENT;
> +		return false;
>  
>  	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
>          level = (val >> 1);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5805e7c4a4dd..4cc3b719208e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1218,7 +1218,7 @@ static bool is_valid_cache(u32 val)
>  	u32 level, ctype;
>  
>  	if (val >= CSSELR_MAX)
> -		return -ENOENT;
> +		return false;
>  
>  	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
>  	level = (val >> 1);
> 


-- 
Jazz is not dead. It just smells funny...
