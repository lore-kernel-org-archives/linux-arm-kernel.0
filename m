From: robert.richter@amd.com (Robert Richter)
Date: Thu, 20 Jan 2011 10:57:13 +0100
Subject: [PATCH] ARM: oprofile: Always allow backtraces
In-Reply-To: <20110120095239.GT21401@erda.amd.com>
References: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
	<000101cbb886$582f1480$088d3d80$@deacon@arm.com>
	<20110120095239.GT21401@erda.amd.com>
Message-ID: <20110120095713.GU21401@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.01.11 10:52:39, Robert Richter wrote:

> I would like to go even further, see the diff below.
> 
> -Robert
> 
> ---
>  arch/arm/oprofile/common.c |   45 ++++++++++++++++++++++++-------------------
>  1 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
> index 8aa9744..916aa2e 100644
> --- a/arch/arm/oprofile/common.c
> +++ b/arch/arm/oprofile/common.c
> @@ -47,18 +47,6 @@ char *op_name_from_perf_id(void)
>  	}
>  }
>  
> -static int report_trace(struct stackframe *frame, void *d)
> -{
> -	unsigned int *depth = d;
> -
> -	if (*depth) {
> -		oprofile_add_trace(frame->pc);
> -		(*depth)--;
> -	}
> -
> -	return *depth == 0;
> -}
> -
>  /*
>   * The registers we're interested in are at the end of the variable
>   * length saved register structure. The fp points at the end of this
> @@ -91,6 +79,30 @@ static struct frame_tail* user_backtrace(struct frame_tail *tail)
>  	return buftail[0].fp-1;
>  }
>  
> +#else
> +
> +static int oprofile_arch_init(struct oprofile_operations *ops)

Of course it should compile, but in this sense...

-Robert

> +{
> +	pr_info("oprofile: hardware counters not available\n");
> +	return -ENODEV;
> +}
> +
> +static void oprofile_arch_exit(void) { }
> +
> +#endif /* CONFIG_HW_PERF_EVENTS */
> +
> +static int report_trace(struct stackframe *frame, void *d)
> +{
> +	unsigned int *depth = d;
> +
> +	if (*depth) {
> +		oprofile_add_trace(frame->pc);
> +		(*depth)--;
> +	}
> +
> +	return *depth == 0;
> +}
> +
>  static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
>  {
>  	struct frame_tail *tail = ((struct frame_tail *) regs->ARM_fp) - 1;
> @@ -111,6 +123,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
>  
>  int __init oprofile_arch_init(struct oprofile_operations *ops)
>  {
> +	/* provide backtrace support also in timer mode: */
>  	ops->backtrace		= arm_backtrace;
>  
>  	return oprofile_perf_init(ops);
> @@ -120,11 +133,3 @@ void __exit oprofile_arch_exit(void)
>  {
>  	oprofile_perf_exit();
>  }
> -#else
> -int __init oprofile_arch_init(struct oprofile_operations *ops)
> -{
> -	pr_info("oprofile: hardware counters not available\n");
> -	return -ENODEV;
> -}
> -void __exit oprofile_arch_exit(void) {}
> -#endif /* CONFIG_HW_PERF_EVENTS */


-- 
Advanced Micro Devices, Inc.
Operating System Research Center
