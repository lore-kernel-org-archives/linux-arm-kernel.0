From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Feb 2017 15:26:09 +0000
Subject: [PATCH v31 03/12] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170201124630.6016-2-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-2-takahiro.akashi@linaro.org>
Message-ID: <20170201152609.GE4756@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 01, 2017 at 09:46:22PM +0900, AKASHI Takahiro wrote:
> +#ifdef CONFIG_KEXEC_CORE
> +/*
> + * reserve_crashkernel() - reserves memory for crash kernel
> + *
> + * This function reserves memory area given in "crashkernel=" kernel command
> + * line parameter. The memory reserved is used by dump capture kernel when
> + * primary kernel is crashing.
> + */
> +static void __init reserve_crashkernel(void)
> +{
> +	unsigned long long crash_base, crash_size;
> +	int ret;
> +
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +				&crash_size, &crash_base);
> +	/* no crashkernel= or invalid value specified */
> +	if (ret || !crash_size)
> +		return;
> +
> +	crash_size = PAGE_ALIGN(crash_size);
> +
> +	if (crash_base == 0) {
> +		/* Current arm64 boot protocol requires 2MB alignment */
> +		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> +				crash_size, SZ_2M);
> +		if (crash_base == 0) {
> +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> +				crash_size);

Nit: can we please make that "size: 0x%llx", so that it's always clearly
a hex number? e.g.

	pr_warn("cannot allocate 0x%llx bytes for crashkernel\n",
		crash_size);

> +			return;
> +		}
> +	} else {
> +		/* User specifies base address explicitly. */
> +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> +			memblock_is_region_reserved(crash_base, crash_size)) {
> +			pr_warn("crashkernel has wrong address or size\n");
> +			return;
> +		}

To better report the error, can we please split these up:

		if (!memblock_is_region_memory(crash_base, crash_size)) {
			pr_warn("cannot reserve crashkernel: region is not memory\n");
			return;
		}

		if (!memblock_is_region_memory(crash_base, crash_size)) {
			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
			return;
		}

> +		if (!IS_ALIGNED(crash_base, SZ_2M)) {
> +			pr_warn("crashkernel base address is not 2MB aligned\n");
> +			return;
> +		}
> +	}
> +	memblock_reserve(crash_base, crash_size);
> +
> +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> +		crash_size >> 20, crash_base >> 20);

We only page-align the size, so the MB will be a little off, but that's
probably OK. However, it would also be nicer to log the base as an
address.

Could we dump this as we do for the kernel memory layout? e.g.

	pr_info("crashkernel reserved: 0x%016lx - 0x%016lx (%lld MB)\n",
		crash_base, crash_base + crash_size, crash_size >> 20);

With those:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
