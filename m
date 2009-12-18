From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 18:20:07 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <20091218180406.32211.72790.stgit@e101986-lin>
References: <20091218180406.32211.72790.stgit@e101986-lin>
Message-ID: <20091218182007.GF5527@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 06:04:06PM +0000, Leif Lindholm wrote:
> +static int swp_handler(struct pt_regs *regs, unsigned int instr)
> +{
> +	unsigned int address, destreg, data;
> +	unsigned int res = 0;
> +	long current_pid = sys_getpid();

Kernel functions calling system calls like this is frowned upon.  We
know what the current PID is - it's available from current->pid.  No
function call required.

> +/*
> + * Register handler and create status file in /proc/cpu
> + * Invoked as late_initcall, since not needed before init spawned.
> + */
> +static int __init swp_emulation_init(void)
> +{
> +#ifdef CONFIG_PROC_FS
> +	struct proc_dir_entry *res;
> +
> +#ifndef CONFIG_ALIGNMENT_TRAP
> +	res = proc_mkdir("cpu", NULL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res = create_proc_entry("swp_emulation", S_IRUGO, res);
> +#else
> +	res = create_proc_entry("cpu/swp_emulation", S_IRUGO, NULL);
> +#endif

This needs to be cleaned up - we should probably always create the "cpu"
directory so that these don't have to worry about whether it exists or
not.

> +	  NOTE: when accessing uncached shared regions, LDREX/STREX rely
> +	  on an external transaction monitoring block called a global
> +	  monitor to maintain update atomicity. If your system does not
> +	  implement a global monitor, this option is not safe for programs
> +	  that are permitted to map uncached memory (CAP_SYS_RAWIO).

We can trap this case by looking at the L_PTE_MT_* bits in the pte
for the page we're going to be accessing - that's probably a good
idea to ensure that such accesses are trapped, rather than going
head and possibly risking silent corruption.
