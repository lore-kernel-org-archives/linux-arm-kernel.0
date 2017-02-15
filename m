From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 11:43:27 +0000
Subject: [PATCH RFC 2/3] coresight: add support for debug module
In-Reply-To: <1486966298-16767-3-git-send-email-leo.yan@linaro.org>
References: <1486966298-16767-1-git-send-email-leo.yan@linaro.org>
 <1486966298-16767-3-git-send-email-leo.yan@linaro.org>
Message-ID: <20170215114327.GE31733@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 02:11:37PM +0800, Leo Yan wrote:
> Coresight includes debug module and usually the module connects with CPU
> debug logic. ARMv8 architecture reference manual (ARMv8-ARM) has defined
> the debug registers in the chapter "H9: External Debug Register
> Descriptions".

This should have been in the binding description also.

The layout of the ARM ARM can change over time, so please refer to the
full document number, which can be found at the bottom of each page
(e.g. ARM DDI 0487A.j).

> After enable the debug module we can check CPU state and PC value, etc.
> So this is helpful for some CPU lockup bugs, e.g. if one CPU has run
> into infinite loop with IRQ disabled. So the CPU cannot switch context
> and handle any interrupt, so it cannot handle SMP call for stack dump,
> etc. Furthermore, now ARMv8 introduces some other runtime firmwares like
> ARM trusted firmware BL31, so sometime CPU hard lock may happen in the
> firmware and cannot return back to kernel.

I would generally expect that the secure world would lock down
debugging, as this poses a security risk.

I take it that this is only unlocked on development firmware.

Given that cores can be powered down outside of our control, I'm not
sure that accesses to these registers is safe in general.

> This patch is to enable coresight debug module and register callback
> notifier for panic; so when system detect the CPU lockup we can utilize
> debug module registers to get to know PC value for all CPUs; so we can
> quickly know the hang address for CPUs.
>
> This is initial driver for coresight debug module and could enhance it
> later according to debugging requirement.

How does this interact with an external debugger making use of these
registers?

[...]

> +static struct debug_drvdata *debug_drvdata[NR_CPUS];

A per-cpu variable is preferred to an NR_CPUS sized array.

> +
> +static void debug_os_unlock(struct debug_drvdata *drvdata)
> +{
> +     /* Unlocks the debug registers */
> +     writel_relaxed(0x0, drvdata->base + EDOSLAR);
> +     isb();
> +}

I do not believe this barrier is correct.

[...]

> +static void debug_read_pcsr(struct debug_drvdata *drvdata)
> +{
> +     u32 pcsr_hi, pcsr_lo;
> +
> +     CS_UNLOCK(drvdata->base);
> +
> +     debug_os_unlock(drvdata);
> +
> +#ifdef CONFIG_64BIT
> +     pcsr_lo = readl_relaxed(drvdata->base + EDPCSR_LO);
> +     pcsr_hi = readl_relaxed(drvdata->base + EDPCSR_HI);
> +
> +     pr_emerg("CPU[%d]: PSCR=0x%lx\n", drvdata->cpu,
> +              ((unsigned long)pcsr_hi << 32 | (unsigned long)pcsr_lo));
> +#else
> +     pcsr_lo = readl_relaxed(drvdata->base + EDPCSR_LO);
> +
> +     pr_emerg("CPU[%d]: PSCR=0x%lx\n", drvdata->cpu, pcsr_lo);
> +#endif
> +
> +     CS_LOCK(drvdata->base);
> +}

Per ARM DDI 0487A.k_iss10775, H9.2.32, "EDPCSR, External Debug Program
Counter Sample Register":

        Implemented only if the OPTIONAL PC Sample-based Profiling
        Extension is implemented.

So even if we have access to an MMIO debug interface, we cannot
necessarily acecess this register.

[...]

> +/*
> + * Dump out memory limit information on panic.
> + */
> +static int dump_debug(struct notifier_block *self, unsigned long v, void *p)
> +{
> +     int i;
> +
> +     pr_emerg("Coresight debug module:\n");
> +
> +     for_each_possible_cpu(i) {
> +
> +             if (!debug_drvdata[i])
> +                     continue;
> +
> +             debug_read_pcsr(debug_drvdata[i]);
> +     }

Is there no potential for deadlock with a CPU reading its own debug
interface registers?

[...]

> +static struct amba_id debug_ids[] = {
> +     {       /* Debug for Cortex-A53 */
> +             .id     = 0x000bbd03,
> +             .mask   = 0x000fffff,
> +             .data   = "debug",
> +     },
> +     { 0, 0},
> +};

The DT binding said nothing about Cortex-A53.

How variable are the MMIO registers in practice? Do we need to know the
particular CPU?

Thanks,
Mark.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
