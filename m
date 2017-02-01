From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Feb 2017 19:21:22 +0000
Subject: [PATCH v31 09/12] arm64: kdump: provide /proc/vmcore file
In-Reply-To: <20170201124630.6016-8-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-8-takahiro.akashi@linaro.org>
Message-ID: <20170201192121.GB30584@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 09:46:28PM +0900, AKASHI Takahiro wrote:
> Add arch-specific functions to provide a dump file, /proc/vmcore.
> 
> This file is in ELF format and its ELF header needs to be prepared by
> userspace tools, like kexec-tools, in adance. The primary kernel is
> responsible to allocate the region with reserve_elfcorehdr() at boot time
> and advertize its location to crash dump kernel via a new device-tree
> property, "linux,elfcorehdr".

> +static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
> +		const char *uname, int depth, void *data)
> +{
> +	const __be32 *reg;
> +	int len;
> +
> +	if (depth != 1 || strcmp(uname, "chosen") != 0)
> +		return 0;
> +
> +	reg = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
> +	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +		return 1;
> +
> +	elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +	elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +
> +	return 1;
> +}
> +
> +/*
> + * reserve_elfcorehdr() - reserves memory for elf core header
> + *
> + * This function reserves elf core header given in "elfcorehdr=" kernel
> + * command line parameter. This region contains all the information about
> + * primary kernel's core image and is used by a dump capture kernel to
> + * access the system memory on primary kernel.
> + */
> +static void __init reserve_elfcorehdr(void)
> +{
> +	of_scan_flat_dt(early_init_dt_scan_elfcorehdr, NULL);
> +
> +	if (!elfcorehdr_size)
> +		return;
> +
> +	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
> +		pr_warn("elfcorehdr is overlapped\n");
> +		return;
> +	}
> +
> +	memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
> +
> +	pr_info("Reserving %lldKB of memory at 0x%llx for elfcorehdr\n",
> +		elfcorehdr_size >> 10, elfcorehdr_addr);
> +}

This doesn't seem right to me.  The logic here doesn't match the commit
message, the comment above reserve_elfcorehdr() doesn't match the
implementation, and this doesn't match my understanding of how this was
intended to be used from the DT binding.

I had assumed that we'd treat this in much the same way as the
linux,reserved-memory-region property, with the primary kernel either
dynamically allocating the region or using a command line option, and
the base being exposed to userspace via /sys/ or /proc/ somehow.

Why is that not the case?

Thanks,
Mark.
