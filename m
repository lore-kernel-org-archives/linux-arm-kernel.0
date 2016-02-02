From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Feb 2016 10:19:45 +0000
Subject: [PATCH] arm64: move back to generic
 memblock_enforce_memory_limit()
In-Reply-To: <1454351417-23732-1-git-send-email-ard.biesheuvel@linaro.org>
References: <20160201180256.GJ15514@e104818-lin.cambridge.arm.com>
 <1454351417-23732-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160202101945.GA22042@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 07:30:17PM +0100, Ard Biesheuvel wrote:
>  void __init arm64_memblock_init(void)
>  {
>  	const s64 linear_region_size = -(s64)PAGE_OFFSET;
> @@ -215,24 +180,14 @@ void __init arm64_memblock_init(void)
>  	if (memblock_end_of_DRAM() > linear_region_size)
>  		memblock_remove(0, memblock_end_of_DRAM() - linear_region_size);
>  
> +	/*
> +	 * Apply the memory limit if it was set. Since the kernel may be loaded
> +	 * high up in memory, add back the kernel region that must be accessible
> +	 * via the linear mapping.
> +	 */
>  	if (memory_limit != (phys_addr_t)ULLONG_MAX) {
> -		u64 kbase = round_down(__pa(_text), MIN_KIMG_ALIGN);
> -		u64 kend = PAGE_ALIGN(__pa(_end));
> -		u64 const sz_4g = 0x100000000UL;
> -
> -		/*
> -		 * Clip memory in order of preference:
> -		 * - above the kernel and above 4 GB
> -		 * - between 4 GB and the start of the kernel (if the kernel
> -		 *   is loaded high in memory)
> -		 * - between the kernel and 4 GB (if the kernel is loaded
> -		 *   low in memory)
> -		 * - below 4 GB
> -		 */
> -		clip_mem_range(max(sz_4g, kend), ULLONG_MAX);
> -		clip_mem_range(sz_4g, kbase);
> -		clip_mem_range(kend, sz_4g);
> -		clip_mem_range(0, min(kbase, sz_4g));
> +		memblock_enforce_memory_limit(memory_limit);
> +		memblock_add(__pa(__init_begin), (u64)(_end - __init_begin));

Thanks, it looks much simpler now. However, loading the kernel 1GB
higher with mem=1G fails somewhere during the KVM hyp initialisation. It
works if I change the last line below to:

	memblock_add(__pa(_text), (u64)(_end - _text));

I can fold the change in.

-- 
Catalin
