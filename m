From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 1 Dec 2016 17:16:50 +0000
Subject: [PATCH] arm64: smp: Prevent raw_smp_processor_id() recursion
In-Reply-To: <bb132e9abf4d256e40ad311b106b05d724b290fb.1480607460.git.robin.murphy@arm.com>
References: <bb132e9abf4d256e40ad311b106b05d724b290fb.1480607460.git.robin.murphy@arm.com>
Message-ID: <2bd54897-df2e-a20e-d748-07966642b850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/16 15:55, Robin Murphy wrote:
> Under CONFIG_DEBUG_PREEMPT=y, this_cpu_ptr() ends up calling back into
> raw_smp_processor_id(), resulting in some hilariously catastrophic
> infinite recursion. In the normal case, we have:
> 
>   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
> 
> and everything is dandy. However for CONFIG_DEBUG_PREEMPT, this_cpu_ptr()
> is defined in terms of my_cpu_offset, wherein the fun begins:
> 
>   #define my_cpu_offset per_cpu_offset(smp_processor_id())
>   ...
>   #define smp_processor_id() debug_smp_processor_id()
>   ...
>   notrace unsigned int debug_smp_processor_id(void)
>   {
>   	return check_preemption_disabled("smp_processor_id", "");
>   ...
>   notrace static unsigned int check_preemption_disabled(const char *what1,
>   							const char *what2)
>   {
>   	int this_cpu = raw_smp_processor_id();
> 
> and bang. Use raw_cpu_ptr() directly to avoid that.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I wasn't sure whether commit IDs on for-next/core are stable, but if
they are, this could also have:

Fixes: 57c82954e77f ("arm64: make cpu number a percpu variable")

Robin.

> ---
> 
> Since I just reproduced this locally to verify Will's suggestion, it
> seemed I might as well just write it up as a patch :)
> 
>  arch/arm64/include/asm/smp.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index a62db952ffcb..d050d720a1b4 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -41,8 +41,10 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
>   * We don't use this_cpu_read(cpu_number) as that has implicit writes to
>   * preempt_count, and associated (compiler) barriers, that we'd like to avoid
>   * the expense of. If we're preemptible, the value can be stale at use anyway.
> + * And we can't use this_cpu_ptr() either, as that winds up recursing back
> + * here under CONFIG_DEBUG_PREEMPT=y.
>   */
> -#define raw_smp_processor_id() (*this_cpu_ptr(&cpu_number))
> +#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
>  
>  struct seq_file;
>  
> 
