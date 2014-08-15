From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 11:43:34 +0100
Subject: [PATCH] arm64: smp: Update the topology masks before calling
 CPU_STARTING notifiers
In-Reply-To: <1407892269-28650-1-git-send-email-rvaswani@codeaurora.org>
References: <1407892269-28650-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <20140815104333.GH27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 02:11:09AM +0100, Rohit Vaswani wrote:
> Currently, the CPU_STARTING notifiers would observe an incorrect sibling
> mask since the notifier chain is called before the topology masks are updated
> for the new cpu.
> Update the topology masks before calling the notifier chain to fix this
> problem.
> 
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> ---
>  arch/arm/kernel/smp.c   | 4 ++--
>  arch/arm64/kernel/smp.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 7c4fada..0e2237c 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -363,12 +363,12 @@ asmlinkage void secondary_start_kernel(void)
>  	if (smp_ops.smp_secondary_init)
>  		smp_ops.smp_secondary_init(cpu);
>  
> +	smp_store_cpu_info(cpu);
> +
>  	notify_cpu_starting(cpu);
>  
>  	calibrate_delay();
>  
> -	smp_store_cpu_info(cpu);
> -

Hmm, smp_store_cpu_info takes a copy of loops_per_jiffy. Are you sure it's
safe to move the call before calibrate_delay?

Will
