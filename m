From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Jan 2014 16:58:15 +0000
Subject: [PATCH] ARM: DT/kernel: fix arch_match_cpu_phys_id to avoid
 erroneous match
In-Reply-To: <1382358632-32762-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1382358632-32762-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20140107165815.GF4180@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was just looking in devtree.c and I noticed this seems to have fallen
by the wayside. Given that this fixes a possible bug and there have been
no negative comments, I think it's good for mainline.

Could you place this in the patch system, assuming Russell has no
comments?

Cheers,
Mark.

On Mon, Oct 21, 2013 at 01:30:32PM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> The MPIDR contains specific bitfields(MPIDR.Aff{2..0}) which uniquely
> identify a CPU, in addition to some non-identifying information and
> reserved bits. The ARM cpu binding defines the 'reg' property to only
> contain the affinity bits, and any cpu nodes with other bits set in
> their 'reg' entry are skipped.
> 
> As such it is not necessary to mask the phys_id with MPIDR_HWID_BITMASK,
> and doing so could lead to matching erroneous CPU nodes in the device
> tree. This patch removes the masking of the physical identifier.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/kernel/devtree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index f35906b..41960fb 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -171,7 +171,7 @@ void __init arm_dt_init_cpu_maps(void)
>  
>  bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>  {
> -	return (phys_id & MPIDR_HWID_BITMASK) == cpu_logical_map(cpu);
> +	return phys_id == cpu_logical_map(cpu);
>  }
>  
>  /**
> -- 
> 1.8.1.2
> 
