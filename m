From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 11:15:09 +0100
Subject: [PATCH v2 11/22] arm64: Populate cpuinfo after notify_cpu_starting
In-Reply-To: <1444064531-25607-12-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-12-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151008101508.GE17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 06:02:00PM +0100, Suzuki K. Poulose wrote:
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index cb3e0d8..6987de4 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -163,14 +163,14 @@ asmlinkage void secondary_start_kernel(void)
>  		cpu_ops[cpu]->cpu_postboot();
>  
>  	/*
> -	 * Log the CPU info before it is marked online and might get read.
> +	 * Enable GIC and timers.
>  	 */
> -	cpuinfo_store_cpu();
> +	notify_cpu_starting(cpu);
>  
>  	/*
> -	 * Enable GIC and timers.
> +	 * Log the CPU info before it is marked online and might get read.
>  	 */
> -	notify_cpu_starting(cpu);
> +	cpuinfo_store_cpu();
>  
>  	smp_store_cpu_info(cpu);

You can move the cpuinfo_store_cpu() call directly to
smp_store_cpu_info().

-- 
Catalin
