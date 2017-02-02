From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 2 Feb 2017 13:52:36 +0900
Subject: [PATCH v31 03/12] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170201152609.GE4756@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-2-takahiro.akashi@linaro.org>
 <20170201152609.GE4756@leverpostej>
Message-ID: <20170202045235.GB13549@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 03:26:09PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Feb 01, 2017 at 09:46:22PM +0900, AKASHI Takahiro wrote:
> > +#ifdef CONFIG_KEXEC_CORE
> > +/*
> > + * reserve_crashkernel() - reserves memory for crash kernel
> > + *
> > + * This function reserves memory area given in "crashkernel=" kernel command
> > + * line parameter. The memory reserved is used by dump capture kernel when
> > + * primary kernel is crashing.
> > + */
> > +static void __init reserve_crashkernel(void)
> > +{
> > +	unsigned long long crash_base, crash_size;
> > +	int ret;
> > +
> > +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > +				&crash_size, &crash_base);
> > +	/* no crashkernel= or invalid value specified */
> > +	if (ret || !crash_size)
> > +		return;
> > +
> > +	crash_size = PAGE_ALIGN(crash_size);
> > +
> > +	if (crash_base == 0) {
> > +		/* Current arm64 boot protocol requires 2MB alignment */
> > +		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> > +				crash_size, SZ_2M);
> > +		if (crash_base == 0) {
> > +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> > +				crash_size);
> 
> Nit: can we please make that "size: 0x%llx", so that it's always clearly
> a hex number? e.g.
> 
> 	pr_warn("cannot allocate 0x%llx bytes for crashkernel\n",
> 		crash_size);

OK

> > +			return;
> > +		}
> > +	} else {
> > +		/* User specifies base address explicitly. */
> > +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> > +			memblock_is_region_reserved(crash_base, crash_size)) {
> > +			pr_warn("crashkernel has wrong address or size\n");
> > +			return;
> > +		}
> 
> To better report the error, can we please split these up:
> 
> 		if (!memblock_is_region_memory(crash_base, crash_size)) {
> 			pr_warn("cannot reserve crashkernel: region is not memory\n");
> 			return;
> 		}
> 
> 		if (!memblock_is_region_memory(crash_base, crash_size)) {
> 			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
> 			return;
> 		}

OK, and

> > +		if (!IS_ALIGNED(crash_base, SZ_2M)) {
> > +			pr_warn("crashkernel base address is not 2MB aligned\n");


			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");

> > +			return;
> > +		}
> > +	}
> > +	memblock_reserve(crash_base, crash_size);
> > +
> > +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > +		crash_size >> 20, crash_base >> 20);
> 
> We only page-align the size, so the MB will be a little off, but that's
> probably OK. However, it would also be nicer to log the base as an
> address.

You might notice that the exact same message is used by all the other
architectures, but

> Could we dump this as we do for the kernel memory layout? e.g.
> 
> 	pr_info("crashkernel reserved: 0x%016lx - 0x%016lx (%lld MB)\n",
> 		crash_base, crash_base + crash_size, crash_size >> 20);

We can go either way.

> With those:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.
