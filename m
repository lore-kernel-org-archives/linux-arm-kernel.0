From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 12 Jun 2018 10:27:03 +0100
Subject: [PATCH] arm64: make secondary_start_kernel() notrace
In-Reply-To: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
References: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
Message-ID: <c5dc3b1d-ad49-fa50-dae8-8b8d679deb5b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/18 10:07, Zhizhou Zhang wrote:
> We can't call function trace hook before setup percpu offset.
> When entering secondary_start_kernel(), percpu offset has not
> been initialized.  So this lead hotplug malfunction.
> Here is the flow to reproduce this bug:
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo function > /sys/kernel/debug/tracing/current_tracer
> echo 1 > /sys/kernel/debug/tracing/tracing_on
> echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>   arch/arm64/kernel/smp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index f3e2e3ae..11b0f30 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -179,7 +179,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>    * This is the secondary CPU boot entry.  We're using this CPUs
>    * idle thread stack, but a set of temporary page tables.
>    */
> -asmlinkage void secondary_start_kernel(void)
> +notrace asmlinkage void secondary_start_kernel(void)
>   {
>   	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>   	struct mm_struct *mm = &init_mm;
> 

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I think this should go to stable releases as well.

Suzuki
