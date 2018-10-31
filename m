From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 31 Oct 2018 18:40:50 +0000
Subject: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
Message-ID: <20181031184050.sd5opni3mznaapkv@holly.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index f3cadda45f07..9a3f952de6ed 100644
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

smp_call_function() automatically skips the calling CPU but this code does
not. It isn't a hard bug since kgdb_nmicallback() does a re-entrancy
check but I'd still prefer to skip the calling CPU.

As mentioned in another part of the thread we can also add robustness
by skipping a cpu where csd->flags != 0 (and adding an appropriately
large comment regarding why). Doing the check directly is abusing
internal knowledge that smp.c normally keeps to itself so an accessor
of some kind would be needed.


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

I can't help noticing this code is very similar to kgdb_roundup_cpus. Do
we really gain much from ahead-of-time initializing csd->func?


Daniel.
