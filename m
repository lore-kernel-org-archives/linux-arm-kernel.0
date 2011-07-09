From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 09:38:15 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110709083815.GE4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:50:18PM +0100, Lorenzo Pieralisi wrote:
> +static int late_init(void)
> +{
> +	int rc;
> +	struct sr_cluster *cluster;
> +	int cluster_index, cpu_index = sr_platform_get_cpu_index();

Stop this madness, and use the standard linux APIs like smp_processor_id
here.  It might actually help you find bugs, like the fact that you're
in a preemptible context here, and so could be rescheduled onto any other
CPU in the system _after_ you've read the MPIDR register.

> +
> +	cluster_index = sr_platform_get_cluster_index();
> +	cluster = main_table.cluster_table + cluster_index;
> +	main_table.os_mmu_context[cluster_index][cpu_index] =
> +				current->active_mm->pgd;
> +	cpu_switch_mm(main_table.fw_mmu_context, current->active_mm);
> +	rc = sr_platform_init();
> +	cpu_switch_mm(main_table.os_mmu_context[cluster_index][cpu_index],
> +				current->active_mm);

CPU numbers are unique in the system, why do you need a 'cluster_index'
to save this?  In fact why do you even need to save it in a structure
at all?

Plus, "cluster" is not used, please get rid of it.

Plus, here you just switch the page tables without a MMU flush.  Further
down in this file you call cpu_switch_mm() but also flush the TLB.  Why
that difference?

If this is the state of just the first bit of this I've looked at, plus
the comments from Frank on your use of internal functions like
cpu_do_suspend and cpu_do_resume, I don't want to look at it any further.
Can you please clean it up as best you can first.
