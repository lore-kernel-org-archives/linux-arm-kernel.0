From: ccross@google.com (Colin Cross)
Date: Tue, 8 Feb 2011 02:08:36 -0600
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110207141734.GG31929@n2100.arm.linux.org.uk>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinu+ydG0frSeGf9=8PX2A1DLXma1Zfvds6+nws+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 7, 2011 at 8:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

<snip>

> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> new file mode 100644
> index 0000000..9f106fa
> --- /dev/null
> +++ b/arch/arm/kernel/sleep.S
> @@ -0,0 +1,110 @@
> +#include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
> +#include <asm/glue-cache.h>
> +#include <asm/glue-proc.h>
> + ? ? ? .text
> +
> +/*
> + * Save CPU state for a suspend
> + * ?r1 = v:p offset
> + * ?r3 = virtual return function
> + * Note: sp is decremented to allocate space for CPU state on stack
> + * r0-r3,r9,r10,lr corrupted
> + */
> +ENTRY(cpu_suspend)
> + ? ? ? mov ? ? r9, lr
> +#ifdef MULTI_CPU
> + ? ? ? ldr ? ? r10, =processor
> + ? ? ? mov ? ? r2, sp ? ? ? ? ? ? ? ? ?@ current virtual SP
> + ? ? ? ldr ? ? r0, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
> + ? ? ? ldr ? ? ip, [r10, #CPU_DO_RESUME] @ virtual resume function
> + ? ? ? sub ? ? sp, sp, r0 ? ? ? ? ? ? ?@ allocate CPU state on stack
> + ? ? ? mov ? ? r0, sp ? ? ? ? ? ? ? ? ?@ save pointer
> + ? ? ? add ? ? ip, ip, r1 ? ? ? ? ? ? ?@ convert resume fn to phys
> + ? ? ? stmfd ? sp!, {r1, r2, r3, ip} ? @ save v:p, virt SP, retfn, phys resume fn
> + ? ? ? ldr ? ? r3, =sleep_save_sp
The global variable will prevent using this function to save the state
of multiple CPUs during idle.

<snip>

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 0c1172b..a5187dd 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S

<snip>

> +/* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
> +.globl cpu_v7_suspend_size
> +.equ ? cpu_v7_suspend_size, 4 * 8
> +#ifdef CONFIG_PM
> +ENTRY(cpu_v7_do_suspend)
> + ? ? ? stmfd ? sp!, {r4 - r11, lr}
> + ? ? ? mrc ? ? p15, 0, r4, c13, c0, 0 ?@ FCSE/PID
> + ? ? ? mrc ? ? p15, 0, r5, c13, c0, 1 ?@ Context ID
> + ? ? ? mrc ? ? p15, 0, r6, c3, c0, 0 ? @ Domain ID
> + ? ? ? mrc ? ? p15, 0, r7, c2, c0, 0 ? @ TTB 0
> + ? ? ? mrc ? ? p15, 0, r8, c2, c0, 1 ? @ TTB 1
> + ? ? ? mrc ? ? p15, 0, r9, c1, c0, 0 ? @ Control register
> + ? ? ? mrc ? ? p15, 0, r10, c1, c0, 1 ?@ Auxiliary control register
> + ? ? ? mrc ? ? p15, 0, r11, c1, c0, 2 ?@ Co-processor access control
> + ? ? ? stmia ? r0, {r4 - r11}
> + ? ? ? ldmfd ? sp!, {r4 - r11, pc}
> +ENDPROC(cpu_v7_do_suspend)

Should the FIQ banked registers be saved in here, or by the driver
that set them?
