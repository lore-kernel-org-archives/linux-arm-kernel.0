From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 May 2017 11:09:52 +0100
Subject: [patch V2 03/17] arm64: Adjust system_state check
In-Reply-To: <20170516184735.112589728@linutronix.de>
References: <20170516184231.564888231@linutronix.de>
 <20170516184735.112589728@linutronix.de>
Message-ID: <20170517100951.GB14654@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 08:42:34PM +0200, Thomas Gleixner wrote:
> To enable smp_processor_id() and might_sleep() debug checks earlier, it's
> required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.
> 
> Adjust the system_state check in smp_send_stop() to handle the extra states.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm64/kernel/smp.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -961,8 +961,7 @@ void smp_send_stop(void)
>  		cpumask_copy(&mask, cpu_online_mask);
>  		cpumask_clear_cpu(smp_processor_id(), &mask);
>  
> -		if (system_state == SYSTEM_BOOTING ||
> -		    system_state == SYSTEM_RUNNING)
> +		if (system_state <= SYSTEM_RUNNING)
>  			pr_crit("SMP: stopping secondary CPUs\n");
>  		smp_cross_call(&mask, IPI_CPU_STOP);
>  	}
> 
> 
