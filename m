From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jan 2011 10:02:30 -0000
Subject: [PATCH] ARM: oprofile: Always allow backtraces
In-Reply-To: <20110120095239.GT21401@erda.amd.com>
References: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
	<000101cbb886$582f1480$088d3d80$@deacon@arm.com>
	<20110120095239.GT21401@erda.amd.com>
Message-ID: <000601cbb889$26887ae0$739970a0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

> I would like to go even further, see the diff below.

[...]
 
> +#else
> +
> +static int oprofile_arch_init(struct oprofile_operations *ops)
> +{
> +	pr_info("oprofile: hardware counters not available\n");
> +	return -ENODEV;
> +}
> +
> +static void oprofile_arch_exit(void) { }
> +
> +#endif /* CONFIG_HW_PERF_EVENTS */

Don't we now have oprofile_arch_init defined twice in the non-PMU 
case? (and one of these definitions is __init)?

>  static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
>  {
>  	struct frame_tail *tail = ((struct frame_tail *) regs->ARM_fp) - 1;
> @@ -111,6 +123,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
> 
>  int __init oprofile_arch_init(struct oprofile_operations *ops)
>  {
> +	/* provide backtrace support also in timer mode: */
>  	ops->backtrace		= arm_backtrace;

Right, so this becomes common code but we need to ensure that we
don't call oprofile_perf_init. I suppose an alternative would be
to provide an empty static inline stub for oprofile_perf_init
instead.

Will
