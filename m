From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 31 Oct 2018 14:49:26 +0100
Subject: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
Message-ID: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> Looking closely at it, it seems like a really bad idea to be calling
> local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> like it could violate spinlock semantics and cause a deadlock.
> 
> Instead, let's use a private csd alongside
> smp_call_function_single_async() to round up the other CPUs.  Using
> smp_call_function_single_async() doesn't require interrupts to be
> enabled so we can remove the offending bit of code.

You might want to mention that the only reason this isn't a deadlock
itself is because there is a timeout on waiting for the slaves to
check-in.

> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		smp_call_function_single_async(cpu, csd);
> +	}
> +}
> +
> +static void kgdb_generic_roundup_init(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		csd->func = kgdb_call_nmi_hook;
> +	}
> +}
> +
>  /*
>   * Some architectures need cache flushes when we set/clear a
>   * breakpoint:
> @@ -993,6 +1027,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  		return -EBUSY;
>  	}
>  
> +	kgdb_generic_roundup_init();
> +
>  	if (new_dbg_io_ops->init) {
>  		err = new_dbg_io_ops->init();
>  		if (err) {

That's a little bit of overhead for those architectures not using that
generic code; but I suppose we can live with that.
