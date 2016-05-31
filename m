From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 31 May 2016 20:28:26 +0800
Subject: [PATCH v7 07/15] arm64, numa: Cleanup NUMA disabled messages.
In-Reply-To: <1464129345-18985-8-git-send-email-ddaney.cavm@gmail.com>
References: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
 <1464129345-18985-8-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <574D836A.2090905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/5/25 6:35, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> As noted by Dennis Chen, we don't want to print "No NUMA configuration
> found" if NUMA was forced off from the command line.
>
> Change the type of numa_off to bool, and clean up printing code.
> Print "NUMA disabled" if forced off on command line and "No NUMA
> configuration found" if there was no firmware NUMA information.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm64/mm/numa.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 6cb03f9..1def1de 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -29,7 +29,7 @@ static int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
>
>   static int numa_distance_cnt;
>   static u8 *numa_distance;
> -static int numa_off;
> +static bool numa_off;
>
>   static __init int numa_parse_early_param(char *opt)
>   {
> @@ -37,7 +37,7 @@ static __init int numa_parse_early_param(char *opt)
>   		return -EINVAL;
>   	if (!strncmp(opt, "off", 3)) {
>   		pr_info("%s\n", "NUMA turned off");
> -		numa_off = 1;
> +		numa_off = true;
>   	}
>   	return 0;
>   }
> @@ -362,7 +362,10 @@ static int __init dummy_numa_init(void)
>   	int ret;
>   	struct memblock_region *mblk;
>
> -	pr_info("%s\n", "No NUMA configuration found");
> +	if (numa_off)
> +		pr_info("NUMA disabled\n"); /* Forced off on command line. */
> +	else
> +		pr_info("No NUMA configuration found\n");
>   	pr_info("NUMA: Faking a node at [mem %#018Lx-%#018Lx]\n",
>   	       0LLU, PFN_PHYS(max_pfn) - 1);
>
> @@ -375,7 +378,7 @@ static int __init dummy_numa_init(void)
>   		return ret;
>   	}
>
> -	numa_off = 1;
> +	numa_off = true;
>   	return 0;
>   }

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

>
>
