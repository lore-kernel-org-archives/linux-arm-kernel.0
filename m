From: drjones@redhat.com (Andrew Jones)
Date: Mon, 28 Nov 2016 10:42:56 +0100
Subject: [kvm-unit-tests PATCH v7 07/11] arm/tlbflush-code: Add TLB flush
 during code execution test
In-Reply-To: <20161124161033.11456-8-alex.bennee@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
 <20161124161033.11456-8-alex.bennee@linaro.org>
Message-ID: <20161128094256.4m3zfsb7cwmd2zf4@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 04:10:29PM +0000, Alex Benn?e wrote:
> This adds a fairly brain dead torture test for TLB flushes intended for
> stressing the MTTCG QEMU build. It takes the usual -smp option for
> multiple CPUs.
> 
> By default it CPU0 will do a TLBIALL flush after each cycle. You can
> pass options via -append to control additional aspects of the test:
> 
>   - "page" flush each page in turn (one per function)
>   - "self" do the flush after each computation cycle
>   - "verbose" report progress on each computation cycle
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> 
> ---
> v2
>   - rename to tlbflush-test
>   - made makefile changes cleaner
>   - added self/other flush mode
>   - create specific prefix
>   - whitespace fixes
> v3
>   - using new SMP framework for test runing
> v4
>   - merge in the unitests.cfg
> v5
>   - max out at -smp 4
>   - printf fmtfix
> v7
>   - rename to tlbflush-code
>   - int -> bool flags
> ---
>  arm/Makefile.common |   2 +
>  arm/tlbflush-code.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg   |  24 ++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 arm/tlbflush-code.c
> 
> diff --git a/arm/Makefile.common b/arm/Makefile.common
> index cca0d9c..de99a6e 100644
> --- a/arm/Makefile.common
> +++ b/arm/Makefile.common
> @@ -13,6 +13,7 @@ tests-common  = $(TEST_DIR)/selftest.flat
>  tests-common += $(TEST_DIR)/spinlock-test.flat
>  tests-common += $(TEST_DIR)/pci-test.flat
>  tests-common += $(TEST_DIR)/gic.flat
> +tests-common += $(TEST_DIR)/tlbflush-code.flat
>  
>  all: test_cases
>  
> @@ -81,3 +82,4 @@ generated_files = $(asm-offsets)
>  test_cases: $(generated_files) $(tests-common) $(tests)
>  
>  $(TEST_DIR)/selftest.o $(cstart.o): $(asm-offsets)
> +$(TEST_DIR)/tlbflush-code.elf: $(cstart.o) $(TEST_DIR)/tlbflush-code.o

This should no longer be necessary.

> diff --git a/arm/tlbflush-code.c b/arm/tlbflush-code.c
> new file mode 100644
> index 0000000..cb5cdc2
> --- /dev/null
> +++ b/arm/tlbflush-code.c
> @@ -0,0 +1,212 @@
> +/*
> + * TLB Flush Race Tests
> + *
> + * These tests are designed to test for incorrect TLB flush semantics
> + * under emulation. The initial CPU will set all the others working a
> + * compuation task and will then trigger TLB flushes across the
> + * system. It doesn't actually need to re-map anything but the flushes
> + * themselves will trigger QEMU's TCG self-modifying code detection
> + * which will invalidate any generated  code causing re-translation.
> + * Eventually the code buffer will fill and a general tb_lush() will
> + * be triggered.
> + *
> + * Copyright (C) 2016, Linaro, Alex Benn?e <alex.bennee@linaro.org>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.
> + */
> +
> +#include <libcflat.h>
> +#include <asm/smp.h>
> +#include <asm/cpumask.h>
> +#include <asm/barrier.h>
> +#include <asm/mmu.h>
> +
> +#define SEQ_LENGTH 10
> +#define SEQ_HASH 0x7cd707fe
> +
> +static cpumask_t smp_test_complete;
> +static int flush_count = 1000000;
> +static bool flush_self;
> +static bool flush_page;
> +static bool flush_verbose;
> +
> +/*
> + * Work functions
> + *
> + * These work functions need to be:
> + *
> + *  - page aligned, so we can flush one function at a time
> + *  - have branches, so QEMU TCG generates multiple basic blocks
> + *  - call across pages, so we exercise the TCG basic block slow path
> + */
> +
> +/* Adler32 */
> +__attribute__((aligned(PAGE_SIZE))) uint32_t hash_array(const void *buf,
> +							size_t buflen)

I think I'd prefer

__attribute__((aligned(PAGE_SIZE)))
uint32_t hash_array(const void *buf, size_t buflen)

to handle the long line

> +{
> +	const uint8_t *data = (uint8_t *) buf;
> +	uint32_t s1 = 1;
> +	uint32_t s2 = 0;
> +
> +	for (size_t n = 0; n < buflen; n++) {
> +		s1 = (s1 + data[n]) % 65521;
> +		s2 = (s2 + s1) % 65521;
> +	}
> +	return (s2 << 16) | s1;
> +}
> +
> +__attribute__((aligned(PAGE_SIZE))) void create_fib_sequence(int length,
> +							unsigned int *array)
> +{
> +	int i;
> +
> +	/* first two values */
> +	array[0] = 0;
> +	array[1] = 1;
> +	for (i=2; i<length; i++) {
> +		array[i] = array[i-2] + array[i-1];
> +	}

please don't use {} for one-liners. Try running the kernel's check_patch
on your patches. Applies many places below

> +}
> +
> +__attribute__((aligned(PAGE_SIZE))) unsigned long long factorial(unsigned int n)

long line

> +{
> +	unsigned int i;
> +	unsigned long long fac = 1;
> +	for (i=1; i<=n; i++)
> +	{
> +		fac = fac * i;
> +	}
> +	return fac;
> +}
> +
> +__attribute__((aligned(PAGE_SIZE))) void factorial_array
> +(unsigned int n, unsigned int *input, unsigned long long *output)
> +{
> +	unsigned int i;
> +	for (i=0; i<n; i++) {
> +		output[i] = factorial(input[i]);
> +	}
> +}
> +
> +__attribute__((aligned(PAGE_SIZE))) unsigned int do_computation(void)
> +{
> +	unsigned int fib_array[SEQ_LENGTH];
> +	unsigned long long facfib_array[SEQ_LENGTH];
> +	uint32_t fib_hash, facfib_hash;
> +
> +	create_fib_sequence(SEQ_LENGTH, &fib_array[0]);
> +	fib_hash = hash_array(&fib_array[0], sizeof(fib_array));
> +	factorial_array(SEQ_LENGTH, &fib_array[0], &facfib_array[0]);
> +	facfib_hash = hash_array(&facfib_array[0], sizeof(facfib_array));
> +
> +	return (fib_hash ^ facfib_hash);
> +}
> +
> +/* This provides a table of the work functions so we can flush each
> + * page individually
> + */
> +static void * pages[] = {&hash_array, &create_fib_sequence, &factorial,
> +			 &factorial_array, &do_computation};

please put the '*' by pages

> +
> +static void do_flush(int i)
> +{
> +	if (flush_page) {
> +		flush_tlb_page((unsigned long)pages[i % ARRAY_SIZE(pages)]);
> +	} else {
> +		flush_tlb_all();
> +	}
> +}
> +
> +
> +static void just_compute(void)
> +{
> +	int i, errors = 0;
> +	int cpu = smp_processor_id();
> +
> +	uint32_t result;
> +
> +	printf("CPU%d online\n", cpu);
> +
> +	for (i=0; i < flush_count; i++) {
> +		result = do_computation();
> +
> +		if (result != SEQ_HASH) {
> +			errors++;
> +			printf("CPU%d: seq%d 0x%"PRIx32"!=0x%x\n",
> +				cpu, i, result, SEQ_HASH);
> +		}
> +
> +		if (flush_verbose && (i % 1000) == 0) {
> +			printf("CPU%d: seq%d\n", cpu, i);
> +		}
> +
> +		if (flush_self) {
> +			do_flush(i);
> +		}
> +	}
> +
> +	report("CPU%d: Done - Errors: %d\n", errors == 0, cpu, errors);
> +
> +	cpumask_set_cpu(cpu, &smp_test_complete);
> +	if (cpu != 0)
> +		halt();
> +}
> +
> +static void just_flush(void)
> +{
> +	int cpu = smp_processor_id();
> +	int i = 0;
> +
> +	/* set our CPU as done, keep flushing until everyone else
> +	   finished */

Not our comment style

> +	cpumask_set_cpu(cpu, &smp_test_complete);
> +
> +	while (!cpumask_full(&smp_test_complete)) {
> +		do_flush(i++);
> +	}
> +
> +	report("CPU%d: Done - Triggered %d flushes\n", true, cpu, i);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int cpu, i;
> +	char prefix[100];
> +
> +	for (i=0; i<argc; i++) {
> +		char *arg = argv[i];
> +
> +		if (strcmp(arg, "page") == 0) {
> +			flush_page = true;
> +                }
> +
> +                if (strcmp(arg, "self") == 0) {
> +			flush_self = true;
> +                }
> +
> +		if (strcmp(arg, "verbose") == 0) {
> +			flush_verbose = true;
> +                }
> +	}
> +
> +	snprintf(prefix, sizeof(prefix), "tlbflush_%s_%s",
> +		flush_page?"page":"all",
> +		flush_self?"self":"other");
> +	report_prefix_push(prefix);
> +
> +	for_each_present_cpu(cpu) {
> +		if (cpu == 0)
> +			continue;
> +		smp_boot_secondary(cpu, just_compute);
> +	}
> +
> +	if (flush_self)
> +		just_compute();
> +	else
> +		just_flush();
> +
> +	while (!cpumask_full(&smp_test_complete))
> +		cpu_relax();
> +
> +	return report_summary();
> +}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index c7392c7..beaae84 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -72,3 +72,27 @@ file = gic.flat
>  smp = $MAX_SMP
>  extra_params = -machine gic-version=3 -append 'ipi'
>  groups = gic
> +
> +# TLB Torture Tests
> +[tlbflush-code::all_other]

We don't use the '::' style anymore, as it doesn't work
well with mkstandalone.

> +file = tlbflush-code.flat
> +smp = $(($MAX_SMP>4?4:$MAX_SMP))
> +groups = tlbflush
> +
> +[tlbflush-code::page_other]
> +file = tlbflush-code.flat
> +smp = $(($MAX_SMP>4?4:$MAX_SMP))
> +extra_params = -append 'page'
> +groups = tlbflush
> +
> +[tlbflush-code::all_self]
> +file = tlbflush-code.flat
> +smp = $(($MAX_SMP>4?4:$MAX_SMP))
> +extra_params = -append 'self'
> +groups = tlbflush
> +
> +[tlbflush-code::page_self]
> +file = tlbflush-code.flat
> +smp = $(($MAX_SMP>4?4:$MAX_SMP))
> +extra_params = -append 'page self'
> +groups = tlbflush
> -- 
> 2.10.1
>

I only did a superficial review, but it looks familiar. I guess I've
reviewed some of it before.

drew
