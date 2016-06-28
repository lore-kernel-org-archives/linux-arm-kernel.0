From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 18:16:10 +0100
Subject: [PATCH v3 2/7] arm64: vmlinux.ld: Add .mmuoff.{text,data} sections
In-Reply-To: <1467125510-18758-3-git-send-email-james.morse@arm.com>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
 <1467125510-18758-3-git-send-email-james.morse@arm.com>
Message-ID: <20160628171610.GT31744@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

This looks mostly fine.

On Tue, Jun 28, 2016 at 03:51:45PM +0100, James Morse wrote:
> Resume from hibernate needs to clean any text executed by the kernel with
> the MMU off to the PoC. Collect these functions together into a new
> .mmuoff.text section. __boot_cpu_mode and secondary_holding_pen_release
> are data that is read or written with the MMU off. Add these to a new
> .mmuoff.data section.
> 
> This covers booting of secondary cores and the cpu_suspend() path used
> by cpu-idle and suspend-to-ram.
> 
> The bulk of head.S is not included, as the primary boot code is only ever
> executed once, the kernel never needs to ensure it is cleaned to a
> particular point in the cache.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * mmuoff.data section added
>  * secondary_holding_pen_release initialisation moved to head.S
>  * secondary_holding_pen and set_cpu_boot_mode_flag moved into mmuoff.text
> 
>  arch/arm64/include/asm/sections.h  |  2 ++
>  arch/arm64/kernel/head.S           | 10 +++++++++-
>  arch/arm64/kernel/sleep.S          |  2 ++
>  arch/arm64/kernel/smp_spin_table.c |  2 +-
>  arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
>  arch/arm64/mm/proc.S               |  4 ++++
>  6 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
> index cb68eb348566..7eecfa110330 100644
> --- a/arch/arm64/include/asm/sections.h
> +++ b/arch/arm64/include/asm/sections.h
> @@ -24,5 +24,7 @@ extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
>  extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
>  extern char __hyp_text_start[], __hyp_text_end[];
>  extern char __idmap_text_start[], __idmap_text_end[];
> +extern char __mmuoff_text_start[], __mmuoff_text_end[];
> +extern char __mmuoff_data_start[], __mmuoff_data_end[];
>  
>  #endif /* __ASM_SECTIONS_H */
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 2c6e598a94dc..6e56cd136d27 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -52,6 +52,9 @@
>  #error TEXT_OFFSET must be less than 2MB
>  #endif
>  
> +/* INVALID_HWID is defined as ULONG_MAX, but we can't include linux/kernel.h */
> +#define ULONG_MAX ~0

We could avoid the duplication and simplify the change using __section()
in smp_spin_table.c, e.g.

volatile unsigned long __section(".mmuoff.data) 
secondary_holding_pen_release = INVALID_HWID

> +
>  /*
>   * Kernel startup entry point.
>   * ---------------------------
> @@ -477,6 +480,7 @@ ENTRY(kimage_vaddr)
>   * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
>   * booted in EL1 or EL2 respectively.
>   */
> +	.pushsection ".mmuoff.text", "ax"
>  ENTRY(el2_setup)
>  	mrs	x0, CurrentEL
>  	cmp	x0, #CurrentEL_EL2
> @@ -627,11 +631,14 @@ ENDPROC(set_cpu_boot_mode_flag)
>   * This is not in .bss, because we set it sufficiently early that the boot-time
>   * zeroing of .bss would clobber it.
>   */
> -	.pushsection	.data..cacheline_aligned
> +	.pushsection ".mmuoff.data", "aw"
>  	.align	L1_CACHE_SHIFT
>  ENTRY(__boot_cpu_mode)
>  	.long	BOOT_CPU_MODE_EL2
>  	.long	BOOT_CPU_MODE_EL1

We might need to pad things in .mmuoff.data to the CWG.

__boot_cpu_mode is written with the MMU off, and read with the MMU on,
while secondary_holding_pen_release is written with the MMU on and read
with the MMU off.

Maintenance for either could corrupt one or the other, if they fall in
the same CWG.

Other than that, this looks good to me.

Thanks,
Mark.
