From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Sep 2016 17:59:43 +0100
Subject: [PATCH v3 6/8] ARM: Change MPIDR_AFFINITY_LEVEL to ignore Aff3
In-Reply-To: <1473350810-10857-7-git-send-email-vladimir.murzin@arm.com>
References: <1473350810-10857-1-git-send-email-vladimir.murzin@arm.com>
 <1473350810-10857-7-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57D2EA7F.9030705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 17:06, Vladimir Murzin wrote:
> vgic-v3 driver queries CPU affinity level up to Aff3, which is valid
> for arm64.  However, for arm up to Aff2 levels are supported, so
> querying for third level ends with upper bits of MPIDR are treated as
> valid affinity level which is not true. Make sure we report zero for
> any affinity level above two.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/cputype.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 1ee94c7..f08fac4 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -55,9 +55,10 @@
>  
>  #define MPIDR_LEVEL_BITS 8
>  #define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
> +#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
>  
>  #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
> -	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
> +	(((mpidr & MPIDR_HWID_BITMASK) >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
>  
>  #define ARM_CPU_IMP_ARM			0x41
>  #define ARM_CPU_IMP_INTEL		0x69
> 

There is something I don't quite get. Is this patch really necessary?
Are there cases where we construct a MPIDR that can have Aff3 set on 32bit?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
