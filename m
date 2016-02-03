From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Feb 2016 12:57:38 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160203125735.GA26487@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Mon, Jan 25, 2016 at 06:07:02PM +0000, Suzuki K. Poulose wrote:
> +/* Values for secondary_data.status */
> +
> +#define CPU_MMU_OFF		-1
> +#define CPU_BOOT_SUCCESS	0
> +/* The cpu invoked ops->cpu_die, synchronise it with cpu_kill */
> +#define CPU_KILL_ME		1
> +/* The cpu couldn't die gracefully and is looping in the kernel */
> +#define CPU_STUCK_IN_KERNEL	2
> +/* Fatal system error detected by secondary CPU, crash the system */
> +#define CPU_PANIC_KERNEL	3

Please add braces around these numbers, just in case (I added them
locally).

>  /*
> + * The booting CPU updates the failed status, with MMU turned off,
> + * below which lies in head.txt to make sure it doesn't share the same writeback
> + * granule. So that we can invalidate it properly.

I can't really parse this (it looks like punctuation in the wrong place;
also "share the same..." with what?).

> + *
> + * update_early_cpu_boot_status tmp, status
> + *  - Corrupts tmp, x0, x1
> + *  - Writes 'status' to __early_cpu_boot_status and makes sure
> + *    it is committed to memory.
> + */
> +
> +	.macro	update_early_cpu_boot_status tmp, status
> +	mov	\tmp, lr
> +	adrp	x0, __early_cpu_boot_status
> +	add	x0, x0, #:lo12:__early_cpu_boot_status

Nitpick: you could use the adr_l macro.

> +	mov	x1, #\status
> +	str	x1, [x0]
> +	add	x1, x0, 4
> +	bl	__inval_cache_range
> +	mov	lr, \tmp
> +	.endm

If the CPU that's currently booting has the MMU off, what's the point of
invalidating the cache here? The operation may not even be broadcast to
the other CPU. So you actually need the invalidation before reading the
status on the primary CPU.

> +
> +ENTRY(__early_cpu_boot_status)
> +	.long 	0
> +END(__early_cpu_boot_status)

I think we should just do like __boot_cpu_mode and place it in the
.data..cacheline_aligned section. You can always use the safe
clean+invalidate before reading the value so that we don't care much
about the write-back granule.

> @@ -89,12 +101,14 @@ static DECLARE_COMPLETION(cpu_running);
>  int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  {
>  	int ret;
> +	int status;
>  
>  	/*
>  	 * We need to tell the secondary core where to find its stack and the
>  	 * page tables.
>  	 */
>  	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
> +	update_cpu_boot_status(CPU_MMU_OFF);
>  	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>  
>  	/*
> @@ -117,7 +131,35 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
>  
> +	/* Make sure the update to status is visible */
> +	smp_rmb();

Which status? In relation to what?

>  	secondary_data.stack = NULL;
> +	status = READ_ONCE(secondary_data.status);
> +	if (ret && status) {
> +
> +		if (status == CPU_MMU_OFF)
> +			status = READ_ONCE(__early_cpu_boot_status);

You need cache maintenance before reading this.

> +
> +		switch (status) {
> +		default:
> +			pr_err("CPU%u: failed in unknown state : 0x%x\n",
> +					cpu, status);
> +			break;
> +		case CPU_KILL_ME:
> +			if (!op_cpu_kill(cpu)) {
> +				pr_crit("CPU%u: died during early boot\n", cpu);
> +				break;
> +			}
> +			/* Fall through */
> +			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
> +		case CPU_STUCK_IN_KERNEL:
> +			pr_crit("CPU%u: is stuck in kernel\n", cpu);
> +			cpus_stuck_in_kernel++;
> +			break;
> +		case CPU_PANIC_KERNEL:
> +			panic("CPU%u detected unsupported configuration\n", cpu);
> +		}
> +	}
>  
>  	return ret;
>  }

BTW, you can send a fix-up on top of this series with corrections, I can
fold them in.

-- 
Catalin
