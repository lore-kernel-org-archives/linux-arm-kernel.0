From: james.morse@arm.com (James Morse)
Date: Thu, 26 Jul 2018 14:36:58 +0100
Subject: [PATCH v12 12/16] arm64: kexec_file: add crash dump support
In-Reply-To: <20180724065759.19186-13-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-13-takahiro.akashi@linaro.org>
Message-ID: <e7605411-c54f-c744-43a7-aecc0e36e3f3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> Enabling crash dump (kdump) includes
> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>   using crash_prepare_elf64_headers(), and
> * add two device tree properties, "linux,usable-memory-range" and
>   "linux,elfcorehdr", which represent respectively a memory range
>   to be used by crash dump kernel and the header's location

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 5d102a1054b3..1b2c27026ae0 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -97,8 +97,12 @@ static inline void crash_post_resume(void) {}
>  #define ARCH_HAS_KIMAGE_ARCH
>  
>  struct kimage_arch {

> -	void *dtb_buf;
> +	void *dtb;

This change should be in an earlier patch, otherwise this series doesn't build
during bisect.

With the build-issues fixed:
Reviewed-by: James Morse <james.morse@arm.com>

Some boring Nits:

>  	unsigned long dtb_mem;
> +	/* Core ELF header buffer */
> +	void *elf_headers;
> +	unsigned long elf_headers_mem;
> +	unsigned long elf_headers_sz;
>  };
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index b8297f10e2ef..7356da5a53d5 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -38,12 +44,30 @@ static int setup_dtb(struct kimage *image,
>  		void **dtb_buf, unsigned long *dtb_buf_len)
>  {
>  	void *buf = NULL;
> -	size_t buf_size;
> +	size_t buf_size, range_size;
>  	int nodeoffset;
>  	int ret;
>  
>  	/* duplicate dt blob */
>  	buf_size = fdt_totalsize(initial_boot_params);
> +	range_size = of_fdt_reg_cells_size();
> +
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		buf_size += fdt_prop_len("linux,elfcorehdr", range_size);
> +		buf_size += fdt_prop_len("linux,usable-memory-range",
> +								range_size);
> +	}

Nit: it would be better if these strings were defined in a header file somewhere
so we don't risk a typo if this gets refactored.



> @@ -129,6 +170,43 @@ static int setup_dtb(struct kimage *image,
>  	return ret;
>  }
>  
> +static int prepare_elf_headers(void **addr, unsigned long *sz)
> +{
> +	struct crash_mem *cmem;
> +	unsigned int nr_ranges;
> +	int ret;
> +	u64 i;
> +	phys_addr_t start, end;
> +
> +	nr_ranges = 1; /* for exclusion of crashkernel region */

> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
> +							&start, &end, NULL)

Nit: MEMBLOCK_NONE


Thanks,

James
