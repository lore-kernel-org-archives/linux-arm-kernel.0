From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Aug 2014 09:19:24 +0100
Subject: [PATCH v8 01/11] ARM: brcmstb: add infrastructure for
 ARM-based Broadcom STB SoCs
In-Reply-To: <1405976886-27807-2-git-send-email-computersforpeace@gmail.com>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <1405976886-27807-2-git-send-email-computersforpeace@gmail.com>
Message-ID: <20140802081924.GW30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's some more comments on this.

On Mon, Jul 21, 2014 at 02:07:56PM -0700, Brian Norris wrote:
> +static void brcmstb_cpu_die(u32 cpu)
> +{
> +	v7_exit_coherency_flush(all);

This is ultimately what causes my builds to break:

/tmp/ccSPowmq.s:171: Error: selected processor does not support ARM mode `isb '
/tmp/ccSPowmq.s:177: Error: selected processor does not support ARM mode `isb '
/tmp/ccSPowmq.s:178: Error: selected processor does not support ARM mode `dsb '
make[2]: *** [arch/arm/mach-bcm/platsmp-brcmstb.o] Error 1

It seems that v7_exit_coherency_flush() can only be used with code which
is ARMv7 only.

> +	/* Prevent all interrupts from reaching this CPU. */
> +	arch_local_irq_disable();

Why do you think it is necessary to disable interrupts here?  Where
have they been re-enabled since this bit of generic code:

void __ref cpu_die(void)
{
        unsigned int cpu = smp_processor_id();

        idle_task_exit();

        local_irq_disable();

and why arch_local_irq_disable() at that?  Even if interrupts were
enabled prior to your call to arch_local_irq_disable(), what do you
think would be the effect of receiving an interrupt after you've
exited coherency?

> +
> +	/*
> +	 * Final full barrier to ensure everything before this instruction has
> +	 * quiesced.
> +	 */
> +	isb();
> +	dsb();

If the call to arch_local_irq_disable() is removed, and
v7_exit_coherency_flush() is fixed, then this is not required, because
v7_exit_coherency_flush() already does this at the very end.

> +
> +	per_cpu_sw_state_wr(cpu, 0);
> +
> +	/* Sit and wait to die */
> +	wfi();
> +
> +	/* We should never get here... */
> +	panic("Spurious interrupt on CPU %d received!\n", cpu);

You really should /not/ be calling panic here, because that uses data
shared with the CPUs which are still coherent.  This is akin to doing
DMA into bits of the kernel space without dealing with the cache
coherency issues.  Moreover, if you read the comments on
v7_exit_coherency_flush() about ldrex/strex, which are two instructions
spinlocks use, you'll see that ldrex/strex must not be executed, which
means you can't call any function which uses spinlocks.  That rules
out printk() et.al.  printascii is fine, but that's only available when
the low level debug stuff is enabled.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
