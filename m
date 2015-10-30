From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Oct 2015 12:08:22 +0000
Subject: [PATCH v2 4/4] arm64: document the cache policy behavior
In-Reply-To: <1446160842-25787-4-git-send-email-avanbrunt@nvidia.com>
References: <1446160842-25787-1-git-send-email-avanbrunt@nvidia.com>
 <1446160842-25787-4-git-send-email-avanbrunt@nvidia.com>
Message-ID: <20151030120822.GH20030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 04:20:42PM -0700, Alex Van Brunt wrote:
> Add a comment that clairfies how the kernel should behave given the cache

clarifies

> policy reported by the CPU.
> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/arm64/kernel/cpuinfo.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index ae04ac1..bf7e5e2 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -49,6 +49,14 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>  	unsigned int cpu = smp_processor_id();
>  	u32 l1ip = CTR_L1IP(info->reg_ctr);
>  
> +	/*
> +	 * The ARM architecture defines PIPT, VIPT and AIVIVT in terms of the

-the

> +	 * the observable behavior not how the CPU implements the policy.

s/not/rather than/

> +	 * Specifically, the policies differentiate the correct way to
> +	 * invalidate the cache. The definitions say that the only
> +	 * architecturally guaranteed way to invalidate a VIPT or AIVIVT
> +	 * instruction cache is to invalidate the entire instruction cache.
> +	 */
>  	if (l1ip != ICACHE_POLICY_PIPT)
>  		set_bit(ICACHEF_ALIASING, &__icache_flags);
>  	if (l1ip == ICACHE_POLICY_AIVIVT)

With the minor cosmetic changes:

  Acked-by: Will Deacon <will.deacon@arm.com>

although I don't see how we can really apply this given that we're not
planning to revert the cache geometry stuff. Maybe you could spin a
separate series just addressing the aliasing I-cache detection, then we
can build on top of that?

Will
