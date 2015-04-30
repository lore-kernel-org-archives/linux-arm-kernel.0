From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Apr 2015 10:50:55 +0100
Subject: [PATCH arm 1/2] arm64: Use common outgoing-CPU-notification code
In-Reply-To: <1429819654-10498-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20150423200603.GA9473@linux.vnet.ibm.com>
 <1429819654-10498-1-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <20150430095055.GI18867@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Apr 23, 2015 at 01:07:33PM -0700, Paul E. McKenney wrote:
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 328b8ce4b007..6dc727a6e73e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -252,15 +252,13 @@ static int op_cpu_kill(unsigned int cpu)
>  	return cpu_ops[cpu]->cpu_kill(cpu);
>  }
>  
> -static DECLARE_COMPLETION(cpu_died);
> -
>  /*
>   * called on the thread which is asking for a CPU to be shutdown -
>   * waits until shutdown has completed, or it is timed out.
>   */
>  void __cpu_die(unsigned int cpu)
>  {
> -	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> +	if (!cpu_wait_death(cpu, 5)) {
>  		pr_crit("CPU%u: cpu didn't die\n", cpu);
>  		return;
>  	}
> @@ -293,7 +291,7 @@ void cpu_die(void)
>  	local_irq_disable();
>  
>  	/* Tell __cpu_die() that this CPU is now safe to dispose of */
> -	complete(&cpu_died);
> +	(void)cpu_report_death();
>  
>  	/*
>  	 * Actually shutdown the CPU. This must never fail. The specific hotplug

Are these functions are only defined when HOTPLUG_CPU is enabled? On
arm64 we can end up with this option disabled if SUSPEND is disabled.

-- 
Catalin
