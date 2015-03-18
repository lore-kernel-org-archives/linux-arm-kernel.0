From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Mar 2015 18:13:15 +0000
Subject: [PATCH v5 8/8] arm64: enforce x1|x2|x3 == 0 upon kernel entry as
 per boot protocol
In-Reply-To: <1426690527-14258-9-git-send-email-ard.biesheuvel@linaro.org>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426690527-14258-9-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150318181315.GH19814@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 02:55:27PM +0000, Ard Biesheuvel wrote:
> According to the arm64 boot protocol, registers x1 to x3 should be
> zero upon kernel entry, and non-zero values are reserved for future
> use. This future use is going to be problematic if we never enforce
> the current rules, so start enforcing them now, by emitting a warning
> if non-zero values are detected.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S  |  4 ++++
>  arch/arm64/kernel/setup.c | 15 +++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index a0fbd99efb89..8636c3cef006 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -233,6 +233,10 @@ section_table:
>  #endif
>  
>  ENTRY(stext)
> +	adr_l	x8, boot_regs			// record the contents of
> +	stp	x0, x1, [x8]			// x0 .. x3 at kernel entry
> +	stp	x2, x3, [x8, #16]

I think we should have a dc ivac here as we do for
set_cpu_boot_mode_flag.

That avoids a potential issue with boot_regs sharing a cacheline with
data we write with the MMU on -- using __flush_dcache_area will result
in a civac, so we could write back dirty data atop of the boot_regs if
there were clean entries in the cache when we did the non-cacheable
write.

Mark.

> +
>  	mov	x21, x0				// x21=FDT
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
>  	adrp	x24, __PHYS_OFFSET
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 6c5fb5aff325..2d5cae2de679 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -114,6 +114,11 @@ void __init early_print(const char *str, ...)
>  	printk("%s", buf);
>  }
>  
> +/*
> + * The recorded values of x0 .. x3 upon kernel entry.
> + */
> +u64 __read_mostly boot_regs[4];
> +
>  void __init smp_setup_processor_id(void)
>  {
>  	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> @@ -387,6 +392,16 @@ void __init setup_arch(char **cmdline_p)
>  	conswitchp = &dummy_con;
>  #endif
>  #endif
> +	/*
> +	 * boot_regs[] is written by the boot CPU with the caches off, so we
> +	 * need to ensure that we read the value from main memory
> +	 */
> +	__flush_dcache_area(boot_regs, sizeof(boot_regs));
> +	if (boot_regs[1] || boot_regs[2] || boot_regs[3]) {
> +		pr_err("WARNING: boot protocol violation detected (x1 == %llx, x2 == %llx, x3 == %llx)\n",
> +			boot_regs[1], boot_regs[2], boot_regs[3]);
> +		pr_err("WARNING: your bootloader may fail to load newer kernels\n");
> +	}
>  }
>  
>  static int __init arm64_device_init(void)
> -- 
> 1.8.3.2
> 
> 
