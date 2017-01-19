From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2017 14:37:04 +0000
Subject: [PATCH] arm64/cpufeatures: Enforce inline/const properties of
 cpus_have_const_cap
In-Reply-To: <1484740725-24776-1-git-send-email-marc.zyngier@arm.com>
References: <1484740725-24776-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20170119143703.GB31594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 11:58:45AM +0000, Marc Zyngier wrote:
> Despite being flagged "inline", cpus_have_const_cap may end-up being
> placed out of line if the compiler decides so. This would be unfortunate,
> as we want to be able to use this function in HYP, where we need to
> be 100% sure of what is mapped there. __always_inline seems to be a
> better choice given the constraint.
> 
> Also, be a lot tougher on non-const or out-of-range capability values
> (a non-const cap value shouldn't be used here, and the semantic of an
> OOR value is at best ill defined). In those two case, BUILD_BUG_ON is
> what you get.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index b4989df..4710469 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -105,10 +105,11 @@ static inline bool cpu_have_feature(unsigned int num)
>  }
>  
>  /* System capability check for constant caps */
> -static inline bool cpus_have_const_cap(int num)
> +static __always_inline bool cpus_have_const_cap(int num)
>  {
> -	if (num >= ARM64_NCAPS)
> -		return false;
> +	BUILD_BUG_ON(!__builtin_constant_p(num));
> +	BUILD_BUG_ON(num >= ARM64_NCAPS);

This gives different behaviour to cpus_have_const_cap when compared to
cpus_have_cap, which I really don't like. What is the current behaviour
if you pass a non-constant num parameter? Does the kernel actually build?

Maybe it's best to spin a separate patch that makes cpus_have_cap and
cpus_have_const_cap both use __always_inline, then we can debate the merit
of the BUILD_BUG_ONs separately.

Will
