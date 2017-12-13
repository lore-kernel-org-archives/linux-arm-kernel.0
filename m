From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 13 Dec 2017 13:47:47 +0300
Subject: [PATCH] IPI performance benchmark
In-Reply-To: <20171211153332.GG15649@char.us.oracle.com>
References: <20171211141600.24401-1-ynorov@caviumnetworks.com>
 <20171211153332.GG15649@char.us.oracle.com>
Message-ID: <20171213104747.m4b5pbnlcroodfe7@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 10:33:32AM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Dec 11, 2017 at 05:16:00PM +0300, Yury Norov wrote:
> > This benchmark sends many IPIs in different modes and measures
> > time for IPI delivery (first column), and total time, ie including
> > time to acknowledge the receive by sender (second column).
> > 
> > The scenarios are:
> > Dry-run:	do everything except actually sending IPI. Useful
> > 		to estimate system overhead.
> > Self-IPI:	Send IPI to self CPU.
> > Normal IPI:	Send IPI to some other CPU.
> > Broadcast IPI:	Send broadcast IPI to all online CPUs.
> > 
> > For virtualized guests, sending and reveiving IPIs causes guest exit.
> > I used this test to measure performance impact on KVM subsystem of
> > Christoffer Dall's series "Optimize KVM/ARM for VHE systems".
> > 
> > https://www.spinics.net/lists/kvm/msg156755.html
> > 
> > Test machine is ThunderX2, 112 online CPUs. Below the results normalized
> > to host dry-run time. Smaller - better.
> 
> Would it make sense to also add spinlock contention tests? Meaning make
> this framework a bit more generic so you could do IPI and you could
> also do spinlock contention?
> 
> Like:
> http://xenbits.xen.org/gitweb/?p=xentesttools/bootstrap.git;a=blob;f=root_image/drivers/spinlock_hog/spinlock_hog.c;h=040a154808452576b1aa5720a6282981319a5360;hb=HEAD

There's kernel/locking/locktorture.c for spinlock testing. Maybe it
worth to add new testcase there? If you find my 'framework' more
suitable for you, I'm also OK with it. Is my understanding correct
that you want something like broadcast IPI case, but with different
payload?

Yury

> And then also this could be used for an CPU intensive
> test to see how well virtualization schedulers work:
> 
> http://xenbits.xen.org/gitweb/?p=xentesttools/bootstrap.git;a=blob;f=root_image/drivers/ipi_hog/ipi_hog.c;h=6dcc4f3382c29c42fec077791cc53bc52e6d8868;hb=HEAD
> 
> (asking as it never occurred to me upstream those test-cases
> but if folks are OK with Yury little module, then other things
> could be done as well with it).
> 
> > 
> > Host, v4.14:
> > Dry-run:	  0	    1
> > Self-IPI:         9	   18
> > Normal IPI:      81	  110
> > Broadcast IPI:    0	 2106
> > 
> > Guest, v4.14:
> > Dry-run:          0	    1
> > Self-IPI:        10	   18
> > Normal IPI:     305	  525
> > Broadcast IPI:    0    	 9729
> > 
> > Guest, v4.14 + VHE:
> > Dry-run:          0	    1
> > Self-IPI:         9	   18
> > Normal IPI:     176	  343
> > Broadcast IPI:    0	 9885
> > 
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Ashish Kalra <Ashish.Kalra@cavium.com>
> > CC: Christoffer Dall <christoffer.dall@linaro.org>
> > CC: Geert Uytterhoeven <geert@linux-m68k.org>
> > CC: Linu Cherian <Linu.Cherian@cavium.com>
> > CC: Sunil Goutham <Sunil.Goutham@cavium.com>
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  arch/Kconfig           |  10 ++++
> >  kernel/Makefile        |   1 +
> >  kernel/ipi_benchmark.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 145 insertions(+)
> >  create mode 100644 kernel/ipi_benchmark.c
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 057370a0ac4e..80d6ef439199 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -82,6 +82,16 @@ config JUMP_LABEL
> >  	 ( On 32-bit x86, the necessary options added to the compiler
> >  	   flags may increase the size of the kernel slightly. )
> >  
> > +config IPI_BENCHMARK
> > +	tristate "Test IPI performance on SMP systems"
> > +	depends on SMP
> > +	help
> > +	  Test IPI performance on SMP systems. If system has only one online
> > +	  CPU, sending IPI to other CPU is obviously not possible, and ENOENT
> > +	  is returned for corresponding test.
> > +
> > +	  If unsure, say N.
> > +
> >  config STATIC_KEYS_SELFTEST
> >  	bool "Static key selftest"
> >  	depends on JUMP_LABEL
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index 172d151d429c..04e550e1990c 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -101,6 +101,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
> >  obj-$(CONFIG_IRQ_WORK) += irq_work.o
> >  obj-$(CONFIG_CPU_PM) += cpu_pm.o
> >  obj-$(CONFIG_BPF) += bpf/
> > +obj-$(CONFIG_IPI_BENCHMARK) += ipi_benchmark.o
> >  
> >  obj-$(CONFIG_PERF_EVENTS) += events/
> >  
> > diff --git a/kernel/ipi_benchmark.c b/kernel/ipi_benchmark.c
> > new file mode 100644
> > index 000000000000..35f1f7598c36
> > --- /dev/null
> > +++ b/kernel/ipi_benchmark.c
> > @@ -0,0 +1,134 @@
> > +/*
> > + * Performance test for IPI on SMP machines.
> > + *
> > + * Copyright (c) 2017 Cavium Networks.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of version 2 of the GNU General Public
> > + * License as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * General Public License for more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/ktime.h>
> > +
> > +#define NTIMES 100000
> > +
> > +#define POKE_ANY	0
> > +#define DRY_RUN		1
> > +#define POKE_SELF	2
> > +#define POKE_ALL	3
> > +
> > +static void __init handle_ipi(void *t)
> > +{
> > +	ktime_t *time = (ktime_t *) t;
> > +
> > +	if (time)
> > +		*time = ktime_get() - *time;
> > +}
> > +
> > +static ktime_t __init send_ipi(int flags)
> > +{
> > +	ktime_t time;
> > +	unsigned int cpu = get_cpu();
> > +
> > +	switch (flags) {
> > +	case POKE_ALL:
> > +		/* If broadcasting, don't force all CPUs to update time. */
> > +		smp_call_function_many(cpu_online_mask, handle_ipi, NULL, 1);
> > +		/* Fall thru */
> > +	case DRY_RUN:
> > +		/* Do everything except actually sending IPI. */
> > +		time = 0;
> > +		break;
> > +	case POKE_ANY:
> > +		cpu = cpumask_any_but(cpu_online_mask, cpu);
> > +		if (cpu >= nr_cpu_ids) {
> > +			time = -ENOENT;
> > +			break;
> > +		}
> > +		/* Fall thru */
> > +	case POKE_SELF:
> > +		time = ktime_get();
> > +		smp_call_function_single(cpu, handle_ipi, &time, 1);
> > +		break;
> > +	default:
> > +		time = -EINVAL;
> > +	}
> > +
> > +	put_cpu();
> > +	return time;
> > +}
> > +
> > +static int __init __bench_ipi(unsigned long i, ktime_t *time, int flags)
> > +{
> > +	ktime_t t;
> > +
> > +	*time = 0;
> > +	while (i--) {
> > +		t = send_ipi(flags);
> > +		if ((int) t < 0)
> > +			return (int) t;
> > +
> > +		*time += t;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init bench_ipi(unsigned long times, int flags,
> > +				ktime_t *ipi, ktime_t *total)
> > +{
> > +	int ret;
> > +
> > +	*total = ktime_get();
> > +	ret = __bench_ipi(times, ipi, flags);
> > +	if (unlikely(ret))
> > +		return ret;
> > +
> > +	*total = ktime_get() - *total;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init init_bench_ipi(void)
> > +{
> > +	ktime_t ipi, total;
> > +	int ret;
> > +
> > +	ret = bench_ipi(NTIMES, DRY_RUN, &ipi, &total);
> > +	if (ret)
> > +		pr_err("Dry-run FAILED: %d\n", ret);
> > +	else
> > +		pr_err("Dry-run:       %18llu, %18llu ns\n", ipi, total);
> > +
> > +	ret = bench_ipi(NTIMES, POKE_SELF, &ipi, &total);
> > +	if (ret)
> > +		pr_err("Self-IPI FAILED: %d\n", ret);
> > +	else
> > +		pr_err("Self-IPI:      %18llu, %18llu ns\n", ipi, total);
> > +
> > +	ret = bench_ipi(NTIMES, POKE_ANY, &ipi, &total);
> > +	if (ret)
> > +		pr_err("Normal IPI FAILED: %d\n", ret);
> > +	else
> > +		pr_err("Normal IPI:    %18llu, %18llu ns\n", ipi, total);
> > +
> > +	ret = bench_ipi(NTIMES, POKE_ALL, &ipi, &total);
> > +	if (ret)
> > +		pr_err("Broadcast IPI FAILED: %d\n", ret);
> > +	else
> > +		pr_err("Broadcast IPI: %18llu, %18llu ns\n", ipi, total);
> > +
> > +	/* Return error to avoid annoying rmmod. */
> > +	return -EINVAL;
> > +}
> > +module_init(init_bench_ipi);
> > +
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.11.0
> > 
