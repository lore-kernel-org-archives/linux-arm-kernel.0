From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Jun 2018 10:14:41 +0100
Subject: [PATCH] arm64: make secondary_start_kernel() notrace
In-Reply-To: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
References: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
Message-ID: <20180612091440.f4jd2r4kq3nxv7pr@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 05:07:37PM +0800, Zhizhou Zhang wrote:
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
>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index f3e2e3ae..11b0f30 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -179,7 +179,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   * This is the secondary CPU boot entry.  We're using this CPUs
>   * idle thread stack, but a set of temporary page tables.
>   */
> -asmlinkage void secondary_start_kernel(void)
> +notrace asmlinkage void secondary_start_kernel(void)

Minor nit: can we please keep asmlinkage first, e.g.

asmlinkage notrace void secondary_start_kernel(void)

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  {
>  	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>  	struct mm_struct *mm = &init_mm;
> -- 
> 1.9.1
> 
