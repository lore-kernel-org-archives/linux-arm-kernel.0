From: ccross@google.com (Colin Cross)
Date: Fri, 11 Feb 2011 18:52:55 -0800
Subject: [PATCH 6/6] ARM: pm: allow generic sleep code to be used with SMP
	CPU idle
In-Reply-To: <E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTik=NTwJHo7CfmbJm+MwjdVPQnvV96fpmk3ymcAL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 8:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Allow the generic sleep code to be used with SMP CPU idle by storing
> N CPU stack pointers rather than just one.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/kernel/sleep.S | ? 26 +++++++++++++++++++++++++-
> ?1 files changed, 25 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 9f106fa..e10618f 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -25,7 +25,14 @@ ENTRY(cpu_suspend)
> ? ? ? ?stmfd ? sp!, {r1, r2, r3, ip} ? @ save v:p, virt SP, retfn, phys resume fn
> ? ? ? ?ldr ? ? r3, =sleep_save_sp
> ? ? ? ?add ? ? r2, sp, r1 ? ? ? ? ? ? ?@ convert SP to phys
> +#ifdef CONFIG_SMP
> + ? ? ? ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
> + ? ? ? ALT_UP(mov lr, #0)
> + ? ? ? and ? ? lr, lr, #15
> + ? ? ? str ? ? r2, [r3, lr, lsl #2] ? ?@ save phys SP
> +#else
> ? ? ? ?str ? ? r2, [r3] ? ? ? ? ? ? ? ?@ save phys SP
> +#endif
> ? ? ? ?mov ? ? lr, pc
> ? ? ? ?ldr ? ? pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
> ?#else
> @@ -36,7 +43,14 @@ ENTRY(cpu_suspend)
> ? ? ? ?stmfd ? sp!, {r1, r2, r3} ? ? ? @ save v:p, virt SP, return fn
> ? ? ? ?ldr ? ? r3, =sleep_save_sp
> ? ? ? ?add ? ? r2, sp, r1 ? ? ? ? ? ? ?@ convert SP to phys
> +#ifdef CONFIG_SMP
> + ? ? ? ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
> + ? ? ? ALT_UP(mov lr, #0)
> + ? ? ? and ? ? lr, lr, #15
> + ? ? ? str ? ? r2, [r3, lr, lsl #2] ? ?@ save phys SP
> +#else
> ? ? ? ?str ? ? r2, [r3] ? ? ? ? ? ? ? ?@ save phys SP
> +#endif
> ? ? ? ?bl ? ? ?cpu_do_suspend
> ?#endif
>
> @@ -96,7 +110,15 @@ cpu_resume_after_mmu:
> ? ? ? ?.data
> ? ? ? ?.align
> ?ENTRY(cpu_resume)
> +#ifdef CONFIG_SMP
> + ? ? ? adr ? ? r0, sleep_save_sp
> + ? ? ? ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
> + ? ? ? ALT_UP(mov r1, #0)
> + ? ? ? and ? ? r1, r1, #15
> + ? ? ? ldr ? ? r0, [r0, r1, lsl #2] ? ?@ stack phys addr
> +#else
> ? ? ? ?ldr ? ? r0, sleep_save_sp ? ? ? @ stack phys addr
> +#endif
> ? ? ? ?msr ? ? cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE @ set SVC, irqs off
> ?#ifdef MULTI_CPU
> ? ? ? ?ldmia ? r0!, {r1, sp, lr, pc} ? @ load v:p, stack, return fn, resume fn
> @@ -107,4 +129,6 @@ ENTRY(cpu_resume)
> ?ENDPROC(cpu_resume)
>
> ?sleep_save_sp:
> - ? ? ? .word ? 0 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ preserve stack phys ptr here
> + ? ? ? .rept ? CONFIG_NR_CPUS
> + ? ? ? .long ? 0 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ preserve stack phys ptr here
> + ? ? ? .endr
> --
> 1.6.2.5

Acked-by: Colin Cross <ccross@android.com>

Tested with idle and suspend on Tegra 2.
