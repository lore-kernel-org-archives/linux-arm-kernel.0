From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 May 2014 13:10:32 +0100
Subject: [PATCH] arm: use cpu_online_mask when using forced
 irq_set_affinity
In-Reply-To: <1399653640-21559-1-git-send-email-sudeep.holla@arm.com>
References: <1399653640-21559-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140523121032.GV3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 05:40:40PM +0100, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Commit 01f8fa4f01d8("genirq: Allow forcing cpu affinity of interrupts")
> enabled the forced irq_set_affinity which previously refused to route an
> interrupt to an offline cpu.
> 
> Commit ffde1de64012("irqchip: Gic: Support forced affinity setting")
> implements this force logic and disables the cpu online check for GIC
> interrupt controller.
> 
> When __cpu_disable calls migrate_irqs, it disables the current cpu in
> cpu_online_mask and uses forced irq_set_affinity to migrate the IRQs
> away from the cpu but passes affinity mask with the cpu being offlined
> also included in it.
> 
> When calling irq_set_affinity with force == true in a cpu hotplug path,
> the caller must ensure that the cpu being offlined is not present in the
> affinity mask or it may be selected as the target CPU, leading to the
> interrupt not being migrated.
> 
> This patch uses cpu_online_mask when using forced irq_set_affinity so
> that the IRQs are properly migrated away.
> 
> Tested on TC2 hotpluging CPU0 in and out. Without this patch the system
> locks up as the IRQs are not migrated away from CPU0.

You don't explain /how/ this happens, and I'm not convinced that you've
properly diagnosed this bug.

> @@ -155,11 +155,15 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
>  		return false;
>  
> -	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
> -		affinity = cpu_online_mask;
> +	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids)
>  		ret = true;
> -	}

The idea here with the original code is:

- if the current CPU (which is the one being offlined) is not in the
  affinity mask, do nothing.
- if "affinity & cpu_online_mask" indicates that there's no CPUs in the
  new set (cpu_online_mask must have been updated to indicate that the
  current CPU is offline) then re-set the affinity mask and report that
  we forced a change.
- otherwise, re-set the existing affinity (which will force the IRQ
  controller to re-evaluate it's routing given the affinity and online
  CPUs.)

This code is correct.  In fact, changing it as you have, you /always/
reset the affinity mask whether or not the CPU being offlined is the
last CPU in the affinity set.

If you are finding that CPU0 is left with interrupts afterwards, the
bug lies elsewhere - probably in the IRQ controller code.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
