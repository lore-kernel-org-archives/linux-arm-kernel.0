From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Dec 2010 12:35:18 +0000
Subject: [PATCH v5 5/5] msm: add SMP support for msm
In-Reply-To: <1292302233-16194-6-git-send-email-johlstei@codeaurora.org>
References: <1292302233-16194-1-git-send-email-johlstei@codeaurora.org>
	<1292302233-16194-6-git-send-email-johlstei@codeaurora.org>
Message-ID: <AANLkTimnuTcv+5cWNzvV-Z=1LHsAmTojDSBJMjjOs7K+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 December 2010 04:50, Jeff Ohlstein <johlstei@codeaurora.org> wrote:
> --- /dev/null
> +++ b/arch/arm/mach-msm/headsmp.S
[...]
> +ENTRY(msm_secondary_startup)
> + ? ? ? mrc ? ? p15, 0, r0, c0, c0, 5 ? @ MPIDR
> + ? ? ? and ? ? r0, r0, #15 ? ? ? ? ? ? @ What CPU am I
> + ? ? ? adr ? ? r4, 1f ? ? ? ? ? ? ? ? ?@ address of
> + ? ? ? ldmia ? r4, {r5, r6} ? ? ? ? ? ?@ load curr addr and pen_rel addr
> + ? ? ? sub ? ? r4, r4, r5 ? ? ? ? ? ? ?@ determine virtual/phys offsets
> + ? ? ? add ? ? r6, r6, r4 ? ? ? ? ? ? ?@ apply
> +pen:
> + ? ? ? wfe
> + ? ? ? dsb ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ ensure subsequent access is
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ after event

As I wrote in a different e-mail, this DSB isn't actually needed as
the processor shouldn't speculate beyond the WFE. But it's harmless
anyway.

> --- /dev/null
> +++ b/arch/arm/mach-msm/platsmp.c
[...]
> +int boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> + ? ? ? static int cold_boot_done;
> + ? ? ? unsigned long timeout;
> + ? ? ? printk(KERN_DEBUG "Starting secondary CPU %d\n", cpu);
> +
> + ? ? ? if (cold_boot_done == false) {
> + ? ? ? ? ? ? ? prepare_cold_cpu(cpu);
> + ? ? ? ? ? ? ? cold_boot_done = true;
> + ? ? ? }
> +
> + ? ? ? pen_release = cpu;
> + ? ? ? __cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
> + ? ? ? outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
> + ? ? ? __asm__("sev");
> + ? ? ? dsb();

What's the need for the dsb() here (one before SEV maybe)?

Also, do we need to add a "memory" clobber to the SEV asm, not sure
whether the compiler would try to reorder the code.

-- 
Catalin
