From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Feb 2016 16:36:05 +0100
Subject: [PATCH v2 21/21] arm64: Panic when VHE and non VHE CPUs coexist
In-Reply-To: <1453737235-16522-22-git-send-email-marc.zyngier@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-22-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160201153605.GA1478@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 03:53:55PM +0000, Marc Zyngier wrote:
> Having both VHE and non-VHE capable CPUs in the same system
> is likely to be a recipe for disaster.
> 
> If the boot CPU has VHE, but a secondary is not, we won't be
> able to downgrade and run the kernel at EL1. Add CPU hotplug
> to the mix, and this produces a terrifying mess.
> 
> Let's solve the problem once and for all. If you mix VHE and
> non-VHE CPUs in the same system, you deserve to loose, and this
> patch makes sure you don't get a chance.
> 
> This is implemented by storing the kernel execution level in
> a global variable. Secondaries will park themselves in a
> WFI loop if they observe a mismatch. Also, the primary CPU
> will detect that the secondary CPU has died on a mismatched
> execution level. Panic will follow.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/virt.h | 17 +++++++++++++++++
>  arch/arm64/kernel/head.S      | 19 +++++++++++++++++++
>  arch/arm64/kernel/smp.c       |  3 +++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 9f22dd6..f81a345 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -36,6 +36,11 @@
>   */
>  extern u32 __boot_cpu_mode[2];
>  
> +/*
> + * __run_cpu_mode records the mode the boot CPU uses for the kernel.
> + */
> +extern u32 __run_cpu_mode[2];
> +
>  void __hyp_set_vectors(phys_addr_t phys_vector_base);
>  phys_addr_t __hyp_get_vectors(void);
>  
> @@ -60,6 +65,18 @@ static inline bool is_kernel_in_hyp_mode(void)
>  	return el == CurrentEL_EL2;
>  }
>  
> +static inline bool is_kernel_mode_mismatched(void)
> +{
> +	/*
> +	 * A mismatched CPU will have written its own CurrentEL in
> +	 * __run_cpu_mode[1] (initially set to zero) after failing to
> +	 * match the value in __run_cpu_mode[0]. Thus, a non-zero
> +	 * value in __run_cpu_mode[1] is enough to detect the
> +	 * pathological case.
> +	 */
> +	return !!ACCESS_ONCE(__run_cpu_mode[1]);
> +}
> +
>  /* The section containing the hypervisor text */
>  extern char __hyp_text_start[];
>  extern char __hyp_text_end[];
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 2a7134c..bc44cf8 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -577,7 +577,23 @@ ENTRY(set_cpu_boot_mode_flag)
>  1:	str	w20, [x1]			// This CPU has booted in EL1
>  	dmb	sy
>  	dc	ivac, x1			// Invalidate potentially stale cache line
> +	adr_l	x1, __run_cpu_mode
> +	ldr	w0, [x1]
> +	mrs	x20, CurrentEL
> +	cbz	x0, skip_el_check
> +	cmp	x0, x20
> +	bne	mismatched_el

can't you do a ret here instead of writing the same value and flushing
caches etc.?

> +skip_el_check:			// Only the first CPU gets to set the rule
> +	str	w20, [x1]
> +	dmb	sy
> +	dc	ivac, x1	// Invalidate potentially stale cache line
>  	ret
> +mismatched_el:
> +	str	w20, [x1, #4]
> +	dmb	sy
> +	dc	ivac, x1	// Invalidate potentially stale cache line
> +1:	wfi

I'm no expert on SMP bringup, but doesn't this prevent the CPU from
signaling completion and thus you'll never actually reach the checking
code in __cpu_up?

Thanks,
-Christoffer

> +	b	1b
>  ENDPROC(set_cpu_boot_mode_flag)
>  
>  /*
> @@ -592,6 +608,9 @@ ENDPROC(set_cpu_boot_mode_flag)
>  ENTRY(__boot_cpu_mode)
>  	.long	BOOT_CPU_MODE_EL2
>  	.long	BOOT_CPU_MODE_EL1
> +ENTRY(__run_cpu_mode)
> +	.long	0
> +	.long	0
>  	.popsection
>  
>  	/*
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index b1adc51..bc7650a 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -113,6 +113,9 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  			pr_crit("CPU%u: failed to come online\n", cpu);
>  			ret = -EIO;
>  		}
> +
> +		if (is_kernel_mode_mismatched())
> +			panic("CPU%u: incompatible execution level", cpu);
>  	} else {
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
> -- 
> 2.1.4
> 
