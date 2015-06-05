From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Jun 2015 15:45:40 +0100
Subject: [PATCH 1/2] arm64: perf: Don't use of_node after putting it
In-Reply-To: <1433364818-6682-1-git-send-email-sboyd@codeaurora.org>
References: <1433364818-6682-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150605144539.GC7420@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Jun 03, 2015 at 09:53:37PM +0100, Stephen Boyd wrote:
> It's possible, albeit unlikely, that using the of_node here will
> reference freed memory. Call of_node_put() after printing the
> name to be safe.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm64/kernel/perf_event.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 702591f6180a..8af7784a8e35 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1340,12 +1340,13 @@ static int armpmu_device_probe(struct platform_device *pdev)
>  			if (arch_find_n_match_cpu_physical_id(dn, cpu, NULL))
>  				break;
>  
> -		of_node_put(dn);
>  		if (cpu >= nr_cpu_ids) {
>  			pr_warn("Failed to find logical CPU for %s\n",
>  				dn->name);
> +			of_node_put(dn);
>  			break;
>  		}
> +		of_node_put(dn);
>  
>  		irqs[i] = cpu;
>  	}

Yeah, I agree this needs changing but given (a) the CPU node isn't going
to disappear and (b) this patch will conflict horribly with my queue for
4.2, do you mind if I sit on this until after the merge window (as a fix
for 4.2)?

Will
