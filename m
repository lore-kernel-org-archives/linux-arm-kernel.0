From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Apr 2016 12:37:06 +0100
Subject: [PATCH] arm64: Reduce verbosity on SMP CPU stop
In-Reply-To: <1460715876-10780-1-git-send-email-jglauber@cavium.com>
References: <1460715876-10780-1-git-send-email-jglauber@cavium.com>
Message-ID: <20160415113706.GE22906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 12:24:36PM +0200, Jan Glauber wrote:
> When CPUs are stopped during an abnormal operation like panic
> for each CPU a line is printed and the stack trace is dumped.
> 
> This information is only interesting for the aborting CPU
> and on systems with many CPUs it only makes it harder to
> debug if after the aborting CPU the log is flooded with data
> about all other CPUs too.
> 
> Therefore remove the stack dump and printk of other CPUs
> and only print a single line that the other CPUs are going to be
> stopped.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  arch/arm64/kernel/smp.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index b2d5f4e..e6c2eb1 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -770,14 +770,6 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
>   */
>  static void ipi_cpu_stop(unsigned int cpu)
>  {
> -	if (system_state == SYSTEM_BOOTING ||
> -	    system_state == SYSTEM_RUNNING) {
> -		raw_spin_lock(&stop_lock);
> -		pr_crit("CPU%u: stopping\n", cpu);
> -		dump_stack();
> -		raw_spin_unlock(&stop_lock);
> -	}
> -
>  	set_cpu_online(cpu, false);
>  
>  	local_irq_disable();
> @@ -872,6 +864,9 @@ void smp_send_stop(void)
>  		cpumask_copy(&mask, cpu_online_mask);
>  		cpumask_clear_cpu(smp_processor_id(), &mask);
>  
> +		if (system_state == SYSTEM_BOOTING ||
> +		    system_state == SYSTEM_RUNNING)
> +			pr_crit("SMP: stopping secondary CPUs\n");

You can remove stop_lock altogether now, right? I also wonder whether
it would be worth printing out which CPUs are still online in the case where
we fail to stop all the secondaries?

Will
