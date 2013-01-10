From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Jan 2013 16:53:27 +0000
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAHkRjk4A+EMFRTVdfCUBNpAEUMWrOqbT2ki19Vska6dY_WrVXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> --- /dev/null
> +++ b/Documentation/arm/big.LITTLE/cluster-pm-race-avoidance.txt
> @@ -0,0 +1,498 @@
> +Big.LITTLE cluster Power-up/power-down race avoidance algorithm
> +===============================================================

Nice description and ascii art :).

> --- a/arch/arm/common/bL_entry.c
> +++ b/arch/arm/common/bL_entry.c
> @@ -116,3 +116,163 @@ int bL_cpu_powered_up(void)
>                 platform_ops->powered_up();
>         return 0;
>  }
> +
> +struct bL_sync_struct bL_sync;
> +
> +static void __sync_range(volatile void *p, size_t size)
> +{
> +       char *_p = (char *)p;
> +
> +       __cpuc_flush_dcache_area(_p, size);
> +       outer_flush_range(__pa(_p), __pa(_p + size));
> +       outer_sync();

The outer flush-range operations already contain a cache_sync, so an
additional outer_sync() operation is not necessary.

You (well, Dave) said that you use the flush instead of
clean/invalidate to avoid races with other CPUs writing the location.
However, on the same CPU you can get a speculative load into L1 after
the L1 flush but before the L2 flush, so the reader case can fail.

The sequence for readers is (note *L2* inval first):

L2 inval
L1 inval

The sequence for writers is:

L1 clean
L2 clean

The bi-directional sequence (that's what you need) is:

L1 clean
L2 clean+inval
L1 clean+inval

The last L1 op must be clean+inval in case another CPU writes to this
location to avoid discarding the write.

If you don't have an L2, you just end up with two L1 clean ops, so you
can probably put some checks.

> +#define sync_mem(ptr) __sync_range(ptr, sizeof *(ptr))
> +
> +/*
> + * __bL_cpu_going_down: Indicates that the cpu is being torn down.
> + *    This must be called at the point of committing to teardown of a CPU.
> + *    The CPU cache (SCTRL.C bit) is expected to still be active.
> + */
> +void __bL_cpu_going_down(unsigned int cpu, unsigned int cluster)
> +{
> +       bL_sync.clusters[cluster].cpus[cpu].cpu = CPU_GOING_DOWN;
> +       sync_mem(&bL_sync.clusters[cluster].cpus[cpu].cpu);
> +}
> +
> +/*
> + * __bL_cpu_down: Indicates that cpu teardown is complete and that the
> + *    cluster can be torn down without disrupting this CPU.
> + *    To avoid deadlocks, this must be called before a CPU is powered down.
> + *    The CPU cache (SCTRL.C bit) is expected to be off.
> + */
> +void __bL_cpu_down(unsigned int cpu, unsigned int cluster)
> +{
> +       dsb();
> +       bL_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
> +       sync_mem(&bL_sync.clusters[cluster].cpus[cpu].cpu);
> +       sev();

For the sev() here (and other functions in this patch) you need a
dsb() before. I'm not sure outer_sync() has one.

-- 
Catalin
