From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 13:36:12 +0000
Subject: [PATCH v3] arm64: enforce x1|x2|x3 == 0 upon kernel entry as per
 boot protocol
In-Reply-To: <1426762852-13699-1-git-send-email-ard.biesheuvel@linaro.org>
References: <20150319104100.GB18473@leverpostej>
 <1426762852-13699-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150319133612.GD18473@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 11:00:52AM +0000, Ard Biesheuvel wrote:
> According to the arm64 boot protocol, registers x1 to x3 should be
> zero upon kernel entry, and non-zero values are reserved for future
> use. This future use is going to be problematic if we never enforce
> the current rules, so start enforcing them now, by emitting a warning
> if non-zero values are detected.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S  | 19 ++++++++++++++++++-
>  arch/arm64/kernel/setup.c | 10 ++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index f5ac337f9598..1fdf42041f42 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -233,7 +233,7 @@ section_table:
>  #endif
>  
>  ENTRY(stext)
> -	mov	x21, x0				// x21=FDT
> +	bl	preserve_boot_args
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
>  	adrp	x24, __PHYS_OFFSET
>  	bl	set_cpu_boot_mode_flag
> @@ -253,6 +253,23 @@ ENTRY(stext)
>  ENDPROC(stext)
>  
>  /*
> + * Preserve the arguments passed by the bootloader in x0 .. x3
> + */
> +preserve_boot_args:
> +	mov	x21, x0				// x21=FDT
> +
> +	adr_l	x0, boot_args			// record the contents of
> +	stp	x21, x1, [x0]			// x0 .. x3 at kernel entry
> +	stp	x2, x3, [x0, #16]
> +
> +	dmb	sy				// needed before dc ivac with
> +						// MMU off
> +
> +	add	x1, x0, #0x20			// 4 x 8 bytes
> +	b	__inval_cache_range		// tail call
> +ENDPROC(preserve_boot_args)
> +
> +/*
>   * Determine validity of the x21 FDT pointer.
>   * The dtb must be 8-byte aligned and live in the first 512M of memory.
>   */
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 1783b38cf4c0..2f384019b201 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -115,6 +115,11 @@ void __init early_print(const char *str, ...)
>  	printk("%s", buf);
>  }
>  
> +/*
> + * The recorded values of x0 .. x3 upon kernel entry.
> + */
> +u64 __cacheline_aligned boot_args[4];

All the above looks correct to me.

> +
>  void __init smp_setup_processor_id(void)
>  {
>  	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> @@ -412,6 +417,11 @@ void __init setup_arch(char **cmdline_p)
>  	conswitchp = &dummy_con;
>  #endif
>  #endif
> +	if (boot_args[1] || boot_args[2] || boot_args[3]) {
> +		pr_err("WARNING: boot protocol violation detected (x1 == %llx, x2 == %llx, x3 == %llx)\n",
> +			boot_args[1], boot_args[2], boot_args[3]);
> +		pr_err("WARNING: your bootloader may fail to load newer kernels\n");

If we ever decide to use x1-x3 for something, and try to boot an older
kernel, that warning is going to be a bit misleading. That could matter
for VMs where we're going to see old kernel images for a long time.

I would like the warning to mention that could be the case.

It would also be nice if the message were consistently spaced regardless
of the values of x1-x3, so we should zero-pad them (and as that takes a
resonable amount of space, let's give them a line each).

So could we change the warning to be something like:

	pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
	       "\tx1: %016llx\n\tx2: %016llx\n\tx3: %016llx\n"
	       "This indicates a broken bootloader or old kernel\n",
	       boot_args[1], boot_args[2], boot_args[3]);

With that,

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
