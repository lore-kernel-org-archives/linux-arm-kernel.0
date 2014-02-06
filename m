From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Feb 2014 11:41:02 +0000
Subject: [PATCH 28/51] arm64, hw_breakpoint.c: Fix CPU hotplug callback
 registration
In-Reply-To: <20140205220944.19080.26519.stgit@srivatsabhat.in.ibm.com>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
 <20140205220944.19080.26519.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20140206114102.GK26035@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 10:09:45PM +0000, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:

[...]

> Fix the hw-breakpoint code in arm64 by using this latter form of callback
> registration.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/arm64/kernel/hw_breakpoint.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index f17f581..24e88d0 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -913,6 +913,8 @@ static int __init arch_hw_breakpoint_init(void)
>  	pr_info("found %d breakpoint and %d watchpoint registers.\n",
>  		core_num_brps, core_num_wrps);
>  
> +	cpu_maps_update_begin();
> +
>  	/*
>  	 * Reset the breakpoint resources. We assume that a halting
>  	 * debugger will leave the world in a nice state for us.
> @@ -927,7 +929,10 @@ static int __init arch_hw_breakpoint_init(void)
>  			      TRAP_HWBKPT, "hw-watchpoint handler");
>  
>  	/* Register hotplug notifier. */
> -	register_cpu_notifier(&hw_breakpoint_reset_nb);
> +	__register_cpu_notifier(&hw_breakpoint_reset_nb);
> +
> +	cpu_maps_update_done();
> +
>  	/* Register cpu_suspend hw breakpoint restore hook */
>  	cpu_suspend_set_dbg_restorer(hw_breakpoint_reset);

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
