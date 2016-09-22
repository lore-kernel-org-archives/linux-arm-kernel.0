From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Thu, 22 Sep 2016 11:04:04 +0800
Subject: [PATCH] arm64: Call numa_store_cpu_info() earlier.
In-Reply-To: <1474397195-16520-1-git-send-email-ddaney.cavm@gmail.com>
References: <1474397195-16520-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20bc1c5f-7e8f-a18c-0061-24d97b3a62fe@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/9/21 2:46, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Fix by moving call to numa_store_cpu_info() for all CPUs into
> smp_prepare_cpus(), which happens before wq_numa_init().  Since
> smp_store_cpu_info() now contains only a single function call,
> simplify by removing the function and out-lining its contents.
> 
> Suggested-by: Robert Richter <rric@kernel.org>
> fixes: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
> Cc: <stable@vger.kernel.org> # 4.7.x-
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
Tested-by: Yisheng Xie <xieyisheng1@huawei.com>

Thanks.

>  arch/arm64/kernel/smp.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d93d433..3ff173e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -201,12 +201,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	return ret;
>  }
>  
> -static void smp_store_cpu_info(unsigned int cpuid)
> -{
> -	store_cpu_topology(cpuid);
> -	numa_store_cpu_info(cpuid);
> -}
> -
>  /*
>   * This is the secondary CPU boot entry.  We're using this CPUs
>   * idle thread stack, but a set of temporary page tables.
> @@ -254,7 +248,7 @@ asmlinkage void secondary_start_kernel(void)
>  	 */
>  	notify_cpu_starting(cpu);
>  
> -	smp_store_cpu_info(cpu);
> +	store_cpu_topology(cpu);
>  
>  	/*
>  	 * OK, now it's safe to let the boot CPU continue.  Wait for
> @@ -689,10 +683,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	int err;
>  	unsigned int cpu;
> +	unsigned int this_cpu;
>  
>  	init_cpu_topology();
>  
> -	smp_store_cpu_info(smp_processor_id());
> +	this_cpu = smp_processor_id();
> +	store_cpu_topology(this_cpu);
> +	numa_store_cpu_info(this_cpu);
>  
>  	/*
>  	 * If UP is mandated by "nosmp" (which implies "maxcpus=0"), don't set
> @@ -719,6 +716,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  			continue;
>  
>  		set_cpu_present(cpu, true);
> +		numa_store_cpu_info(cpu);
>  	}
>  }
>  
> 
