From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 7 Jun 2011 12:22:58 +0100 (BST)
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to
	a physical address
In-Reply-To: <1307379898-14256-5-git-send-email-will.deacon@arm.com>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
	<1307379898-14256-5-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.DEB.2.00.1106071126290.2247@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 6 Jun 2011, Will Deacon wrote:

> Tools such as kexec and CPU hotplug require a way to reset the processor
> and branch to some code in physical space. This requires various bits of
> jiggery pokery with the caches and MMU which, when it goes wrong, tends
> to lock up the system.
>
> This patch implements a new function, arm_machine_reset, for
> consolidating this code in one place where it can be used by multiple
> subsystems.
>
[ ... ]
> +void arm_machine_reset(unsigned long reset_code_phys)
> +{
> +	unsigned long cpu_reset_end = PAGE_ALIGN((unsigned long)cpu_reset);
> +	/* This is stricter than necessary but better to be safe than sorry. */
> +	BUG_ON(virt_to_phys((void *)cpu_reset_end) >= TASK_SIZE);
> +
> +	/* Disable interrupts first */
> +	local_irq_disable();
> +	local_fiq_disable();
> +
> +	/*
> +	 * Clean and invalidate L2.
> +	 * This is racy, so we must be the last guy left.
> +	 */
> +	WARN_ON(num_online_cpus() > 1);
> +	/* Flush while we still have locking available to us. */
> +	outer_flush_all();
> +	outer_disable();
> +	/* Data destroyed here will only be speculative. */
> +	outer_inv_all();
> +
> +	prepare_for_reboot(0);
> +
> +	/* Switch to the identity mapping. */
> +	((typeof(cpu_reset) *)virt_to_phys((void *)cpu_reset))(reset_code_phys);

void (*reset_func)(unsigned long) = virt_to_phys(cpu_reset)

> +}
> +
> /*
>  * Function pointers to optional machine specific functions
>  */
> -- 
> 1.7.0.4
>
>
