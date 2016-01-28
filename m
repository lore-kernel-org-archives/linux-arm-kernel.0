From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 28 Jan 2016 11:30:52 -0500 (EST)
Subject: [PATCH 2/2] ARM: shmobile: Move shmobile_smp_{mpidr,fn,arg}[]
 from .text to .data
In-Reply-To: <1453993462-12210-3-git-send-email-geert+renesas@glider.be>
References: <1453993462-12210-1-git-send-email-geert+renesas@glider.be>
 <1453993462-12210-3-git-send-email-geert+renesas@glider.be>
Message-ID: <alpine.LFD.2.20.1601281124140.19789@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jan 2016, Geert Uytterhoeven wrote:

> When CONFIG_ARM_KERNMEM_PERMS=y and CONFIG_DEBUG_RODATA=y, the kernel
> crashes during system suspend:
> 
>     Freezing user space processes ... (elapsed 0.004 seconds) done.
>     Freezing remaining freezable tasks ... (elapsed 0.002 seconds)
>     done.
>     PM: suspend of devices complete after 111.948 msecs
>     PM: late suspend of devices complete after 1.086 msecs
>     PM: noirq suspend of devices complete after 11.576 msecs
>     Disabling non-boot CPUs ...
>     Kernel panic - not syncing: Attempted to kill the idle task!
>     1014ec ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>     CPU0: stopping
> 
> This happens because the .text section is marked read-only, while the
> arrays shmobile_smp_mpidr[], shmobile_smp_fn[], and shmobile_smp_arg[]
> are being written to.
> 
> Fix this by moving these arrays from the .text to the .data section.
> This requires accessing them through a pointer after virtual to physical
> translation.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-shmobile/headsmp.S | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
> index 330c1fc63197df89..f924273ceaf476b4 100644
> --- a/arch/arm/mach-shmobile/headsmp.S
> +++ b/arch/arm/mach-shmobile/headsmp.S
> @@ -50,9 +50,12 @@ ENTRY(shmobile_smp_boot)
>  	mrc	p15, 0, r1, c0, c0, 5		@ r1 = MPIDR
>  	and	r0, r1, r0			@ r0 = cpu_logical_map() value
>  	mov	r1, #0				@ r1 = CPU index
> -	adr	r5, 1f				@ array of per-cpu mpidr values
> -	adr	r6, 2f				@ array of per-cpu functions
> -	adr	r7, 3f				@ array of per-cpu arguments
> +	adr	r2, 1f
> +	ldmia	r2, {r4, r5, r6, r7}
> +	sub	r2, r2, r4			@ virt->phys offset
> +	add	r5, r5, r2			@ array of per-cpu mpidr values
> +	add	r6, r6, r2			@ array of per-cpu functions
> +	add	r7, r7, r2			@ array of per-cpu arguments

You could do something slightly more efficient like this:

	adr	r2, 1f
	ldmia	r2, {r5, r6, r7}
	add	r5, r5, r2
	add	r6, r6, r2
	add	r7, r7, r2

[...]

1:	.long	shmobile_smp_mpidr - .
	.long	shmobile_smp_fn - 1b
	.long	shmobile_smp_arg - 1b


Nicolas
